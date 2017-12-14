/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import DB.Projects;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Bhagya
 */
public class getUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            JSONArray ar = new JSONArray();
            int UsrID = Integer.parseInt(request.getParameter("uid"));
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            DB.UserLogin usr = (DB.UserLogin) ses.load(DB.UserLogin.class, UsrID);
            
            Criteria cr = ses.createCriteria(DB.Projects.class);
            cr.add(Restrictions.eq("user", usr));
            int procount = cr.list().size();
            
            Criteria cr2 = ses.createCriteria(DB.AddJob.class);
            cr2.add(Restrictions.eq("user", usr));
            int jobcount = cr2.list().size();
           
            JSONObject job = new JSONObject();
            job.put("id", usr.getUser().getIduser());
            job.put("fnm", usr.getUser().getFname());
            job.put("lnm", usr.getUser().getLname());
            job.put("eml", usr.getUser().getEmail());
            job.put("des", usr.getUser().getDescription());
            job.put("status", usr.getStatus());
            job.put("type",usr.getUserType().getRoleName());
            job.put("jobcount",jobcount);
            job.put("procount",procount);         
            ar.add(job);

            JSONObject obj = new JSONObject();
            obj.put("user", ar);
            out.write(obj.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
