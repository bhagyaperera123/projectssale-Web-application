package Servlet;

import DB.UserLoginDetails;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
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
public class login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            String ipAddress = request.getRemoteAddr();
            PrintWriter out = response.getWriter();
            String uname = request.getParameter("un");
            String pass = request.getParameter("ps");
            System.out.println(uname);
            System.out.println(pass);
            if (uname != "") {

                if (pass != "") {

                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    Transaction tr = ses.beginTransaction();
                    Criteria cr = ses.createCriteria(DB.UserLogin.class);
                    cr.add(Restrictions.eq("uname", uname));
                    cr.add(Restrictions.eq("password", pass));

                    DB.UserLogin ul = (DB.UserLogin) cr.uniqueResult();
                    if (ul != null) {
                        if (ul.getStatus() == 1) {
                            // System.out.println("uset Active :" + ul.getStatus());

                            String browserDetails = request.getHeader("User-Agent");
                            String userAgent = browserDetails;
                            String user = userAgent.toLowerCase();

                            String os = "";
                            String browser = "";

                            System.out.println("User Agent for the request is===>" + browserDetails);
                            //=================OS=======================
                            if (userAgent.toLowerCase().indexOf("windows") >= 0) {
                                os = "Windows";
                            } else if (userAgent.toLowerCase().indexOf("mac") >= 0) {
                                os = "Mac";
                            } else if (userAgent.toLowerCase().indexOf("x11") >= 0) {
                                os = "Unix";
                            } else if (userAgent.toLowerCase().indexOf("android") >= 0) {
                                os = "Android";
                            } else if (userAgent.toLowerCase().indexOf("iphone") >= 0) {
                                os = "IPhone";
                            } else {
                                os = "UnKnown, More-Info: " + userAgent;
                            }
                            //===============Browser===========================
                            if (user.contains("msie")) {
                                String substring = userAgent.substring(userAgent.indexOf("MSIE")).split(";")[0];
                                browser = substring.split(" ")[0].replace("MSIE", "IE") + "-" + substring.split(" ")[1];
                            } else if (user.contains("safari") && user.contains("version")) {
                                browser = (userAgent.substring(userAgent.indexOf("Safari")).split(" ")[0]).split("/")[0] + "-" + (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
                            } else if (user.contains("opr") || user.contains("opera")) {
                                if (user.contains("opera")) {
                                    browser = (userAgent.substring(userAgent.indexOf("Opera")).split(" ")[0]).split("/")[0] + "-" + (userAgent.substring(userAgent.indexOf("Version")).split(" ")[0]).split("/")[1];
                                } else if (user.contains("opr")) {
                                    browser = ((userAgent.substring(userAgent.indexOf("OPR")).split(" ")[0]).replace("/", "-")).replace("OPR", "Opera");
                                }
                            } else if (user.contains("chrome")) {
                                browser = (userAgent.substring(userAgent.indexOf("Chrome")).split(" ")[0]).replace("/", "-");
                            } else if ((user.indexOf("mozilla/7.0") > -1) || (user.indexOf("netscape6") != -1) || (user.indexOf("mozilla/4.7") != -1) || (user.indexOf("mozilla/4.78") != -1) || (user.indexOf("mozilla/4.08") != -1) || (user.indexOf("mozilla/3") != -1)) {
                                //browser=(userAgent.substring(userAgent.indexOf("MSIE")).split(" ")[0]).replace("/", "-");
                                browser = "Netscape-?";

                            } else if (user.contains("firefox")) {
                                browser = (userAgent.substring(userAgent.indexOf("Firefox")).split(" ")[0]).replace("/", "-");
                            } else if (user.contains("rv")) {
                                browser = "IE";
                            } else {
                                browser = "UnKnown, More-Info: " + userAgent;
                            }
                            System.out.println("Operating System======>" + os);
                            System.out.println("Browser Name==========>" + browser);


                            InetAddress ip;
                            String ipaddress = "";
                            String macaddress = "";
                            try {

                                ip = InetAddress.getLocalHost();
                                // System.out.println("Current IP address : " + ip.getHostAddress());
                                ipaddress = ip.getHostAddress();
                                NetworkInterface network = NetworkInterface.getByInetAddress(ip);

                                byte[] mac = network.getHardwareAddress();

                                //System.out.print("Current MAC address : ");

                                StringBuilder sb = new StringBuilder();
                                for (int i = 0; i < mac.length; i++) {
                                    sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
                                }
                                //  System.out.println(sb.toString());
                                macaddress = sb.toString();

                            } catch (UnknownHostException e) {

                                e.printStackTrace();

                            } catch (SocketException e) {

                                e.printStackTrace();

                            }

                            System.out.println("IP Address :" + ipaddress);
                            System.out.println("Mac Address :" + macaddress);

                            if (ul.getUserType().getStatus() == 1) {
                                HttpSession ss = request.getSession();
                                ss.setAttribute("fname", ul.getUser().getFname());
                                ss.setAttribute("type", ul.getUserType().getIdUserType());
                                ss.setAttribute("user", ul.getIduserLogin());
                                ss.setAttribute("user_path", ul.getLocation());
                                ss.setAttribute("job_path", ul.getJobLocation());
                                DB.UserLoginDetails uld = new UserLoginDetails();
                                uld.setDescription(browserDetails);
                                uld.setIntime(new Date() + "");
                                uld.setIpaddress(ipAddress);
                                uld.setOuttime("");
                                uld.setUserLogin(ul);
                                uld.setMacAddress(macaddress);
                                uld.setOperationSystem(os);
                                uld.setBrowserDetails(browser);
                                ses.save(uld);
                                ss.setAttribute("uld", uld);
                                tr.commit();
                                ses.flush();
                                ses.close();
                                response.sendRedirect("Home.jsp");
                            } else {
                                response.sendRedirect("under_construction.jsp");
                            }

                        } else if (ul.getStatus() == 2) {
                            response.sendRedirect("index.jsp?block=User allready block please contact admin");
                        } else if (ul.getStatus() == 0) {
                            response.sendRedirect("index.jsp?delete=User allready delete please contact admin");
                        }

                    } else {
                        out.write("3");
                        // System.out.println("error");
                        response.sendRedirect("index.jsp");
                    }

                } else {
                    out.write("2");
                    response.sendRedirect("index.jsp");
                }

            } else {
                out.write("1");
                response.sendRedirect("index.jsp");
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
