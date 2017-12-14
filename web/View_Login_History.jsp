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
<%@page import="java.util.Date"%>
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
        <title>Admin | Login History</title>
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
        </script>
    </head>
    <body style="">

        <%@include file="slide_nav.jsp" %>

        <%
            Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
            HttpSession s = request.getSession();
            int type = Integer.parseInt(s.getAttribute("type").toString());
            DB.UserType ut = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up = (DB.UserPage) sess.load(DB.UserPage.class, 8);
            Criteria crr = sess.createCriteria(DB.UserTypeHasUserPage.class);
            crr.add(Restrictions.eq("userType", ut));
            crr.add(Restrictions.eq("userPage", up));
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
                <h2 class="bg-primary" style="padding-left: 100px"><samp>View Login History</samp></h2>
                <br/>
                <br/>
                <div class="container" style="width: 100%;">
                    <table style="width: 100%;" id="example" class="display" cellspacing="0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>User Name</th>
                                <th>Password</th>
                                <th>Ip Address</th>
                                <th>Mac Address</th>
                                <th>In Time</th>
                                <th>Out Time</th>
                                <th>Browser</th>
                                <th>Platform</th>
                                <!--<th>Description</th>-->
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                Criteria cr = ses.createCriteria(DB.UserLoginDetails.class);
                                List<DB.UserLoginDetails> l = cr.list();
                                for (DB.UserLoginDetails u : l) {
                                    if (u.getUserLogin().getUserType().getIdUserType() != 5) {
                            %>
                            <tr>
                                <td><%= u.getIduserLoginDetails()%></td>
                                <td><%=u.getUserLogin().getUname()%></td>
                                <td><%=u.getUserLogin().getPassword()%></td>
                                <td><%= u.getIpaddress()%></td>
                                <td><%= u.getMacAddress()%></td>
                                <td><%= u.getIntime()%></td>
                                <td><%= u.getOuttime()%></td>
                                <td><%= u.getBrowserDetails()%></td>
                                <td><%= u.getOperationSystem()%></td>
                                <!--<td><%= u.getDescription()%></td>-->
                                <td><span class="" style="">none</span></td>
                                <td>
                                    <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-lock"></span> Block</button>
                                    <!--<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Delete</button>-->
                                </td>
                            </tr>
                            <%}
                                }%>
                        </tbody>
                    </table>
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