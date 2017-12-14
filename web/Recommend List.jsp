<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%@page import="org.hibernate.criterion.MatchMode"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">
        <title>Recommend List</title>
        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
        <link href="css/pro_model.css" rel="stylesheet">
        <script>
            var xmlhttp ;
            if (window.XMLHttpRequest) {
                xmlhttp=new XMLHttpRequest();
            } else {
                xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            function buyingproducts(pid) {
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText; 
                        alert(te);
                    }
                }
                xmlhttp.open("POST","AddToCart?pid="+pid,true);
                xmlhttp.send();
            }
        </script>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0);
            HttpSession htps = request.getSession();
            if (htps.getAttribute("user") != null) {
        %>
        <%@include file="nav.jsp" %>
        <br/>
        <br/>
        <br/>
        <br/>
    <center><div style="width: 90%; background-color: #f6f6f6;">
            <div class="container">
                <div class="row">
                    <br/>
                    <br/>
                    <br/>

                    <%
                        int type = Integer.parseInt(htps.getAttribute("type").toString());
                        int uid = Integer.parseInt(htps.getAttribute("user").toString());
                        String search = request.getParameter("name");
                        Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                        Criteria cr = ses.createCriteria(DB.Projects.class);
                        cr.add(Restrictions.like("projectName", search, MatchMode.ANYWHERE));
                        //cr.add(Restrictions.like("price", search, MatchMode.ANYWHERE));
                        List<DB.Projects> l = cr.list();
                        if (cr.list().size() != 0) {
                            for (DB.Projects pro : l) {

                    %>
                    <div class="col-md-3 column productbox">
                        <samp class="tags" style="margin-left: 10px;"><%=pro.getProjectName()%></samp>
                        <img src="<%=pro.getUploadPic().getPath()%>" class="img-responsive">
                        <div class="producttitle"></div>
                        <div class="productprice">
                            <div class="pull-right">
                                <a href="<%=pro.getUploadDemo().getPath()%>"><button href="" class="btn btn-success btn-sm" role='button'> View Demo </button></a> 
                                <% if (type == 2 && pro.getUser().getIduser() != uid) {%>
                                <button href="" class="btn btn-danger btn-sm" onclick="buyingproducts(<%=pro.getIdprojects()%>)" role='button'>BUY</button>
                                <%}%>
                            </div>
                            <div class='pricetext'>$<%=pro.getPrice()%>.00</div></div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <h1><samp>Sorry No Result</samp></h1>
                    <%                        }
                    %>

                </div>
            </div>
            <br/>
            <br/>
            <br/>
            <br/>
            <script>
                $('#tagmanager').tagmanager({
                    strategy: 'array',
                    tagFieldName: 'tags[]',
                    ajaxCreate: 'http://localhost/tag/create',
                    ajaxRemove: 'http://localhost/tag/remove',
                    initialCap: true,
                    backspaceChars: [ 8 ],
                    delimiterChars: [ 13, 44, 188 ],
                    createHandler: function(tagManager, tag, isImport) {
                        return;
                    },
                    removeHandler: function(tagManager, tag, isEmpty) {
                        return true;
                    },
                    createElementHandler: function(tagManager, tagElement, isImport) {
                        tagManager.$element.before(tagElement);
                    },
                    validateHandler: function(tagManager, tag, isImport) {
                        return tag;
                    }
                });
            </script>
            <%} else {
                            response.sendRedirect("index.jsp");
                        }%>
            <%@include file="footer.jsp" %>

