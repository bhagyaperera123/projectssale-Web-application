<%-- 
    Document   : Home
    Created on : Feb 9, 2015, 8:27:04 AM
    Author     : Bhagya
--%>
<%@page import="org.hibernate.criterion.Projections"%>
<%@page import="org.hibernate.cfg.Configuration"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="java.util.Iterator"%>
<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<%@page import="DB.Projects"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Criteria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/pro_model.css" rel="stylesheet">
        <script>
            var xmlhttp ;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            function buyingproducts(pid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        alert(te);
                    }
                }
                xmlhttp.open("POST","AddToCart?pid="+pid,true);
                xmlhttp.send();
            }
            function Advance_serch() {
                var val = document.getElementById("search").value;
                window.location.href = "Recommend List.jsp?name="+val;
            }
        </script>
    </head>
    <body style="background-color: white;" onload="loaded()">
        <%@include file="nav.jsp" %>
        <div  style="height: 500px; width: 100%;"><img class="img-responsive" src="1.jpg">
            <div style="position: absolute; margin-top: -270px; margin-left: 30%;" class="col-md-5">

                <form class="form">
                    <div class="input-group text-center">
                        <input type="text" id="search" class="form-control input-lg" placeholder="">
                        <span class="input-group-btn"><button onclick="Advance_serch()" class="btn btn-lg btn-success" type="button"><span class="glyphicon glyphicon-search"></span></button></span>
                    </div>
                </form>

            </div>
        </div>
        <br/>
        <br/>
        <br/>
        <div class="container">
            <div class="row" id="row">
                <div>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12" >
                                <h3>&nbsp;</h3>
                                <div class="tabbable-panel">
                                    <div class="tabbable-line">
                                        <ul class="nav nav-tabs " style="">
                                            <li class="active">
                                                <a href="Home.jsp" >
                                                    Projects </a>
                                            </li>
                                            <li>
                                                <a href="Designer.jsp">
                                                    Designers </a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab_default_1">
                                                <div class="container">
                                                    <div class="row">
                                                        <%
                                                            int type = Integer.parseInt(htps.getAttribute("type").toString());
                                                            int uid = Integer.parseInt(htps.getAttribute("user").toString());
                                                        %>

                                                        <%
                                                            SessionFactory factory = new Configuration().configure().buildSessionFactory();
                                                            int pageIndex = 0;
                                                            int totalNumberOfRecords = 0;
                                                            int numberOfRecordsPerPage = 8;

                                                            String sPageIndex = request.getParameter("pageIndex");

                                                            if (sPageIndex == null) {
                                                                pageIndex = 1;
                                                            } else {
                                                                pageIndex = Integer.parseInt(sPageIndex);
                                                            }

                                                            Session ses = factory.openSession();
                                                            int s = (pageIndex * numberOfRecordsPerPage) - numberOfRecordsPerPage;

                                                            Criteria crit = ses.createCriteria(DB.Projects.class);
                                                            crit.setFirstResult(s);
                                                            crit.setMaxResults(numberOfRecordsPerPage);
                                                            List l = crit.list();
                                                            Iterator it = l.iterator();
                                                            while (it.hasNext()) {
                                                                DB.Projects projects = (Projects) it.next();
                                                                if(projects.getStatus()!=0){
                                                        %>

                                                        <div class="col-md-3 column productbox">
                                                            <samp class="tags" style="margin-left: 10px;"><%=projects.getProjectName()%></samp>
                                                            <img src="<%=projects.getUploadPic().getPath()%>" class="img-responsive">
                                                            <div class="producttitle"></div>
                                                            <div class="productprice">
                                                                <div class="pull-right">
                                                                    <a href="<%=projects.getUploadDemo().getPath()%>"> <button href="" class="btn btn-success btn-sm" role='button'> View Demo </button></a> 
                                                                    <% if (type == 2 && projects.getUser().getIduser() != uid) {%>
                                                                    <button href="" class="btn btn-danger btn-sm" onclick="buyingproducts(<%=projects.getIdprojects()%>)" role='button'>BUY</button>
                                                                    <%}%>
                                                                </div>
                                                                <div class='pricetext'>$<%=projects.getPrice()%>.00</div></div>
                                                        </div> 

                                                        <%
                                                                                                               }
                                                            }
                                                            Criteria crit1 = ses.createCriteria(Projects.class);
                                                            crit1.setProjection(Projections.rowCount());

                                                            List l1 = crit1.list();

                                                            Iterator it1 = l1.iterator();

                                                            if (it1.hasNext()) {
                                                                Object o = it1.next();
                                                                totalNumberOfRecords = Integer.parseInt(o.toString());
                                                            }

                                                            int noOfPages = totalNumberOfRecords / numberOfRecordsPerPage;
                                                            if (totalNumberOfRecords > (noOfPages * numberOfRecordsPerPage)) {
                                                                noOfPages = noOfPages + 1;
                                                            }

                                                        %>


                                                    </div>
                                                </div>
                                                                                                                <%
                                                            out.print("<div style=\"padding-right:80px; clear: right ; float: right; \">");

                                                            String myurl1 = "Home.jsp?pageIndex=" + 1;
                                                            out.println("<a  href=" + myurl1 + "  class='btn'><input type='button' value='<<'></a>");

                                                            for (int i = 1; i <= noOfPages; i++) {
                                                                String myurl = "Home.jsp?pageIndex=" + i;

                                                                out.println("<button type='button'  href=" + myurl + " class='btn btn-default'>" + i + "</button>");

                                                            }
                                                            myurl1 = "Home.jsp?pageIndex=" + noOfPages;
                                                            out.println("<a  href=" + myurl1 + "  class=\"btn\"><input type='button' value='>>'></a>");

                                                            out.print("</div>");

                                                        %>
                                            </div>

                                            <style>
                                                .gold{
                                                    color: #FFBF00;
                                                }
                                                .product-rating{
                                                    font-size: 17px;
                                                }
                                            </style>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <br>
                    <br>
                </div>
            </div>
        </div>
        <br/>
        <%@include file="footer.jsp" %>
        <%} else {
                response.sendRedirect("index.jsp");
            }%>

