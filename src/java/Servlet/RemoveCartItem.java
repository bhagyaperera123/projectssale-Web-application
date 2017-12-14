/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
public class RemoveCartItem extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            String pid = request.getParameter("pid");
            String cid = request.getParameter("cid");
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            DB.Projects pro = (DB.Projects) ses.load(DB.Projects.class, Integer.parseInt(pid));
            DB.Cart cart = (DB.Cart) ses.load(DB.Cart.class, Integer.parseInt(cid));

            Criteria cr = ses.createCriteria(DB.CartHasProject.class);
            cr.add(Restrictions.eq("projects", pro));
            cr.add(Restrictions.eq("cart", cart));
            cr.add(Restrictions.eq("isPurchase", 0));

            DB.CartHasProject chp = (DB.CartHasProject) cr.uniqueResult();

            Transaction tr = ses.beginTransaction();
            cart.setProductCount(cart.getProductCount() - chp.getQty().intValue());
            cart.setTotalAmount(cart.getTotalAmount() - chp.getPrice());
            ses.update(cart);
            ses.delete(chp);
            tr.commit();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
