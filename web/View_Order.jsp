<%-- 
    Document   : View_Order
    Created on : Feb 17, 2015, 8:24:04 PM
    Author     : Bhagya
--%>
<%      response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="chat-box/assets/css/style.css" rel="stylesheet">
        <title>View Order</title>
        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
    </head>
    <body style="">
        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <div style="height: 400px;">
                <br/>
                <br/>
                <br/>
                <br/>
                <%
                    int orid = Model.Main.valid_url(request.getParameter("orid"));
                    if (0 < orid) {
                        Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                        Criteria cr = ses.createCriteria(DB.Order.class);
                        cr.add(Restrictions.eq("idorder", orid));
                        List<DB.Order> l = cr.list();
                        for (DB.Order order : l) {
                %>

                <div class="container">
                    <div class="row pad-top pad-bottom">
                        <div class="col-lg-11 col-md-11 col-sm-11">
                            <div class="chat-box-div">

                                <div class="panel-body chat-box-main">

                                    <hr class="hr-clas" />
                                    <div align="left" class="chat-box-left">
                                        <%= order.getOrderDetails().getMsgBody()%>
                                    </div>
                                    <div class="chat-box-name-left">
                                        <img src="user.png" alt="bootstrap Chat box user image" class="img-circle" />
                                        -  <%= order.getUserBySendOrderUser().getFname()+" "+order.getUserBySendOrderUser().getLname() %>
                                    </div>


                            </div>

                        </div>
                    </div>
                </div>

                <%                    }
                } else {
                %><br/>
                <br/>
                <br/>
                <h1>No Result</h1>
                <%}%>
            </div>
            <%@include file="footer.jsp" %>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>