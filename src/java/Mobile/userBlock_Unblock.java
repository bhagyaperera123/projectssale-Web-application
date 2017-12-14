/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

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
public class userBlock_Unblock extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            int uid = Integer.parseInt(request.getParameter("uid"));
            String method  = request.getParameter("method");
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();
            DB.User usr = (DB.User) ses.load(DB.User.class, uid);
            Criteria cr = ses.createCriteria(DB.UserLogin.class);
            cr.add(Restrictions.eq("user", usr));
            DB.UserLogin ul = (DB.UserLogin) cr.uniqueResult();
            if (ul != null) {

                ul.setJobLocation(ul.getJobLocation());
                ul.setLocation(ul.getLocation());
                ul.setPassword(ul.getPassword());
                if(method.equals("block")){
                    ul.setStatus(2);
                }else if(method.equals("unblock")){
                    ul.setStatus(1);
                }
                ul.setUname(ul.getUname());
                ul.setUser(ul.getUser());
                ul.setUserType(ul.getUserType());
                ses.update(ul);
                tr.commit();
                ses.flush();
                ses.close();
                out.write("1");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
