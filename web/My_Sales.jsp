<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <title>My Sales</title>
        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
        <script>
       
            var xmlhttp ;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            function load_projects(id) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        document.getElementById("formid").innerHTML = te;
                    }
                }
                xmlhttp.open("POST","Edit_Projects?id="+id,true);
                xmlhttp.send();
            }
        
            function Delete_Project(typeid){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;  
                        if(te == 1){
                            window.location.href = "My_Sales.jsp";
                            alert('Success'); 
                        }
                    }
                }
                xmlhttp.open("POST","Delete_Project?id="+typeid,true);
                xmlhttp.send();
            }
        </script>

    </head>
    <body style="">
        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <div style="">
                <style>
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
                <div style="height: 100px;"></div>
                <div class="container">
                    <div class="row">
                        <div class="col-md-11">
                            <ul class="thumbnail-list">
                                <%
                                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                    Criteria cr = ses.createCriteria(DB.Projects.class);
                                    int uid = Integer.parseInt(htps.getAttribute("user").toString());
                                    DB.User u = (DB.User) ses.load(DB.User.class, uid);
                                    cr.add(Restrictions.eq("user", u));
                                    List<DB.Projects> ll = cr.list();
                                    if (ll != null) {

                                        for (DB.Projects pro : ll) {
                                           if(pro.getStatus()== 1){ 
            %>
                                <li> 
                                    <a href="#" class=""><img src="<%=pro.getUploadPic().getPath()%>" class=""></a>
                                    <a style="font-size: 23px;" class=""><%=pro.getProjectName()%></a>
                                    <div class="product-price">
                                    </div>
                                    <button data-toggle="modal" data-target="#myModal" onclick="load_projects((<%=pro.getIdprojects()%>))" type="button" class="btn btn-default navbar-btn">Edit</button>
                                    <button type="button" class="btn btn-danger" onclick="Delete_Project(<%=pro.getIdprojects()%>)"><span class="glyphicon glyphicon-trash"></span> Delete</button>
                                </li>
                                <%}}
                                    }%>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="footer.jsp" %>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>