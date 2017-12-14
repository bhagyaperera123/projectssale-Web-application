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
public class Delete_order extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession hs = request.getSession();
            if (hs.getAttribute("user") != null) {
                int uid = Integer.parseInt(request.getParameter("uid"));
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                Criteria cr = ses.createCriteria(DB.Order.class);
                cr.add(Restrictions.eq("idorder", uid));

                DB.Order or = (DB.Order) cr.uniqueResult();
                if (or != null) {

                    or.setAddJob(or.getAddJob());
                    or.setOrderDetails(or.getOrderDetails());
                    or.setStatus(0);
                    or.setUserByReceiverUser(or.getUserByReceiverUser());
                    or.setUserBySendOrderUser(or.getUserBySendOrderUser());
                    ses.update(or);
                    tr.commit();
                    ses.flush();
                    ses.close();
                    out.write("1");
                }
            } else {
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
        }
    }
}
