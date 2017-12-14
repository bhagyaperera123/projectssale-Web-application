/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

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
import org.json.simple.JSONObject;

/**
 *
 * @author Bhagya
 */
public class NewUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String reval = "";
        try {

            String uname = request.getParameter("unm");
            String fname = request.getParameter("fnm");
            String description = request.getParameter("des");
            String lname = request.getParameter("lnm");
            String password = request.getParameter("pass");
            String email = request.getParameter("eml");
            String urolename = request.getParameter("urole");

            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.UserPage.class);
            List<DB.UserPage> l = cr.list();

            Transaction tr = ses.beginTransaction();

            DB.User u = new DB.User();
            u.setFname(fname);
            u.setLname(lname);
            u.setEmail(email);
            u.setDescription(description);
            ses.save(u);
            DB.UserLogin ul = new DB.UserLogin();
            ul.setUname(uname);
            ul.setPassword(password);
            ul.setLocation("");
            ul.setJobLocation("");
            ul.setStatus(1);
            Criteria cr1 = ses.createCriteria(DB.UserType.class);
            cr1.add(Restrictions.eq("roleName", urolename));
            DB.UserType ttt = (DB.UserType) cr1.uniqueResult();
            DB.UserType ut = (DB.UserType) ses.load(DB.UserType.class, ttt.getIdUserType());
            ul.setUserType(ut);
            ul.setUser(u);
            ses.save(ul);
            tr.commit();
            ses.flush();
            ses.close();
            reval = "1";
        } catch (Exception e) {
            reval = "0";
            e.printStackTrace();
        }
        out.write(reval);
    }
}
