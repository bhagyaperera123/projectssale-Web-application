/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Mobile;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class load_p_Des extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            
            int ProID = Integer.parseInt(request.getParameter("pid"));
            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.Projects.class);
            cr.add(Restrictions.eq("idprojects", ProID));
            DB.Projects pro = (DB.Projects) cr.uniqueResult();
            out.write(pro.getDescription());
            ses.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
