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
public class Acti_Deac_Job extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            System.out.println("Job ID :- "+request.getParameter("id"));
            System.out.println("Val :- "+request.getParameter("val"));
            int pro_id = Model.Main.int_Value(request.getParameter("id"));
            int val = Integer.parseInt(request.getParameter("val").toString());
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
                        up.setStatus(val);
                        up.setTags(up.getTags());
                        up.setTitle(up.getTitle());
                        up.setUser(up.getUser());
                        ses.save(up);
                        tr.commit();
                        ses.flush();
                        ses.close();
                    }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
