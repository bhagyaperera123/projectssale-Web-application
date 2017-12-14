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
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class block_User extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession hs = request.getSession();
            if (hs.getAttribute("user") != null) {
                int uid = Integer.parseInt(request.getParameter("uid"));
                Session ses  = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                DB.User u = (DB.User) ses.load(DB.User.class, uid);
                Criteria cr = ses.createCriteria(DB.UserLogin.class);
                cr.add(Restrictions.eq("user", u));
                
                DB.UserLogin ul = (DB.UserLogin) cr.uniqueResult();
                if(ul != null){
                    
                    ul.setJobLocation(ul.getJobLocation());
                    ul.setLocation(ul.getLocation());
                    ul.setPassword(ul.getPassword());
                    ul.setStatus(2);
                    ul.setUname(ul.getUname());
                    ul.setUser(ul.getUser());
                    ul.setUserType(ul.getUserType());
                    ses.update(ul);
                    tr.commit();
                    ses.flush();
                    ses.close();
                    out.write("1");
                }
                
            } else {
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
