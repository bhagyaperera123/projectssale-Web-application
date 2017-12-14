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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Bhagya
 */
public class getProject extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            JSONArray ar = new JSONArray();
            int ProID = Integer.parseInt(request.getParameter("pid"));
            
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            DB.Projects pro = (Projects) ses.load(DB.Projects.class, ProID);
            JSONObject job = new JSONObject();
            job.put("id", pro.getIdprojects());
            job.put("pnm", pro.getProjectName());
            job.put("img", pro.getUploadPic().getPath().replace("\\", "/").replace(" ", "%20"));
            job.put("cate", pro.getCategory().getCategoryType().getName());
            job.put("scate", pro.getCategory().getSubCategory().getName());
            job.put("price", pro.getPrice());
            job.put("des", pro.getDescription());
            job.put("status", pro.getStatus());
            ar.add(job);
            JSONObject obj = new JSONObject();
            obj.put("project", ar);
            out.write(obj.toJSONString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
