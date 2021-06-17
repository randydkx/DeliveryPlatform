<%@ page import="cn.edu.njust.entity.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户成功支付页面</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Users user= (Users)session.getAttribute("user");
    %>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap-sweetalert/sweetalert.css">
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>/static/css/main.css">

</head>
    <body>


    </body>
<script src="<%=basePath%>/static/js/jquery-3.2.1.min.js"></script>
<script src="<%=basePath%>/static/js/bootstrap-sweetalert/sweetalert.min.js"></script>
<script>
    $(document).ready(function() {
        swal({
            title: "支付提示",
            text: "成功下单，等待商家配送",
            type: "success",
            confirmButtonClass: "btn-success",
            confirmButtonText: "Success"
        });
        setInterval(function(){
            window.location.href='<%=basePath%>/user/showRoute.do';
        },3000);
    });
</script>

</html>
