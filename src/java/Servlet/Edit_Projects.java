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
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class Edit_Projects extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession s = request.getSession();
            if (s.getAttribute("user") != null) {
                int id = Integer.parseInt(request.getParameter("id"));
                int uid = Integer.parseInt(s.getAttribute("user").toString());

                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                DB.User u = (DB.User) ses.load(DB.User.class, uid);
                Criteria cr = ses.createCriteria(DB.Projects.class);
                cr.add(Restrictions.eq("user", u));
                cr.add(Restrictions.eq("idprojects", id));
                DB.Projects ul = (DB.Projects) cr.uniqueResult();
                if (ul != null) {
                    String reval = "";
                    reval += "<fieldset>\n"
                            + "                                                    <!-- Text input-->\n"
                            + "\n"
                            + "                                                    <!-- Text input-->\n"
                            + "                                                    <div class=\"form-group\">\n"
                            + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">Price</label>\n"
                            + "                                                        <div class=\"col-sm-10\">\n"
                            + "                                                            <input name='price' type='text' class='form-control' value='"+ul.getPrice()+"' >"
                            + "                                                        </div></div>"
                            + "                                                            <input type='hidden' value='" + id + "' name='id'> "
                            + "                                                    <div class=\"form-group\">\n"
                            + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">Description</label>\n"
                            + "                                                        <div class=\"col-sm-10\">\n"
                            + "                                                            <textarea style=\"height: 200px;\" name='ifb' value='' type=\"text\" placeholder=\"Description\" class=\"form-control\">" + ul.getDescription() + "</textarea>\n"
                            + "                                                        </div></div>"
                            + "                                                </fieldset>";
                    out.write(reval);

                }
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
