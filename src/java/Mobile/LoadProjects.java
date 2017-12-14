package Mobile;

import DB.User;
import DB.UserLogin;
import java.io.File;
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
public class LoadProjects extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            JSONArray ar = new JSONArray();
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.Projects.class);
            List<DB.Projects> l1 = cr.list();
            for (DB.Projects pro : l1) {
                JSONObject job = new JSONObject();
                job.put("id", pro.getIdprojects());
                job.put("pnm", pro.getProjectName());
                job.put("price", pro.getPrice());
                job.put("img", pro.getUploadPic().getPath().replace("\\", "/").replace(" ", "%20"));
                ar.add(job);
            }
            JSONObject obj = new JSONObject();
            obj.put("projects", ar);
            out.write(obj.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
