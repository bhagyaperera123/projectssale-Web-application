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
public class active_job extends HttpServlet {

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
                    up.setIdaddJob(pro_id);
                    up.setDescription(up.getDescription());
                    up.setInstructionsForBuyer(up.getInstructionsForBuyer());
                    up.setJobCategory(up.getJobCategory());
                    up.setJobDisplayPhoto(up.getJobDisplayPhoto());
                    up.setJobDuration(up.getJobDuration());
                    up.setJobFeedbacks(up.getJobFeedbacks());
                    up.setOrders(up.getOrders());
                    up.setStatus(1);
                    up.setTags(up.getTags());
                    up.setTitle(up.getTitle());
                    up.setUser(up.getUser());
                    ses.save(up);
                    tr.commit();
                    ses.flush();
                    ses.close();
                    reval = "1";
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
