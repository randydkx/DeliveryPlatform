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
<body >

</body>
<script src="<%=basePath%>/static/js/jquery-3.2.1.min.js"></script>
<script src="<%=basePath%>/static/js/bootstrap-sweetalert/sweetalert.min.js"></script>
<script>
    $(document).ready(function() {
        swal({
            title: "错误提示",
            text: "您的支付密码不正确！请重新输入",
            type: "warning",
            // showCancelButton: true,
            confirmButtonClass: "btn-danger",
            confirmButtonText: "重新支付",
            // cancelButtonText: "No, cancel plx!",
            closeOnConfirm: false,
            closeOnCancel: false
        })

        setInterval(function () {
                window.location.href="<%=basePath%>/user/toPayPage.do";
        },2000)

    });
</script>

</html>
