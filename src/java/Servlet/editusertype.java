package Servlet;

import DB.UserType;
import DB.UserTypeHasUserPage;
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
public class editusertype extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
                        HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
            String s = "";
            int type = Integer.parseInt(request.getParameter("type"));
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();
            DB.UserType ut = (DB.UserType) ses.load(DB.UserType.class, type);

            Criteria cr = ses.createCriteria(DB.UserPage.class);
            List<DB.UserPage> l = cr.list();

            for (int i = 1; i < l.size() + 1; i++) {
                if (request.getParameter(i + "") != null) {
                    Criteria cr1 = ses.createCriteria(DB.UserPage.class);
                    cr1.add(Restrictions.eq("iduserPage", i));
                    List<DB.UserPage> l1 = cr1.list();
                    for (DB.UserPage up : l1) {
                        Model.user_has_page.Save_(ut, up.getIduserPage());
                    }
                }
            }
            response.sendRedirect("Add_User_Role.jsp");
            }else{
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}