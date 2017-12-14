            
var xmlhttp ;
if (window.XMLHttpRequest) {
    xmlhttp=new XMLHttpRequest();
} else {
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
}      
function remove_database(id){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == "3"){
                alert('ID Not Found');
            }else if(te == "2"){
                alert('Type Not Found');
            }else if(te == "1"){
                alert('Remove Successfully');
                window.location.href = "Other_Function.jsp";
            }
        }
    }
    xmlhttp.open("POST","Add_Database?id="+id+"&type=remove",true);
    xmlhttp.send();
}
function Active_database(id){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == "3"){
                alert('ID Not Found');
            }else if(te == "2"){
                alert('Type Not Found');
            }else if(te == "1"){
                alert('Activate Successfully');
                window.location.href = "Other_Function.jsp";
            }
        }
    }
    xmlhttp.open("POST","Add_Database?id="+id+"&type=active",true);
    xmlhttp.send();
}
function Add_database(){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == 1){
                alert('Success');
                window.location.href = "Other_Function.jsp";
            }else if(te == 4){
                alert('Database Name Null');
            }
        }
    }
    var val = document.getElementById("dbname").value;
    xmlhttp.open("POST","Add_Database?name="+val+"&type=add",true);
    xmlhttp.send();
}
function remove_job_Category(id){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == "3"){
                alert('ID Not Found');
            }else if(te == "2"){
                alert('Type Not Found');
            }else if(te == "1"){
                alert('Remove Successfully');
                window.location.href = "Other_Function.jsp";
            }
        }
    }
    xmlhttp.open("POST","Add_job_category?id="+id+"&type=remove",true);
    xmlhttp.send();
}
function Active_job_Category(id){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == "3"){
                alert('ID Not Found');
            }else if(te == "2"){
                alert('Type Not Found');
            }else if(te == "1"){
                alert('Activate Successfully');
                window.location.href = "Other_Function.jsp";
            }
        }
    }
    xmlhttp.open("POST","Add_job_category?id="+id+"&type=active",true);
    xmlhttp.send();
}
function Add_job_category(){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == 1){
                alert('Success');
                window.location.href = "Other_Function.jsp";
            }else if(te == 4){
                alert('Database Name Null');
            }
        }
    }
    var val = document.getElementById("jobcatename").value;
    xmlhttp.open("POST","Add_job_category?name="+val+"&type=add",true);
    xmlhttp.send();
}
function remove_sub_Category(id){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == "3"){
                alert('ID Not Found');
            }else if(te == "2"){
                alert('Type Not Found');
            }else if(te == "1"){
                alert('Remove Successfully');
                window.location.href = "Other_Function.jsp";
            }
        }
    }
    xmlhttp.open("POST","Add_sub_category?id="+id+"&type=remove",true);
    xmlhttp.send();
}
function Active_sub_Category(id){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == "3"){
                alert('ID Not Found');
            }else if(te == "2"){
                alert('Type Not Found');
            }else if(te == "1"){
                alert('Activate Successfully');
                window.location.href = "Other_Function.jsp";
            }
        }
    }
    xmlhttp.open("POST","Add_sub_category?id="+id+"&type=active",true);
    xmlhttp.send();
}
function Add_sub_category(){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == 1){
                alert('Success');
                window.location.href = "Other_Function.jsp";
            }else if(te == 4){
                alert('Database Name Null');
            }
        }
    }
    var val = document.getElementById("subname").value;
    xmlhttp.open("POST","Add_sub_category?name="+val+"&type=add",true);
    xmlhttp.send();
}
function remove_Category_type(id){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == "3"){
                alert('ID Not Found');
            }else if(te == "2"){
                alert('Type Not Found');
            }else if(te == "1"){
                alert('Remove Successfully');
                window.location.href = "Other_Function.jsp";
            }
        }
    }
    xmlhttp.open("POST","Add_category_type?id="+id+"&type=remove",true);
    xmlhttp.send();
}
function Activate_Category_type(id){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == "3"){
                alert('ID Not Found');
            }else if(te == "2"){
                alert('Type Not Found');
            }else if(te == "1"){
                alert('Activate Successfully');
                window.location.href = "Other_Function.jsp";
            }
        }
    }
    xmlhttp.open("POST","Add_category_type?id="+id+"&type=active",true);
    xmlhttp.send();
}
function Add_category_type(){
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var te = xmlhttp.responseText; 
            if(te == 1){
                alert('Success');
                window.location.href = "Other_Function.jsp";
            }else if(te == 4){
                alert('Category type Name Null');
            }
        }
    }
    var val = document.getElementById("catetypeid").value;
    xmlhttp.open("POST","Add_category_type?name="+val+"&type=add",true);
    xmlhttp.send();
}