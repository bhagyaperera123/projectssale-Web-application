/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DB.UserType;
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
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class removeUserType extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
                        HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
            String reval = "";
            
            int type = Integer.parseInt(request.getParameter("id"));

            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Transaction tr = ses.beginTransaction();

            Criteria cr = ses.createCriteria(DB.UserType.class);
            cr.add(Restrictions.eq("idUserType", type));
            DB.UserType l = (DB.UserType) cr.uniqueResult();
            if (l != null) {
                l.setIdUserType(type);
                l.setRoleName(l.getRoleName());
                l.setStatus(0);
                ses.save(l);
                tr.commit();
                ses.close();
                reval += "1";
            } else {
                reval += "2";
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
