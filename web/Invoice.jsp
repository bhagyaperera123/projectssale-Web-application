<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.Date"%>
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
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <style>
            .cancel{
                background-color: red;
            }
        </style>
        <script>
            function print_In(){
                print();
            }
            
            function AutoRefresh(t){
                setTimeout("window.location.href='Home.jsp';", t);
            }
            
        </script>
    </head>
    <body onload="print_In(),AutoRefresh(10)">
        <div class="container">
            <%
                if (request.getParameter("id") != null) {

                    String a = Security.Security.decrypt(request.getParameter("id"));
                    int id = Integer.parseInt(a);
                    Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                    DB.Payment php = (DB.Payment) ses.load(DB.Payment.class, id);
                    Criteria cr = ses.createCriteria(DB.PaymentHasProjects.class);
                    cr.add(Restrictions.eq("payment", php));
                    List<DB.PaymentHasProjects> payhas = cr.list();
                    if (payhas != null) {
            %>
            <div class="row">
                <div class="col-xs-12">
                    <div class="invoice-title">
                        <h2>Invoice</h2><h3 class="pull-right">Invoice ID # <%=id%></h3>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-xs-6">
                            <address>
                                <strong>Payment Method:</strong><br>
                                Visa ending **** 4242<br>

                            </address>
                        </div>
                        <div class="col-xs-6 text-right">
                            <address>
                                <strong>Date:</strong><br>
                                <%=new Date()%><br><br>
                            </address>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><strong>Order summary</strong></h3>
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-condensed">
                                    <thead>
                                        <tr>
                                            <td><strong>Item</strong></td>
                                            <td class="text-center"><strong>Price</strong></td>
                                            <td class="text-center"><strong>Quantity</strong></td>
                                            <td class="text-right"><strong>Totals</strong></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%  double total = 0;
                                            for (DB.PaymentHasProjects payh : payhas) {
                                        %>
                                        <tr>
                                            <td><%= payh.getProjects().getProjectName()%></td>
                                            <td class="text-center"><%= payh.getPrice()%></td>
                                            <td class="text-center"><%= payh.getQty()%></td>
                                            <td class="text-right"><%= payh.getPrice()%></td>
                                            <%
                                                total += payh.getPrice();
                                            %>
                                        </tr>
                                        <%}%>
                                        <tr>
                                            <td class="thick-line"></td>
                                            <td class="thick-line"></td>
                                            <td class="thick-line text-center"><strong>Subtotal</strong></td>
                                            <td class="thick-line text-right">$<%=total%></td>
                                        </tr>
                                        <tr>
                                            <td class="no-line"></td>
                                            <td class="no-line"></td>
                                            <td class="no-line text-center"><strong>Tax</strong></td>
                                            <td class="no-line text-right">$0.0</td>
                                        </tr>
                                        <tr>
                                            <td class="no-line"></td>
                                            <td class="no-line"></td>
                                            <td class="no-line text-center"><strong>Total</strong></td>
                                            <td class="no-line text-right">$<%=total%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="span8 well invoice-thank">
                    <h5 style="text-align:center;">Thank You!</h5>
                </div>
            </div>
            <div class="row">
                <div class="span3">
                    <strong>Phone:</strong> <a>0719877863</a>
                </div>
                <div class="span3">
                    <strong>Email:</strong> <a>bsoftsoftwaresolution@gmail.com</a>
                </div>
                <div class="span3">
                    <strong>Website:</strong> <a>www.projectssale.com</a>
                </div>
            </div>
        </div>

        <style>

            .invoice-head td {
                padding: 0 8px;
            }
            .container {
                padding-top:30px;
            }
            .invoice-body{
                background-color:transparent;
            }
            .invoice-thank{
                margin-top: 60px;
                padding: 5px;
            }
            address{
                margin-top:15px;
            }

            .invoice-title h2, .invoice-title h3 {
                display: inline-block;
            }

            .table > tbody > tr > .no-line {
                border-top: none;
            }

            .table > thead > tr > .no-line {
                border-bottom: none;
            }

            .table > tbody > tr > .thick-line {
                border-top: 2px solid;
            }
        </style>
        <%                } else {
                        response.sendRedirect("My_History.jsp");
                    }
                } else {
                    response.sendRedirect("My_History.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        %>
    </body>
</html>