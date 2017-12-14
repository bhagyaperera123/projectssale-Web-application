//package Mobile;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import javax.json.Json;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import org.hibernate.Criteria;
//import org.hibernate.Session;
//import org.hibernate.Transaction;
//import org.hibernate.criterion.Restrictions;
//import org.json.simple.JSONObject;
//
///**
// *
// * @author Bhagya
// */
//public class M_Login extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            PrintWriter out = response.getWriter();
//            String UserName = request.getParameter("un");
//            String Password = request.getParameter("ps");
//            if (!UserName.equals("") & !Password.equals("")) {
//                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
//                Transaction tr = ses.beginTransaction();
//                Criteria cr = ses.createCriteria(DB.UserLogin.class);
//                cr.add(Restrictions.eq("uname", UserName));
//                cr.add(Restrictions.eq("password", Password));
//                DB.UserLogin ul = (DB.UserLogin) cr.uniqueResult();
//                JSONObject jo = new JSONObject();
//                if (ul != null) {
//                    if (ul.getStatus() == 1) {
//                        if ("User".equals(ul.getUserType().getRoleName())) {
//                            jo.put("logtype", "user");
//                            jo.put("uid", ul.getUser().getIduser());
//                            jo.put("unm", ul.getUname());
//                            jo.put("eml", ul.getUser().getEmail());
//                            jo.put("pass", ul.getPassword());
//                            jo.put("status", ul.getStatus());
//                        } else {
//                            jo.put("eml", ul.getUser().getEmail());
//                            jo.put("logtype", "admin");
//                            jo.put("uid", ul.getUser().getIduser());
//                            jo.put("unm", ul.getUname());
//                            jo.put("pass", ul.getPassword());
//                            jo.put("status", ul.getStatus());
//                        }
//                        JSONObject job = new JSONObject();
//                        job.put("log", jo);
//                        out.write(job.toJSONString());
//                    }
//                }
//            } else {
//                out.write("worng password!");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}
