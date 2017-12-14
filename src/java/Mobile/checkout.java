/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import DB.CartHasProject;
import DB.Payment;
import DB.PaymentHasProjects;
import DB.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class checkout extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String sec ="";
        try {
            System.out.println("asdfghjkl");
            int id = Integer.parseInt(request.getParameter("uid"));
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            User us = (User) ses.load(DB.User.class, id);
            Criteria cr = ses.createCriteria(DB.Cart.class);
            cr.add(Restrictions.eq("user", us));
            DB.Cart crt = (DB.Cart) cr.uniqueResult();
            Criteria cr2 = ses.createCriteria(DB.CartHasProject.class);
            cr2.add(Restrictions.eq("cart", crt));
            List<CartHasProject> item = cr2.list();

            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            
            String cid = request.getParameter("cid");
            int cartid = Integer.parseInt(cid);
            Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Transaction trr = sess.beginTransaction();
            Payment pay = new Payment();
            pay.setDateTime(df.format(new Date()));
            pay.setProjectCount(crt.getProductCount());
            pay.setTotalAmount(crt.getTotalAmount());
            pay.setUser(us);
            pay.setEmailStatus(1);
            sess.save(pay);

            DB.Cart cart = (DB.Cart) sess.load(DB.Cart.class, cartid);
            Criteria crr = sess.createCriteria(DB.CartHasProject.class);
            crr.add(Restrictions.eq("cart", cart));
            List<DB.CartHasProject> ll = crr.list();
            int payid = 0;
            String val = "";
            for (CartHasProject chpro : ll) {
                payid++;
                if (chpro.getIsPurchase() == 0) {
                    DB.PaymentHasProjects php = new PaymentHasProjects();
                    php.setIsPurchase(1);
                    php.setPayment(pay);
                    php.setPrice(chpro.getPrice());
                    php.setProjects(chpro.getProjects());
                    String aa = chpro.getQty() + "";
                    String[] bb = aa.split(".0");
                    int qty = 0;
                    for (int i = 0; i < bb.length; i++) {
                        qty = Integer.parseInt(bb[i]);
                        val += chpro.getProjects().getIdprojects() + ",";
                    }
                    php.setQty(qty);
                    sess.save(php);
                }
            }
            System.out.println(val);
            trr.commit();
            for (CartHasProject chp : item) {
                if (chp.getIsPurchase() != 1) {
                    Transaction tr = ses.beginTransaction();
                    chp.setIsPurchase(1);
                    ses.update(chp);
                    tr.commit();
                }
            }
            Transaction tr2 = ses.beginTransaction();
            crt.setDateTime(null);
            crt.setProductCount(0);
            crt.setTotalAmount(0.0);
            ses.update(crt);
            tr2.commit();
            System.out.println(us.getEmail());
            //Model.Send_Mail_For_Invoice.send_Mail_For_Invoice(us.getEmail(), val);
            sec="1";
        } catch (Exception e) {
            sec="0";
            e.printStackTrace();
        }
        out.write(sec);
    }
}
