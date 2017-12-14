/*
 * 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DB.Order;
import DB.OrderDetails;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Bhagya
 */
public class order_now extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            
            HttpSession hs = request.getSession();
            if (hs.getAttribute("user") != null) {

                int send_user_id = Integer.parseInt(hs.getAttribute("user").toString());
                String id = request.getParameter("uid");
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                int receiver_user_id = Integer.parseInt(Security.Security.decrypt(id));
                String s = Security.Security.encrypt("msgtitle");
                String msg_title = request.getParameter(s);
                String a = Security.Security.encrypt("msgbody");
                String msg_body = request.getParameter(a);
                
                System.out.println("msg title : "+msg_title);
                System.out.println("msg body : "+msg_body);
                System.out.println("send user : "+send_user_id);
                System.out.println("receiver user : "+receiver_user_id);

                DB.OrderDetails orde = new OrderDetails();
                orde.setTitle(msg_title);
                orde.setMsgBody(msg_body);
                ses.save(orde);

                int jobid = Integer.parseInt(request.getParameter("jobid").toString());
                DB.AddJob adj = (DB.AddJob) ses.load(DB.AddJob.class, jobid);
                DB.Order or = new Order();
                DB.User u = (DB.User) ses.load(DB.User.class, send_user_id);
                DB.User u1 = (DB.User) ses.load(DB.User.class, receiver_user_id);
                or.setUserBySendOrderUser(u);
                or.setUserByReceiverUser(u1);
                or.setAddJob(adj);
                or.setOrderDetails(orde);
                or.setStatus(2);
                ses.save(or);
                tr.commit();
                ses.flush();
                ses.close();
                
                response.sendRedirect("View_job.jsp?id="+Security.Security.encrypt(jobid+""));


            } else {
                response.sendRedirect("index.jsp");
            }



        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
