package Servlet;

import DB.AddJob;
import DB.Order;
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
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class loadproject extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {

                PrintWriter out = response.getWriter();
                String return_Value = "";
                HttpSession hs = request.getSession();
                int uid = Integer.parseInt(hs.getAttribute("user").toString());
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria cr = ses.createCriteria(DB.AddJob.class);
                DB.User u = (DB.User) ses.load(DB.User.class, uid);
                cr.add(Restrictions.eq("user", u));
                List<DB.AddJob> l = cr.list();



                for (AddJob addJo : l) {
                    if (addJo.getStatus() == 1) {
                        DB.Order ord = (DB.Order) ses.load(DB.Order.class, addJo.getIdaddJob());
                        Criteria cr1 = ses.createCriteria(DB.Order.class);
                        cr1.add(Restrictions.eq("addJob", ord));

                        List<DB.Order> a = cr1.list();
                        for (int i = 0; i < a.size(); i++) {
                            Order order = a.get(i);
                        }


                        return_Value += "<tr>\n"
                                + "<td><input type=\"checkbox\" class=\"checkthis\" /></td>\n"
                                + "<td><img src='" + addJo.getJobDisplayPhoto().getPath() + "' class='img-responsive img-circle' width='40' height='40'></td>\n"
                                + "<td><a style=\"text-decoration: none;\">" + addJo.getTitle() + "</a></td>"
                                + "<td><span class=\"glyphicon glyphicon-stats\">13%</span></td>\n"
                                + "<td><span class=\"glyphicon glyphicon-eye-open\">12</span></td>\n"
                                + "<td><span class=\"glyphicon glyphicon-sort-by-order\"> " + cr1.list().size() + "</span></td>\n"
                                + "<td></td>\n"
                                + "<td></td>\n"
                                + "<td><p data-placement=\"top\" data-toggle=\"tooltip\" title=\"Delete\"><button onclick='Delete_job(" + addJo.getIdaddJob() + ")' class=\"btn btn-danger btn-xs\" ><span class=\"glyphicon glyphicon-trash\"></span></button></p></td>\n"
                                + "</tr>";

                    }
                    
                }
                out.write(return_Value);
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
