<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>             <%
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

        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
    </head>
    <body style="">

        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <div style="height: 650px;">
                <div style="height: 190px; padding-top: 80px;">
                    <h1 style="">Your Job Added Successfully</h1>
                </div>

                <div class="item">
                    <blockquote>
                        <div class="row">
                            <div class="col-sm-8 col-sm-offset-2">

                                <p style="padding-top: 50px;">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. .</p>
                                <small>Projectssale</small>
                                <button class="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp;Go to Home</button>
                            </div>
                        </div>
                    </blockquote>
                </div>

            </div>

        </div>
        <%@include file="footer.jsp" %>

        <%} else {
                response.sendRedirect("index.jsp");
            }%>