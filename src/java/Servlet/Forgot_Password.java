package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Bhagya
 */
public class Forgot_Password extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            String email_Address = request.getParameter("email");

            int i = Model.Send_Mail.sendMail(email_Address);
            out.write(i);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
