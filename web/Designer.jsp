<%-- 
    Document   : Home
    Created on : Feb 9, 2015, 8:27:04 AM
    Author     : Bhagya
--%>
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
        <title>Designers</title>
        <script>
            function buyingproducts(pid) {
                var xmlhttp ;
                if (window.XMLHttpRequest) {
                    xmlhttp=new XMLHttpRequest();
                } else {
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        alert(te);
                    }
                }
                xmlhttp.open("POST","AddToCart?pid="+pid,true);
                xmlhttp.send();
            }
        </script>
    </head>
    <body style="background-color: white;" onload="loaded()">
        <%@include file="nav.jsp" %>
        <div  style="height: 500px; width: 100%;"><img class="img-responsive" src="1.jpg">
            <div style="position: absolute; margin-top: -270px; margin-left: 30%;" class="col-md-5">

                <form class="form">
                    <div class="input-group text-center">
                        <input type="text" class="form-control input-lg" placeholder="">
                        <span class="input-group-btn"><button class="btn btn-lg btn-success" type="button"><span class="glyphicon glyphicon-search"></span></button></span>
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
                                            <li>
                                                <a href="Home.jsp">
                                                    Projects </a>
                                            </li>
                                            <li class="active">
                                                <a href="Designer.jsp" >
                                                    Designers </a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab_default_2">
                                                <div class="container">
                                                    <div class="row">

                                                        <%

                                                            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                                            Criteria cr = ses.createCriteria(DB.AddJob.class);
                                                            List<DB.AddJob> l = cr.list();
                                                            for (int i = 0; i < l.size(); i++) {
                                                                DB.AddJob us = l.get(i);
                                                                if (us.getStatus() == 1) {
                                                        %>
                                                        <div class="col-md-4">
                                                            <br/>
                                                            <div style="width: 90%; height: 275px; border: 1px solid silver; border-radius: 6px; ">
                                                                <div style=" padding: 8px 8px 8px 8px;">
                                                                    <samp><%= us.getTitle()%></samp>
                                                                    <a style="text-decoration: none;" href="View_job.jsp?id=<%=Security.Security.encrypt(us.getIdaddJob() + "")%>"  class="hvr">
                                                                        <img src="<%=us.getJobDisplayPhoto().getPath()%>" width="100%" style="height: 200px;"  class="img-responsive">
                                                                        <div style="height: 10px;"></div>
                                                                        <div class="col-md-7">
                                                                            <label>$</label>
                                                                        </div>
                                                                        <div class="col-md-5">
                                                                            <div class="product-rating"><i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star gold"></i> <i class="fa fa-star-o"></i> </div>
                                                                        </div>                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%}
                                                            }%>
                                                    </div>
                                                </div>
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
                    <style>


                        .productbox {
                            background-color:#ffffff;
                            padding:10px;
                            margin-bottom:10px;
                            -webkit-box-shadow: 0 8px 6px -6px  #999;
                            -moz-box-shadow: 0 8px 6px -6px  #999;
                            box-shadow: 0 8px 6px -6px #999;
                        }

                        .producttitle {
                            font-weight:bold;
                            padding:5px 0 5px 0;
                        }

                        .productprice {
                            border-top:1px solid #dadada;
                            padding-top:5px;
                        }

                        .pricetext {
                            font-weight:bold;
                            font-size:1.4em;
                        }
                        /* pro */

                        /* Tabs panel */
                        .tabbable-panel {
                            /*border:1px solid #eee;*/
                            padding: 10px;
                        }

                        /* Default mode */
                        .tabbable-line > .nav-tabs {
                            border: none;
                            margin: 0px;
                        }
                        .tabbable-line > .nav-tabs > li {
                            margin-right: 2px;
                        }
                        .tabbable-line > .nav-tabs > li > a {
                            border: 0;
                            margin-right: 0;
                            color: #737373;
                        }
                        .tabbable-line > .nav-tabs > li > a > i {
                            color: #a6a6a6;
                        }
                        .tabbable-line > .nav-tabs > li.open, .tabbable-line > .nav-tabs > li:hover {
                            border-bottom: 4px solid #fbcdcf;
                        }
                        .tabbable-line > .nav-tabs > li.open > a, .tabbable-line > .nav-tabs > li:hover > a {
                            border: 0;
                            background: none !important;
                            color: #333333;
                        }
                        .tabbable-line > .nav-tabs > li.open > a > i, .tabbable-line > .nav-tabs > li:hover > a > i {
                            color: #a6a6a6;
                        }
                        .tabbable-line > .nav-tabs > li.open .dropdown-menu, .tabbable-line > .nav-tabs > li:hover .dropdown-menu {
                            margin-top: 0px;
                        }
                        .tabbable-line > .nav-tabs > li.active {
                            border-bottom: 4px solid #f3565d;
                            position: relative;
                        }
                        .tabbable-line > .nav-tabs > li.active > a {
                            border: 0;
                            color: #333333;
                        }
                        .tabbable-line > .nav-tabs > li.active > a > i {
                            color: #404040;
                        }
                        .tabbable-line > .tab-content {
                            margin-top: -3px;
                            background-color: #fff;
                            border: 0;
                            border-top: 1px solid #eee;
                            padding: 15px 0;
                        }
                        .portlet .tabbable-line > .tab-content {
                            padding-bottom: 0;
                        }

                        /* Below tabs mode */

                        .tabbable-line.tabs-below > .nav-tabs > li {
                            border-top: 4px solid transparent;
                        }
                        .tabbable-line.tabs-below > .nav-tabs > li > a {
                            margin-top: 0;
                        }
                        .tabbable-line.tabs-below > .nav-tabs > li:hover {
                            border-bottom: 0;
                            border-top: 4px solid #fbcdcf;
                        }
                        .tabbable-line.tabs-below > .nav-tabs > li.active {
                            margin-bottom: -2px;
                            border-bottom: 0;
                            border-top: 4px solid #f3565d;
                        }
                        .tabbable-line.tabs-below > .tab-content {
                            margin-top: -10px;
                            border-top: 0;
                            border-bottom: 1px solid #eee;
                            padding-bottom: 15px;
                        }
                    </style>
                </div>
            </div>
        </div>
        <br/>
        <%@include file="footer.jsp" %>
        <%} else {
                        response.sendRedirect("index.jsp");
                    }%>

