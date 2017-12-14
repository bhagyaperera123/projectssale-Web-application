/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
public class LoadJobs extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            JSONArray ar = new JSONArray();
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.AddJob.class);
            List<DB.AddJob> l1 = cr.list();
            for (DB.AddJob jobs : l1) {
                JSONObject job = new JSONObject();
                job.put("id", jobs.getIdaddJob());
                job.put("pnm", jobs.getTitle());
                job.put("status", jobs.getStatus());
                job.put("price", jobs.getJobPriceList().getPrice());
                job.put("img", jobs.getJobDisplayPhoto().getPath().replace("\\", "/").replace(" ", "%20"));
                ar.add(job);
            }
            JSONObject obj = new JSONObject();
            obj.put("jobs", ar);
            out.write(obj.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
