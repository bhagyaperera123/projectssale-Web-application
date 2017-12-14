package Servlet;

import DB.Database1;
import DB.JobCategory;
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
public class Add_job_category extends HttpServlet {

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
                        DB.JobCategory db = new JobCategory();
                        db.setCategoryName(name);
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
                    System.out.println(id);
                    Criteria cr = ses.createCriteria(DB.JobCategory.class);
                    cr.add(Restrictions.eq("idjobType", Integer.parseInt(id)));
                    DB.JobCategory db = (DB.JobCategory) cr.uniqueResult();
                    if (db != null) {

                        db.setCategoryName(db.getCategoryName());
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
                    System.out.println(id);
                    Criteria cr = ses.createCriteria(DB.JobCategory.class);
                    cr.add(Restrictions.eq("idjobType", Integer.parseInt(id)));
                    DB.JobCategory db = (DB.JobCategory) cr.uniqueResult();
                    if (db != null) {

                        db.setCategoryName(db.getCategoryName());
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
