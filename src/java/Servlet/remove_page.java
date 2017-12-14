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
public class remove_page extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
                String s = "";
                int page_id = Integer.parseInt(request.getParameter("pid"));
                int type_id = Integer.parseInt(request.getParameter("tyid"));

                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria cr = ses.createCriteria(DB.UserTypeHasUserPage.class);
                Transaction tr = ses.beginTransaction();

                DB.UserPage up = (DB.UserPage) ses.load(DB.UserPage.class, page_id);
                DB.UserType ut = (DB.UserType) ses.load(DB.UserType.class, type_id);

                cr.add(Restrictions.eq("userType", ut));
                cr.add(Restrictions.eq("userPage", up));

                DB.UserTypeHasUserPage uthp = (DB.UserTypeHasUserPage) cr.uniqueResult();
                if (uthp != null) {
                    s += "1";
                    ses.delete(uthp);
                    tr.commit();
                    ses.flush();
                    ses.close();

                } else {
                    s += "2";
                }
                out.write(s);
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
