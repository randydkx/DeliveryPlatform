<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cn.edu.njust.entity.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户修改信息页面</title>
        <%
            String path = request.getContextPath();
            String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
            Users user=(Users)session.getAttribute("user");
        %>
    <head>
        <title>Home</title>
        <!-- for-mobile-apps -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Great Taste Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
        function hideURLbar(){ window.scrollTo(0,1); } </script>
        <!-- //for-mobile-apps -->
        <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=basePath%>/static/css/loaddish.css" rel="stylesheet" type="text/css" media="all" />
        <!-- js -->
        <script src="<%=basePath%>/static/js/jquery-1.11.1.min.js"></script>
        <script src="<%=basePath%>/static/js/bootstrap.js"></script>
        <!-- //js -->
        <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
        <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>

        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Great+Vibes' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Comfortaa:400,300,700' rel='stylesheet' type='text/css'>

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
<%--<c:if test="${not empty requestScope.message}">--%>
<%--    <div class="alert alert-info alert-error fade show text-center" >--%>
<%--        <button type="button" class="close" data-dismiss="alert">&times;</button>--%>
<%--        <strong>${requestScope.message}</strong>--%>
<%--    </div>--%>
<%--</c:if>--%>
<!-- banner-body -->
<div class="banner-body">
    <div class="container">
        <div class="banner-body-content">
            <div>
                <div class="col-xs-3 banner-body-left">
                    <div style="padding-left: 30px">
                        <c:if test="${!empty sessionScope.user}">
                            <img src="<%=basePath%>/static/upload/${sessionScope.user.avatar}"
                                 style="height:150px;width:150px;border-radius: 50%;"/>
                        </c:if>
                    </div>
                    <div class="top-nav">
                        <nav class="navbar navbar-default">
                            <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                                <nav class="stroke">
                                    <ul class="nav navbar-nav">
                                        <li><a href="<%=basePath%>/user/findByPage.do" class="hvr-underline-from-left"><i class="home"></i>主页</a></li>
                                        <li class="active"><a href="#"><i class="picture1"></i>个人信息</a></li>
                                        <li><a href="<%=basePath%>/user/toViewOrders.do" class="hvr-underline-from-left"><i class="edit1"></i>我的订单</a></li>
                                        <li>
                                            <a href="#" class="hvr-underline-from-left">
                                                <i class="text-size1"></i>我的积分<span class="badge badge-pill badge-success">${sessionScope.user.score}</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" class="hvr-underline-from-left">
                                                <i class="envelope1"></i>我的等级<span class="badge badge-pill badge-warning">
                                                <b>LV</b><%=(int)Math.ceil((double)user.getScore()/100)%>
                                            </span>
                                            </a>
                                        </li>
                                        <li><a href="<%=basePath%>/user/logout.do" class="hvr-underline-from-left"><i class="text-size1"></i>注销账户</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </nav>
                    </div>

                    <div class="latest-news">
                        <h2>最新消息</h2>
                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                            吃货头条——汉堡王
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">
                                        吃货福利单人套餐现价29.9元，立省30.1元，现在下单还有机会赢88元大礼包...
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                            中秋美味精选
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        中秋大赏爆品水果最高满45减15，柚子不止9.9一个...
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                            聚在身边乐在一起
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        即日起一次订单满35元，即随单赠送可口可乐公司系列产品任一罐...
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="join">
                            <a href=#>更多消息</a>
                        </div>
                        <h3>我们的理念</h3>
                        <p>理工外卖美食城是一个专业性的餐饮快递服务平台，我们擅长以标准化的管理来运营该平台，
                            从而提高工作效率，降低成本，以高素质的服务和诚信至上的理念提升我们的品牌度。</p>
                    </div>
                </div>

                <div class="col-xs-9 banner-body-right">
                    <div style="width: 16px;height: 45px;background: #E0BD62;float: left;margin-right: 50px;"></div>
                    <h1>个人信息</h1>
                    <hr />
                    <form action="<%=basePath%>/user/modifyInfo.do" name="userInfo" enctype="multipart/form-data" method="post">
                        <input type="hidden" name="userID" value="${sessionScope.user.userID}"/>
                        <div>
                            <h4>头像:</h4>
                            <c:if test="${!empty sessionScope.user}">
                                <img src="<%=basePath%>/static/upload/${sessionScope.user.avatar}"
                                     style="height:150px;width:150px;border-radius: 50%;"/>
                            </c:if>
                        </div>
                        <br />
                        <br />
                        <div class="row" style="box-shadow:0px 2px 2px 1px rgba(0,0,0,0.3);">
                            <div class="col-sm-3" style="font-size: 20px;">
                                <p>用户ID：</p>
                                <p>用户名：</p>
                                <p>登录密码：</p>
                                <p>配送地址：</p>
                                <p>Email：</p>
                                <p>手机号：</p>
                                <p>银行账户：</p>
                            </div>
                            <div class="col-sm-6" style="font-size: 20px;">
                                <p>10928716942${sessionScope.user.userID}</p>
                                <p>${sessionScope.user.userName}</p>
                                <p>************</p>
                                <p>${sessionScope.user.address}</p>
                                <p>${sessionScope.user.email}</p>
                                <p>${sessionScope.user.phoneNum}</p>
                                <p>${sessionScope.user.accountID}</p>
                            </div>
                            <div class="col-sm-3"></div>
                        </div>
                        <br />
                        <div class="col">
                            <button type="button" class="btn btn-primary"  data-toggle="modal" data-target="#myModal">修改信息</button>
                            <div class="modal fade" id="myModal">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class= "modal-header">
                                            <div class="pic" style="margin-left:175px ;">
                                                <img src="<%=basePath%>/static/upload/${sessionScope.user.avatar}"
                                                     style="width: 150px;height: 150px;" id="icon"/>
                                                <input type="file" class="custom-file-input" id="customFile" name="file" onchange="upload('#customFile','#icon')"/>
                                            </div>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <fieldset class="form-group">
                                                <label class="form-label">用户名：</label>
                                                <input name="userName"
                                                       type="text"
                                                       class="form-control"
                                                       value="${sessionScope.user.userName}"
                                                       data-validation="[NOTEMPTY]">
                                            </fieldset>
                                            <fieldset class="form-group">
                                                <label class="form-label">密码：</label>
                                                <input name="password"
                                                       type="password"
                                                       class="form-control"
                                                       value="${sessionScope.user.password}"
                                                       data-validation="[NOTEMPTY]">
                                            </fieldset>
                                            <fieldset class="form-group">
                                                <label class="form-label">确认密码：</label>
                                                <input name="password2"
                                                       type="password"
                                                       class="form-control"
                                                       value="${sessionScope.user.password}"
                                                       data-validation="[NOTEMPTY]">
                                            </fieldset>
                                            <fieldset class="form-group">
                                                <label class="form-label">配送地址：</label>
                                                <input name="address"
                                                       type="text"
                                                       class="form-control"
                                                       value="${sessionScope.user.address}"
                                                       data-validation="[NOTEMPTY]">
                                            </fieldset>
                                            <fieldset class="form-group">
                                                <label class="form-label">Email：</label>
                                                <input name="email"
                                                       type="email"
                                                       class="form-control"
                                                       value="${sessionScope.user.email}"
                                                       data-validation="[NOTEMPTY]">
                                            </fieldset>
                                            <fieldset class="form-group">
                                                <label class="form-label">手机号：</label>
                                                <input name="phoneNum"
                                                       type="tel"
                                                       class="form-control"
                                                       value="${sessionScope.user.phoneNum}"
                                                       data-validation="[NOTEMPTY]">
                                            </fieldset>
                                            <fieldset class="form-group">
                                                <label class="form-label">账户ID：</label>
                                                <input name="accountID"
                                                       type="text"
                                                       class="form-control"
                                                       value="${sessionScope.user.accountID}"
                                                       data-validation="[NOTEMPTY]">
                                            </fieldset>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success saveInfo">保存</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>



                    </form>
                </div>


                <div class="clearfix"> </div>
            </div>
            <div class="clearfix"> </div>
            <div class="footer">
                <div class="footer-left">
                    <ul>
                        <li><a href="#">相关法律</a>|</li>
                        <li><a href="#">加入我们</a>|</li>
                        <li><a href="#">联系我们</a></li>
                    </ul>
                    <p>Copyright &copy; <a href="http://www.njust.edu.cn/" target="_blank">南京理工大学课设团队----罗文水&nbsp;|&nbsp;宋涛&nbsp;|&nbsp;王安文</a>
                        &nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.baidu.com/" target="_blank" title="百度">理工外卖美食城</a>
                    </p>
                </div>
                <div class="footer-right">
                    <ul class="social-nav model-3">
                        <li><a href="#" class="icon icon-border facebook"></a></li>
                        <li><a href="#" class="icon icon-border twitter"></a></li>
                        <li><a href="#" class="icon icon-border googleplus"></a></li>
                        <li><a href="#" class="icon icon-border github"></a></li>
                        <li><a href="#" class="icon icon-border rss"></a></li>
                    </ul>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>