/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import DB.User;
import DB.UserLogin;
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
public class getUsers extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            JSONArray ar = new JSONArray();

            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.UserLogin.class);
            List<DB.UserLogin> l1 = cr.list();
            for (DB.UserLogin ul : l1) {

                JSONObject job = new JSONObject();
                job.put("id", ul.getUser().getIduser());
                job.put("fnm", ul.getUser().getFname());;
                job.put("lnm", ul.getUser().getLname());;
                job.put("eml", ul.getUser().getEmail());;
                job.put("des", ul.getUser().getDescription());
                job.put("unm", ul.getUname());;
                job.put("pas", ul.getPassword());;
                job.put("status", ul.getStatus());;
                job.put("utype", ul.getUserType().getRoleName()+"_"+ul.getUserType().getIdUserType());
                ar.add(job);
            }
            JSONObject obj = new JSONObject();
            obj.put("types", ar);
            out.write(obj.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
