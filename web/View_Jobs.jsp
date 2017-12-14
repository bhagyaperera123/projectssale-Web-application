<%-- 
    Document   : Admin_Console
    Created on : Feb 19, 2015, 9:01:32 AM
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

</style>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="datatable/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="datatable/dataTables.bootstrap.css">
        <link rel="stylesheet" type="text/css" href="admin/css/style01.css">
        <title>Admin | Projects</title>
        <script type="text/javascript" language="javascript" src="datatable/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" language="javascript" src="datatable/jquery.dataTables.min.js"></script>
        <script type="text/javascript" language="javascript" src="datatable/dataTables.bootstrap.js"></script>
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
            
            $(document).ready(function() {
                $('#example').dataTable();
            } );
            
            var xmlhttp ;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            
            function Deactive_job(typeid){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;  
                        if(te == 1){
                            window.location.href = "View_Jobs.jsp";
                            alert('Success'); 
                        }
                    }
                }
                xmlhttp.open("POST","Deactivate_job?id="+typeid,true);
                xmlhttp.send();
            }
            
            function load_job(typeid){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;  
                        document.getElementById("reval").innerHTML = te;
                    }
                }
                xmlhttp.open("POST","load_job?id="+typeid,true);
                xmlhttp.send();
            }
            function Delete_job(typeid){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;  
                        if(te == 1){
                            window.location.href = "View_Jobs.jsp";
                            alert('Success'); 
                        }
                    }
                }
                xmlhttp.open("POST","Delete_Job?id="+typeid,true);
                xmlhttp.send();
            }
            
        </script>
    </head>
    <body style="">
        <%@include file="slide_nav.jsp" %>
        <%
            Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
            HttpSession s = request.getSession();
            int type = Integer.parseInt(s.getAttribute("type").toString());
            DB.UserType ut1 = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 7);
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
            <div class="container">

                <h2 class="bg-primary" style="padding-left: 100px"><samp>Jobs</samp></h2>
                <br/>
                <br/>
                <div class="container" style="width: 100%;">
                    <table style="width: 100%;" id="example" class="display" cellspacing="0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Price</th>
                                <th>User</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Session ses2 = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                Criteria cr2 = ses2.createCriteria(DB.AddJob.class);
                                List<DB.AddJob> l2 = cr2.list();
                                for (DB.AddJob ul : l2) {
                                    if (ul.getStatus() == 1) {
                            %>
                            <tr>
                                <td><%=ul.getIdaddJob()%></td>
                                <td><%=ul.getTitle()%></td>
                                <td>70.00</td>
                                <td><%=ul.getUser().getFname() + " " + ul.getUser().getLname()%></td>
                                <td><span class="bg bg-primary">Activate</span></td>
                                <td>
                                    <button type="button" class="btn btn-default" onclick="load_job(<%=ul.getIdaddJob()%>)"data-toggle="modal" data-target="#myModal" View>View</button>
                                    <button type="button" class="btn btn-default" onclick="Deactive_job(<%=ul.getIdaddJob()%>)"> Deactivate</button>
                                    <button type="button" class="btn btn-danger" onclick="Delete_job(<%=ul.getIdaddJob()%>)"><span class="glyphicon glyphicon-trash"></span> Delete</button>
                                </td>
                            </tr>
                            <%}
                                }%>
                        </tbody>
                    </table>
                </div>
            </div>
            <br/>
            <br/>
            <!-- Modal -->
            <div class="modal fade bs-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">View Project</h4>
                        </div>
                        <div class="modal-body">
                            <div id="reval"></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
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