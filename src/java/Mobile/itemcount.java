/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import DB.Cart;
import DB.CartHasProject;
import DB.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;

/**
 *
 * @author Bhagya
 */
public class itemcount extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            int count= 0;
            
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            User us = (User) ses.load(DB.User.class, Integer.parseInt(request.getParameter("uid")));
            Criteria cr = ses.createCriteria(DB.Cart.class);

            cr.add(Restrictions.eq("user", us));
            Cart crt = (Cart) cr.uniqueResult();
            if (crt != null) {
                Query qr = ses.createQuery("from CartHasProject where cart='" + crt.getIdcart() + "'");
                List<DB.CartHasProject> chp = qr.list();

                for (CartHasProject c : chp) {
                    DB.Projects pro = (DB.Projects) ses.load(DB.Projects.class, c.getProjects().getIdprojects());
                    if (c.getIsPurchase() == 0) {
                     count++;   
                    }
                }
            }
            out.write(count+"");


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
