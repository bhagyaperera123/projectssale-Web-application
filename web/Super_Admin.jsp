<%-- 
    Document   : Admin_Profie
    Created on : Feb 20, 2015, 5:27:01 PM
    Author     : Bhagya
--%>
                <%
                    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
        %>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
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
        <link rel="stylesheet" type="text/css" href="css/tree/tree_style.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <script type="text/javascript" language="javascript" src="datatable/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" language="javascript" src="datatable/jquery.dataTables.min.js"></script>
        <script type="text/javascript" language="javascript" src="datatable/dataTables.bootstrap.js"></script>
        <script>
            
            function add_page(id){
                alert(id);
            }
            
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
            
            var xmlhttp ;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            
            function Active_type(typeid){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;  
                        if(te == 1){
                            window.location.href = "Super_Admin.jsp";
                            alert('Success'); 
                        }else if(te == "2"){
                            alert('Sorry User Type Not Available');
                        }
                    }
                }
                xmlhttp.open("POST","active_type?id="+typeid,true);
                xmlhttp.send();
            
            }
            function Block_Page(pageID){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            window.location.href = "Super_Admin.jsp";
                            alert('Success'); 
                        }
                    }
                }
                xmlhttp.open("POST","block_page?pid="+pageID,true);
                xmlhttp.send();
            }
            function Active_Page(pageID){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            window.location.href = "Super_Admin.jsp";
                            alert('Success'); 
                        }
                    }
                }
                xmlhttp.open("POST","Active_Page?pid="+pageID,true);
                xmlhttp.send();
            }
            
            $(document).ready(function() {
                $('#example').dataTable();
            } );
        </script>
    </head>
    <body style="">
        <%@include file="slide_nav.jsp" %>
        <%
            Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
            HttpSession s = request.getSession();
            int type = Integer.parseInt(s.getAttribute("type").toString());
            DB.UserType ut1 = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 6);
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
            <div class="col-md-12">
                <h2 class="bg-primary" style="padding-left: 100px"><samp>Activate User Type</samp></h2>
                <br/>
                <ul class="tree">
                    <%
                        Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                        Criteria cr = ses.createCriteria(DB.UserType.class);
                        List<DB.UserType> l = cr.list();
                        List<DB.UserTypeHasUserPage> l1 = null;
                        for (DB.UserType ut : l) {
                    %>
                    <% if (ut.getStatus().equals(0)) {%>
                    <div class="col-md-3">
                        <li><a href="#"><%=ut.getRoleName()%></a> &nbsp;<span onclick="Active_type(<%=ut.getIdUserType()%>)" style="color: red;" class="glyphicon glyphicon-plus"></span>
                            <ul>
                                <%
                                    Criteria cr1 = ses.createCriteria(DB.UserTypeHasUserPage.class);
                                    DB.UserType uty = (DB.UserType) ses.load(DB.UserType.class, ut.getIdUserType());
                                    cr1.add(Restrictions.eq("userType", uty));
                                    l1 = cr1.list();
                                    for (DB.UserTypeHasUserPage uhp : l1) {
                                %>
                                <li><%=uhp.getUserPage().getPageName()%></li>   
                                <%}%>
                            </ul>
                        </li>
                    </div>
                    <%}%>
                    <%}
                        if (l1 == null) {
                    %>
                    <samp>Sorry No Result</samp>
                    <%}%>
                </ul>
                <script type="text/javascript" language="javascript" src="js/tree/tree_script.js"></script>
            </div>            
            <div class="col-md-12">
                <h2 class="bg-primary" style="padding-left: 100px"><samp>Manage Page</samp></h2>
                <br/>
                <br/>
                <div class="container" style="width: 100%;">
                    <table style="width: 100%;" id="example" class="display" cellspacing="0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Page Name</th>
                                <th>Url</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%

                                Criteria cr2 = ses.createCriteria(DB.UserPage.class);
                                List<DB.UserPage> upage = cr2.list();
                                for (DB.UserPage up : upage) {
                            %>
                            <tr>
                                <td><%=up.getIduserPage()%></td>
                                <td><%=up.getPageName()%></td>
                                <td><%=up.getUrl()%></td>
                                <%
                                    if (up.getStatus() == 1) {
                                %>
                                <td><span class="bg bg-primary">Active</span></td>
                                <%} else {%>
                                <td><span style="background-color: red; color: white;">Block</span></td>
                                <%}%>
                                <td>
                                    <%if (up.getStatus() == 1) {%>
                                    <button type="button" onclick="Block_Page(<%=up.getIduserPage()%>)" class="btn btn-default"><span class="glyphicon glyphicon-lock"></span> Block</button>
                                    <%} else {%>
                                    <button type="button" onclick="Active_Page(<%=up.getIduserPage()%>)" class="btn btn-default"><span class=""></span> Active</button>
                                    <%}%>
                                    <!--                                    <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Delete</button>-->
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script>
            $('#example')
            .removeClass( 'display' )
            .addClass('table table-striped table-bordered');
        </script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>
        <%} else {
                response.sendRedirect("index.jsp");
            }%>