<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">

        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
    </head>
    <script>
       
        var xmlhttp ;
        if (window.XMLHttpRequest) {
            xmlhttp=new XMLHttpRequest();
        } else {
            xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
       
        function onload() {
            xmlhttp.onreadystatechange=function() {
                if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                    var te = xmlhttp.responseText; 
                    document.getElementById("formid").innerHTML = te;
                }
            }
            xmlhttp.open("POST","load_user_profile",true);
            xmlhttp.send();
        }
        function load_job(id) {
            xmlhttp.onreadystatechange=function() {
                if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                    var te = xmlhttp.responseText; 
                    document.getElementById("reval").innerHTML = te;
                }
            }
            xmlhttp.open("POST","loadjob?id="+id,true);
            xmlhttp.send();
        }
    </script>
    <body  onload="onload()">

        <%@include file="nav.jsp" %>
    <center><div style="width: 90%; background-color: #f6f6f6;">
            <br/>
            <br/>
            <br/>
            <br/>
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <img src="user.png" style="width: 200px; height: 200px;" alt="" class="img-circle">
                    </div>
                    <%
                        String fname = "";
                        String lname = "";
                        String email = "";
                        String Description = "";

                        int uid = Integer.parseInt(htps.getAttribute("user").toString());
                        Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                        Criteria cr = ses.createCriteria(DB.UserLogin.class);
                        DB.User u = (DB.User) ses.load(DB.User.class, uid);
                        cr.add(Restrictions.eq("user", u));
                        DB.UserLogin user = (DB.UserLogin) cr.uniqueResult();
                        if (user != null) {
                            fname = user.getUser().getFname();
                            lname = user.getUser().getLname();
                            email = user.getUser().getEmail();
                            Description = user.getUser().getDescription();
                        } else {
                            System.out.println("user null");
                        }
                    %>
                    <div class="col-md-3">
                        <h2><%= fname + " " + lname%></h2>
                        <div style="width: 300px; height: 150px;">
                            <br/>
                            <%=Description%>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <a href="#" data-toggle="modal" data-target="#myModal"> <span class="glyphicon glyphicon-edit"></span> edit</a>
                    </div>
                </div>
            </div>
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
            <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form class="form-horizontal" action="Edit_Job" method="post">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Update Profile</h4>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div id="reval">
                                            
                                        </div>

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
            <br/>
            <br/>
            <br/>
            <br/>
            <style>
                .hvr:hover{
                    color: #2dd87a;
                    text-decoration: none;
                    font-size: 18px;
                }
                .hvr{
                    text-decoration: none;
                    font-size: 19px;
                }


            </style>
            <hr>
            <hr>
            <center>
                <div class="container">
                    <div class="row">

                        <%
                            //HttpSession ss = request.getSession();
                            if (ss.getAttribute("user") != null) {
                                int uid1 = Integer.parseInt(ss.getAttribute("user").toString());

                                Session ses1 = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                Criteria cr1 = ses1.createCriteria(DB.AddJob.class);
                                DB.User u1 = (DB.User) ses1.load(DB.User.class, uid);
                                cr.add(Restrictions.eq("user", u1));
                                List<DB.AddJob> l = cr1.list();

                                for (int i = 0; i < l.size(); i++) {
                                    DB.AddJob us = l.get(i);
                                    if(us.getUser() == u1 & us.getStatus() == 1){
                        %>

                        <div class="col-md-4">
                            <br/>
                            <div style="width: 90%; height: 260px; border: 1px solid silver; border-radius: 6px; ">
                                <div style=" padding: 8px 8px 8px 8px;">
                                    <img src="<%=us.getJobDisplayPhoto().getPath()%>" width="100%" style="height: 200px;"  class="img-responsive">
                                    <a class="hvr"><%= us.getTitle()%></a>
                                    <br/>
                                    <a href="#" onclick="load_job(<%=us.getIdaddJob()%>)" data-toggle="modal" data-target="#myModal1"> <span class="glyphicon glyphicon-edit"></span> edit</a>
                                </div>
                            </div>
                        </div>
                        <%}
                                }
                            }
                        %>
                    </div>
                </div>
            </center>
            <br/>
            <br/>
            <br/>
            <style>
                header,
                footer {
                    padding:30px;
                    background:orange;
                    text-align:center;
                    margin-bottom:20px;
                }
                .thumbnail-list {
                    list-style:none;
                    margin:0;
                    padding:0;
                    font-size:0;
                }
                .thumbnail-list li {
                    display:inline-block;
                    vertical-align:top;
                    width:50%;
                    padding:2%;
                    font-size:12px;
                }
                .thumbnail-list img {
                    display:block;
                    width:100%;
                }
                .item { background:green; }
                .cut-price {
                    text-decoration:line-through;
                    color:#ccc;
                }
                .product-price {
                    float:left;
                    width:100%;
                    color:#999;
                }
                .btn-slide { display:none; }

                @media (min-width:640px) {
                    .thumbnail-list li { width:33.33333%; }
                }
                @media (max-width:767px) {
                    .btn-slide {
                        text-align:center;
                        width:100%;
                        padding:10px;
                        margin:0 auto;
                        display:block;
                        font:bold 120%/100% Arial,Helvetica,sans-serif;
                        color:#000;
                        text-decoration:none;
                        border:1px solid #ccc;
                    }
                    #panel { display:none; }
                    .thumbnail-list li { text-align:center; }
                }
                @media (max-width:320px) {
                    .thumbnail-list li { width: 100%}
                }
            </style>
            <%@include file="footer.jsp" %>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>