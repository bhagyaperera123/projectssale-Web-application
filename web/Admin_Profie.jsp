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
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
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
            
            function onload() {
                var xmlhttp ;
                if (window.XMLHttpRequest) {
                    xmlhttp=new XMLHttpRequest();
                } else {
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        document.getElementById("formid").innerHTML = te;
                    }
                }
                xmlhttp.open("POST","load_user_profile",true);
                xmlhttp.send();
            }
        </script>
    </head>
    <body style="" onload="onload()">
        <%@include file="slide_nav.jsp" %>
        <%
            Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
            HttpSession s = request.getSession();
            int type = Integer.parseInt(s.getAttribute("type").toString());
            DB.UserType ut1 = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 10);
            Criteria crr = sess.createCriteria(DB.UserTypeHasUserPage.class);
            crr.add(Restrictions.eq("userType", ut1));
            crr.add(Restrictions.eq("userPage", up1));
            DB.UserTypeHasUserPage ll = (DB.UserTypeHasUserPage) crr.uniqueResult();
            if (ll != null) {
                //System.out.println("list not null");
            } else {
                //System.out.println("list null");
                response.sendRedirect("Admin_Console.jsp");
            }
        %>
        <div class="main">
            <div class="container">
                <div class="row">
                    <div class="col-md-5  toppad  pull-right col-md-offset-3 ">
                        <A href="#" class="" data-toggle="modal" data-target="#myModal" ><span class="glyphicon glyphicon-edit"></span>Edit Profile</A>
                        <br>

                    </div>
                    <!-- Modal -->
                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form class="form-horizontal" action="Edit_Admin_profile" method="post">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="myModalLabel">Update Profile</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div id="formid"></div>


                                            </div><!-- /.col-lg-12 -->
                                        </div><!-- /.row -->
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                    </div>
                                </form> 
                            </div>

                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >


                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">Your Profile</h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-3 col-lg-3 " align="center"> <img alt="User Pic" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=100" class="img-circle"> </div>

                                    <div class=" col-md-9 col-lg-9 "> 
                                        <table class="table table-user-information">
                                            <%
                                                int uid = Integer.parseInt(htps.getAttribute("user").toString());
                                                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                                Criteria cr = ses.createCriteria(DB.UserLogin.class);
                                                DB.User u = (DB.User) ses.load(DB.User.class, uid);
                                                cr.add(Restrictions.eq("user", u));
                                                DB.UserLogin user = (DB.UserLogin) cr.uniqueResult();
                                                if (user != null) {
                                            %>
                                            <tbody>
                                                <tr>
                                                    <td>First Name:</td>
                                                    <td><%= user.getUser().getFname()%></td>
                                                </tr>
                                                <tr>
                                                    <td>Last Name:</td>
                                                    <td><%=user.getUser().getLname()%></td>
                                                </tr>
                                                <tr>
                                                    <td>Email:</td>
                                                    <td><%=user.getUser().getEmail()%></td>
                                                </tr>

                                                <tr>
                                                <tr>
                                                    <td>Description:</td>
                                                    <td><%= user.getUser().getDescription()%></td>
                                                </tr>
                                                <tr>
                                                    <td>User Name:</td>
                                                    <td><%= user.getUname()%></td>
                                                </tr>
                                                <tr>
                                                    <td>Password:</td>
                                                    <td>**********</td>
                                                </tr>

                                            </tbody>
                                            <%}%>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <style>
                .user-row {
                    margin-bottom: 14px;
                }

                .user-row:last-child {
                    margin-bottom: 0;
                }

                .dropdown-user {
                    margin: 13px 0;
                    padding: 5px;
                    height: 100%;
                }

                .dropdown-user:hover {
                    cursor: pointer;
                }

                .table-user-information > tbody > tr {
                    border-top: 1px solid rgb(221, 221, 221);
                }

                .table-user-information > tbody > tr:first-child {
                    border-top: 0;
                }


                .table-user-information > tbody > tr > td {
                    border-top: 0;
                }
                .toppad
                {margin-top:20px;
                }

            </style>

        </div>
    </div>
    <script src="js/bootstrap.js"></script>
</body>
</html>
<%} else {
        response.sendRedirect("index.jsp");
    }%>