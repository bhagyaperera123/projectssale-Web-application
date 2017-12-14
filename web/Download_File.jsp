<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>            
<%@page import="java.util.List"%>
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
        <style>
            .text-color-white {
                color: #FFFFFF;
            }

            .text-color-black {
                color: #000000;
            }

            .text-color-theme {
                color: #6f5499;
            }

            /* Background colors */
            .theme-bg{
                background: #6f5499;
            }

            .bg-black{
                background: #000000;
            }

            .secondary-bg {
                background: #f0ecf6;
            }


            /* Margin */

            .margin-bottom-0 {
                margin-bottom: 0 !important;
            }

            .margin-bottom-10 {
                margin-bottom: 10px !important;
            }

            .margin-bottom-15 {
                margin-bottom: 15px !important;
            }

            .margin-bottom-20 {
                margin-bottom: 20px !important;
            }

            .margin-bottom-30 {
                margin-bottom: 30px !important;
            }

            .margin-bottom-40 {
                margin-bottom: 40px !important;
            }

            .margin-bottom-50 {
                margin-bottom: 50px !important;
            }

            .margin-bottom-60 {
                margin-bottom: 60px !important;
            }

            .margin-bottom-70 {
                margin-bottom: 70px !important;
            }

            .margin-bottom-80 {
                margin-bottom: 80px !important;
            }

            .margin-bottom-90 {
                margin-bottom: 90px !important;
            }

            .margin-bottom-100 {
                margin-bottom: 100px !important;
            }

            .margin-bottom-120 {
                margin-bottom: 120px !important;
            }

            .margin-right-0 {
                margin-right: 0 !important;
            }

            .margin-right-5 {
                margin-right: 5px !important;
            }

            .margin-right-10 {
                margin-right: 10px !important;
            }

            /* Padding surround */

            .padding-0 {
                padding: 0px !important;
            }

            .padding-30 {
                padding: 30px !important;
            }

            .padding-50 {
                padding: 40px !important;
            }


            /* Buttons */

            .btn {
                letter-spacing: 1px;
                text-decoration: none;
                background: none;
                -moz-user-select: none;
                background-image: none;
                border: 1px solid transparent;
                border-radius: 0;
                cursor: pointer;
                display: inline-block;
                margin-bottom: 0;
                vertical-align: middle;
                white-space: nowrap;
                font-size:14px;
                line-height:20px;
                font-weight:700;
                text-transform:uppercase;
                border: 3px solid;
                padding:8px 20px;
            }

            .btn-outlined {
                border-radius: 0;
                -webkit-transition: all 0.3s;
                -moz-transition: all 0.3s;
                transition: all 0.3s;
            }

            .btn-outlined.btn-theme {
                background: none;
                color: #6f5499;
                border-color: #6f5499;
            }

            .btn-outlined.btn-theme:hover,
            .btn-outlined.btn-theme:active {
                color: #FFF;
                background: #6f5499;
                border-color: #6f5499;
            }

            .btn-outlined.btn-black {
                background: none;
                color: #000000;
                border-color: #000000;
            }

            .btn-outlined.btn-black:hover,
            .btn-outlined.btn-black:active {
                color: #FFF;
                background: #000000;
                border-color: #000000;
            }

            .btn-outlined.btn-white {
                background: none;
                color: #FFFFFF;
                border-color: #FFFFFF;
            }

            .btn-outlined.btn-white:hover,
            .btn-outlined.btn-white:active {
                color: #6f5499;
                background: #FFFFFF;
                border-color: #FFFFFF;
            }

            .btn-xs{
                font-size:11px;
                line-height:14px;
                border: 1px solid;
                padding:5px 10px;
            }

            .btn-sm{
                font-size:12px;
                line-height:16px;
                border: 2px solid;
                padding:8px 15px;
            }

            .btn-lg{
                font-size:18px;
                line-height:22px;
                border: 4px solid;
                padding:13px 40px;
            }
        </style>
    </head>
    <body style="">

        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <div style="">
                <div style="height: 190px; padding-top: 80px;">
                    <h1 style=""></h1>
                </div>
                <div class="item">
                    <blockquote>
                        <div class="row">
                            <div class="col-sm-8 col-sm-offset-2">
                                <!-- Buttons code start from here -->
                                <div class="container-fluid padding-50">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="container">
                                                <div class="row">
                                                    <div style="margin-left: -30px;" class="col-lg-6 col-lg-offset-3">
                                                        <table>
                                                            <%
                                                                if (request.getParameter("proid") != null) {
                                                                    String val = request.getParameter("proid");
                                                                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();

                                                                    String[] ar = val.split(",");
                                                                    //                                                            sSystem.out.println(ar.length);
                                                                    for (int i = 0; i < ar.length; i++) {
                                                                        int id = Integer.parseInt(ar[i]);
                                                                        System.out.println(id);
                                                                        Criteria cr = ses.createCriteria(DB.Projects.class);
                                                                        cr.add(Restrictions.eq("idprojects", id));
                                                                        List<DB.Projects> l = cr.list();
                                                                        for (DB.Projects pro : l) {

                                                            %>
                                                            <tr>
                                                                <td>Project : <%=pro.getProjectName()%></td>
                                                                <td>
                                                                    <p>
                                                                        <a href="<%=pro.getUploadFile().getPath()%>" class="btn btn-outlined btn-theme btn-lg" data-wow-delay="0.7s">Download Now</a>
                                                                    </p> 
                                                                    <br/>
                                                                </td>
                                                            </tr>

                                                            <%                                                                                }
                                                                    }
                                                                }
                                                            %>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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