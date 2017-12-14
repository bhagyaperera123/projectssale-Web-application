package Servlet;

import DB.SubCategory;
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
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class load_sub extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
                        HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
            PrintWriter out = response.getWriter();
            String reval = "";
            int id = Integer.parseInt(request.getParameter("cid").toString());

            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
            Criteria cr = ses.createCriteria(DB.Category.class);
            DB.CategoryType cty = (DB.CategoryType) ses.load(DB.CategoryType.class, id);
            cr.add(Restrictions.eq("categoryType", cty));

            List l = cr.list();
            reval += "<select class='form-control' name='scate' >";
            for (int i = 0; i < l.size(); i++) {
                DB.Category c = (DB.Category) l.get(i);
                reval += "<option value='" + c.getSubCategory().getIdSubCategory() + "'> " + c.getSubCategory().getName() + " </option>";
            }
            reval += "</select>";

            out.write(reval);
            }else{
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
