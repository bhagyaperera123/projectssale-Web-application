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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Bhagya
 */
public class pro_user_job extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            JSONArray ar = new JSONArray();
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.User.class);
            Criteria cr1 = ses.createCriteria(DB.Projects.class);
            Criteria cr2 = ses.createCriteria(DB.AddJob.class);
            
            JSONObject job = new JSONObject();
            job.put("user", cr.list().size());
            job.put("project", cr1.list().size());
            job.put("job", cr2.list().size());
            ar.add(job);
            
            JSONObject obj = new JSONObject();
            obj.put("mainm", ar);
            out.write(obj.toJSONString());
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
