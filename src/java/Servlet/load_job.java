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
public class load_job extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
                        HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
            String reval = "";

            int pro_id = Model.Main.int_Value(request.getParameter("id"));

            if (0 < pro_id) {
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                Criteria cr = ses.createCriteria(DB.AddJob.class);
                cr.add(Restrictions.eq("idaddJob", pro_id));
                DB.AddJob up = (DB.AddJob) cr.uniqueResult();
                if (up != null) {


                    reval += "<div class=\"container\">\n"
                            + "                <div class=\"row\">\n"
                            + "                    <div class=\"col-md-4\">\n"
                            + "                        <div class=\"box-body\">\n"
                            + "                            <div class=\"form-group\">\n"
                            + "                                <label for=\"exampleInputEmail1\">Title</label>\n"
                            + "                                <samp class=\"form-control\">" + up.getTitle() + "</samp>\n"
                            + "                            </div>\n"
                            + "                            <div class=\"form-group\">\n"
                            + "                                <label for=\"exampleInputPassword1\">Price</label>\n"
                            + "                                <samp class=\"form-control\">RS70.00/=</samp>\n"
                            + "                            </div>\n"
                            + "                        </div>\n"
                            + "                    </div>\n"
                            + "                    <div class=\"col-md-4\">\n"
                            + "                        <div class=\"box-body\">\n"
                            + "                            <div class=\"form-group\">\n"
                            + "                                <label for=\"exampleInputEmail1\">Description</label>\n"
                            + "                                <textarea style=\"height: 110px;\"  class=\"form-control\" id=\"exampleInputEmail1\">" + up.getDescription() + "</textarea>\n"
                            + "                            </div>\n"
                            + "                        </div>\n"
                            + "                    </div>\n"
                            + "                </div>\n"
                            + "                <div class=\"row\">\n"
                            + "                    <div class=\"col-md-4\">\n"
                            + "                        <div class=\"box-body\">\n"
                            + "                            <div class=\"form-group\">\n"
                            + "                                <label for=\"exampleInputEmail1\">Tags</label>\n"
                            + "                                <samp class=\"form-control\"><span class=\"tags\" style=\"color: red;\">" + up.getTags() + "</span></samp>\n"
                            + "                            </div>\n"
                            + "                            <div class=\"form-group\">\n"
                            + "                                <label for=\"exampleInputPassword1\">Category</label>\n"
                            + "                                <samp class=\"form-control\">" + up.getJobCategory().getCategoryName() + "</samp>\n"
                            + "                            </div>\n"
                            + "                        </div>\n"
                            + "                    </div>\n"
                            + "                    <div class=\"col-md-4\">\n"
                            + "                        <div class=\"box-body\">\n"
                            + "                            <div class=\"form-group\">\n"
                            + "                                <label for=\"exampleInputEmail1\">Instructions for buyer</label>\n"
                            + "                                <textarea style=\"height: 110px;\" type=\"email\" class=\"form-control\" id=\"exampleInputEmail1\">" + up.getInstructionsForBuyer() + "</textarea>\n"
                            + "                            </div>\n"
                            + "                        </div>\n"
                            + "                    </div>\n"
                            + "                </div>\n"
                            + "                <div class=\"row\">\n"
                            + "                    <div class=\"col-md-4\">\n"
                            + "                        <div class=\"box-body\">\n"
                            + "                            <div class=\"form-group\">\n"
                            + "                                <label for=\"exampleInputEmail1\">Display photo</label><br/>\n"
                            + "                                <img src='" + up.getJobDisplayPhoto().getPath() + "' width=\"150\" height=\"150\" >\n"
                            + "                            </div>\n"
                            + "                        </div>"
                            + "                    </div>"
                            + "<div class='col-md-4'>"
                            + "                        <div class='box-body'>"
                            + "                            <div class='form-group'>"
                            + "                                <label for='exampleInputEmail1'>Job Duration</label><br/>"
                            + "                                <samp class='form-control'>" + up.getJobDuration().getTime() + "</samp>"
                            + "                            </div>"
                            + "                        </div>"
                            + "                    </div>"
                            + "                </div>"
                            + "        </div>";

                } else {
                    response.sendRedirect("Manage_Job.jsp");
                }
            } else {
                response.sendRedirect("Manage_Job.jsp");
            }
            out.write(reval);
            }else{
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
