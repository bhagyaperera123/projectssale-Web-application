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
public class View_order extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession hs = request.getSession();
            if (hs.getAttribute("user") != null) {
                String reval = "";
                int uid = Integer.parseInt(request.getParameter("uid"));
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                Criteria cr = ses.createCriteria(DB.Order.class);
                cr.add(Restrictions.eq("idorder", uid));
                System.out.println("awaa");
                DB.Order or = (DB.Order) cr.uniqueResult();
                if (or != null) {
                    reval += "<fieldset>\n"
                            + "                                                    <!-- Text input-->\n"
                            + "\n"
                            + "                                                    <!-- Text input-->\n"
                            + "                                                    <div class=\"form-group\">\n"
                            + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">Message Title</label>\n"
                            + "                                                        <div class=\"col-sm-10\">\n"
                            + "                                                            <textarea style=\"height: 200px;\" name='description' value='' type=\"text\" placeholder=\"Description\" class=\"form-control\">" + or.getOrderDetails().getTitle() + "</textarea>\n"
                            + "                                                        </div></div>"
                            + "                                                    <div class=\"form-group\">\n"
                            + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">Message Body</label>\n"
                            + "                                                        <div class=\"col-sm-10\">\n"
                            + "                                                            <textarea style=\"height: 200px;\" name='ifb' value='' type=\"text\" placeholder=\"Description\" class=\"form-control\">" + or.getOrderDetails().getMsgBody() + "</textarea>\n"
                            + "                                                        </div></div>"
                            + "                                                </fieldset>";
                }
                out.write(reval);
            } else {
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
