<%-- 
    Document   : Admin_Console
    Created on : Feb 19, 2015, 9:01:32 AM
    Author     : Bhagya
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="DB.Payment"%>
<%@page import="Connection.NewHibernateUtil"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
            function block_user(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            alert('Success');
                            window.location.href = "View_Admin.jsp";
                        }
                    }
                }
                xmlhttp.open("POST","block_User?uid="+uid,true);
                xmlhttp.send();
            }
            function Delete_User(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            alert('Success');
                            window.location.href = "View_Admin.jsp";
                        }
                    }
                }
                xmlhttp.open("POST","Delete_User?uid="+uid,true);
                xmlhttp.send();
            }
            function Unblock_User(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            alert('Success');
                            window.location.href = "View_Admin.jsp";
                        }
                    }
                }
                xmlhttp.open("POST","ubblock_user?uid="+uid,true);
                xmlhttp.send();
            }
            function Active_User(uid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            alert('Success');
                            window.location.href = "View_Admin.jsp";
                        }
                    }
                }
                xmlhttp.open("POST","Active_User?uid="+uid,true);
                xmlhttp.send();
            }
            
            function check(){
                
                var date1 = document.getElementById("date1").value;
                var date2 = document.getElementById("date2").value;
                window.location = "View_profit.jsp?date1="+date1+"&date2="+date2;
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
            DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 20);
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
                <h2 class="bg-primary" style="padding-left: 100px"><samp>Profit Calculation</samp></h2>
                <div class="container" style="width: 95%;">
                    <input type="date" id="date1">
                    <input type="date" id="date2">
                    <input type="button" value="Check" onclick="check()" class="btn btn-success">
                    <div style="height: 30px;"></div>
                    <table style="width: 100%;" id="example" class="display" cellspacing="0">

                        <thead>
                            <tr>
                                <th>#</th>
                                <th>User</th>
                                <th>Total Amount</th>
                                <th>Date Time</th>
                                <th>Profit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%

//                                if (request.getParameter("date1") != null & request.getParameter("date2") != null) {
                                double tot = 0;
                                String date1 = request.getParameter("date1");
                                String date2 = request.getParameter("date2");
                                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                                DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                Date d1 = null, d2 = null;
                                try {
                                    d1 = df.parse(date1);
                                    d2 = df.parse(date2);
                                } catch (Exception e) {
                                    //                                    e.printStackTrace();
                                }

                                Session ses = NewHibernateUtil.getSessionFactory().openSession();
                                Criteria cr = ses.createCriteria(Payment.class);

                                //                                if (d1 != null && d2 != null) {
                                //                                    cr.add(Restrictions.between("dateTime", d1 + "", d2 + ""));
                                //                                }

                                ArrayList<Payment> paymt = (ArrayList<Payment>) cr.list();
                                System.out.println("size=" + paymt.size() + " " + d1);
                                for (Payment p : paymt) {
                                    double selP = p.getTotalAmount();
                                    double profit = selP * 5 / 100;
                                    double buyP = selP - profit;
                                    tot += profit;
                                    Date d3 = null;
                                    try {
                                        d3 = df1.parse(p.getDateTime());
                                        System.out.println((d2.after(d3)) + " " + (d1.before(d3)));
                                    } catch (Exception e) {
                                        //                                        e.printStackTrace();
                                    }

                                    if ((d1 != null && d2 != null && d2.after(d3) && d1.before(d3)) || d1 == null || d2 == null) {
                            %>
                            <tr>
                                <td><%=p.getIdPayment()%></td>
                                <td><%=p.getUser().getFname()+" "+p.getUser().getLname()%></td>
                                <td><%=p.getTotalAmount()%></td>
                                <td><%=p.getDateTime()%></td>
                                <td><%=profit%></td>
                            </tr>

                            <%
                                        System.out.println("soop");
                                    }
                                    //                                    System.out.println(selP + " " + profit + " " + buyP + " " + d3);
                                }

                            %>


                        </tbody>
                    </table>
                </div>
                            <h4>Total Profit : <samp>RS <%=tot%>0</samp></h4>
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