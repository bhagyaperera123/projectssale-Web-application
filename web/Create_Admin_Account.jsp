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
<%@page import="java.security.cert.CRL"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Admin | Create Account</title>
        <link rel="stylesheet" type="text/css" href="datatable/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="datatable/dataTables.bootstrap.css">
        <link rel="stylesheet" type="text/css" href="admin/css/style01.css">

        <script type="text/javascript" language="javascript" src="datatable/jquery-1.10.2.min.js"></script>
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
    </script>
</head>
<body style="">

    <%@include file="slide_nav.jsp" %>
    <div class="main">
        <div >
            <%
                Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
                HttpSession s = request.getSession();
                int type = Integer.parseInt(s.getAttribute("type").toString());
                DB.UserType ut1 = (DB.UserType) sess.load(DB.UserType.class, type);
                DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 2);
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
            <h2 class="bg-primary" style="padding-left: 100px"><samp>Create New Account</samp></h2>
            <br/>
            <br/>
            <form action="create_account" method="post">
                <div class="container-fluid">
                    <section class="container">
                        <div class="container-page">				
                            <div class="col-md-6">
                                <h3 class="dark-grey">Registration</h3>

                                <div class="form-group col-lg-12">
                                    <label>User Name</label>
                                    <input type="text" class="form-control" name="unm">
                                </div>
                                <div class="form-group col-lg-6">
                                    <label>First Name</label>
                                    <input type="text" class="form-control" name="fnm">
                                </div>
                                <div class="form-group col-lg-6">
                                    <label>Last Name</label>
                                    <input type="text" class="form-control" name="lnm">
                                </div>

                                <div class="form-group col-lg-6">
                                    <label>Password</label>
                                    <input type="password" class="form-control" name="pass">
                                </div>

                                <div class="form-group col-lg-6">
                                    <label>Repeat Password</label>
                                    <input type="password" class="form-control" name="repass">
                                </div>

                                <div class="form-group col-lg-6">
                                    <label>Email Address</label>
                                    <input type="" class="form-control" name="email">
                                </div>

                                <div class="form-group col-lg-6">
                                    <label>User role</label>
                                    <select name="urole" class="form-control">
                                        <%
                                            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                            Criteria cr1 = ses.createCriteria(DB.UserType.class);
                                            List<DB.UserType> l1 = cr1.list();
                                            for (DB.UserType ut : l1) {
                                                if (ut.getStatus().equals(1) & ut.getIdUserType() != 2) {
                                        %>
                                        <option value="<%=ut.getIdUserType()%>"><%=ut.getRoleName()%></option>
                                        <%}
                                            }%>
                                    </select>
                                </div>	
                                <div class="col-md-6">

                                </div>
                                <div align="right" class="col-md-6">
                                    <button type="submit" onclick="create_account()" class="btn btn-primary">Register</button>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </form>
        </div>
    </div>
    <script src="js/bootstrap.js"></script>
</body>
</html>
<%} else {
        response.sendRedirect("index.jsp");
    }%>