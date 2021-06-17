<%@ page import="cn.edu.njust.entity.Users" %>
<%@ page import="java.util.Date" %>
<%@ page import="static cn.edu.njust.utils.DateTool.Date2Str" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <title>用户支付订单页面</title>
    <%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    Users user= (Users)session.getAttribute("user");
%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Great Taste Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript"> addEventListener("load",
        function() {
        setTimeout(hideURLbar, 0);
        }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
    <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/order.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/bootstrap.min.css"/>
    <link href="<%=basePath%>/static/css/font-awesome/font-awesome.min.css"/>
    <!-- js -->
<%--    <script src="<%=basePath%>/static/js/jquery-1.11.1.min.js"></script>--%>
    <script src="<%=basePath%>/static/js/jquery-3.3.1.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap.js"></script>
    <!-- //js -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Great+Vibes' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Comfortaa:400,300,700' rel='stylesheet' type='text/css'>

</head>
<style type="text/css">
    .order{
        width: 100%;
    }
    .order-top{
        width: 100%;
        height: 30px;
        font-size: 20px;
        border: 1px solid #E0E0E0;
        background: rgba(250,250,250,1);
    }
    .order-top2{
        float: right;
        margin-top: -1px;
    }
    .order-body{
        width: 100%;
        border: 1px solid #E0A800;
    }
    .order-body-1{
        height: 100px;
    }
    .order-body-2{
        height: 100%;
        display: table;
    }
    .order-body-2 span{
        display: table-cell;
        vertical-align: middle;
        font-size: 16px;
    }
    .order-body-2 span img{
        width: 60px;
        height: 60px;
    }
</style>
<body style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">

<!-- banner-body -->
<div class="banner-body">
    <div class="container">
        <div class="banner-body-content">
            <div class="col-xs-3 banner-body-left">
                <div style="padding-left: 30px">
                    <c:if test="${!empty sessionScope.user}">
                        <img src="<%=basePath%>/static/upload/${sessionScope.user.avatar}"
                             style="height:150px;width:150px;border-radius: 50%;"/>
                    </c:if>
                </div>
                <div class="top-nav">
                    <nav class="navbar navbar-default">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>

                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                            <nav class="stroke">
                                <ul class="nav navbar-nav">
                                    <li class="active"><a href="<%=basePath%>/user/findByPage.do"><i class="home"></i>主页</a></li>
                                    <li><a href="<%=basePath%>/user/toUserInfo.do" class="hvr-underline-from-left"><i class="picture1"></i>个人信息</a></li>
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
                        <!-- /.navbar-collapse -->
                    </nav>
                </div>

            </div>


            <div class="col-xs-9 banner-body-right2">
                <h1 class="text-center">结算订单</h1>
                <hr />
                <h2>${sessionScope.restaurant.name}</h2>
                <br />

                <div class="order">
                    <div class="order-body">
                        <c:forEach var="item" items="${sessionScope.orderItemToShow}" varStatus="status">
                            <div class="row order-body-1">
                                <div class="col-sm-3 order-body-2">
                                    <span><img src="<%=basePath%>/static/upload/${item.orderedDish.image}" class="center-block" /></span>
                                </div>
                                <div class="col-sm-3 text-center order-body-2">
                                    <span>${item.orderedDish.name}</span>
                                </div>
                                <div class="col-sm-3 text-center order-body-2">
                                <span>￥${item.orderedDish.price}
                                    <c:choose>
                                        <c:when test="${item.orderedDish.discount>9.99}">
                                            (无折扣)
                                        </c:when>
                                        <c:otherwise>
                                            (打${item.orderedDish.discount}折)
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                                </div>
                                <div class="col-sm-3 text-center order-body-2">
                                    <span>x${item.count}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <hr />
                <div class="delivery">
                    <h2>配送信息</h2>
                    <br />
                    <div class="row">
                        <div class="col-sm-3">
                            <p>收货人：</p>
                            <p>地址：</p>
                            <p>下单时间：</p>
                        </div>

                        <div class="col-sm-6">
                            <p><%=user.getUserName()%></p>
                            <p><%=user.getAddress()%></p>
                            <p><%=Date2Str(new Date(), "yyyy-MM-dd HH:mm" )%></p>

                        </div>
                        <div class="col-sm-3">
                            <img src="<%=basePath%>/static/upload/<%=user.getAvatar()%>" style="width: 100px;height: 100px; border-radius: 50%;"/>
                        </div>
                    </div>
                </div>
                <br />

                <div class="row">
                    <div class="col-sm-3">
                        <button type="button" class="btn btn-success" onclick="history.back(-2)">返回</button>
                    </div>
                    <div class="col-sm-9">
                        <button type="button" class="btn btn-warning"
                        data-toggle="modal" data-target="#payValidationModal"
                                onclick="return validPay()"
                        >支付：${sessionScope.totalValue}&nbsp;￥</button>
                    </div>
                </div>

            </div>
            <div class="clearfix"> </div>


            <div class="footer">
                <div class="footer-left">
                    <ul>
                        <li><a href="#">相关法律</a>|</li>
                        <li><a href="#">加入我们</a>|</li>
                        <li><a href="#">联系我们</a></li>
                    </ul>
                    <p>Copyright &copy; <a href="http://www.njust.edu.cn/"target="_blank">南京理工大学课设团队----罗文水&nbsp;|&nbsp;宋涛&nbsp;|&nbsp;王安文</a>
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

<!-- 编辑的模态框 -->
<form class="form-horizontal" method="post" id="submitForm" action="<%=basePath%>/user/validToPay.do">
    <div class="modal fade" id="payValidationModal" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">支付信息</h4>
                    </div>
                    <div class="modal-body" style="margin-left: 80px;">
                        <c:if test="${!empty message}">
                            <c:out value="${message}"/>
                        </c:if>
                        <div class="form-group form-inline">
                            <label>支付账号：</label>
                            <input name="accountID" value="${sessionScope.user.accountID}" type="hidden"/>
                            <c:out value="${sessionScope.user.accountID}"/>
                        </div>
                        <br/>
                        <br/>
                        <div class="form-group form-inline">
                            <label>支付密码：</label>
                            <input type="password" name="accountPassword" class="form-control" id="password"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="toPay btn btn-success" data-dismiss="modal" >确认支付</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">取消支付</button>
                    </div>
                </div>
            </div>
    </div>
</form>
<script>
    $(".toPay").click(function(){
        $("#submitForm").submit();
    })
</script>
</body>
</html>
