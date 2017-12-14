/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class Deactivate_projects extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
                String reval = "";
                int pro_id = Model.Main.int_Value(request.getParameter("id"));

                if (0 < pro_id) {
                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Transaction tr = ses.beginTransaction();
                    Criteria cr = ses.createCriteria(DB.Projects.class);
                    cr.add(Restrictions.eq("idprojects", pro_id));
                    DB.Projects up = (DB.Projects) cr.uniqueResult();
                    if (up != null) {
                        up.setCartHasProjects(up.getCartHasProjects());
                        up.setCategory(up.getCategory());
                        up.setDatabase1(up.getDatabase1());
                        up.setIdprojects(pro_id);
                        up.setPrice(up.getPrice());
                        up.setProLan(up.getProLan());
                        up.setProjectName(up.getProjectName());
                        up.setStatus(0);
                        up.setSubCategory(up.getSubCategory());
                        up.setUploadFile(up.getUploadFile());
                        up.setUploadPic(up.getUploadPic());
                        up.setUser(up.getUser());
                        up.setViews(up.getViews());
                        ses.update(up);
                        tr.commit();
                        ses.flush();
                        ses.close();
                        reval = "1";
                    } else {
                        response.sendRedirect("Manage_Projects.jsp");
                    }
                } else {
                    response.sendRedirect("Manage_Projects.jsp");
                }
                out.write(reval);
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
