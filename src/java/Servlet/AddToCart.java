package Servlet;

import Connection.NewHibernateUtil;
import DB.Cart;
import DB.CartHasProject;
import DB.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class AddToCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {

                String pid = request.getParameter("pid");
                String bqty = "1";
                HttpSession s = request.getSession();
                int uid = Integer.parseInt(s.getAttribute("user").toString());
                Session ss = NewHibernateUtil.getSessionFactory().openSession();
                Criteria crr = ss.createCriteria(DB.Cart.class);
                DB.User user = (DB.User) ss.load(DB.User.class, uid);
                crr.add(Restrictions.eq("user", user));
                DB.Cart cart = (DB.Cart) crr.uniqueResult();
                DB.Projects project = (DB.Projects) ss.load(DB.Projects.class, Integer.parseInt(pid));
                Criteria crite = ss.createCriteria(DB.CartHasProject.class);
                crite.add(Restrictions.eq("projects", project));
                crite.add(Restrictions.eq("cart", cart));

                DB.CartHasProject chpro = (DB.CartHasProject) crite.uniqueResult();

                if (chpro != null) {
                    out.write("Allready added");
                } else {
                    User us = (User) ss.load(User.class, uid);
                    DB.Projects pro = (DB.Projects) ss.load(DB.Projects.class, Integer.parseInt(pid));

                    Criteria cri = ss.createCriteria(Cart.class);
                    cri.add(Restrictions.eq("user", us));

                    Cart cr = (Cart) cri.uniqueResult();
                    double up = Double.parseDouble(pro.getPrice());
                    Transaction tr = ss.beginTransaction();

                    if (cr == null) {
                        Cart crt = new Cart();
                        crt.setDateTime(new Date());
                        crt.setUser(us);
                        crt.setProductCount(Integer.parseInt(bqty));
                        crt.setTotalAmount(up);
                        ss.save(crt);

                        CartHasProject chp = new CartHasProject();
                        chp.setCart(crt);
                        chp.setIsPurchase(0);
                        chp.setProjects(pro);
                        chp.setQty(Double.parseDouble(bqty));
                        chp.setPrice(up);
                        ss.save(chp);

                    } else {
                        cr.setDateTime(new Date());
                        cr.setProductCount(cr.getProductCount() + Integer.parseInt(bqty));
                        cr.setTotalAmount(cr.getTotalAmount() + (up));
                        ss.update(cr);

                        Criteria cri2 = ss.createCriteria(CartHasProject.class);
                        cri2.add(Restrictions.eq("cart", cr));
                        cri2.add(Restrictions.eq("projects", pro));
                        cri2.add(Restrictions.eq("isPurchase", 0));

                        CartHasProject chp2 = (CartHasProject) cri2.uniqueResult();
                        if (chp2 == null || chp2.getIsPurchase() == 1) {
                            CartHasProject chp3 = new CartHasProject();
                            chp3.setCart(cr);
                            chp3.setIsPurchase(0);
                            chp3.setProjects(pro);
                            chp3.setQty(Double.parseDouble(bqty));
                            chp3.setPrice(up * Double.parseDouble(bqty));
                            ss.save(chp3);
                        } else {
                            chp2.setQty(chp2.getQty() + Double.parseDouble(bqty));
                            chp2.setPrice(chp2.getPrice() + (up * Double.parseDouble(bqty)));
                            ss.update(chp2);
                        }
                    }
                    tr.commit();
                    out.write("Added Successfully");
                }

            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
