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
public class Loadusers extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            JSONArray ar = new JSONArray();
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.UserLogin.class);
            List<DB.UserLogin> l1 = cr.list();
            for (DB.UserLogin usr : l1) {
//                if (!"Super Admin".equals(usr.getUserType().getRoleName())) {
                    JSONObject job = new JSONObject();
                    job.put("id", usr.getUser().getIduser());
                    job.put("fnm", usr.getUser().getFname());
                    job.put("lnm", usr.getUser().getLname());
                    job.put("eml", usr.getUser().getEmail());
                    job.put("des", usr.getUser().getDescription());
                    job.put("status", usr.getStatus());
                    job.put("type", usr.getUserType().getRoleName());
                    ar.add(job);
//                }
            }
            JSONObject obj = new JSONObject();
            obj.put("users", ar);
            out.write(obj.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
