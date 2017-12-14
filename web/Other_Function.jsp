<%-- 
    Document   : Admin_Profie
    Created on : Feb 20, 2015, 5:27:01 PM
    Author     : Bhagya
--%>
<%@page import="java.util.List"%>
<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Admin | Create Account</title>
        <link rel="stylesheet" type="text/css" href="datatable/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="admin/css/style01.css">

        <script type="text/javascript" language="javascript" src="datatable/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" language="javascript" src="Ajax/Ajax_data.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <script>            
            function htmlbodyHeightUpdate(){
                var height3 = $( window ).height()
                var height1 = $('.nav').height()+50
                height2 = $('.main').height()
                if(height2 > height3){
                    $('html').height(Math.max(height1,height3,height2)+10);
                    $('body').height(Math.max(height1,height3,height2)+10);
                }
                else
                {
                    $('html').height(Math.max(height1,height3,height2));
                    $('body').height(Math.max(height1,height3,height2));
                }
		
            }
            $(document).ready(function () {
                htmlbodyHeightUpdate()
                $( window ).resize(function() {
                    htmlbodyHeightUpdate()
                });
                $( window ).scroll(function() {
                    height2 = $('.main').height()
                    htmlbodyHeightUpdate()
                });
            });
        </script>
    </head>
    <body style="">
        <%@include file="slide_nav.jsp" %>
        <%
            Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
            HttpSession s = request.getSession();
            int type = Integer.parseInt(s.getAttribute("type").toString());
            DB.UserType ut1 = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 17);
            Criteria crr = sess.createCriteria(DB.UserTypeHasUserPage.class);
            crr.add(Restrictions.eq("userType", ut1));
            crr.add(Restrictions.eq("userPage", up1));
            DB.UserTypeHasUserPage ll = (DB.UserTypeHasUserPage) crr.uniqueResult();
            if (ll != null) {
                System.out.println("list not null");
            } else {
                System.out.println("list null");
                response.sendRedirect("Admin_Console.jsp");
            }
        %>
        <div class="main"> 
            <h2 class="bg-primary" style="padding-left: 100px"><samp>Add New Database</samp></h2>
            <div class="container">
                <div class="row">
                    <div class="col-md-5">
                        <h3 class="dark-grey">Add New Database</h3>
                        <div class="form-group col-lg-6">
                            <label>Database Name</label>
                            <input id="dbname" type="text" name="type" class="form-control" id="" value="">
                            <br/>
                            <button onclick="Add_database()" class="btn btn-success">Add Database</button>
                        </div>	
                    </div>
                    <div class="col-md-6">
                        <h3 class="dark-grey">Databases</h3>
                        <%
                            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                            Criteria cr2 = ses.createCriteria(DB.Database1.class);
                            List<DB.Database1> l2 = cr2.list();
                            for (DB.Database1 up : l2) {
                                if (up.getStatus() != 0) {
                        %>
                        <div class="col-md-5">
                            <label name="<%=up.getIdDatabase()%>" value="<%=up.getIdDatabase()%>"><%=up.getName()%> &nbsp;&nbsp; <a href="" onclick="remove_database(<%=up.getIdDatabase()%>)" style="color: red;" class="glyphicon glyphicon-remove"></a></label>
                        </div>
                        <%}
                            }%>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <h3 class="dark-grey">Remove Item</h3>
                            <%
                                for (DB.Database1 up : l2) {
                                    if (up.getStatus() != 1) {
                            %>
                            <div class="col-md-5">
                                <label><%=up.getName()%> &nbsp;&nbsp; <a href="" onclick="Active_database(<%=up.getIdDatabase()%>)" style="color: green;" class="glyphicon glyphicon-plus"></a></label>
                            </div>
                            <%}
                                }%>
                        </div>
                    </div>
                </div>
                <h2 class="bg-primary" style="padding-left: 100px"><samp>Add New Job Category</samp></h2>
                <div class="row">
                    <div class="col-md-5">
                        <h3 class="dark-grey">Add New Job Category</h3>
                        <div class="form-group col-lg-6">
                            <label>Category Name</label>
                            <input id="jobcatename" type="text" name="type" class="form-control" id="" value="">
                            <br/>
                            <button onclick="Add_job_category()" class="btn btn-success">Add</button>
                        </div>	
                    </div>
                    <div class="col-md-6">
                        <h3 class="dark-grey">Job Category</h3>
                        <%
                            Criteria cr3 = ses.createCriteria(DB.JobCategory.class);
                            List<DB.JobCategory> l3 = cr3.list();
                            for (DB.JobCategory up : l3) {
                                if (up.getStatus() != 0) {
                        %>
                        <div class="col-md-5">
                            <label name="" value=""><%=up.getCategoryName()%> &nbsp;&nbsp; <a href="" onclick="remove_job_Category(<%=up.getIdjobType()%>)" style="color: red;" class="glyphicon glyphicon-remove"></a></label>
                        </div>
                        <%}
                            }%>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <h3 class="dark-grey">Remove Item</h3>
                            <%
                                for (DB.JobCategory up : l3) {
                                    if (up.getStatus() != 1) {
                            %>
                            <div class="col-md-5">
                                <label><%=up.getCategoryName()%> &nbsp;&nbsp; <a href="" onclick="Active_job_Category(<%=up.getIdjobType()%>)" style="color: green;" class="glyphicon glyphicon-plus"></a></label>
                            </div>
                            <%}
                                }%>
                        </div>
                    </div>
                </div>
                <h2 class="bg-primary" style="padding-left: 100px"><samp>Add New Sub Category</samp></h2>
                <div class="row">
                    <div class="col-md-5">
                        <h3 class="dark-grey">Add New Sub Category</h3>
                        <div class="form-group col-lg-6">
                            <label>Category Name</label>
                            <input id="subname" type="text" name="type" class="form-control" id="" value="">
                            <br/>
                            <button onclick="Add_sub_category()" class="btn btn-success">Add</button>
                        </div>	
                    </div>
                    <div class="col-md-6">
                        <h3 class="dark-grey">Sub Category</h3>
                        <%
                            Criteria cr4 = ses.createCriteria(DB.SubCategory.class);
                            List<DB.SubCategory> l4 = cr4.list();
                            for (DB.SubCategory up : l4) {
                                if (up.getStatus() != 0) {
                        %>
                        <div class="col-md-5">
                            <label name="" value=""><%=up.getName()%> &nbsp;&nbsp; <a href="" onclick="remove_sub_Category(<%=up.getIdSubCategory()%>)" style="color: red;" class="glyphicon glyphicon-remove"></a></label>
                        </div>
                        <%}
                            }%>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <h3 class="dark-grey">Remove Item</h3>
                            <%
                                for (DB.SubCategory up : l4) {
                                    if (up.getStatus() != 1) {
                            %>
                            <div class="col-md-5">
                                <label><%=up.getName()%> &nbsp;&nbsp; <a href="" onclick="Active_sub_Category(<%=up.getIdSubCategory()%>)" style="color: green;" class="glyphicon glyphicon-plus"></a></label>
                            </div>
                            <%}
                                }%>
                        </div>
                    </div>
                </div>
                <h2 class="bg-primary" style="padding-left: 100px"><samp>Add New Category Type</samp></h2>
                <div class="row">
                    <div class="col-md-5">
                        <h3 class="dark-grey">Add New Category Type</h3>
                        <div class="form-group col-lg-6">
                            <label>Type Name</label>
                            <input id="catetypeid" type="text" name="type" class="form-control" id="" value="">
                            <br/>
                            <button onclick="Add_category_type()" class="btn btn-success">Add</button>
                        </div>	
                    </div>
                    <div class="col-md-6">
                        <h3 class="dark-grey">Category Type</h3>
                        <%
                            Criteria cr5 = ses.createCriteria(DB.CategoryType.class);
                            List<DB.CategoryType> l5 = cr5.list();
                            for (DB.CategoryType up : l5) {
                                if (up.getStatus() != 0) {
                        %>
                        <div class="col-md-5">
                            <label name="" value=""><%=up.getName()%> &nbsp;&nbsp; <a href="" onclick="remove_Category_type(<%=up.getIdCategoryType()%>)" style="color: red;" class="glyphicon glyphicon-remove"></a></label>
                        </div>
                        <%}
                            }%>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <h3 class="dark-grey">Remove Item</h3>
                            <%
                                for (DB.CategoryType up : l5) {
                                    if (up.getStatus() != 1) {
                            %>
                            <div class="col-md-5">
                                <label><%=up.getName()%> &nbsp;&nbsp; <a href="" onclick="Activate_Category_type(<%=up.getIdCategoryType()%>)" style="color: green;" class="glyphicon glyphicon-plus"></a></label>
                            </div>
                            <%}
                                }%>
                        </div>
                    </div>
                </div>
                <h2 class="bg-primary" style="padding-left: 100px"><samp>Category Has Subcategory</samp></h2>
                <div class="row">
                    <form action="Cate_has_Subcate" method="post">
                        <div class="col-md-5">
                            <h3 class="dark-grey">Add New Category Type</h3>
                            <div class="form-group col-lg-6">
                                <label>Type Name</label>
                                <select name="cgtp" class="form-control">
                                    <%
                                        Criteria cr6 = ses.createCriteria(DB.CategoryType.class);
                                        List<DB.CategoryType> l6 = cr6.list();
                                        for (DB.CategoryType up : l6) {
                                            
                                    %>
                                    <option value="<%=up.getIdCategoryType()%>"><%=up.getName()%></option>
                                    <%
                                    }%>
                                </select>
                                <br/>
                            </div>	
                        </div>
                        <div class="col-md-6">
                            <h3 class="dark-grey">Category Type</h3>
                            <div class="col-md-12">
                                <%
                                    Criteria cr7 = ses.createCriteria(DB.SubCategory.class);
                                    List<DB.SubCategory> l7 = cr7.list();
                                    for (DB.SubCategory up : l7) {
                                        
                                %>
                                <div class="col-md-5">
                                <input type="checkbox" value="<%=up.getIdSubCategory()%>" name="<%=up.getIdSubCategory()%>" ><%=up.getName()%><br/>
                                </div>
                                <%
                                    }%>
                                <br/>
                                <button type="submit" class="btn btn-success">Add</button>
                            </div>

                        </div>
                    </form>
                </div>

                <div style="height: 150px;"></div>
            </div>
        </div>
    </div>
</div>
<script src="js/bootstrap.js"></script>
</body>
</html>
<%} else {
        response.sendRedirect("index.jsp");
    }%>