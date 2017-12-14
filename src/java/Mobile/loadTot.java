/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import DB.Cart;
import DB.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class loadTot extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            User us = (User) ses.load(DB.User.class, Integer.parseInt(request.getParameter("uid")));
            Criteria cr = ses.createCriteria(DB.Cart.class);

            cr.add(Restrictions.eq("user", us));
            Cart crt = (Cart) cr.uniqueResult();
            out.write(crt.getTotalAmount().toString());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
