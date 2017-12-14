package Servlet;

import DB.Cart;
import DB.CartHasProject;
import DB.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Bhagya
 */
public class ViewCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
                String t = "";
                HttpSession hs = request.getSession();
                int id = Integer.parseInt(hs.getAttribute("user").toString());
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                User us = (User) ses.load(DB.User.class, id);
                Criteria cr = ses.createCriteria(DB.Cart.class);
                cr.add(Restrictions.eq("user", us));
                Cart crt = (Cart) cr.uniqueResult();
                if (crt != null) {
                    String url = "payment_form.jsp?";
                    Query qr = ses.createQuery("from CartHasProject where cart='" + crt.getIdcart() + "'");
                    List<DB.CartHasProject> chp = qr.list();

                    t += "<thead>\n"
                            + "                                    <tr>\n"
                            + "                                        <th>Product</th>\n"
                            + "                                        <th class=\"text-center\">Quantity</th>\n"
                            + "                                        <th class=\"text-center\">Price</th>\n"
                            + "                                        <th class=\"text-center\">Total</th>\n"
                            + "                                        <th></th>\n"
                            + "                                    </tr>\n"
                            + "                                </thead>";

                    double net_tot = 0;
                    t += "<tbody>";
                    double qty = 0;
                    for (CartHasProject c : chp) {
                        DB.Projects pro = (DB.Projects) ses.load(DB.Projects.class, c.getProjects().getIdprojects());
                        if (c.getIsPurchase() == 0) {

                            t += "<tr>\n"
                                    + "                                        <td class=\"col-md-6\">\n"
                                    + "                                            <div class=\"media\">\n"
                                    + "                                                <a class=\"thumbnail pull-left\" href=\"#\"> <img class='media-object' src='" + pro.getUploadPic().getPath() + "' style='width: 72px; height: 72px;'> </a>\n"
                                    + "                                                <div class=\"media-body\">\n"
                                    + "                                                    <h4 class=\"media-heading\"><a href=\"#\">" + pro.getProjectName() + "</a></h4>\n"
                                    + "                                                </div>\n"
                                    + "                                            </div></td>\n"
                                    + "                                        \n"
                                    + "                                        <td class=\"col-md-1 text-center\"><strong>" + c.getQty() + "</strong></td>\n"
                                    + "                                        <td class=\"col-md-1 text-center\"><strong>" + pro.getPrice() + "</strong></td>\n"
                                    + "                                        <td class=\"col-md-1 text-center\"><strong>" + c.getPrice() + "</strong></td>\n"
                                    + "                                        <td class=\"col-md-1\">\n"
                                    + "                                            <button onclick='removecart(" + pro.getIdprojects() + "," + c.getCart().getIdcart() + ")' type=\"button\" class=\"btn btn-danger\">\n"
                                    + "                                                <span class=\"glyphicon glyphicon-remove\"></span> Remove\n"
                                    + "                                            </button></td>\n"
                                    + "                                    </tr>";
                            net_tot += c.getPrice();
                            qty += c.getQty();
                        }
                    }

                    t += "<tr>\n"
                            + "                                        <td></td>\n"
                            + "                                        <td></td>\n"
                            + "                                        <td></td>\n"
                            + "                                        <td><h5>Subtotal</h5></td>\n"
                            + "                                        <td class=\"text-right\"><h5><strong>RS." + net_tot + "</strong></h5></td>\n"
                            + "                                    </tr>\n"
                            + "                                    <tr>\n"
                            + "                                        <td></td>\n"
                            + "                                        <td></td>\n"
                            + "                                        <td></td>\n"
                            + "                                        <td><h3>Total</h3></td>\n"
                            + "                                        <td class=\"text-right\"><h3><strong>RS." + net_tot + "</strong></h3></td>\n"
                            + "                                    </tr>\n";
                    t += "                                    <tr>\n";

                    url += "tot=" +net_tot + "&qty=" + Security.Security.encrypt(qty + "") + "&cart=" + Security.Security.encrypt(crt.getIdcart() + "");
                    t += "                                        <td></td>\n"
                            + "                                        <td></td>\n"
                            + "                                        <td></td>\n"
                            + "                                        <td>\n"
                            + "                                           <a href='Home.jsp'> <button type=\"button\" class=\"btn btn-default\">\n"
                            + "                                                <span class=\"glyphicon glyphicon-shopping-cart\"></span> Continue Shopping\n"
                            + "                                            </button></td></a>\n"
                            + "                                        <td>\n";
                    if (crt.getTotalAmount() != 0.0) {
                        t += "                                            <a href='" + url + "'><button onclick='Checkout()' type=\"button\" class=\"btn btn-success\">\n"
                                + "                                                Checkout <span class=\"glyphicon glyphicon-play\"></span>\n";
                        t += "                                            </button></a></td>\n";
                    }
                    t += "                                    </tr>";
                    t += "</tbody>";

                    out.write(t);
                } else {
                    out.write("Your Cart Null");
                }
            } else {
                response.sendRedirect("index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
