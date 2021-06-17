<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>

    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    %>

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
        function validate(){
            if(document.signin.resName.value.length>30){
                alert("不能超过30个字符！");
                document.signin.resName.focus();
                return false;
            }
        }
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
                        <img src="<%=basePath%>/static/img/njust.jpg" id="icon" style="width: 120px;height:120px; float: left;border-radius: 100%;"/>
                    </div>
                    <div class="tbl-cell">
                        <ol class="breadcrumb breadcrumb-simple">
                            <li><a href="#">登录界面</a></li>
                            <li class="active">商家入驻</li>
                        </ol>
                    </div>
                </div>
            </div>
        </header>

        <section class="card" style="background-color: rgba(250,250,250,0.6);">
            <div class="card-block">
                <form action="<%=basePath%>/rest/resin.do" method="post"
                      enctype="multipart/form-data" onsubmit="return validate()">
                    <div class="row">
                        <div class="col-md-6">
                            <div  class="custom-file mb-3" style="margin-top: 31px;">
                                <input type="file" class="custom-file-input" id="customFile" name="file" onchange="upload('#customFile','#icon')"/>
                                <label class="custom-file-label" for="customFile">上传餐馆头像</label>
                            </div>
                            <fieldset class="form-group">
                                <label class="form-label">餐馆名称：</label>
                                <input name="name"
                                       type="text"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">登录密码：</label>
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
                                <label class="form-label">餐馆地址：</label>
                                <input name="locate"
                                       type="text"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                        </div>
                        <div class="col-md-6">
                            <fieldset class="form-group">
                                <label class="form-label">餐馆电话：</label>
                                <input name="resPhone"
                                       type="tel"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">开始营业时间：</label>
                                <input name="startTime"
                                       type="number"
                                       contenteditable="false"
                                       class="form-control"
                                       placeholder="输入0-24之间的整数"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">结束营业时间：</label>
                                <input name="endTime"
                                       type="number"
                                       contenteditable="false"
                                       placeholder="输入0-24之间的整数"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">银行账户：</label>
                                <input name="accountID"
                                       type="text"
                                       class="form-control"
                                       required="required"
                                       data-validation="[NOTEMPTY]">
                            </fieldset>
                            <fieldset class="form-group">
                                <label class="form-label">餐馆类型：</label>
                                <select class="form-control" name="resTypeID" required="required">
                                    <option value="1" autofocus="autofocus">快餐便当</option>
                                    <option value="2">火锅烤鱼</option>
                                    <option value="3">日韩料理</option>
                                    <option value="4">甜品饮品</option>
                                    <option value="5">水果店铺</option>
                                    <option value="6">小吃烧烤</option>
                                    <option value="7">米粉面馆</option>
                                    <option value="8">地方菜馆</option>
                                </select>
                            </fieldset>
                            <fieldset class="form-group">
                                <button type="button" class="btn btn-primary" onclick="returnfun2()">返回</button>
                                <button type="submit" class="btn btn-success text-right">提交注册</button>
                            </fieldset>
                        </div>
                    </div><!--.row-->
                </form>
            </div>
        </section>
    </div><!--.container-fluid-->
</div><!--.page-content-->

<script>
    function returnfun2(){
        return history.back(-1);
    }
</script>
</body>
</html>
