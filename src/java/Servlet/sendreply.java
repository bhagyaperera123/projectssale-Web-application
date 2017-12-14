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
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Bhagya
 */
public class sendreply extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
                        HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();

            String id = request.getParameter("fromuser");
            String msg_txt = request.getParameter("msg");
            String msgid = request.getParameter("msgid");
            
            int to_uid = Integer.parseInt(Security.Security.decrypt(id));
            HttpSession hs = request.getSession();
            int from_uid = Integer.parseInt(hs.getAttribute("user").toString());

            DB.Message msg = new Message();
            DB.User u = (DB.User) ses.load(DB.User.class, from_uid);
            DB.User u1 = (DB.User) ses.load(DB.User.class, to_uid);
            msg.setUserByIduserForm(u);
            msg.setUserByIduserTo(u1);

            ses.save(msg);

            DB.MessageBody mbody = new MessageBody();
            mbody.setTime(new Date() + "");
            mbody.setMessage_1(msg_txt);
            mbody.setMessage(msg);
            ses.save(mbody);

            tr.commit();
            ses.flush();
            ses.close();
            response.sendRedirect("1");
            }else{
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
