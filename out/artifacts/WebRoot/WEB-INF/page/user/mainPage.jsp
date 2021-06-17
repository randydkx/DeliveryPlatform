<%@ page import="cn.edu.njust.entity.Restaurant" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.edu.njust.entity.Dish" %>
<%@ page import="cn.edu.njust.entity.PageBean" %>
<%@ page import="cn.edu.njust.entity.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户主页</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Users user = (Users)session.getAttribute("user");
    %>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
    <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <script src="<%=basePath%>/static/js/jquery-1.11.1.min.js"></script>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Great+Vibes' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Comfortaa:400,300,700' rel='stylesheet' type='text/css'>
</head>
   <%
       List<Restaurant> listOfRes = (List<Restaurant>)request.getAttribute("res");
       List<Dish> dishes = (List<Dish>)request.getAttribute("dishes");
   %>
<body>

<!-- banner-body -->
<div class="banner-body" style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">
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
                        <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                            <nav class="stroke">
                                <ul class="nav navbar-nav">
                                    <li class="active"><a href="#"><i class="home"></i>主页</a></li>
                                    <li><a href="<%=basePath%>/user/toUserInfo.do" class="hvr-underline-from-left"><i class="text-size1"></i>个人信息</a></li>
                                    <li><a href="<%=basePath%>/user/toViewOrders.do" class="hvr-underline-from-left"><i class="text-size1"></i>我的订单</a></li>
                                    <li>
                                        <a href="#" class="hvr-underline-from-left"><i class="text-size1"></i>我的积分<span class="badge badge-pill badge-success">${sessionScope.user.score}</span></a>
                                    </li>
                                    <li>
                                        <a href="#" class="hvr-underline-from-left">
                                            <i class="text-size1"></i>我的等级<span class="badge badge-pill badge-warning">
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
            <div class="col-xs-9 banner-body-right">
                <div class="wmuSlider example1">
                    <div class="wmuSliderWrapper">
                        <article style="position: absolute; width: 100%; opacity: 0;">
                            <div class="banner-wrap">
                                <div class="banner">
                                </div>
                            </div>
                        </article>
                        <article style="position: absolute; width: 100%; opacity: 0;">
                            <div class="banner-wrap">
                                <div class="banner1">
                                </div>
                            </div>
                        </article>
                        <article style="position: absolute; width: 100%; opacity: 0;">
                            <div class="banner-wrap">
                                <div class="banner2">
                                </div>
                            </div>
                        </article>
                    </div>
                </div>
                <script src="<%=basePath%>/static/js/jquery.wmuSlider.js"></script>
                <!--滑动图片-->
                <script>
                    $('.example1').wmuSlider();
                </script>
                <div class="banner-bottom">
                    <div class="banner-bottom-top">
                        <p><i>今日幸运餐馆></i></p>
                    </div>
<%--                    小环节--%>
                    <c:forEach items="<%=listOfRes%>" var="item">
                        <div class="col-md-4 banner-left">
                            <div class="col-xs-3 banner-left1">
                                <div class="banner-left11">
                                    <img src="<%=basePath%>/static/upload/${item.image}"/>
                                </div>
                            </div>
                            <div class="col-xs-9 banner-right1">
                                <h3><c:out value="${item.name}"/> </h3>
                            </div>
                            <div class="clearfix"> </div>
                            <p>地址：<c:out value="${item.locate}"/> </p>
                            <p>联系电话：<c:out value="${item.resPhone}"></c:out></p>
                        </div>
                    </c:forEach>

                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="clearfix"> </div>
            <div class="col-xs-3 banner-body-left">
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
                        <a href="#">更多消息</a>
                    </div>
                    <h3>我们的理念</h3>
                    <p>理工外卖美食城是一个专业性的餐饮快递服务平台，我们擅长以标准化的管理来运营该平台，
                        从而提高工作效率，降低成本，以高素质的服务和诚信至上的理念提升我们的品牌度。</p>
                </div>
            </div>
            <div class="col-xs-9 banner-body-right">
                <div class="msg-text">
                    <div class="row">
                        <div class="col-xs-3 msg-text-left">
                            <p>单品推荐></p>
                        </div>
                        <div class="col-xs-9 msg-text-right">
                            <p>遇见美食遇见你</p>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="col-sm-3">
                                <span class="badge badge-pill badge-primary" style="size:20px;" >
                                    <a href="<%=basePath%>/user/findByPage?condition=1" style="color: white">
                                        快餐便当
                                    </a>
                                </span>
                            </div>
                            <div class="col-sm-3">
                                <span class="badge badge-pill badge-danger">
                                    <a href="<%=basePath%>/user/findByPage?condition=2"  style="color: white">
                                        火锅烤鱼
                                    </a>
                                </span>
                            </div>
                            <div class="col-sm-3">
                                <span class="badge badge-pill badge-secondary">
                                    <a href="<%=basePath%>/user/findByPage?condition=3" style="color: white">
                                        日韩料理
                                    </a>
                                </span>
                            </div>
                            <div class="col-sm-3">
                                 <span class="badge badge-pill badge-success">
                                    <a href="<%=basePath%>/user/findByPage?condition=4" style="color: white">
                                        甜品饮品
                                    </a>
                                </span>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="col-sm-3">
                                <span class="badge badge-pill badge-info">
                                    <a href="<%=basePath%>/user/findByPage?condition=6" style="color: white">
                                        小吃烧烤
                                    </a>
                                </span>
                            </div>
                            <div class="col-sm-3">
                                <span class="badge badge-pill badge-warning">
                                    <a href="<%=basePath%>/user/findByPage?condition=7" style="color: white">
                                       米粉面馆
                                    </a>
                                </span>
                            </div>
                            <div class="col-sm-3">
                                <span class="badge badge-pill badge-success">
                                    <a href="<%=basePath%>/user/findByPage?condition=8" style="color: white">
                                        地方菜系
                                    </a>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
<%--                右下角页面--%>
                <div class="msg-text-bottom">
<%--                    页面上的菜品数量小于或者等于三个的时候直接显示一行--%>
                        <c:if test="${requestScope.page.beanList.size() <= 3}">
                        <div class="row">
                            <c:forEach items="${requestScope.page.beanList}" var="dish"
                                begin="0" end="${requestScope.page.beanList.size()-1}">
                                <div class="col-md-4 msg-text-bottom-left">
                                    <figure class="effect-winston">
                                        <a href="<%=basePath%>/user/todish2Res.do?dishID=${dish.dishID}&resID=${dish.resID}">
                                            <img src="<%=basePath%>/static/upload/${dish.image}"  class="img-responsive" />
                                            <figcaption>
                                            </figcaption>
                                        </a>
                                    </figure>
                                    <h3><a href="<%=basePath%>/user/todish2Res.do?dishID=${dish.dishID}&resID=${dish.resID}">${dish.name}</a></h3>
                                    <p>菜品描述：${dish.description}</p>
                                    <hr />
                                    <div class="sale" style="float: left;font-size: 10px;color: #888888;"><span>月售<b>${dish.saleAmount}</b></span></div>
                                    <div class="price" style="float: right;font-size: 15px;color: #D43F3A;"><span>￥${dish.price}&nbsp;|&nbsp;
                                    <c:if test="${dish.discount>=9.98}">
                                        不打折
                                    </c:if>
                                    <c:if test="${dish.discount<10}">
                                        打&nbsp;<c:out value="${dish.discount}"/>折
                                    </c:if>
                                </span></div>
                                </div>
                            </c:forEach>
                        </div>
                        </c:if>
<%--                        页面上的菜品数量大于三个的时候显示两行，第一行显示三个，第二行显示beanlist.size()-3个--%>
                        <c:if test="${requestScope.page.beanList.size()>3}">
                            <div class="row">
                                <c:forEach items="${requestScope.page.beanList}" var="dish"
                                           begin="0" end="2">
                                    <div class="col-md-4 msg-text-bottom-left">
                                        <figure class="effect-winston">
                                            <a href="<%=basePath%>/user/todish2Res.do?dishID=${dish.dishID}&resID=${dish.resID}">
                                                <img src="<%=basePath%>/static/upload/${dish.image}"  class="img-responsive" />
                                                <figcaption>
                                                </figcaption>
                                            </a>
                                        </figure>
                                        <h3><a href="<%=basePath%>/user/todish2Res.do?dishID=${dish.dishID}&resID=${dish.resID}">${dish.name}</a></h3>
                                        <p>菜品描述：${dish.description}</p>
                                        <hr />
                                        <div class="sale" style="float: left;font-size: 10px;color: #888888;"><span>月售<b>${dish.saleAmount}</b></span></div>
                                        <div class="price" style="float: right;font-size: 15px;color: #D43F3A;"><span>￥${dish.price}&nbsp;|&nbsp;
                                    <c:if test="${dish.discount>=9.98}">
                                        不打折
                                    </c:if>
                                    <c:if test="${dish.discount<10}">
                                        打&nbsp;<c:out value="${dish.discount}"/>折
                                    </c:if>
                                    </span></div>
                                    </div>
                                </c:forEach>
                            </div>

                            <br />

                            <div class="row " style="margin-top: 30px">
                                <c:forEach items="${requestScope.page.beanList}" var="dish"
                                           begin="3" end="${requestScope.page.beanList.size()-1}">
                                    <div class="col-md-4 msg-text-bottom-left">
                                        <figure class="effect-winston">
                                            <a href="<%=basePath%>/user/todish2Res.do?dishID=${dish.dishID}&resID=${dish.resID}">
                                                <img src="<%=basePath%>/static/upload/${dish.image}"  class="img-responsive" />
                                                <figcaption>
                                                </figcaption>
                                            </a>
                                        </figure>
                                        <h3><a href="<%=basePath%>/user/todish2Res.do?dishID=${dish.dishID}&resID=${dish.resID}">${dish.name}</a></h3>
                                        <p>菜品描述：${dish.description}</p>
                                        <hr />
                                        <div class="sale" style="float: left;font-size: 10px;color: #888888;">
                                            <span>月售<b>${dish.saleAmount}</b></span></div>
                                        <div class="price" style="float: right;font-size: 15px;color: #D43F3A;"><span>￥${dish.price}&nbsp;|&nbsp;
                                            <c:if test="${dish.discount>=9.98}">
                                                不打折
                                            </c:if>
                                            <c:if test="${dish.discount<10}">
                                                打&nbsp;<c:out value="${dish.discount}"/>折
                                            </c:if>
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="clearfix"> </div>
                        </c:if>
                    </div>
                    <div>


<%--                页面选择控件--%>
                    <form class="listForm" method="post" style="margin-top: 30px;" action="<%=basePath%>/user/findByPage.do">
                        <div class="row">
                            <div class="form-inline">
                                <label style="font-size:14px;margin-top:22px;">
                                    <strong>共<b style="color: red;">${requestScope.page.totalCount}</b>条记录，
                                        共<b style="color: red;">${requestScope.page.totalPage}</b>页</strong>
                                    &nbsp;

                                    <strong>每页显示</strong>
                                    <input name="pageCode" value="${requestScope.page.pageCode}" hidden="hidden"/>
                                    <select class="form-control" name="pageSize">
                                        <option value="3"
                                                <c:if test="${requestScope.page.pageSize == 3}">selected</c:if> >3
                                        </option>
                                        <option value="6"
                                                <c:if test="${requestScope.page.pageSize == 6}">selected</c:if> >6
                                        </option>
                                        <option value="9"
                                                <c:if test="${requestScope.page.pageSize == 9}">selected</c:if> >9
                                        </option>
                                        <option value="12"
                                                <c:if test="${requestScope.page.pageSize == 12}">selected</c:if> >12
                                        </option>
                                    </select>
                                    <strong>条</strong>

<%--                                    <strong>到第</strong>&nbsp;<input type="text" size="3" id="page" name="pageCode"--%>
<%--                                                                    class="form-control input-sm"--%>
<%--                                                                    style="width:11%"/>&nbsp;<strong>页</strong>--%>
                                    &nbsp;
                                    <button type="submit" class="btn btn-sm btn-info">GO!</button>
                                </label>

                                <ul class="pagination media" style="float:right;">
                                    <li>
                                        <a href="<%=basePath%>/user/findByPage.do?pageCode=1"><strong>首页</strong></a>
                                    </li>
                                    <li>
                                        <c:if test="${requestScope.page.pageCode > 2}">
                                            <a href="<%=basePath%>/user/findByPage.do?pageCode=${requestScope.page.pageCode - 1}">&laquo;</a>
                                        </c:if>
                                    </li>

                                    <!-- 写关于分页页码的逻辑 -->
                                    <c:choose>
                                        <c:when test="${requestScope.page.totalPage <= 5}">
                                            <c:set var="begin" value="1"/>
                                            <c:set var="end" value="${requestScope.page.totalPage}"/>
                                        </c:when>
                                        <c:otherwise>
<%--                                            只显示五个选择页面，分页算法的实现   --%>
                                            <c:set var="begin" value="${requestScope.page.pageCode - 1}"/>
                                            <c:set var="end" value="${requestScope.page.pageCode + 3}"/>

                                            <!-- 头溢出 -->
                                            <c:if test="${begin < 1}">
                                                <c:set var="begin" value="1"/>
                                                <c:set var="end" value="5"/>
                                            </c:if>

                                            <!-- 尾溢出 -->
                                            <c:if test="${end > requestScope.page.totalPage}">
                                                <c:set var="begin" value="${requestScope.page.totalPage -4}"/>
                                                <c:set var="end" value="${requestScope.page.totalPage}"/>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- 显示页码 -->
                                    <c:forEach var="i" begin="${begin}" end="${end}">
                                        <!-- 判断是否是当前页 -->
<%--                                        当前页面选中之后没有任何动作--%>
                                        <c:if test="${i == requestScope.page.pageCode}">
                                            <li class="active"><a href="javascript:void(0);">${i}</a></li>
                                        </c:if>
                                        <c:if test="${i != requestScope.page.pageCode}">
                                            <li>
<%--                                                选中一个指定的页面之后页面上菜品的数量不变，重新寻求新的一面--%>
                                                <a href="<%=basePath%>/user/findByPage.do?pageCode=${i}&pageSize=${requestScope.page.pageSize}">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>

                                    <li>
                                        <c:if test="${requestScope.page.pageCode < requestScope.page.totalPage}">
                                            <a href="<%=basePath%>/user/findByPage.do?pageCode=${requestScope.page.pageCode + 1}">&raquo;</a>
                                        </c:if>
                                    </li>
                                    <li>
                                        <a href="<%=basePath%>/user/findByPage.do?pageCode=${requestScope.page.totalPage}"><strong>末页</strong></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </form>
                    <div class="clearfix"> </div>
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
<!-- //banner-body -->
<!-- for bootstrap working -->
<script src="<%=basePath%>/static/js/bootstrap.js"></script>
<!-- //for bootstrap working -->
</body>
</html>
