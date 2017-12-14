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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="datatable/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="datatable/dataTables.bootstrap.css">
        <link rel="stylesheet" type="text/css" href="admin/css/style01.css">

        <script type="text/javascript" language="javascript" src="datatable/jquery-1.10.2.min.js"></script>
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
            DB.UserType ut = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up = (DB.UserPage) sess.load(DB.UserPage.class, 1);
            Criteria crr = sess.createCriteria(DB.UserTypeHasUserPage.class);
            crr.add(Restrictions.eq("userType", ut));
            crr.add(Restrictions.eq("userPage", up));
            DB.UserTypeHasUserPage ll = (DB.UserTypeHasUserPage) crr.uniqueResult();
            if (ll != null) {
                System.out.println("list not null");
            } else {
                System.out.println("list null");
                response.sendRedirect("Home.jsp");
            }
        %>
        <div class="main">
            <div class="container">

                <div class="row">
                    <div class="col-xs-6 col-md-3">

                        <div class="panel status panel-primary">
                            <div class="panel-heading">
                                <%
                                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(DB.UserLogin.class);
                                    List<DB.UserLogin> l = cr.list();
                                    int usize = 0;
                                    DB.UserLogin ulog = (DB.UserLogin) ses.load(DB.UserLogin.class, 2);
                                    for (DB.UserLogin ul : l) {
                                        if (ul.getUserType().getIdUserType() == 2) {
                                            usize++;
                                        }
                                    }
                                %>
                                <h1 class="panel-title text-center"><%=usize%></h1>
                            </div>
                            <div class="panel-body text-center">   
                                <strong>Users</strong>
                            </div>
                        </div>

                    </div>          
                    <div class="col-xs-6 col-md-3">

                        <div class="panel status panel-success">
                            <div class="panel-heading" style="background-color: #00cc00;">
                                <h1 class="panel-title text-center">17</h1>
                            </div>
                            <div class="panel-body text-center">                        
                                <strong>Jobs</strong>
                            </div>
                        </div>

                    </div>
                    <div class="col-xs-6 col-md-3">

                        <div class="panel status panel-danger">
                            <div class="panel-heading" style="background-color: #ff9900;">
                                <h1 class="panel-title text-center">2</h1>
                            </div>
                            <div class="panel-body text-center">                        
                                <strong>Projects</strong>
                            </div>
                        </div>


                    </div>
                    <div class="col-xs-6 col-md-3">

                        <div class="panel status panel-info">
                            <div class="panel-heading" style="background-color: #00cccc;">
                                <h1 class="panel-title text-center">18</h1>
                            </div>
                            <div class="panel-body text-center">                        
                                <strong>Order</strong>
                            </div>
                        </div>


                    </div>

                </div>
                <br/>
                <br/>

                <div class="row">                     

                    <div class="col-md-6 col-sm-12 col-xs-12">                     
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Donut Chart Example
                            </div>
                            <div class="panel-body">
                                <div id="morris-donut-chart"></div>
                            </div>
                        </div>            
                    </div>
                    <div class="col-md-6 col-sm-12 col-xs-12">                     
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Line Chart Example
                            </div>
                            <div class="panel-body">
                                <div id="morris-line-chart"></div>
                            </div>
                        </div>            
                    </div> 

                </div>

                <div class="row"> 
                    <div class="col-md-6 col-sm-12 col-xs-12">                     
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Bar Chart Example
                            </div>
                            <div class="panel-body">
                                <div id="morris-bar-chart"></div>
                            </div>
                        </div>            
                    </div>
                    <div class="col-md-6 col-sm-12 col-xs-12">                     
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Area Chart Example
                            </div>
                            <div class="panel-body">
                                <div id="morris-area-chart"></div>
                            </div>
                        </div>            
                    </div> 

                </div>
                <!-- /. ROW  -->


            </div>
            <br/>
            <br/>
            <script src="js/bootstrap.js"></script>
            <script src="assets/js/jquery.metisMenu.js"></script>
            <script src="assets/js/morris/raphael-2.1.0.min.js"></script>
            <script src="assets/js/morris/morris.js"></script>
            <script src="assets/js/custom.js"></script>
    </body>
</html>
<%} else {
        response.sendRedirect("index.jsp");
    }%>