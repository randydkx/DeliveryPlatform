<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cn.edu.njust.entity.Users" %>
<%@ page import="cn.edu.njust.entity.Restaurant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>餐馆展示所有订单</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Restaurant restaurant=(Restaurant) session.getAttribute("restaurant");
    %>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

        <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
        <link href="<%=basePath%>/static/css/order.css" rel="stylesheet" type="text/css" media="all" />
        <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
        <!-- js -->
        <script src="<%=basePath%>/static/js/jquery-1.11.1.min.js"></script>
        <!-- //js -->
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Great+Vibes' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Comfortaa:400,300,700' rel='stylesheet' type='text/css'>

    </head>

<body style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">

<!-- banner-body -->
<div class="banner-body">
    <div class="container">
        <div class="banner-body-content clearfix">
            <div>
                <div class="col-xs-3 banner-body-left">
                    <div style="padding-left: 30px">
                        <c:if test="${!empty sessionScope.restaurant}">
                            <img src="<%=basePath%>/static/upload/${sessionScope.restaurant.image}"
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
                                        <li><a href="<%=basePath%>/rest/getStatistic.do"><i class="home"></i>餐馆数据分析主页</a></li>
                                        <li class="active"><a href="#"><i class="picture1"></i>查看订单</a></li>
                                        <li><a href="<%=basePath%>/rest/listAllDish.do" class="hvr-underline-from-left"><i class="picture1"></i>查看上架菜品</a></li>
                                        <li><a href="<%=basePath%>/rest/toUploadDish.do" class="hvr-underline-from-left"><i class="edit1"></i>上传菜品</a></li>
                                        <li><a href="<%=basePath%>/rest/toViewReviews.do" class="hvr-underline-from-left"><i class="text-size1"></i>查看评论</a></li>
                                        <li><a href="<%=basePath%>/rest/logout.do" class="hvr-underline-from-left"><i class="text-size1"></i>注销账号</a></li>
                                    </ul>
                                </nav>
                            </div>
                            <!-- /.navbar-collapse -->
                        </nav>
                    </div>

                    <div class="latest-news">
                        <h2>常见服务</h2>
                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                            开店流程
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                    <div class="panel-body">
                                        按要求填写店铺信息，提交营业资质照片，等待管理员审核，审核通过即可录入菜品开店...
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                            开店要求
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                    <div class="panel-body">
                                        入驻平台之前，需要有线下的实体店铺，需要提供符合国家法律规定的经营许可证照，平台支持以下经营项目...
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                            收费标准
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                    <div class="panel-body">
                                        餐馆入驻本身不收取任何费用，产生订单后会收取平台服务费，配送方案也不尽相同...
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="join">
                            <a href="">更多消息</a>
                        </div>
                        <h3>平台的优势</h3>
                        <p>理工外卖美食城平台致力于以标准化的管理模式提高资源配置效率，秉承诚信至上的理念，
                            通过增加曝光提升客户量，以不变的成本提高商家收入，平台还提供了各种一站式服务，一对一解决生意难题。</p>
                    </div>

                </div>


                <div class="col-xs-9 banner-body-right">
                    <div class="row">
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <h2>全部订单</h2>
                            <hr/>
<%--餐馆查找用户已经付过款但是没有配送的订单--%>
                            <c:forEach var="queryOrderFullDetail" items="${requestScope.ordersAlreadyPay}" varStatus="status">
                                <form action="<%=basePath%>/rest/acceptDelivery.do" id="accept_form">
                                    <input type="hidden" value="${queryOrderFullDetail.orderID}" name="orderID"/>
                                    <div class="order">
                                        <div class="order-top">
                                            <span>订单号:af23423fa${queryOrderFullDetail.orderID}</span>
                                            <div class="order-top2">
                                                <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#info"
                                                    onclick="viewDetail(${queryOrderFullDetail.orderID})">详细信息</button>

                                            </div>
                                        </div>
                                        <div class="order-body">
                                        <c:forEach varStatus="status" items="${queryOrderFullDetail.orderItems}" var="extendOrderItem">
                                            <div class="row order-body-1">
                                                <div class="col-sm-3 order-body-2">
                                                    <span><img src="<%=basePath%>/static/upload/${extendOrderItem.orderedDish.image}" class="center-block" /></span>
                                                </div>
                                                <div class="col-sm-3 text-center order-body-2">
                                                    <span>${extendOrderItem.orderedDish.name}</span>
                                                </div>
                                                <div class="col-sm-3 text-center order-body-2">
                                                    <span>￥${extendOrderItem.orderedDish.price}
                                                    <c:choose>
                                                        <c:when test="${extendOrderItem.orderedDish.discount>=9.999}">
                                                            （不打折）
                                                        </c:when>
                                                        <c:otherwise>
                                                            （打${extendOrderItem.orderedDish.discount}折）
                                                        </c:otherwise>
                                                    </c:choose>
                                                    </span>
                                                </div>
                                                <div class="col-sm-3 text-center order-body-2">
                                                    <span>x${extendOrderItem.count}</span>
                                                </div>
                                            </div>
                                        </c:forEach>

                                            <div class="row order-body-3" style="padding-bottom: 6px;">
                                                <div class="col-sm-6 text-center">
                                                    <span><strong>总价：￥${queryOrderFullDetail.totalMoney}</strong></span>
                                                </div>
                                                <div class="col-sm-6 text-center">
                                                    <span><strong>订单状态：待配送</strong></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="order-bottom">
                                            <div class="stop" style="float: right;margin: 5px;">
                                                <button type="submit" class="btn btn-warning">确认配送</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <br />
                                <br />
                                <br />
                            </c:forEach>

<%--                            餐馆查找郑爱配送中的订单，对其进行配送完成确认--%>
                            <c:forEach var="queryOrderFullDetail" items="${requestScope.ordersInDelivery}" varStatus="status">
                                <form action="<%=basePath%>/rest/alreadyDone.do" id="alreadyDone_form">
                                    <input type="hidden" value="${queryOrderFullDetail.orderID}" name="orderID"/>
                                    <div class="order">
                                        <div class="order-top">
                                            <span>订单号:af23423fa${queryOrderFullDetail.orderID}</span>
                                            <div class="order-top2">
                                                <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#info"
                                                        onclick="viewDetail(${queryOrderFullDetail.orderID})">详细信息</button>
                                            </div>
                                        </div>
                                        <div class="order-body">
                                            <c:forEach varStatus="status" items="${queryOrderFullDetail.orderItems}" var="extendOrderItem">
                                                <div class="row order-body-1">
                                                    <div class="col-sm-3 order-body-2">
                                                        <span><img src="<%=basePath%>/static/upload/${extendOrderItem.orderedDish.image}" class="center-block" /></span>
                                                    </div>
                                                    <div class="col-sm-3 text-center order-body-2">
                                                        <span>${extendOrderItem.orderedDish.name}</span>
                                                    </div>
                                                    <div class="col-sm-3 text-center order-body-2">
                                                        <span>￥${extendOrderItem.orderedDish.price}
                                                            <c:choose>
                                                                <c:when test="${extendOrderItem.orderedDish.discount>=9.999}">
                                                                    （不打折）
                                                                </c:when>
                                                                <c:otherwise>
                                                                    （打${extendOrderItem.orderedDish.discount}折）
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                    <div class="col-sm-3 text-center order-body-2">
                                                        <span>x${extendOrderItem.count}</span>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <div class="row order-body-3" style="padding-bottom: 6px;">
                                                <div class="col-sm-6 text-center">
                                                    <span><strong>总价：￥${queryOrderFullDetail.totalMoney}</strong></span>
                                                </div>
                                                <div class="col-sm-6 text-center">
                                                    <span><strong>订单状态：配送中</strong></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="order-bottom">
                                            <div class="review" style="float: right;margin: 5px;">
                                                <button type="submit" class="btn btn-info">确认送达</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>

                                <br />
                                <br />
                                <br />
                            </c:forEach>


                        </div>
                        <div class="col-sm-1"></div>

                    </div>

                </div>
            </div>
<%--            详细信息的模态框--%>
            <div class="modal fade" id="info">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2 class="modal-title">详细信息</h2>
                        </div>
                        <div class="modal-body">
                            <h3><strong>配送信息</strong></h3>
                            <p id="userName"></p>
                            <p id="address"></p>
                            <p>期望时间：立即配送</p>
                            <p>配送方式：理工配送</p>
                            <br />

                            <h3><strong>订单信息</strong></h3>
                            <p id="orderID"></p>
                            <p id="orderTime"></p>
                            <p>支付方式：在线支付</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="clearfix"></div>
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
<script src="<%=basePath%>/static/js/bootstrap.js"></script>
<script>
    function viewDetail(orderID){
        $.ajax({
            url:'<%=basePath%>/user/viewDetailOfOneOrder.do',
            type:'POST',
            // async:true,
            dataType:'json',
            contentType: 'application/json;charset=UTF-8',
            data:JSON.stringify({
                orderID:orderID
            }),
            success: function(data){
                $("#userName").html('收货人： '+data.userName);
                $("#address").html('收货地址： '+data.address);
                $("#orderID").html('订单号：af23423fa'+data.orderID);
                $("#orderTime").html('下单时间： '+data.orderTime);
                $("#info").modal('show');
            },
            error: function(data){
                alert("错误");
            }
        });
    }
</script>
</body>
</html>
