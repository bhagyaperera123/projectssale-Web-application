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
            <div style="height: 500px;">



            </div>
            <%@include file="footer.jsp" %>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>