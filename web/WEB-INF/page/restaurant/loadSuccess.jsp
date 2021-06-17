<%@ page import="cn.edu.njust.entity.Users" %>
<%@ page import="cn.edu.njust.entity.Restaurant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户成功支付页面</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Restaurant restaurant=(Restaurant) session.getAttribute("restaurant");
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
            title: "菜品上传成功提示",
            text: "菜品已经成功上传",
            type: "success",
            confirmButtonClass: "btn-success",
            confirmButtonText: "Success"
        });
        setInterval(function(){
            window.location.href='<%=basePath%>/rest/toListAllDish.do';
        },2000);
    });
</script>

</html>
