 
    Document   : Admin_Profie
    Created on : Feb 20, 2015, 5:27:01 PM
    Author     : Bhagya

<%@page import="java.util.List"%>
<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<%@page import="org.hibernate.criterion.Restrictions"%>
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
        <title>My Payment History</title>
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
            
            function add_page(id){
                alert(id);
            }
            
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
            DB.UserType ut1 = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 16);
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

            <h2 class="bg-primary" style="padding-left: 100px;"><samp>Payment History</samp></h2>
            <div class="container" style="width: 100%;">
                <table style="width: 100%;" id="example" class="display" cellspacing="0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Projects Count</th>
                                <th>Total Amount</th>
                                <th>Date Time</th>
                                <th>User</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int userid = Integer.parseInt(htps.getAttribute("user").toString());
                                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                Criteria cr = ses.createCriteria(DB.Payment.class);
                                List<DB.Payment> l = cr.list();
                                for (DB.Payment u : l) {
                            %>
                            <tr>
                                <td><%=u.getIdPayment()%></td>
                                <td><%=u.getProjectCount()%></td>
                                <td><%=u.getTotalAmount()%></td>
                                <td><%=u.getDateTime()%></td>
                                <td><%=u.getUser().getFname()+" "+u.getUser().getLname()%></td>
                                <% 
                                    String id = Security.Security.encrypt(u.getIdPayment()+"");
                                %>
                                <td><a href="Invoice.jsp?id=<%=id%>"><button class="btn btn-success">View Invoice</button></a></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
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