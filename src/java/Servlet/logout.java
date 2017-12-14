package Servlet;

import DB.UserLoginDetails;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
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
public class logout extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {

                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                HttpSession s = request.getSession();

                if (s.getAttribute("uld") != null) {

                    DB.UserLoginDetails uld = (DB.UserLoginDetails) s.getAttribute("uld");
                    uld.setDescription("");
                    uld.setIduserLoginDetails(uld.getIduserLoginDetails());
                    uld.setIntime(uld.getIntime());
                    uld.setIpaddress(uld.getIpaddress());
                    uld.setOuttime(new Date() + "");
                    uld.setUserLogin(uld.getUserLogin());
                    uld.setBrowserDetails(uld.getBrowserDetails());
                    uld.setOperationSystem(uld.getOperationSystem());
                    uld.setMacAddress(uld.getMacAddress());
                    uld.setDescription(uld.getDescription());
                    ses.update(uld);
                    tr.commit();
                    ses.flush();
                    ses.close();

                }

                HttpSession ss = request.getSession();
                ss.invalidate();
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                response.setHeader("Pragma", "no-cache"); // HTTP 1.0
                response.setDateHeader("Expires", 0);
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
