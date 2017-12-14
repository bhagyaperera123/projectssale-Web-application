<%-- 
    Document   : Add_User_Role
    Created on : Feb 19, 2015, 11:20:30 PM
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
        <title>Admin | Create Account</title>
        <link rel="stylesheet" type="text/css" href="datatable/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="admin/css/style01.css">
        <link rel="stylesheet" type="text/css" href="css/tree/tree_style.css">

        <script type="text/javascript" language="javascript" src="datatable/jquery-1.10.2.min.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <script>
            
            function add_page(id){
                var v = "<input id='utypeid' type='hidden' value='"+id+"' name='type'>";
                document.getElementById("typeid").innerHTML= v;
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
            
            
            var xmlhttp ;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            
            function remove_page(pageid , typeid){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        if(te == 1){
                            window.location.href = "Add_User_Role.jsp";
                            alert('Success'); 
                        }else if(te == "2"){
                            alert('Sorry No Result');
                        }
                    }
                }
                xmlhttp.open("POST","remove_page?pid="+pageid+"&tyid="+typeid,true);
                xmlhttp.send();
            }
            function remove_Type(typeid){
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;   
                        
                        if(te == 1){
                            window.location.href = "Add_User_Role.jsp";
                            alert('Success'); 
                        }else if(te == "2"){
                            alert('Sorry User Type Not Available');
                        }
                    }
                }
                xmlhttp.open("POST","removeUserType?id="+typeid,true);
                xmlhttp.send();
            
            }
        </script>
    </head>
    <body style="">
        <%
            Session sess = Connection.NewHibernateUtil.getSessionFactory().openSession();
            HttpSession s = request.getSession();
            int type = Integer.parseInt(s.getAttribute("type").toString());
            DB.UserType ut1 = (DB.UserType) sess.load(DB.UserType.class, type);
            DB.UserPage up1 = (DB.UserPage) sess.load(DB.UserPage.class, 4);
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

        <%@include file="slide_nav.jsp" %>
        <div class="main">
            <div >
                <h2 class="bg-primary" style="padding-left: 100px"><samp>Manage User Role</samp></h2>
                <br/>
                <br/>
                <div class="container-fluid">
                    <form action="AddUserType" method="post">
                        <section class="container">
                            <div class="container-page">				
                                <div class="col-md-5">
                                    <h3 class="dark-grey">Add User Type</h3>
                                    <div class="form-group col-lg-6">
                                        <label>User Type Name</label>
                                        <input type="text" name="type" class="form-control" id="" value="">
                                    </div>	
                                </div>
                                <div class="col-md-6">
                                    <h3 class="dark-grey">Privilege Manage</h3>
                                    <%
                                        Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                        Criteria cr2 = ses.createCriteria(DB.UserPage.class);
                                        List<DB.UserPage> l2 = cr2.list();
                                        for (DB.UserPage up : l2) {

                                    %>
                                    <div class="col-md-5">
                                        <input type="checkbox" name="<%=up.getIduserPage()%>" value="<%=up.getIduserPage()%>"> <%=up.getPageName()%>&nbsp;
                                    </div>
                                    <%}%>
                                    <div class="col-md-4">
                                        <br/>
                                        <button type="submit" onclick="create_account()" class="btn btn-success">Add Type</button>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </form>
                </div>
                <br/>
                <br/>
                <h2 class="bg-primary" style="padding-left: 100px"><samp>User Type</samp></h2>
                <br/>
                <ul class="tree">
                    <%
                        Criteria cr = ses.createCriteria(DB.UserType.class);
                        List<DB.UserType> l = cr.list();
                        for (DB.UserType ut : l) {
                    %>

                    <% if (ut.getStatus().equals(1)) {%>
                    <div class="col-md-3">
                        <li><a href="#"><%=ut.getRoleName()%></a> &nbsp;<span onclick="remove_Type(<%=ut.getIdUserType()%>)" style="color: red;" class="glyphicon glyphicon-remove"></span>
                            <ul>
                                <%
                                    Criteria cr1 = ses.createCriteria(DB.UserTypeHasUserPage.class);
                                    DB.UserType uty = (DB.UserType) ses.load(DB.UserType.class, ut.getIdUserType());
                                    cr1.add(Restrictions.eq("userType", uty));
                                    List<DB.UserTypeHasUserPage> l1 = cr1.list();
                                    for (DB.UserTypeHasUserPage uhp : l1) {
                                %>
                                <li><%=uhp.getUserPage().getPageName()%> <span style="color: red;" class="glyphicon glyphicon-remove" onclick="remove_page(<%=uhp.getUserPage().getIduserPage()%>, <%=ut.getIdUserType()%>)"></span></li>   
                                <%}%>
                                <li><a href="#" data-toggle="modal" data-target="#myModal" onclick="add_page(<%=ut.getIdUserType()%>)">Add New Page <span class="glyphicon glyphicon-plus"></span></a></li>   

                            </ul>
                        </li>
                    </div>
                    <%}%>

                    <%}%>
                </ul>    
            </div>
        </div>
        <script type="text/javascript" language="javascript" src="js/tree/tree_script.js"></script>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="editusertype" method="post">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Add New Page</h4>
                        </div>
                        <div class="modal-body">
                            <div style="height: 200px;">
                                <div id="typeid"></div>
                                <div class="col-md-12">
                                    <%
                                        Criteria cr3 = ses.createCriteria(DB.UserPage.class);
                                        List<DB.UserPage> l3 = cr3.list();
                                        for (DB.UserPage up : l3) {

                                    %>
                                    <div class="col-md-5">
                                        <input type="checkbox" name="<%=up.getIduserPage()%>" value="<%=up.getIduserPage()%>"> <%=up.getPageName()%>&nbsp;
                                    </div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary" onclick="Add_New_Page()">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/bootstrap.js"></script>
    </body>
</html>
<%} else {
        response.sendRedirect("index.jsp");
    }%>