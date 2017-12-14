/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DB.Database1;
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
public class Add_Database extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                String type = request.getParameter("type");
                if (type.equals("add")) {
                    String name = request.getParameter("name");
                    if (name.equals("")) {
                        out.write("4");
                    } else {
                        DB.Database1 db = new Database1();
                        db.setName(name);
                        db.setStatus(1);
                        ses.save(db);
                        tr.commit();
                        ses.flush();
                        ses.close();
                        out.write("1");
                        System.out.println(name);
                    }
                } else if (type.equals("remove")) {
                    String id = request.getParameter("id");
                    Criteria cr = ses.createCriteria(DB.Database1.class);
                    cr.add(Restrictions.eq("idDatabase", Integer.parseInt(id)));
                    DB.Database1 db = (DB.Database1) cr.uniqueResult();
                    if (db != null) {

                        db.setName(db.getName());
                        db.setStatus(0);
                        ses.update(db);
                        tr.commit();
                        ses.flush();
                        ses.close();
                        out.write("1");
                    } else {
                        out.write("3");
                    }
                } else if (type.equals("active")) {
                    String id = request.getParameter("id");
                    Criteria cr = ses.createCriteria(DB.Database1.class);
                    cr.add(Restrictions.eq("idDatabase", Integer.parseInt(id)));
                    DB.Database1 db = (DB.Database1) cr.uniqueResult();
                    if (db != null) {

                        db.setName(db.getName());
                        db.setStatus(1);
                        ses.update(db);
                        tr.commit();
                        ses.flush();
                        ses.close();
                        out.write("1");
                    } else {
                        out.write("3");
                    }
                } else {
                    out.write("2");
                }


            } else {
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
