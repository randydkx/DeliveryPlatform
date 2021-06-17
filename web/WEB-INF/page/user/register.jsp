<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<head>
    <meta charset="UTF-8">
    <title></title>
    <![endif]-->
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>/static/css/resin.css">
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var upload = function (c, d) {
            "use strict";
            var $c = document.querySelector(c),
                $d = document.querySelector(d),
                file = $c.files[0],
                reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function (e) {
                $d.setAttribute("src", e.target.result);
            };
        };
    </script>
</head>
<body style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">
<c:if test="${not empty requestScope.message}">
    <div class="alert alert-info alert-error fade show text-center" >
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <strong>${requestScope.message}</strong>
    </div>
</c:if>
<div class="page-content" style="margin-bottom: 100px;">
    <div class="container-fluid">
        <header class="section-header">
            <div class="tbl">
                <div class="tbl-row">
                    <div class="logo" style="background: none;">
                        <img id="icon" src="<%=basePath%>/static/img/njust.jpg" style="width: 120px;height:120px;float: left;border-radius:100%;"/>
                    </div>
                    <div class="tbl-cell">
                        <ol class="breadcrumb breadcrumb-simple">
                            <li><a href="#">登录界面</a></li>
                            <li class="active">用户注册</li>
                        </ol>
                    </div>
                </div>
            </div>
        </header>

        <section class="card" style="background-color: rgba(250,250,250,0.6);">
            <div class="card-block">
                <form action="<%=basePath%>/user/register.do" method="POST" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md">
                            <div class="custom-file mb-3" style="margin-top: 32px;">
                                <input type="file" class="custom-file-input" id="customFile" name="file" onchange="upload('#customFile','#icon')">
                                <label class="custom-file-label" for="customFile" >上传头像</label>
                            </div>
                            <fieldset class="form-group">
                                <label class="form-label">用户名：</label>
                                <input name="userName"
                                       type="text"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">密码：</label>
                                <input name="password"
                                       type="password"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">确认密码：</label>
                                <input name="password2"
                                       type="password"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">配送地址：</label>
                                <input name="address"
                                       type="address"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                        </div>
                        <div class="col-md">
                            <fieldset class="form-group">
                                <label class="form-label">Email：</label>
                                <input name="email"
                                       type="email"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">手机号：</label>
                                <input name="phoneNum"
                                       type="tel"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">账户ID：</label>
                                <input name="accountID"
                                       type="text"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">账户密码：</label>
                                <input name="accountPwd"
                                       type="password"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group align-content-center">
                                <button type="button" class="btn btn-primary" onclick="returnfun()">返回</button>
                                <button type="submit" class="btn btn-success ml-lg-2 text-right ">提交注册</button>
                            </fieldset>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </div><!--.container-fluid-->
</div><!--.page-content-->
    <script>
        function returnfun(){
            history.back(-1);
        }
    </script>
</body>
</html>
