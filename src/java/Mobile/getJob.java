/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import DB.AddJob;
import DB.Projects;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Bhagya
 */
public class getJob extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            JSONArray ar = new JSONArray();
            int JID = Integer.parseInt(request.getParameter("jid"));
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            DB.AddJob jobs = (AddJob) ses.load(DB.AddJob.class, JID);
            JSONObject job = new JSONObject();
                job.put("id", jobs.getIdaddJob());
                job.put("title", jobs.getTitle());
                job.put("status", jobs.getStatus());
                job.put("des", jobs.getDescription());
                job.put("cate", jobs.getJobCategory().getCategoryName());
                job.put("duration", jobs.getJobDuration().getTime());
                job.put("price", jobs.getJobPriceList().getPrice());
                job.put("img", jobs.getJobDisplayPhoto().getPath().replace("\\", "/").replace(" ", "%20"));
                ar.add(job);
            JSONObject obj = new JSONObject();
            obj.put("project", ar);
            out.write(obj.toJSONString());
           
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
