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
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class load_user_profile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            HttpSession ss = request.getSession();
            if(ss.getAttribute("user")!= null){
            int uid = Integer.parseInt(ss.getAttribute("user").toString());
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            DB.User u = (DB.User) ses.load(DB.User.class, uid);
            Criteria cr = ses.createCriteria(DB.UserLogin.class);
            cr.add(Restrictions.eq("user", u));
            DB.UserLogin ul = (DB.UserLogin) cr.uniqueResult();
            if (ul != null) {
                String s = "";
                s += "<fieldset>\n"
                        + "                                                    <!-- Text input-->\n"
                        + "                                                    <div class=\"form-group\">\n"
                        + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">First Name</label>\n"
                        + "                                                        <div class=\"col-sm-10\">\n"
                        + "                                                            <input type=\"text\" name='fname' placeholder=\"Enter First Name\" value='" + ul.getUser().getFname() + "' class=\"form-control\">\n"
                        + "                                                        </div>\n"
                        + "                                                    </div>\n"
                        + "\n"
                        + "                                                    <!-- Text input-->\n"
                        + "                                                    <div class=\"form-group\">\n"
                        + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">Last Name</label>\n"
                        + "                                                        <div class=\"col-sm-10\">\n"
                        + "                                                            <input type=\"text\" name='lname'  placeholder=\"\" value='" + ul.getUser().getLname() + "' class=\"form-control\">\n"
                        + "                                                        </div>\n"
                        + "                                                    </div>\n"
                        + "\n"
                        + "                                                    <!-- Text input-->\n"
                        + "                                                    <div class=\"form-group\">\n"
                        + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">Email</label>\n"
                        + "                                                        <div class=\"col-sm-10\">\n"
                        + "                                                            <input type=\"email\" name='email'  placeholder=\"\" value='" + ul.getUser().getEmail() + "' class=\"form-control\">\n"
                        + "                                                        </div>\n"
                        + "                                                    </div>\n"
                        + "\n"
                        + "                                                    <!-- Text input-->\n"
                        + "                                                    <div class=\"form-group\">\n"
                        + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">Description</label>\n"
                        + "                                                        <div class=\"col-sm-10\">\n"
                        + "                                                            <textarea style=\"height: 200px;\" name='description' value='' type=\"text\" placeholder=\"Description\" class=\"form-control\">" + ul.getUser().getDescription() + "</textarea>\n"
                        + "                                                        </div>\n"
                        + "                                                    </div>\n"
                        + "                                                    <div class=\"form-group\">\n"
                        + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">User Name</label>\n"
                        + "                                                        <div class=\"col-sm-10\">\n"
                        + "                                                            <input type='text' name='unm' value='" + ul.getUname() + "'  placeholder=\"\" class=\"form-control\">\n"
                        + "                                                        </div>\n"
                        + "                                                    </div>\n"
                        + "                                                    <div class=\"form-group\">\n"
                        + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">Password</label>\n"
                        + "                                                        <div class=\"col-sm-10\">\n"
                        + "                                                            <input type=\"password\" name='password'  placeholder=\"\" class=\"form-control\">\n"
                        + "                                                        </div>\n"
                        + "                                                    </div>\n"
                        + "                                                    <div class=\"form-group\">\n"
                        + "                                                        <label style=\"font-size: 12px;\" class=\"col-sm-2 control-label\" for=\"textinput\">New Password</label>\n"
                        + "                                                        <div class=\"col-sm-10\">\n"
                        + "                                                            <input type=\"text\" name='npass' placeholder=\"\" class=\"form-control\">\n"
                        + "                                                        </div>\n"
                        + "                                                    </div>\n"
                        + "                                                    <div style=\"font-size: 12px;\" class=\"form-group\">\n"
                        + "                                                        <label class=\"col-sm-2 control-label\" for=\"textinput\">Confirm New Password</label>\n"
                        + "                                                        <div class=\"col-sm-10\">\n"
                        + "                                                            <input type=\"text\" name='cpass' placeholder=\"\" class=\"form-control\">\n"
                        + "                                                        </div>\n"
                        + "                                                    </div>\n"
                        + "                                                </fieldset>";
                out.write(s);
            }
            }else{
                response.sendRedirect("index.jsp");
            }
            
        } catch (Exception e) {
        }
    }
}
