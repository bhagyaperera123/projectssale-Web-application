/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DB.Category;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;

/**
 *
 * @author Bhagya
 */
public class Cate_has_Subcate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            HttpSession s = request.getSession();
            if (s.getAttribute("user") != null) {
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Criteria cr = ses.createCriteria(DB.SubCategory.class);
                List<DB.SubCategory> l = cr.list();

                int catetype = Integer.parseInt(request.getParameter("cgtp"));

                for (int i = 0; i < l.size() + 1; i++) {
//                Category category = l.get(i);
                    if (request.getParameter(i + "") != null) {

                        Model.Main.cateTYpe_Has_Subcate(catetype, Integer.parseInt(request.getParameter(i + "")));

                    }
                }
                response.sendRedirect("Other_Function.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
