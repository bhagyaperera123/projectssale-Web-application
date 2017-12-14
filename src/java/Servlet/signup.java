package Servlet;

import DB.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class signup extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            PrintWriter out = response.getWriter();
//            String path = "C:/Users/Bhagya/Desktop/Projectssale.com/build/web/upload/Users";
            String path = "upload\\Users\\";
            String fnm = request.getParameter("fn");
            String lnm = request.getParameter("ln");
            String unm = request.getParameter("un");
            String pas = request.getParameter("ps");
            String email = request.getParameter("email");
            if (fnm != "" && lnm != "" && unm != "" && pas != "" && email != "") {
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                DB.User u = new User();
                u.setEmail(email);
                u.setFname(fnm);
                u.setLname(lnm);

                DB.UserLogin ul = new DB.UserLogin();
                ul.setUname(unm);
                ul.setPassword(pas);
                ul.setUser(u);
                ul.setStatus(1);
                ul.setLocation(path + unm + "_" + email);
                ul.setJobLocation(path + unm + "_" + email+"\\jobs");
                DB.UserType ut = (DB.UserType) ses.load(DB.UserType.class, 2);
                ul.setUserType(ut);
                ses.save(u);
                ses.save(ul);
                tr.commit();
                ses.flush();
                ses.close();
                path += unm+"_"+email;
                File f = new File(request.getServletContext().getRealPath("\\")+path);
                File f2 = new File(request.getServletContext().getRealPath("\\")+path+"\\jobs");
                f.mkdir();
                f2.mkdir();
                HttpSession ss = request.getSession();
                ss.setAttribute("fname", fnm);
                ss.setAttribute("type", 1);
                ss.setAttribute("user", u);
                response.sendRedirect("Home.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
