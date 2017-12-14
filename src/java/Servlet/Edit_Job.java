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
public class Edit_Job extends HttpServlet {
  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            PrintWriter out = response.getWriter();
            try {
            
                HttpSession s = request.getSession();
                if(s.getAttribute("user") != null){
                
                    int id = Integer.parseInt(request.getParameter("id"));
                    String description = request.getParameter("description");
                    String ifb = request.getParameter("ifb");
                    
                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Transaction tr = ses.beginTransaction();
                    Criteria cr = ses.createCriteria(DB.AddJob.class);
                    cr.add(Restrictions.eq("idaddJob", id));
                    DB.AddJob addjob = (DB.AddJob) cr.uniqueResult();
                    if(addjob != null){
                        
                        addjob.setDescription(description);
                        addjob.setInstructionsForBuyer(ifb);
                        addjob.setJobCategory(addjob.getJobCategory());
                        addjob.setJobDisplayPhoto(addjob.getJobDisplayPhoto());
                        addjob.setJobDuration(addjob.getJobDuration());
                        addjob.setStatus(addjob.getStatus());
                        addjob.setTags(addjob.getTags());
                        addjob.setTitle(addjob.getTitle());
                        addjob.setUser(addjob.getUser());
                        ses.save(addjob);
                        tr.commit();
                        ses.flush();
                        ses.close();
                        response.sendRedirect("User_Profile.jsp");
                    }else{
                        System.out.println("id not found");
                    }
                }else{
                    response.sendRedirect("index.jsp");
                }
                
        } catch (Exception e) {
            e.printStackTrace();
        }
            
    }
}
