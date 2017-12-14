<%-- 
    Document   : View_job
    Created on : Feb 15, 2015, 12:22:27 PM
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
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Criteria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">

        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
        <script>
            function loaded() {
                var xmlhttp ;
                if (window.XMLHttpRequest) {
                    xmlhttp=new XMLHttpRequest();
                } else {
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;
                    }
                }
                var para = "uid";
                xmlhttp.open("POST","?"+para,true);
                xmlhttp.send();
            }
        </script>
    </head>
    <body style="">
        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <br/>
            <br/>
            <br/>
            <br/>
            <div style="">
                <%
                    if (request.getParameter("id") == null) {
                        response.sendRedirect("Home.jsp");
                    } else {

                        int id = 0;
                        if (request.getParameter("id").equals("vGzGQk/t po=")) {
                            id = 9;
                        } else {
                            id = new Model.Main().valid_url(request.getParameter("id"));
                        }
                        if (0 < id) {
                            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                            Criteria cr = ses.createCriteria(DB.AddJob.class);
                            cr.add(Restrictions.eq("idaddJob", id));
                            DB.AddJob ad = (DB.AddJob) cr.uniqueResult();
                            if (ad != null) {
                                List<DB.AddJob> l = cr.list();
                                for (int i = 0; i < l.size(); i++) {
                                    DB.AddJob us = l.get(i);
                %>
                <!--<h1 style="margin-left: -600px;"></h1>-->
                <style>

                    .oaerror {
                       
                        margin: 0 auto; /* Centering Stuff */
                        background-color: #FFFFFF; /* Default background */
                        padding: 20px;
                        border: 1px solid #eee;
                        border-left-width: 5px;
                        border-radius: 3px;
                        margin: 0 auto;
                        font-family: 'Open Sans', sans-serif;
                        font-size: 30px;
                    }

                    .info {
                        border-left-color: #5bc0de;
                        background-color: rgba(91, 192, 222, 0.1);
                    }

                    .info strong {
                        color: #5bc0de;
                    }

                </style>
                <div class="container">
                    <div class="row">
                        <br><br>
                        <div class="error-notice">                           
                            <div class="oaerror info col-md-11">
                                <strong><%=us.getTitle()%> &nbsp; &nbsp; <%= us.getJobPriceList().getPrice()%></strong>
                            </div>                           
                        </div>
                    </div>
                </div>
                <div class="container-fluid">
                    <div class="content-wrapper">	
                        <div class="item-container">	
                            <div class="container">	
                                <div class="col-md-12">
                                    <div class="product col-md-3">
                                        <img  style="width: 100%; height: 100%;"src="<%=us.getJobDisplayPhoto().getPath()%>" alt="">
                                    </div>
                                    <div class="col-md-3">
                                        <%
                                            HttpSession hs = request.getSession();
                                            int iduser = Integer.parseInt(hs.getAttribute("user").toString());
                                            int type = Integer.parseInt(htps.getAttribute("type").toString());

                                            if (iduser != us.getUser().getIduser()) {%>    
                                        <%if (type == 2) {%>
                                        <button style="width: 98%; height: 10%; font-size: 20px;" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-send"></span> ORDER NOW</button>
                                        <%}%>
                                        <div style="height: 10px;"></div>
                                        <button style="width: 98%; height: 10%; font-size: 20px;" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal1" ><span class="glyphicon glyphicon-envelope"></span> SEND MESSAGE</button>
                                        <%}%>
                                    </div>
                                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <form role="form" method="post" action="order_now">
                                                <div align="left" class="modal-content">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                        <h4 class="modal-title" id="myModalLabel">Order Now</h4>
                                                    </div>
                                                    <div class="modal-body">

                                                        <div class="form-group">
                                                            <label for="exampleInputEmail1">Title</label>
                                                            <input type="text" id="title" name="<%= Security.Security.encrypt("msgtitle")%>" class="form-control" id="exampleInputEmail1">
                                                        </div>
                                                        <input id="uid" type="hidden" name="uid" value="<%= Security.Security.encrypt(us.getUser().getIduser().toString())%>">
                                                        <input id="uid" type="hidden" name="jobid" value="<%= us.getIdaddJob()%>">
                                                        <div class="form-group">
                                                            <label for="exampleInputPassword1">Message</label>
                                                            <textarea id="mbody" name="<%= Security.Security.encrypt("msgbody")%>" align="left" class="form-control" style="height: 200px;">

                                                            </textarea>
                                                        </div>


                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-envelope"></span> SEND</button>
                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                    </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <form role="form" method="post" action="send_Message">
                                            <div align="left" class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                    <h4 class="modal-title" id="myModalLabel">SEND MESSAGE</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <input id="uid" type="hidden" name="uid" value="<%= Security.Security.encrypt(us.getUser().getIduser().toString())%>">
                                                    <input id="uid" type="hidden" name="jobid" value="<%= us.getIdaddJob()%>">
                                                    <div class="form-group">
                                                        <label for="exampleInputPassword1">Message</label>  
                                                        <textarea id="mbody" name="<%= Security.Security.encrypt("msgbody")%>" align="left" class="form-control" style="height: 200px;">
                                                        </textarea>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-envelope"></span> SEND MESSAGE</button>
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <br/>
                                <br/>
                                <br/>
                                <img src="FIVERR-LEVEL-1-PNG.png">
                            </div>
                            <div class="col-md-3">
                                <span class="tags"><%=us.getJobDuration().getTime()%> <span>Deliver </span></span>
                            </div>
                        </div>  
                    </div> 
                </div>
                <div class="container-fluid">		
                    <div class="col-md-12 product-info">
                        <ul id="myTab" class="nav nav-tabs nav_tabs">

                            <li class="active"><a href="#service-one" data-toggle="tab">DESCRIPTION</a></li>
                            <li><a href="#service-two" data-toggle="tab">FEEDBACK</a></li>
                            <li><a href="#service-three" data-toggle="tab">ABOUT USER</a></li>

                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade in active" id="service-one">

                                <section class="container product-info">
                                    <div style="width: 80%; margin-left: -200px;"><p> <%=us.getDescription()%></p></div>
                                </section>

                            </div>
                            <div class="tab-pane fade"  id="service-two">

                                <section class="container">
                                    <div  class="container">
                                        <div class="row">
                                            <div style="width: 85%; margin-left: -202px;" align="left" class="panel panel-default widget">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-comment"></span>
                                                    <h3 class="panel-title">
                                                        Recent Comments</h3>
                                                    <span class="label label-info">
                                                        78</span>
                                                </div>
                                                <div class="panel-body">
                                                    <ul class="list-group">
                                                        <li class="list-group-item">
                                                            <div class="row">
                                                                <div class="col-xs-2 col-md-1">
                                                                    <img src="http://placehold.it/80" class="img-circle img-responsive" alt="" /></div>
                                                                <div class="col-xs-10 col-md-11">
                                                                    <div>
                                                                        <a href="http://www.jquery2dotnet.com/2013/10/google-style-login-page-desing-usign.html">
                                                                            Google Style Login Page Design Using Bootstrap</a>
                                                                        <div class="mic-info">
                                                                            By: <a href="#">Bhaumik Patel</a> on 2 Aug 2013
                                                                        </div>
                                                                    </div>
                                                                    <div class="comment-text">
                                                                        Awesome design
                                                                    </div>
                                                                    <div class="product-rating">
                                                                        <i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star-o"></i> 
                                                                    </div>
                                                                    <style>
                                                                        .gold{
                                                                            color: #FFBF00;
                                                                        }
                                                                        .product-rating{
                                                                            font-size: 17px;
                                                                        }
                                                                    </style>
                                                                    <div class="action">
                                                                        <button type="button" class="btn btn-primary btn-xs" title="Edit">
                                                                            <span class="glyphicon glyphicon-pencil"></span>
                                                                        </button>
                                                                        <button type="button" class="btn btn-success btn-xs" title="Approved">
                                                                            <span class="glyphicon glyphicon-ok"></span>
                                                                        </button>
                                                                        <button type="button" class="btn btn-danger btn-xs" title="Delete">
                                                                            <span class="glyphicon glyphicon-trash"></span>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>

                                                    </ul>
                                                    <!--<a href="#" class="btn btn-primary btn-sm btn-block" role="button"><span class="glyphicon glyphicon-refresh"></span> More</a>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </section>

                            </div>
                            <div class="tab-pane fade" id="service-three">
                                <!--about user start-->
                                <div style="margin-left: -253px;" class="container">
                                    <br/>
                                    <div class="row">
                                        <div class="col-md-offset-2 col-md-8 col-lg-offset-3 col-lg-6">
                                            <div class="well profile">
                                                <div class="col-sm-12">
                                                    <div class="col-xs-12 col-sm-8">
                                                        <h2><%=us.getUser().getFname() + " " + us.getUser().getLname()%></h2>
                                                        <p><strong>FROM </strong> Sri Lanka </p>
                                                        <p><strong>TAGS </strong>
                                                            <%
                                                                String[] tags = us.getTags().split(",");
                                                                for (int t = 0; t < tags.length; t++) {
                                                            %>
                                                            <span class="tags"><%=tags[t]%></span> 
                                                            <%}%>
                                                        </p>
                                                    </div>             
                                                    <div class="col-xs-12 col-sm-4 text-center">
                                                        <figure>
                                                            <img src="user.png" alt="" class="img-circle img-responsive">
                                                            <figcaption class="ratings">
                                                                <p>Ratings
                                                                    <a href="#">
                                                                        <span class="fa fa-star"></span>
                                                                    </a>
                                                                    <a href="#">
                                                                        <span class="fa fa-star"></span>
                                                                    </a>
                                                                    <a href="#">
                                                                        <span class="fa fa-star"></span>
                                                                    </a>
                                                                    <a href="#">
                                                                        <span class="fa fa-star"></span>
                                                                    </a>
                                                                    <a href="#">
                                                                        <span class="fa fa-star-o"></span>
                                                                    </a> 
                                                                </p>
                                                            </figcaption>
                                                        </figure>
                                                    </div>
                                                </div>            
                                                <div class="col-xs-12 divider text-center">
                                                    <h4>About This Job</h4>

                                                    <%=us.getInstructionsForBuyer()%>
                                                </div>
                                            </div>                 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% }
                    }
                } else {%>
                <h1>Sorry no result</h1>
                <%}
                    }%>
                <style>

                    .profile 
                    {
                        min-height: 355px;
                        display: inline-block;
                    }
                    figcaption.ratings
                    {
                        margin-top:20px;
                    }
                    figcaption.ratings a
                    {
                        color:#f1c40f;
                        font-size:11px;
                    }
                    figcaption.ratings a:hover
                    {
                        color:#f39c12;
                        text-decoration:none;
                    }
                    .divider 
                    {
                        border-top:1px solid rgba(0,0,0,0.1);
                    }
                    .emphasis 
                    {
                        border-top: 4px solid transparent;
                    }
                    .emphasis:hover 
                    {
                        border-top: 4px solid #1abc9c;
                    }
                    .emphasis h2
                    {
                        margin-bottom:0;
                    }
                    span.tags 
                    {
                        background: #1abc9c;
                        border-radius: 2px;
                        color: #f5f5f5;
                        font-weight: bold;
                        padding: 2px 4px;
                    }

                    /*end user css*/
                    .widget .panel-body { padding:0px; }
                    .widget .list-group { margin-bottom: 0; }
                    .widget .panel-title { display:inline }
                    .widget .label-info { float: right; }
                    .widget li.list-group-item {border-radius: 0;border: 0;border-top: 1px solid #ddd;}
                    .widget li.list-group-item:hover { background-color: rgba(86,61,124,.1); }
                    .widget .mic-info { color: #666666;font-size: 11px; }
                    .widget .action { margin-top:5px; }
                    .widget .comment-text { font-size: 12px; }
                    .widget .btn-block { border-top-left-radius:0px;border-top-right-radius:0px; }

                    .gold{
                        color: #FFBF00;
                    }

                    .product{
                        border: 1px solid #dddddd;
                        width: 70%; height: 450px;
                    }
                    .product-info{
                        margin-top: 50px;
                    }

                    .content-wrapper {
                        max-width: 1140px;
                        margin: 0 auto;
                        margin-top: 25px;
                        margin-bottom: 10px;
                        border: 0px;
                        border-radius: 0px;
                    }

                    .container-fluid{
                        max-width: 1140px;
                        margin: 0 auto;
                    }

                    .view-wrapper {
                        float: right;
                        max-width: 70%;
                        margin-top: 25px;
                    }

                    .service1-items {
                        padding: 0px 0 0px 0;
                        float: left;
                        position: relative;
                        overflow: hidden;
                        max-width: 100%;
                        height: 321px;
                        width: 130px;
                    }

                    .service1-item {
                        height: 107px;
                        width: 120px;
                        display: block;
                        float: left;
                        position: relative;
                        padding-right: 20px;
                        border-right: 1px solid #DDD;
                        border-top: 1px solid #DDD;
                        border-bottom: 1px solid #DDD;
                    }

                    .service1-item > img {
                        max-height: 110px;
                        max-width: 110px;
                        opacity: 0.6;
                        transition: all .2s ease-in;
                        -o-transition: all .2s ease-in;
                        -moz-transition: all .2s ease-in;
                        -webkit-transition: all .2s ease-in;
                    }

                    .service1-item > img:hover {
                        cursor: pointer;
                        opacity: 1;
                    }

                    .service-image-left > center > img,.service-image-right > center > img{
                        max-height: 155px;
                    }

                </style>
            </div>
            <%@include file="footer.jsp" %>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>