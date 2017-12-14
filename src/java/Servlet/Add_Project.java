package Servlet;

import DB.Projects;
import DB.UploadDemo;
import DB.UploadFile;
import DB.UploadPic;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Bhagya
 */
public class Add_Project extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {

            HttpSession ss1 = request.getSession();

            if (ss1.getAttribute("user") != null) {
                String img_name = "";
                String file_name = "";
                String demo_name = "";

                String pro_Lan = "";
                String database = "";
                String description = "";

                String title_ = "";
                String price_ = "";
                String scate = "";
                String category = "";

                String img_location = "";
                String file_location = "";
                String demo_Location = "";
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);

                List<Object> items = upload.parseRequest(request);
                for (Object element : items) {

                    FileItem fileItem = (FileItem) element;

                    if (fileItem.isFormField()) {
                        if (fileItem.getFieldName().equals("title")) {
                            title_ = fileItem.getString();
                        }
                        if (fileItem.getFieldName().equals("category")) {
                            category = fileItem.getString();
                        }
                        if (fileItem.getFieldName().equals("price")) {
                            price_ = fileItem.getString();
                        }
                        if (fileItem.getFieldName().equals("db")) {
                            database = fileItem.getString();
                        }
                        if (fileItem.getFieldName().equals("description")) {
                            description = fileItem.getString();
                        }
                        if (fileItem.getFieldName().equals("scate")) {
                            scate = fileItem.getString();
                        }
                        for (int i = 0; i < 10; i++) {
                            if (fileItem.getFieldName().equals(i + "")) {
                                pro_Lan += fileItem.getString() + ",";
                            }
                        }
                    } else {

                        HttpSession ss = request.getSession();
                        String path = ss.getAttribute("user_path").toString();
                        path += "\\Projects";
                        File f = new File(request.getServletContext().getRealPath("/") + path);
                        f.mkdir();
                        String s1 = path + "\\" + title_;
                        File f3 = new File(request.getServletContext().getRealPath("/") + s1);
                        f3.mkdir();
                        path += "\\" + title_;
                        File f2 = new File(request.getServletContext().getRealPath("/") + path + "/img");
                        File f1 = new File(request.getServletContext().getRealPath("/") + path + "/file");
                        File f4 = new File(request.getServletContext().getRealPath("/") + path + "/demo");
                        f1.mkdir();
                        f2.mkdir();
                        f4.mkdir();
                        if (fileItem.getFieldName().equals("imgfile")) {
                            img_name = fileItem.getName();
                            String imagepath = request.getServletContext().getRealPath("/") + path + "\\img\\" + img_name;
                            File up = new File(imagepath);
                            fileItem.write(up);
                        }
                        if (fileItem.getFieldName().equals("upfile")) {
                            file_name = fileItem.getName();
                            String filepath = request.getServletContext().getRealPath("/") + path + "\\file\\" + file_name;
                            System.out.println(filepath);
                            File fileup = new File(filepath);
                            fileItem.write(fileup);
                        }
                        if (fileItem.getFieldName().equals("demo")) {
                            demo_name = fileItem.getName();
                            String demopath = request.getServletContext().getRealPath("/") + path + "\\demo\\" + demo_name;
                            System.out.println(" demo path :"+demopath);
                            File fileup = new File(demopath);
                            fileItem.write(fileup);
                        }
                        System.out.println(demo_Location);
                        img_location = path + "\\img\\" + img_name;
                        file_location = path + "\\file\\" + file_name;
                        demo_Location = path + "\\demo\\" + file_name;
                    }
                }

                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();

                DB.UploadFile ufile = new UploadFile();
                ufile.setPath(file_location);
                ufile.setName(file_name);

                DB.UploadPic upic = new UploadPic();
                upic.setPath(img_location);
                upic.setName(img_name);
                
                DB.UploadDemo demo = new UploadDemo();
                demo.setName(demo_name);
                demo.setPath(demo_Location);
                ses.save(demo);
                ses.save(upic);
                ses.save(ufile);
                DB.Projects pro = new Projects();
                pro.setProjectName(title_);
                pro.setPrice(price_);
                pro.setUploadDemo(demo);
                DB.Category cte = (DB.Category) ses.load(DB.Category.class, Integer.parseInt(category));
                pro.setCategory(cte);
                DB.SubCategory sb = (DB.SubCategory) ses.load(DB.SubCategory.class, Integer.parseInt(scate));
                pro.setSubCategory(sb);
                pro.setDescription(description);
                DB.Database1 dbs = (DB.Database1) ses.load(DB.Database1.class, Integer.parseInt(database));
                pro.setDatabase1(dbs);
                pro.setProLan(pro_Lan);
                DB.User u = (DB.User) ses.load(DB.User.class, Integer.parseInt(ss1.getAttribute("user").toString()));
                pro.setUser(u);
                pro.setUploadPic(upic);
                pro.setUploadFile(ufile);
                pro.setStatus(0);
                ses.save(pro);

                tr.commit();
                ses.flush();
                ses.close();
                response.sendRedirect("Project_success.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
