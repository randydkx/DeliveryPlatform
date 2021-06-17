<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <title>用户登录</title>
    <script>
        function userRegister(){
            window.location.href="<%=basePath%>/user/toRegister.do";
        }
        function resIn(){
            window.location.href="<%=basePath%>/rest/toResin.do"
        }
    </script>
</head>

<%--<body style="background: url('<%=basePath%>/static/img/2030474.jpg')">--%>
<body style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">
<c:if test="${!empty message}">
    <div class="alert alert-info alert-error fade show text-center" >
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <strong>${requestScope.message}</strong>
    </div>
</c:if>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-4" style=""></div>
        <div class="col-md-4" id = "mainContainer" style="background: rgba(250,250,250,0.6);margin-top: 70px;height:460px">
            <div class="media pt-lg-3">
                <img src="<%=basePath%>/static/img/njust.jpg" class="align-self-start mr-3" style="width:60px;border-radius: 50%;">
                <div class="media-body">
                    <div style="padding-left: 20px;">
                        <h1>理工大外卖<span class="badge badge-pill badge-info">njust</span></h1>
                    </div>
                </div>
            </div>
            <br />
            <form action="<%=basePath%>/user/login.do" method="post">
                <div class="form-group">
                    <label for="accountid">账号:</label>
                    <input type="text" class="form-control"  name="userName" id="accountid" placeholder="填写登录账号" required="required">
                </div>
                <div class="form-group">
                    <label for="pwd">密码:</label>
                    <input type="password" class="form-control" id="pwd" name="password" placeholder="请输入密码" required="required">
                </div>
                <div class="form-check">
                    <label class="form-check-label">
                        <input class="form-check-input" type="checkbox"> Remember me
                    </label>
                </div>
                <br />
                <button type="submit" class="btn btn-primary">登录</button>
                <button type="button" class="btn btn-success" onclick="userRegister()">注册</button>
                <button type="button" class="btn btn-warning" onclick="resIn()" style="float: right;">商家入驻</button>
            </form>
            <br />
            <div id="Sign-footer" style="text-align: center;">
                <div class="SomeLinks" style="font-size: 13px;">
                    <a href="www.baidu.com">帮助</a>
                    <a href="www.baidu.com">隐私</a>
                    <a href="www.baidu.com">条款</a>
                </div>
                <div class="Team">
                    <a>copyright © 南理工课设团队----罗文水&nbsp;|&nbsp;宋涛&nbsp;|&nbsp;王安文</a>
                </div>
            </div>
        </div>
        <div class="col-md-4" style=""></div>
    </div>
</div>
</body>
<script src="<%=basePath%>/static/js/tether/tether.min.js"></script>
<script src="<%=basePath%>/static/js/plugins.js"></script>
<script src="<%=basePath%>/staic/js/notie/notie.js"></script>
<script src="<%=basePath%>/static/js/notie/notie-init.js"></script>
</html>
