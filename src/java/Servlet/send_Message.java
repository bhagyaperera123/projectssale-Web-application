package Servlet;

import DB.Message;
import DB.MessageBody;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Bhagya
 */
public class send_Message extends HttpServlet {

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
                String a = Security.Security.encrypt("msgbody");
                String msg_body = request.getParameter(a);
                
                DB.Message msg = new Message();
                DB.User u = (DB.User) ses.load(DB.User.class, send_user_id);
                DB.User u1 = (DB.User) ses.load(DB.User.class, receiver_user_id);
                msg.setUserByIduserForm(u);
                msg.setUserByIduserTo(u1);
                
                ses.save(msg);
                
                DB.MessageBody mbody = new MessageBody();
                mbody.setTime(new Date()+"");
                mbody.setMessage_1(msg_body);
                mbody.setMessage(msg);
                ses.save(mbody);
                
                tr.commit();
                ses.flush();
                ses.close();
                int jobid = Integer.parseInt(request.getParameter("jobid").toString());
                response.sendRedirect("View_job.jsp?id="+Security.Security.encrypt(jobid+""));
            } else {
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
