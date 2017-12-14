/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import DB.Cart;
import DB.CartHasProject;
import DB.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Bhagya
 */
public class LoadCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            JSONArray ar = new JSONArray();
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            User us = (User) ses.load(DB.User.class, Integer.parseInt(request.getParameter("uid")));
            Criteria cr = ses.createCriteria(DB.Cart.class);

            cr.add(Restrictions.eq("user", us));
            Cart crt = (Cart) cr.uniqueResult();
            if (crt != null) {
                Query qr = ses.createQuery("from CartHasProject where cart='" + crt.getIdcart() + "'");
                List<DB.CartHasProject> chp = qr.list();

                for (CartHasProject c : chp) {
                    DB.Projects pro = (DB.Projects) ses.load(DB.Projects.class, c.getProjects().getIdprojects());
                    if (c.getIsPurchase() == 0) {
                        JSONObject job = new JSONObject();
                        System.out.println("***** " + pro.getProjectName());
                        job.put("id", pro.getIdprojects());
                        job.put("pnm", pro.getProjectName());
                        job.put("qty", c.getQty());
                        job.put("cartid", c.getCart().getIdcart());
                        job.put("price", pro.getPrice());
                        job.put("img", pro.getUploadPic().getPath().replace("\\", "/").replace(" ", "%20"));
                        ar.add(job);
                    }
                }
            }
          
            JSONObject joo = new JSONObject();
            joo.put("idcart", crt.getIdcart());
            
            JSONObject obj = new JSONObject();
            obj.put("projects", ar);
            obj.put("cart", joo);
            
            out.write(obj.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
