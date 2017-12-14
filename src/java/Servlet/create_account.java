/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
public class create_account extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
            String uname = request.getParameter("unm");
            String fname = request.getParameter("fnm");
            String lname = request.getParameter("lnm");
            String password = request.getParameter("pass");
            String repassword = request.getParameter("repass");
            String email = request.getParameter("email");
            int userRolre_id = Integer.parseInt(request.getParameter("urole"));

            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.UserPage.class);
            List<DB.UserPage> l = cr.list();

            Transaction tr = ses.beginTransaction();

            DB.User u = new DB.User();
            u.setFname(fname);
            u.setLname(lname);
            u.setEmail(email);
            u.setDescription("");
            ses.save(u);
            DB.UserLogin ul = new DB.UserLogin();
            ul.setUname(uname);
            ul.setPassword(password);
            ul.setLocation("");
            ul.setJobLocation("");
            ul.setStatus(1);
            DB.UserType ut = (DB.UserType) ses.load(DB.UserType.class, userRolre_id);
            ul.setUserType(ut);
            ul.setUser(u);
            ses.save(ul);
            tr.commit();
            ses.flush();
            ses.close();
            response.sendRedirect("Create_Admin_Account.jsp");
            }else{
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
