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
public class Edit_Admin_profile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String description = request.getParameter("description");
            String password = request.getParameter("password");
            String Npassword = request.getParameter("npass");
            String Cpassword = request.getParameter("cpass");
            String Uname = request.getParameter("unm");

            HttpSession ss = request.getSession();
            int uid = Integer.parseInt(ss.getAttribute("user").toString());
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();
            DB.User u = (DB.User) ses.load(DB.User.class, uid);
            Criteria cr = ses.createCriteria(DB.UserLogin.class);
            cr.add(Restrictions.eq("user", u));
            cr.add(Restrictions.eq("password", password));
            DB.UserLogin ul = (DB.UserLogin) cr.uniqueResult();
            if (ul != null) {

                Criteria cr1 = ses.createCriteria(DB.User.class);
                cr1.add(Restrictions.eq("iduser", ul.getIduserLogin()));
                DB.User user = (DB.User) cr1.uniqueResult();
                if (user != null) {
                    user.setEmail(email);
                    user.setFname(fname);
                    user.setLname(lname);
                    user.setDescription(description);
                    ses.update(user);
                    
                    ul.setUserType(ul.getUserType());
                    ul.setJobLocation(ul.getJobLocation());
                    ul.setLocation(ul.getLocation());
                    ul.setPassword(Cpassword);
                    ul.setStatus(ul.getStatus());
                    ul.setUname(Uname);
                    ul.setUser(ul.getUser());
                    ses.update(ul);
                    tr.commit();
                    ses.flush();
                    ses.close();
                    response.sendRedirect("Admin_Profie.jsp");
                } else {
                }


            } else {
                //password worng
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
