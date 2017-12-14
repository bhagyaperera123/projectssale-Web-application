<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<!DOCTYPE html>
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
    </head>
    <body style="">
        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <div style="">
                <div style="height: 60px;"></div>
                <h2 class="bg-success" style=""><samp>Payment History</samp></h2>
                <div class="container" style="width: 95%;">
                    <table style="width: 100%;" id="example" class="display" cellspacing="0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Projects Count</th>
                                <th>Total Amount</th>
                                <th>Date Time</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int userid = Integer.parseInt(htps.getAttribute("user").toString());
                                Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                DB.User user = (DB.User) ses.load(DB.User.class, userid);
                                Criteria cr = ses.createCriteria(DB.Payment.class);
                                cr.add(Restrictions.eq("user", user));
                                List<DB.Payment> l = cr.list();
                                for (DB.Payment u : l) {
                            %>
                            <tr>
                                <td><%=u.getIdPayment()%></td>
                                <td><%=u.getProjectCount()%></td>
                                <td><%=u.getTotalAmount()%></td>
                                <td><%=u.getDateTime()%></td>
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
        </div>
    </center>
            <script type="text/javascript">
                // For demo to fit into DataTables site builder...
                $('#example')
                .removeClass( 'display' )
                .addClass('table table-striped table-bordered');
            </script>
            
            <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<link href="css/footer.css" type="text/css" rel="stylesheet">
<foote>
    <div class="footer" id="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-3  col-md-2 col-sm-4 col-xs-6">
                    <h3> category </h3>
                    <ul>
                        <li> <a href="#"> Android Application </a> </li>
                        <li> <a href="#"> Web Application </a> </li>
                        <li> <a href="#"> Windows Application(SE/MOB) </a> </li>
                        <li> <a href="#"> Mac Application(SE/MOB) </a> </li>
                    </ul>
                </div>

                <div class="col-lg-3  col-md-2 col-sm-4 col-xs-6">
                    <h3> Follow </h3>
                    <ul>
                        <li> <a href="#"> Facebook </a> </li>
                        <li> <a href="#"> Google </a> </li>
                        <li> <a href="#"> Twitter </a> </li>
                        <li> <a href="#"> TSU </a> </li>
                    </ul>
                </div>
                <div class="col-lg-3  col-md-2 col-sm-4 col-xs-6">
                    <h3> Contact </h3>
                    <ul>
                        <li> <a href="#"> Bsoftsoftwresolution@gmail.com </a> </li>
                        <li> <a href="#"> 0719877863 </a> </li>
                        <li> <a href="#">  </a> </li>
                        <li> <a href="#">  </a> </li>
                    </ul>
                </div>
                <div class="col-lg-3  col-md-3 col-sm-6 col-xs-12 ">
                    <h3> Lorem Ipsum </h3>
                    <ul>
                        <li>
                            <div class="input-append newsletter-box text-center">
                                <input type="text" class="full text-center" placeholder="Email ">
                                <button class="btn  bg-gray" type="button"> Lorem ipsum <i class="fa fa-long-arrow-right"> </i> </button>
                            </div>
                        </li>
                    </ul>
                    <ul class="social">
                        <li> <a href="#"> <i class="fa fa-facebook">   </i> </a> </li>
                        <li> <a href="#"> <i class="fa fa-twitter">   </i> </a> </li>
                        <li> <a href="#"> <i class="fa fa-google-plus">   </i> </a> </li>
                        <li> <a href="#"> <i class="fa fa-pinterest">   </i> </a> </li>
                        <li> <a href="#"> <i class="fa fa-youtube">   </i> </a> </li>
                    </ul>
                </div>
            </div>
            <!--/.row--> 
        </div>
        <!--/.container--> 
    </div>
    <!--/.footer-->

    <div class="footer-bottom">
        <div class="container">
            <p class="pull-left"> Copyright © Projectssale.com 2015. All right reserved. </p>
            <div class="pull-right">
                <ul class="nav nav-pills payments">
                    <li><i class="fa fa-cc-visa"></i></li>
                    <li><i class="fa fa-cc-mastercard"></i></li>
                    <li><i class="fa fa-cc-amex"></i></li>
                    <li><i class="fa fa-cc-paypal"></i></li>
                </ul> 
            </div>
        </div>
    </div>
</footer>
<script src="js/bootstrap.js"></script>


</body>
</html>

            <%} else {
                    response.sendRedirect("index.jsp");
                }%>