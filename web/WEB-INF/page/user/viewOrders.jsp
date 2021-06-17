<%@ page import="cn.edu.njust.service.RestService" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.edu.njust.entity.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>
<head>
    <title>用户陈列订页面</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Users user = (Users)session.getAttribute("user");
    %>
    <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/order.css" rel="stylesheet" type="text/css" media="all" />
    <script src="<%=basePath%>/static/js/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">

    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap-sweetalert/sweetalert.css">
    <script src="<%=basePath%>/static/js/bootstrap-sweetalert/sweetalert.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/static/css/main.css">

</head>

<body style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">

<div class="banner-body">
    <div class="container ">
        <div class="banner-body-content clearfix">
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
                                    <li><a href="<%=basePath%>/user/toUserInfo.do" class="hvr-underline-from-left"><i class="text-size1"></i>个人信息</a></li>
                                    <li class="active"><a href="#" ><i class="text-size1"></i>我的订单</a></li>
                                    <li>
                                        <a href="#" class="hvr-underline-from-left">
                                            <i class="text-size1"></i>我的积分<span class="badge badge-pill badge-success">${sessionScope.user.score}</span>
                                        </a>
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
                        <a href="#">更多消息</a>
                    </div>
                    <h3>我们的理念</h3>
                    <p>理工外卖美食城是一个专业性的餐饮快递服务平台，我们擅长以标准化的管理来运营该平台，
                        从而提高工作效率，降低成本，以高素质的服务和诚信至上的理念提升我们的品牌度。</p>
                </div>

            </div>


            <div class="col-xs-9 banner-body-right">
                <div class="row">
                    <div class="col-sm-1"></div>
                    <div class="col-sm-10">
                        <h2>全部订单</h2>
                        <hr/>
<%--已经支付过但是商家还未开始配送的订单--%>
                        <c:forEach var="queryOrderFullDetails" items="${requestScope.orderFullDetailsAlreadyPay}" varStatus="status">
                            <div class="order">
                                <div class="order-top">
                                    <span style="font-size: 16px;text-align: center;">订单号:af23423fa${queryOrderFullDetails.orderID}</span>
                                    <div class="order-top2">
                                        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#info" onclick="viewDetail(${queryOrderFullDetails.orderID})">详细信息</button>
                                    </div>
                                </div>

                                <div class="order-body">
                                    <c:forEach var="orderItem" items="${queryOrderFullDetails.orderItems}" varStatus="status">
                                        <div class="row order-body-1">
                                            <div class="col-sm-3 order-body-2">
                                                <span><img src="<%=basePath%>/static/upload/${orderItem.orderedDish.image}" class="center-block" /></span>
                                            </div>
                                            <div class="col-sm-3 text-center order-body-2">
                                                <span>${orderItem.orderedDish.name}</span>
                                            </div>
                                            <div class="col-sm-3 text-center order-body-2">
                                                <span id="total_value">￥${orderItem.orderedDish.price}
                                                    <c:choose>
                                                        <c:when test="${orderItem.orderedDish.discount>=9.999}">
                                                            （不打折）
                                                        </c:when>
                                                        <c:otherwise>
                                                            （打${orderItem.orderedDish.discount}折）
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <div class="col-sm-3 text-center order-body-2">
                                                <span>x${orderItem.count}</span>
                                            </div>
                                        </div>
                                    </c:forEach>


                                    <div class="row order-body-3" style="padding-bottom: 6px;">
                                        <div class="col-sm-6 text-center">
                                            <span>
                                                <strong>
                                                    总价：￥${queryOrderFullDetails.totalMoney}
                                                </strong>
                                            </span>
                                        </div>
                                        <div class="col-sm-6 text-center">
                                            <span><strong>订单状态：等待商家配送</strong></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="order-bottom">
                                        <button class="btn btn-danger swal-btn-cancel" id="${queryOrderFullDetails.orderID}">
                                            取消订单
                                        </button>
                                </div>
                            </div>
                            <br />
                            <br />
                        </c:forEach>
<%--正在配送中的订单--%>
                        <c:forEach var="queryOrderFullDetails" items="${requestScope.orderFullDetailsInDelivery}" varStatus="status">
                            <div class="order">
                                <div class="order-top">
                                    <span style="font-size: 16px;text-align: center;">订单号:af23423fa${queryOrderFullDetails.orderID}</span>
                                    <div class="order-top2">
                                        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#info" onclick="viewDetail(${queryOrderFullDetails.orderID})">详细信息</button>
                                    </div>
                                </div>

                                <div class="order-body">
                                    <c:forEach var="orderItem" items="${queryOrderFullDetails.orderItems}" varStatus="status">
                                        <div class="row order-body-1">
                                            <div class="col-sm-3 order-body-2">
                                                <span><img src="<%=basePath%>/static/upload/${orderItem.orderedDish.image}" class="center-block" /></span>
                                            </div>
                                            <div class="col-sm-3 text-center order-body-2">
                                                <span>${orderItem.orderedDish.name}</span>
                                            </div>
                                            <div class="col-sm-3 text-center order-body-2">
                                                <span>￥${orderItem.orderedDish.price}
                                                    <c:choose>
                                                        <c:when test="${orderItem.orderedDish.discount>=9.999}">
                                                            （不打折）
                                                        </c:when>
                                                        <c:otherwise>
                                                            （打${orderItem.orderedDish.discount}折）
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                            <div class="col-sm-3 text-center order-body-2">
                                                <span>x${orderItem.count}</span>
                                            </div>
                                        </div>
                                    </c:forEach>


                                    <div class="row order-body-3" style="padding-bottom: 6px;">
                                        <div class="col-sm-6 text-center">
                                            <span>
                                                <strong>
                                                    总价：￥${queryOrderFullDetails.totalMoney}
                                                </strong>
                                            </span>
                                        </div>
                                        <div class="col-sm-6 text-center">
                                            <span><strong>订单状态：配送中（无法取消订单）</strong></span>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <br />
                            <br />
                        </c:forEach>
<%--商家确认已经送达之后订单为未评论状态--%>
                        <c:forEach var="queryOrderFullDetails" items="${requestScope.orderFullDetailsNoReview}" varStatus="status">
<%--                            表单中上传订单的编号，用于改变订单的状态--%>
                            <div class="order">
                                <div class="order-top">
                                    <span style="font-size: 16px;text-align: center;">订单号:af23423fa${queryOrderFullDetails.orderID}</span>
                                    <div class="order-top2">
                                        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#info2" onclick="viewDetail(${queryOrderFullDetails.orderID})">详细信息</button>
                                    </div>
                                </div>
                                <div class="order-body">
                                     <c:forEach var="orderItem" items="${queryOrderFullDetails.orderItems}" varStatus="status">
                                            <div class="row order-body-1">
                                                <div class="col-sm-3 order-body-2">
                                                    <span><img src="<%=basePath%>/static/upload/${orderItem.orderedDish.image}" class="center-block" /></span>
                                                </div>
                                                <div class="col-sm-3 text-center order-body-2">
                                                    <span>${orderItem.orderedDish.name}</span>
                                                </div>
                                                <div class="col-sm-3 text-center order-body-2">
                                                        <span>￥${orderItem.orderedDish.price}
                                                        <c:choose>
                                                            <c:when test="${orderItem.orderedDish.discount>=9.999}">
                                                                （不打折）
                                                            </c:when>
                                                            <c:otherwise>
                                                                （打${orderItem.orderedDish.discount}折）
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </div>
                                                <div class="col-sm-3 text-center order-body-2">
                                                    <span>x${orderItem.count}</span>
                                                </div>
                                            </div>
                                    </c:forEach>
                                    <div class="row order-body-3" style="padding-bottom: 6px;">
                                        <div class="col-sm-6 text-center">
                                            <span><strong>总价：￥${queryOrderFullDetails.totalMoney}</strong></span>
                                        </div>
                                        <div class="col-sm-6 text-center">
                                            <span><strong>订单状态：已完成</strong></span>
                                        </div>
                                     </div>

                                    <div class="order-bottom">
                                        <div class="review" style="float: right;margin: 5px;">
                                            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#review">评价</button>

                                                <%-- 模态框，添加评论信息--%>
                                            <form action="<%=basePath%>/user/AddReview.do" id="toSubmit_form">
                                                <input name="orderID" type="hidden" value="${queryOrderFullDetails.orderID}"/>
                                                    <%--                                                上传商家的编号以及用户的编号，通过商家的编号对商家进行评论--%>
                                                <input type="hidden" name="userID" value="${sessionScope.user.userID}"/>
                                                <input name="resID" type="hidden" value="${queryOrderFullDetails.resID}"/>
                                                <div class="modal fade" id="review">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h2 class="modal-title">商品评价</h2>
                                                                    <%--                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>--%>
                                                            </div>

                                                            <div class="modal-body">
                                                                <div class="form-group">
                                                                    <label for="comment">用户评价:</label>
                                                                    <textarea class="form-control" rows="5" id="comment" name="content"></textarea>
                                                                </div>
                                                            </div>

                                                            <div class="modal-footer">
                                                                <div style="float:left">
                                                                    <input type="hidden" name="aixin" id="aixin" value="0"/>
                                                                    <i class="fa fa-gittip fa-2x" value="0" id="touch"></i>
                                                                </div>
                                                                <button type="submit" class="btn btn-success" onclick="submitForm()">提交</button>
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <br />
                            <br />
                        </c:forEach>

<%--                        查看详细信息的模态框--%>
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

                    </div>
                    <div class="col-sm-1"></div>

                </div>
            </div>

            <!--页面底端模块-->
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

    <script src="<%=basePath%>/static/js/bootstrap.js"></script>
    <script>
        function  submitForm(){
            $("#toSubmit_form").submit();
        }
    </script>
    <script>
        var time=0;
        $(document).ready(function() {

            $("#touch").click(function(){
                time=1-time;
                if(time==0){
                    $(this).css('color','black');
                    document.getElementById('#aixin').value=0;
                    $('#aixin').attr('value',0);
                }else{
                    $(this).css('color','red');
                    $("#aixin").attr('value',1);
                }
            });
            $('.swal-btn-cancel').click(function(e) {
                e.preventDefault();
                //获得点击的按钮的值
                var val = $(this).attr("id");
                // var id=$(this).value;
                swal({
                        title: "确认取消订单",
                        text: "取消订单之后金额将会返还",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonClass: "btn-danger",
                        confirmButtonText: "确认",
                        cancelButtonText: "取消",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    },
                    function(isConfirm) {
                        if(isConfirm) {
                            swal({
                                title: "Success",
                                text: "你的订单已经成功取消",
                                type: "success",
                                confirmButtonClass: "btn-success"
                            });
                            setInterval(function() {
                                window.location.href = "<%=basePath%>/user/cancelOrder.do?orderID="+val;
                            }, 1000);
                        } else {
                            swal({
                                title: "Cancelled",
                                text: "订单仍在配送中...",
                                type: "error",
                                confirmButtonClass: "btn-danger"
                            });
                        }
                    });
            });
        });

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