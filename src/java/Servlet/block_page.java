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
public class block_page extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
                        HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
            String reval = "";
            int page_ID = Model.Main.int_Value(request.getParameter("pid"));
            if (0 < page_ID) {
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                Criteria cr = ses.createCriteria(DB.UserPage.class);
                cr.add(Restrictions.eq("iduserPage", page_ID));
                DB.UserPage up = (DB.UserPage) cr.uniqueResult();
                if (up != null) {
                    up.setIduserPage(page_ID);
                    up.setPageName(up.getPageName());
                    up.setUrl(up.getUrl());
                    up.setStatus(0);
                    ses.update(up);
                    tr.commit();
                    ses.flush();
                    ses.close();
                    reval = "1";
                } else {
                    response.sendRedirect("Super_Admin.jsp");
                }
            } else {
                response.sendRedirect("Super_Admin.jsp");
            }

            out.write(reval);
            }else{
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
