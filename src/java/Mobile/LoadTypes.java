/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import DB.UserType;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
public class LoadTypes extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            JSONArray ar = new JSONArray();

            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.UserType.class);
            List<DB.UserType> l1 = cr.list();
            for (DB.UserType ut : l1) {
                if (ut.getStatus() == 1) {
                    if (ut.getRoleName().equals("Super Admin")) {
                    } else {
                        JSONObject job = new JSONObject();
                        job.put("id", ut.getIdUserType());
                        job.put("name", ut.getRoleName());;
                        ar.add(job);
                    }
                }
            }

            JSONObject obj = new JSONObject();
            obj.put("types", ar);
            out.write(obj.toJSONString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
