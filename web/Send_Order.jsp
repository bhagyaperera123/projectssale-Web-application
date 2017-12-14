<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%@page import="java.util.List"%>
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
        <title>View | Admin</title>
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
                <div style="height: 100px;"></div>
                <div >
                    <h2 class="bg-primary" style="padding-left: 100px"><samp>Purchase History</samp></h2>
                    <div class="container" style="width: 95%;">
                        <table style="width: 100%;" id="example" class="display" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>project</th>
                                    <th>project price</th>
                                    <th>date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                    int uid = Integer.parseInt(htps.getAttribute("user").toString());
                                    DB.User user = (DB.User) ses.load(DB.User.class, uid);
                                    Criteria cr = ses.createCriteria(DB.CartHasProject.class);
                                    cr.add(Restrictions.eq("isPurchase", 1));
                                    cr.createAlias("projects", "P");
                                    cr.createAlias("P.user", "P1");
                                    cr.add(Restrictions.eq("P1.iduser", user.getIduser()));

                                    List<DB.CartHasProject> l = cr.list();
                                    for (DB.CartHasProject u : l) {

                                %>
                                <tr>
                                    <td><%=u.getIdcartHasProject()%></td>
                                    <td><%=u.getCart().getUser().getFname() + " " + u.getCart().getUser().getLname()%></td>
                                    <td><%=u.getProjects().getProjectName()%></td>                         
                                    <td><%=u.getProjects().getPrice()%></td>                         
                                    <td><%=u.getCart().getDateTime()%></td>                         
                                </tr>
                                <%
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
    </center>
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

    <%} else {
            response.sendRedirect("index.jsp");
        }%>