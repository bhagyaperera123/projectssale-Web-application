<%-- 
    Document   : Admin_Console
    Created on : Feb 19, 2015, 9:01:32 AM
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
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="datatable/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="datatable/dataTables.bootstrap.css">
        <link rel="stylesheet" type="text/css" href="admin/css/style01.css">
        <title>View | Order</title>
        <script type="text/javascript" language="javascript" src="datatable/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" language="javascript" src="datatable/jquery.dataTables.min.js"></script>
        <script type="text/javascript" language="javascript" src="datatable/dataTables.bootstrap.js"></script>
        <script type="text/javascript" charset="utf-8">
            $(document).ready(function() {
                $('#example').dataTable();
            } );
        </script>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <script>
            function htmlbodyHeightUpdate(){
                var height3 = $( window ).height()
                var height1 = $('.nav').height()+50
                height2 = $('.main').height()
                if(height2 > height3){
                    $('html').height(Math.max(height1,height3,height2)+10);
                    $('body').height(Math.max(height1,height3,height2)+10);
                }
                else
                {
                    $('html').height(Math.max(height1,height3,height2));
                    $('body').height(Math.max(height1,height3,height2));
                }
		
            }
            $(document).ready(function () {
                htmlbodyHeightUpdate()
                $( window ).resize(function() {
                    htmlbodyHeightUpdate()
                });
                $( window ).scroll(function() {
                    height2 = $('.main').height()
                    htmlbodyHeightUpdate()
                });
            });
            var xmlhttp ;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            function block_order(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            alert('Success');
                            window.location.href = "Order_view_Admin.jsp";
                        }
                    }
                }
                xmlhttp.open("POST","block_order?uid="+uid,true);
                xmlhttp.send();
            }
            function Delete_order(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            alert('Success');
                            window.location.href = "Order_view_Admin.jsp";
                        }
                    }
                }
                xmlhttp.open("POST","Delete_order?uid="+uid,true);
                xmlhttp.send();
            }
            function Unblock_order(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            alert('Success');
                            window.location.href = "Order_view_Admin.jsp";
                        }
                    }
                }
                xmlhttp.open("POST","Unblock_order?uid="+uid,true);
                xmlhttp.send();
            }
            function Active_order(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            alert('Success');
                            window.location.href = "Order_view_Admin.jsp";
                        }
                    }
                }
                xmlhttp.open("POST","Active_order?uid="+uid,true);
                xmlhttp.send();
            }
            function View_order(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        alert(te);
                        document.getElementById("val123").innerHTML = te;
                    }
                }
                xmlhttp.open("POST","View_order?uid="+uid,true);
                xmlhttp.send();
            }
            
        </script>
    </head>
    <body style="">
        <%@include file="slide_nav.jsp" %>
        <%
            Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
            HttpSession s = request.getSession();
            int type = Integer.parseInt(s.getAttribute("type").toString());
            DB.UserType ut1 = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 19);
            Criteria crr = sess.createCriteria(DB.UserTypeHasUserPage.class);
            crr.add(Restrictions.eq("userType", ut1));
            crr.add(Restrictions.eq("userPage", up1));
            DB.UserTypeHasUserPage ll = (DB.UserTypeHasUserPage) crr.uniqueResult();
            if (ll != null) {
                System.out.println("list not null");
            } else {
                System.out.println("list null");
                response.sendRedirect("Admin_Console.jsp");
            }
        %>

        <div class="main">
            <div >
                <h2 class="bg-primary" style="padding-left: 100px"><samp>View All Users</samp></h2>
                <div class="container" style="width: 95%;">
                    <table style="width: 100%;" id="example" class="display" cellspacing="0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Send User</th>
                                <th>Receiver User</th>
                                <th>Job Name</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                Criteria cr = ses.createCriteria(DB.Order.class);
                                List<DB.Order> l = cr.list();
                                for (DB.Order u : l) {
                            %>
                            <tr>
                                <td><%=u.getIdorder()%></td>
                                <td><%=u.getUserBySendOrderUser().getFname() %></td>
                                <td><%=u.getUserByReceiverUser().getFname()%></td>
                                <td><%=u.getAddJob().getTitle()%></td>
                                <td><span class="bg bg-primary">Active</span></td>
                                <td>
                                    <button onclick="View_order(<%=u.getIdorder()%>)" type="button" class="btn btn-success" data-toggle="modal" data-target="#myModal"><span class=""></span> View</button>
                                    <% if(u.getStatus() == 1){%>
                                    <button onclick="block_order(<%=u.getIdorder()%>)" type="button" class="btn btn-default"><span class="glyphicon glyphicon-lock"></span> Block</button>
                                    <button onclick="Delete_order(<%=u.getIdorder()%>)" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Delete</button>
                                    <%} else if(u.getStatus() == 0){%>
                                    <button onclick="Active_order(<%=u.getIdorder()%>)" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span> Activate</button>
                                    <%} else if(u.getStatus() == 2){%>
                                    <button onclick="Unblock_order(<%=u.getIdorder()%>)" type="button" class="btn btn-default"><span class="glyphicon glyphicon-lock"></span> Unblock</button>
                                    <%}%>
                                </td>
                            </tr>
                            <%
                            }%>
                        </tbody>
                    </table>
                        <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
          <div id="val123"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            // For demo to fit into DataTables site builder...
            $('#example')
            .removeClass( 'display' )
            .addClass('table table-striped table-bordered');
        </script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>
<%} else {
        response.sendRedirect("index.jsp");
    }%>