/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class Send_Mail_For_Invoice {
    
    public void sendHtmlEmail(String host, String port, final String userName, final String password, String toAddress, String subject, String message) throws AddressException,
            MessagingException {

        // sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };

        Session session = Session.getInstance(properties, auth);

        // creates a new e-mail message
        Message msg = new MimeMessage(session);

        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = {new InternetAddress(toAddress)};
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        // set plain text message
        msg.setContent(message, "text/html");

        // sends the e-mail
        Transport.send(msg);

    }

    public static int send_Mail_For_Invoice(String tomail , String id) {
        int reval = 0;
        boolean b = false;
        String uid = "";
        String val = "ihdiahsjdbnijadk";
        org.hibernate.Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
        Criteria cr = ses.createCriteria(DB.User.class);
        cr.add(Restrictions.eq("email", tomail));
        DB.User u = (DB.User) cr.uniqueResult();
        if (u != null) {
            b = true;
            try {
                uid += Security.Security.encrypt(u.getIduser() + "");
            } catch (Exception e) {
            }
        } else {
            reval = 3;
            b = false;
        }

        if (b) {
            String link ="";
            try {
                String pro_id = id;
               link += "http://localhost:8080/Projectssale.com/Download_File.jsp?val=" + Security.Security.encrypt(val+"hjsdcars6fastdyasbbhgsd56rasnsjdjjijdc67677")+"&code="+Security.Security.encrypt("ysgdhab878sdf7dvtgsd65dvsd56rsdrd5fvdfr5rfv6fdyf")+"&id="+Security.Security.encrypt(uid+"")+"&proid="+pro_id;
            } catch (Exception e) {
            }
            // SMTP server information
            String host = "smtp.gmail.com";
            String port = "587";
            String mailFrom = "bsoftsoftwresolution@gmail.com";
            String password = "bhagyasolution";

            // outgoing message information
            String mailTo = tomail;
            String subject = "Recover Your Password";

            // message contains HTML markups
            String message = "<h2>Recover Your Password?</h2><br>";
            message += "Please Go to the link and download file";
            message += "<a href='" + link + "'><button style=' width='40px' height='200px' '>Download</button></a>";

            Send_Mail mailer = new Send_Mail();

            try {
                mailer.sendHtmlEmail(host, port, mailFrom, password, mailTo, subject, message);
                System.out.println("Email sent.");
                reval = 1;
                return reval;
            } catch (Exception ex) {
                System.out.println("Failed to sent email.");
                ex.printStackTrace();
                reval = 2;
                return reval;
            }

        }
        return reval;
    }
    
}
