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
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class Project_ActiveDeactive extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            int proID = Integer.parseInt(request.getParameter("pid"));
            int value = Integer.parseInt(request.getParameter("val"));
           
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();
            Criteria cr = ses.createCriteria(DB.Projects.class);
            cr.add(Restrictions.eq("idprojects", proID));
            DB.Projects up = (DB.Projects) cr.uniqueResult();
            if (up != null) {
                up.setCartHasProjects(up.getCartHasProjects());
                up.setCategory(up.getCategory());
                up.setDatabase1(up.getDatabase1());
                up.setIdprojects(proID);
                up.setPrice(up.getPrice());
                up.setProLan(up.getProLan());
                up.setProjectName(up.getProjectName());
                up.setStatus(value);
                up.setSubCategory(up.getSubCategory());
                up.setUploadFile(up.getUploadFile());
                up.setUploadPic(up.getUploadPic());
                up.setUser(up.getUser());
                up.setViews(up.getViews());
                ses.update(up);
                tr.commit();
                ses.flush();
                ses.close();
                out.write("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
