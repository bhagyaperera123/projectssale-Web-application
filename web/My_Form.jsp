<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%      response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<%@page import="org.hibernate.Query"%>
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
        <script>
            var xmlhttp ;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            function load_projects() {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;
                        document.getElementById("tid").innerHTML = te;
                    }
                }
                xmlhttp.open("POST","loadproject",true);
                xmlhttp.send();
            }
            function Delete_job(typeid){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;  
                        if(te == 1){
                            window.location.href = "View_Jobs.jsp";
                            alert('Success'); 
                        }
                    }
                }
                xmlhttp.open("POST","Delete_Job?id="+typeid,true);
                xmlhttp.send();
            }
        </script>
    </head>
    <body style="" onload="load_projects()">
        <%@include file="nav.jsp" %>

    <center><div style="width: 90%; background-color: #f6f6f6;">
            <div style="">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <h3>&nbsp;</h3>
                            <div class="tabbable-panel">
                                <div class="tabbable-line">
                                    <ul class="nav nav-tabs " style="">

                                        <li class="active">
                                            <a href="#tab_default_1" data-toggle="tab">
                                                My Orders </a>
                                        </li>
                                        <li>
                                            <a href="#tab_default_2" data-toggle="tab">
                                                Inbox </a>
                                        </li>
                                        <li>
                                            <a href="#tab_default_4" data-toggle="tab">
                                                Outbox </a>
                                        </li>
                                        <li>
                                            <a href="#tab_default_3" data-toggle="tab">
                                                My Jobs </a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">

                                        <div class="tab-pane active" id="tab_default_1">
                                            <h3>Order</h3>
                                            <table align="center" class="table" style="width: 80%; border: 1px solid silver; border-radius: 8px;">
                                                <tr>
                                                    <td style="width: 20%;"><span class="glyphicon glyphicon-sort-by-order"></span></td>
                                                    <td style="width: 20%;">Title</td>
                                                    <td style="width: 60%;">Message Body</td>
                                                    <td style="width: 20%;"></td>
                                                    <td style="width: 20%;"></td>
                                                </tr>

                                                <%
                                                    HttpSession hs = request.getSession();
                                                    if (hs.getAttribute("user") != null) {
                                                        int uid = Integer.parseInt(hs.getAttribute("user").toString());
                                                        Session ss1 = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                                        Criteria cr = ss1.createCriteria(DB.Order.class);
                                                        DB.User user = (DB.User) ss1.load(DB.User.class, uid);
                                                        cr.add(Restrictions.eq("userByReceiverUser", user));
                                                        List<DB.Order> l = cr.list();
                                                        for (int i = 0; i < l.size(); i++) {
                                                            String x = null;
                                                            DB.Order order = l.get(i);
                                                            int ar = order.getOrderDetails().getMsgBody().length();

                                                            if (1000 < ar) {
                                                                x = order.getOrderDetails().getMsgBody().substring(999);
                                                            } else if (300 < ar) {
                                                                x = order.getOrderDetails().getMsgBody().substring(290);
                                                            } else {
                                                                x = order.getOrderDetails().getMsgBody();
                                                            }
                                                            
                                                            if(order.getStatus() ==1){
            %>
                                                <tr>
                                                    <td style="width: 25%;"><img width="40" height="40" src="user.png">&nbsp;<%=order.getUserBySendOrderUser().getFname()%></td>
                                                    <td style="width: 20%;"><%=order.getOrderDetails().getTitle()%></td>
                                                    <td style="width: 60%;"><%=x%></td>
                                                    <td style="width: 20%;"><a href=""><button class="btn btn-success"><span class="glyphicon glyphicon-send"></span> DELIVER NOW </button></a></td>
                                                    <td style="">
                                                        <a href="View_Order.jsp?orid=<%=Security.Security.encrypt(order.getIdorder() + "")%>"><button class="btn btn-success"><span class="glyphicon glyphicon-send"></span> View Order </button></a></td>
                                                </tr>
                                                <%}
                                                        }
                                                    } else {
                                                        response.sendRedirect("index.jsp");
                                                    }

                                                %>
                                            </table>
                                        </div>
                                        <div class="tab-pane" id="tab_default_4">
                                            <h3>Inbox</h3>               
                                            <div class="col-md-3" style="margin-left: 66%;">
                                                <input type="text" class="form-control" placeholder="Search My History...."><br/>
                                            </div>
                                            <table align="center" class="table table-striped" style="width: 80%; border: 1px solid silver; border-radius: 8px;">
                                                <tr>
                                                    <td style="width: 10%;"></td>
                                                    <td style="width: 20%;">SENDER</td>
                                                    <td style="width: 50%;">LAST MESSAGE</td>
                                                    <td style="width: 20%;">UPDATE</td>
                                                </tr>
                                                <%

                                                    int uid1 = Integer.parseInt(hs.getAttribute("user").toString());
                                                    Session ss21 = Connection.NewHibernateUtil.getSessionFactory().openSession();

                                                    DB.User user1 = (DB.User) ss21.load(DB.User.class, uid1);
                                                    Query q1 = ss21.createQuery("FROM Message where userByIduserForm = " + uid1 + " group by userByIduserTo order by idMessage desc");
                                                    List<DB.Message> l2 = q1.list();

                                                    for (int i = 0; i < l2.size(); i++) {
                                                        DB.Message msg = l2.get(i);

                                                        Criteria cr1 = ss21.createCriteria(DB.MessageBody.class);
                                                        DB.Message m = (DB.Message) ss21.load(DB.Message.class, msg.getIdMessage());
                                                        cr1.add(Restrictions.eq("message", m));
                                                        List<DB.MessageBody> l1 = cr1.list();
                                                        for (int t = 0; t < l1.size(); t++) {
                                                            DB.MessageBody msgbody = l1.get(t);

                                                            String z = null;
                                                            int w = msgbody.getMessage_1().length();
                                                            if (1000 < w) {
                                                                z = msgbody.getMessage_1().substring(999);
                                                            } else if (300 < w) {
                                                                z = msgbody.getMessage_1().substring(299);
                                                            } else {
                                                                z = msgbody.getMessage_1();
                                                            }
                                                %>
                                                <tr>
                                                    <td><input type="checkbox"></td>
                                                    <td><img width="30" height="30" src="user.png" class="img-circle">&nbsp;&nbsp; <%=msg.getUserByIduserTo().getFname()%> </td>
                                                    <td><a href="View_Outbox.jsp?id=<%=Security.Security.encrypt(msg.getUserByIduserTo().getIduser() + "")%>"><%=z%></a></td>
                                                    <td><%=msgbody.getTime()%></td>
                                                </tr>
                                                <%
                                                        }
                                                    }%>
                                            </table>
                                        </div>
                                        <div class="tab-pane" id="tab_default_2" style="overflow-y: scroll;">
                                            <h3>Inbox</h3>               
                                            <div class="col-md-3" style="margin-left: 66%;">
                                                <input type="text" class="form-control" placeholder="Search My History...."><br/>
                                            </div>
                                            <table align="center" class="table table-striped" style="width: 80%; border: 1px solid silver; border-radius: 8px;">
                                                <tr>
                                                    <td style="width: 10%;"></td>
                                                    <td style="width: 20%;">SENDER</td>
                                                    <td style="width: 50%;">LAST MESSAGE</td>
                                                    <td style="width: 20%;">UPDATE</td>
                                                </tr>
                                                <%

                                                    int uid = Integer.parseInt(hs.getAttribute("user").toString());
                                                    Session ss2 = Connection.NewHibernateUtil.getSessionFactory().openSession();

                                                    DB.User user = (DB.User) ss2.load(DB.User.class, uid);
                                                    Query q = ss2.createQuery("FROM Message where userByIduserTo = " + uid + " group by userByIduserForm order by idMessage desc");
                                                    List<DB.Message> l = q.list();

                                                    for (int i = 0; i < l.size(); i++) {
                                                        DB.Message msg = l.get(i);

                                                        Criteria cr1 = ss2.createCriteria(DB.MessageBody.class);
                                                        DB.Message m = (DB.Message) ss2.load(DB.Message.class, msg.getIdMessage());
                                                        cr1.add(Restrictions.eq("message", m));
                                                        List<DB.MessageBody> l1 = cr1.list();
                                                        for (int t = 0; t < l1.size(); t++) {
                                                            DB.MessageBody msgbody = l1.get(t);

                                                            String z = null;
                                                            int w = msgbody.getMessage_1().length();
                                                            if (1000 < w) {
                                                                z = msgbody.getMessage_1().substring(999);
                                                            } else if (300 < w) {
                                                                z = msgbody.getMessage_1().substring(299);
                                                            } else {
                                                                z = msgbody.getMessage_1();
                                                            }
                                                %>
                                                <tr>
                                                    <td><input type="checkbox"></td>
                                                    <td><img width="30" height="30" src="user.png" class="img-circle">&nbsp;&nbsp; <%=msg.getUserByIduserForm().getFname()%> </td>
                                                    <td><a href="View_Message.jsp?id=<%=Security.Security.encrypt(msg.getUserByIduserForm().getIduser() + "")%>"><%=z%></a></td>
                                                    <td><%=msgbody.getTime()%></td>
                                                </tr>
                                                <%
                                                        }
                                                    }%>
                                            </table>
                                        </div>
                                        <div class="tab-pane" id="tab_default_3">
                                            <div class="container">
                                                <div class="row">


                                                    <div class="col-md-11">
                                                        <h5>
                                                            <input type="radio" onchange="load_projects()" name="a" value="project">Projects
                                                            &nbsp;<input type="radio" onchange="load_projects()" name="a" value="project">Jobs
                                                        </h5>
                                                        <div class="table-responsive" style="width: 99%;">
                                                            <table style="margin-left: 30px; overflow-x: hidden;" id="mytable" class="table table-bordred table-striped">

                                                                <thead>

                                                                <th></th>
                                                                <th>Job</th>
                                                                <th>Job Name</th>
                                                                <th>Rating</th>
                                                                <th>Views</th>
                                                                <th>Order</th>
                                                                <th></th>
                                                                <th></th>
                                                                <th>Delete</th>
                                                                </thead>
                                                                <tbody id="tid">

                                                                </tbody>

                                                            </table>

                                                        </div>

                                                    </div>
                                                </div>
                                            </div>






                                            <div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                                                            <h4 class="modal-title custom_align" id="Heading">Delete this entry</h4>
                                                        </div>
                                                        <div class="modal-body">

                                                            <div class="alert alert-danger"><span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to delete this Record?</div>

                                                        </div>
                                                        <div class="modal-footer ">
                                                            <button type="button" class="btn btn-success" ><span class="glyphicon glyphicon-ok-sign"></span> Yes</button>
                                                            <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> No</button>
                                                        </div>
                                                    </div>
                                                    <!-- /.modal-content --> 
                                                </div>
                                                <!-- /.modal-dialog --> 
                                            </div>
                                        </div>
                                        <script>
                                            
                                            $(document).ready(function(){
                                                $("#mytable #checkall").click(function () {
                                                    if ($("#mytable #checkall").is(':checked')) {
                                                        $("#mytable input[type=checkbox]").each(function () {
                                                            $(this).prop("checked", true);
                                                        });

                                                    } else {
                                                        $("#mytable input[type=checkbox]").each(function () {
                                                            $(this).prop("checked", false);
                                                        });
                                                    }
                                                });

                                                $("[data-toggle=tooltip]").tooltip();
                                            });
                                        </script>
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

                    /* Tabs panel */
                    .tabbable-panel {
                        border:1px solid #eee;
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
            <%@include file="footer.jsp" %>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>