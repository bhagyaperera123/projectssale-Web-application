<%-- 
    Document   : View_Message
    Created on : Feb 18, 2015, 11:51:10 AM
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="chat-box/assets/css/style.css" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
        <script>
            function sendreply() {
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
                var msg =  document.getElementById("msgtext").value;
                var fid =  document.getElementById("fu").value;
                xmlhttp.open("POST","sendreply?fromuser="+fid+"&msg="+msg,true);
                xmlhttp.send();
            }
        </script>
    </head>
    <body style="">
        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <div style="">
                <%
                    HttpSession hs = request.getSession();
                    if (hs.getAttribute("user") != null) {
                        if (request.getParameter("id") != null) {

                            int from_user = Integer.parseInt(hs.getAttribute("user").toString());
                            int to = Model.Main.valid_url(request.getParameter("id"));
                            System.out.println(from_user+" "+to);
                            if (0 < from_user) {

                                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                Criteria cr = ses.createCriteria(DB.Message.class);
                                DB.User to_u = (DB.User) ses.load(DB.User.class, to);
                                DB.User from_u = (DB.User) ses.load(DB.User.class, from_user);
//                                cr.add(Restrictions.eq("userByIduserForm", from_u));
                                cr.add(Restrictions.and(Restrictions.eq("userByIduserTo", to_u), Restrictions.eq("userByIduserForm", from_u)));
//                                cr.add(Restrictions.or(Restrictions.and(Restrictions.eq("userByIduserTo", to_u), Restrictions.eq("userByIduserForm", from_u)),
//                                        Restrictions.and(Restrictions.eq("userByIduserTo", from_u), Restrictions.eq("userByIduserForm", to_u))));
                                List<DB.Message> l = cr.list();
                                System.out.println("a=="+l.size());
                %>
                <br/>
                <br/>
                <br/>
                <h1><samp>OutBox</samp></h1>
                <input type="hidden" id="fu" value="<%=Security.Security.encrypt(from_user + "")%>">
                <div class="container">
                    <div class="row pad-top pad-bottom">
                        <div class="col-lg-11 col-md-11 col-sm-11">
                            <div class="chat-box-div">

                                <div class="panel-body chat-box-main">
                                    <%
                                        for (DB.Message msg : l) {

                                            Criteria cr1 = ses.createCriteria(DB.MessageBody.class);
                                            cr1.add(Restrictions.eq("message", msg));
                                            List<DB.MessageBody> l1 = cr1.list();
                                            for (DB.MessageBody mb : l1) {

                                    %>
                                    <hr class="hr-clas" />
                                    <%
                                        if (mb.getMessage().getUserByIduserForm().getIduser() == from_user) {
                                    %>
                                    <div align="right" class="chat-box-right">
                                        <samp><%=mb.getMessage_1()%></samp>
                                    </div>
                                    <div class="chat-box-name-right">
                                        <img src="user.png" alt="bootstrap Chat box user image" class="img-circle" />
                                        -  <%=msg.getUserByIduserForm().getFname() + " " + msg.getUserByIduserForm().getLname()%>
                                    </div>
                                    <%                                    } 
//                                        else {

                                    %>
<!--                                    <div align="left" class="chat-box-left">
                                        <samp><%= mb.getMessage_1()%></samp>
                                    </div>
                                    <div class="chat-box-name-left">
                                        <img src="user.png" alt="bootstrap Chat box user image" class="img-circle" />
                                        -  <%=msg.getUserByIduserForm().getFname() + " " + msg.getUserByIduserForm().getLname()%>
                                    </div>-->
                                    <% //                                        }
                                            }
                                        }%>

                                    <hr class="hr-clas" />
                                </div>
<!--                                <div class="chat-box-footer">
                                    <div class="input-group">
                                        <textarea type="text" id="msgtext" style="height: 200px;" style="" class="form-control" placeholder="Enter Message Here..."></textarea>
                                        <span class="input-group-btn">
                                            <button onclick="sendreply()" class="btn btn-primary" style="width: 110px;" type="button"><span class="glyphicon glyphicon-send"></span> Send</button><br/>
                                            <input value="Attach File" class="btn btn-default" style="width: 110px;" type="file"><span class="glyphicon glyphicon-paperclip"></span> Attach File</button>
                                        </span>
                                    </div>
                                </div>-->

                            </div>

                        </div>
                    </div>
                </div>
                <%
                            } else {
                                response.sendRedirect("My_Form.jsp");
                            }

                        } else {
                            response.sendRedirect("My_Form.jsp");
                        }
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                %>


            </div>
            <%@include file="footer.jsp" %>
            <%} else {
                    response.sendRedirect("index.jsp");
                }%>