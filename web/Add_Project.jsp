<%-- 
    Document   : Add-Project
    Created on : Feb 9, 2015, 3:25:13 PM
    Author     : Bhagya
--%>
<%
    response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0);
    HttpSession htps = request.getSession();
    if (htps.getAttribute("user") != null) {
%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/bootstrap.css" rel="stylesheet">

        <link type="text/css" rel="stylesheet" href="tagmanager/tagmanager.css">
        <script type="text/javascript" src="tagmanager/jquery.min.js"></script>
        <script type="text/javascript" src="tagmanager/tagmanager.js"></script>
        <script>
            function load_category() {
                var xmlhttp ;
                var category = document.getElementById("cate").value;
                if (window.XMLHttpRequest) {
                    xmlhttp=new XMLHttpRequest();
                } else {
                    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange=function() {
                    if (xmlhttp.readyState==4 && xmlhttp.status==200) {
                        var te = xmlhttp.responseText;
                        document.getElementById("sub").innerHTML = te;
                    }
                }
                
                xmlhttp.open("POST","load_sub?cid="+category,true);
                xmlhttp.send();
            }
        </script>
    </head>
    <body style="" onload="load_category()">
        <%@include file="nav.jsp" %>
    <center><div style="width: 80%; background-color: #f6f6f6;">
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <div class="container">
                <div class="row">
                    <div class="col-md-1">

                    </div>
                    <div class="col-md-6">
                        <form class="form-horizontal" action="Add_Project" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Title</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="" name="title" placeholder="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Price ($)</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="" name="price" placeholder="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Category</label>
                                <div class="col-sm-4">
                                    <select class="form-control" id="cate" name="category" onchange="load_category()">
                                        <%
                                            Session ses = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                            Criteria cr = ses.createCriteria(DB.CategoryType.class);
                                            List<DB.CategoryType> l = cr.list();
                                            if (l != null) {
                                                for (int i = 0; i < l.size(); i++) {
                                                    DB.CategoryType c = l.get(i);
                                                    if (c.getStatus() == 1) {
                                        %>
                                        <option value="<%=c.getIdCategoryType()%>"><%=c.getName()%></option>
                                        <% }
                                                }
                                            }%>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Sub Category</label>
                                <div class="col-sm-4">
                                    <div id="sub">

                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Description</label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" name="description" style="height: 200px; max-height: 150px; min-height: 150px;"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Data Base</label>
                                <div class="col-sm-2">          
                                    <select class="form-control" id="dbb" name="db" style="width: 110px;">
                                        <%
                                            Session ses1 = Connection.NewHibernateUtil.getSessionFactory().openSession();
                                            Criteria cr1 = ses.createCriteria(DB.Database1.class);
                                            List<DB.Database1> l1 = cr1.list();
                                            if (l != null) {
                                                for (int i = 0; i < l1.size(); i++) {
                                                    DB.Database1 c1 = l1.get(i);
                                                    if(c1.getStatus() == 1){
                                        %>
                                        <option value="<%=c1.getIdDatabase()%>"><%=c1.getName()%></option>
                                        <%    }                            }
                                            }%>
                                    </select>

                                </div>
                            </div>
                            <style>
                                .tagmanagerTag{
                                    height: 34px;
                                }
                            </style>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Program Language</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="tags1"placeholder="Add Tags"  id="tagmanager" autocomplete="off">
                                    (Max 10)
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Screen Shot</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="file" name="imgfile">
                                    (Dimensions 520x480) Png or Jpg
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">File</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="file" name="upfile">
                                    (Max 50Mb) Zip File
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="" class="col-sm-2 control-label">Demo File(Zip or Pdf)</label>
                                <div class="col-sm-10">
                                    <input class="form-control" type="file" name="demo">
                                    (Max 20Mb) Zip File
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-plus"> </span> Add</button>
                                    <button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-arrow-left"> </span> Go to Back</button>
                                </div>
                            </div>
                        </form>
                        <br/>
                        <br/>
                    </div>
                </div>
            </div>
        </div></center>
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
    <%@include file="footer.jsp" %>

    <%} else {
            response.sendRedirect("index.jsp");
        }%>