package Servlet;

import DB.AddJob;
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
public class add_job extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        try {
            HttpSession ss = request.getSession();

            if (ss.getAttribute("user") != null) {

                String path = ss.getAttribute("job_path").toString();
                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = ses.beginTransaction();
                Model.add_job aj = new Model.add_job();
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                String price = "";
                List<Object> items = upload.parseRequest(request);
                for (Object element : items) {

                    FileItem fileItem = (FileItem) element;

                    if (fileItem.isFormField()) {

                        if (fileItem.getFieldName().equals("title")) {
                            aj.setTitle(fileItem.getString());
                            File file = new File(request.getServletContext().getRealPath("/") + path + "/" + fileItem.getString());
                            file.mkdir();
                        }
                        if (fileItem.getFieldName().equals("category")) {
                            aj.setCategory(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("description")) {
                            aj.setDescription(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("dura")) {
                            aj.setDuration1(fileItem.getString());
                        }
                        if (fileItem.getFieldName().equals("price")) {
                            price = fileItem.getString();
                        }

                        if (fileItem.getFieldName().equals("INSTRUCTIONS_FOR_BUYER")) {
                            aj.setI_FOR_B(fileItem.getString());
                        }
                        for (int i = 0; i < 10; i++) {
                            if (fileItem.getFieldName().equals(i + "")) {
                                aj.setProgram_lan(aj.getProgram_lan() + fileItem.getString() + ",");
                            }
                        }
                    } else {
                        if (fileItem.getFieldName().equals("dphoto")) {
                            aj.setDisplay_photo(fileItem.getName());
                        }

                        path += "\\" + aj.getTitle() + "\\" + aj.getDisplay_photo();
                        System.out.println(request.getServletContext().getRealPath("/")+path);
                        File savedFile = new File(request.getServletContext().getRealPath("/") + path);
                        fileItem.write(savedFile);
                    }
                }

                DB.AddJob add_job = new AddJob();
                add_job.setTitle(aj.getTitle());
                add_job.setDescription(aj.getDescription());
                add_job.setTags(aj.getProgram_lan());
                add_job.setInstructionsForBuyer(aj.getI_FOR_B());
                DB.JobPriceList jpl = (DB.JobPriceList) ses.load(DB.JobPriceList.class, Integer.parseInt(price));
                add_job.setJobPriceList(jpl);
                DB.JobDisplayPhoto dp = new DB.JobDisplayPhoto();
                dp.setPath(path);
                ses.save(dp);

                DB.JobCategory jc = (DB.JobCategory) ses.load(DB.JobCategory.class, Integer.parseInt(aj.getCategory()));
                DB.JobDuration jdu = (DB.JobDuration) ses.load(DB.JobDuration.class, Integer.parseInt(aj.getDuration1()));

                add_job.setJobCategory(jc);
                add_job.setJobDuration(jdu);
                DB.User u = (DB.User) ses.load(DB.User.class, Integer.parseInt(ss.getAttribute("user").toString()));
                add_job.setUser(u);
                add_job.setJobDisplayPhoto(dp);
                add_job.setStatus(0);
                ses.save(add_job);
                tr.commit();
                ses.flush();
                ses.close();
                response.sendRedirect("job_success.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
