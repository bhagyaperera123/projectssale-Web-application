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
public class Reset_Password extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            String id = request.getParameter("uid");
            int uid = Integer.parseInt(Security.Security.decrypt(id));
            String pass = request.getParameter("pass");
            String unm = request.getParameter("unm");

            if (unm != null & pass != null) {

                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria cr = ses.createCriteria(DB.UserLogin.class);
                Transaction tr = ses.beginTransaction();
                DB.UserLogin ul = (DB.UserLogin) ses.load(DB.UserLogin.class, uid);
                cr.add(Restrictions.eq("user", ul));
                DB.UserLogin userlog = (DB.UserLogin) cr.uniqueResult();
                if (userlog != null) {

                    userlog.setJobLocation(userlog.getJobLocation());
                    userlog.setLocation(userlog.getLocation());
                    userlog.setPassword(pass);
                    userlog.setStatus(userlog.getStatus());
                    userlog.setUname(unm);
                    userlog.setUser(userlog.getUser());
                    userlog.setUserLoginDetailses(userlog.getUserLoginDetailses());
                    userlog.setUserType(userlog.getUserType());
                    ses.update(userlog);
                    tr.commit();
                    ses.flush();
                    ses.close();
                    String reval = "";
                    reval += "<div class='alert alert-success fade in'>";
                    reval += "<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>";
                    reval += "Password Successfully Changed";
                    reval += " </div >";
                    response.sendRedirect("index.jsp?alert=" + reval);
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
