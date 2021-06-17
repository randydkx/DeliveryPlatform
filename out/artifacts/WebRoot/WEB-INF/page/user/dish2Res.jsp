<%@ page import="cn.edu.njust.entity.Dish" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="cn.edu.njust.entity.Users" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="timer" class="java.util.Date"/>
<html>
<head>
    <title>Home</title>
    <!-- for-mobile-apps -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Great Taste Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Users user=(Users)session.getAttribute("user");
    %>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <style type="text/css">
        .banner-body-right2{
            float: left;
        }
        .banner-body-right21 img{
            width: 150px;
            border-radius: 50%;
        }
        .banner-body-right22{
            padding-top: 30px;
        }
        .banner-body-right22 p{
            font-size: 10px;
            color: #888888;
        }
        .banner-body-right3{
            /*background-color: #5CB85C;*/
            padding-top: 5px;
        }
        .banner-body-right3:hover {
            background: #E0BD62;
        }
        .banner-body-right3:hover{
        	color:black;
        }
        .banner-body-right31 img{
            width: 150px;
        }
        .banner-body-right32 button{
            float: right;
        }
        .banner-body-right33{
            font-size: 15px;
            color: #888888;
        }
        .box{
            /*border: red solid 1px;*/
            height: 30px;
            width:100px;
            float:right;
            text-align: center;
        }
        .box input{
            width: 40px;
            text-align: center;
        }
        ul{
            float:right;
            list-style: none;
        }
        ul li{
            display: block;
            float: left;
            vertical-align: middle;
        }
        #totalValue{
            position:fixed;
            right: 10px;
            bottom:10px;
        }
    </style>
    <!-- js -->
    <script src="<%=basePath%>/static/js/jquery-1.11.1.min.js"></script>
    <!-- //js -->
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Great+Vibes' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Comfortaa:400,300,700' rel='stylesheet' type='text/css'>
</head>
<script>
    function plus(id,priceForSingle){
        //改变框子里的数以及支付的数以及隐藏的当前总数
        var i=document.getElementById("total").value;
        var clickTime=document.getElementById("dishes["+id+"].count").value;
        clickTime++;
        document.getElementById("dishes["+id+"].count").value=clickTime;
        var a=Number(i);
        a=a+priceForSingle;
        a=a.toFixed(2);
        document.getElementById("totalValue").innerHTML="<b style=\"color:red;\">"+"结算： "+a+" ￥"+"</b>";
        document.getElementById("total").value=a;
    }

    function subtract(id,priceForSingle){
        var clickTime = document.getElementById("dishes["+id+"].count").value;
        if(clickTime>0){
            clickTime--;
            document.getElementById("dishes["+id+"].count").value=clickTime;
            var i=document.getElementById("total").value;
            var a=Number(i);
            a=a-priceForSingle;
            a=a.toFixed(2);
            if(a<0)a=0;
            document.getElementById("totalValue").innerHTML="<b style=\"color:red;\">"+"结算： "+a+" ￥"+"</b>";
            document.getElementById("total").value=a;
        }else{
            //点击无效果
            clickTime=0;
            document.getElementById("dishes["+id+"].count").value = clickTime;
            // document.getElementById("dishes["+id+"].count").value="0";
        }
    }

</script>
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
            <div class="col-xs-9 banner-body-right2">
                <div class="row">
                    <div class="col-sm-3 banner-body-right21">
                        <img src="<%=basePath%>/static/upload/${requestScope.rest.image}" />
                    </div>
                    <div class="col-sm-9 banner-body-right22">
                        <h2>${requestScope.rest.name}</h2>
                        <p>地址：${requestScope.rest.locate}</p>
                        <p>营业时间：${requestScope.rest.startTime}:00-${requestScope.rest.endTime}:00</p>
                        <p>联系方式：${requestScope.rest.resPhone}</p>
                    </div>
                </div>
                <br />
                <hr />
                <form action="<%=basePath%>/user/goToPay.do" method="post" id="submit_form">
                    <input type="hidden" name="resID" value="${requestScope.rest.resID}"/>
                    <c:forEach var="dish" items="${requestScope.dishes}"
                               begin="0" varStatus="status" >
                        <input type="hidden"
                               id="dishes[${status.index}].dishID"
                               name="dishes[${status.index}].dishID"
                               value="${dish.dishID}"/>
<%--                        <input type="hidden" name="dishes[${status.index}].count" value = "0"/>--%>
                        <div class="row banner-body-right3"
                             style ="border: dot-dash 10px red;border-radius: 10px;">
                            <div class="col-sm-3 banner-body-right31" style="margin-top: 13px">
                                <img src="<%=basePath%>/static/upload/${dish.image}"
                                     style="width:150px;height:100px"/>
                            </div>
                            <div class="col-sm-6 banner-body-right32">
                                <h3>${dish.name}</h3>
                                <p>菜品描述：${dish.description}</p>
                                <p>价格：￥${dish.price} &nbsp;|&nbsp;折扣：${dish.discount}</p>
                                <div class="box">
                                    <ul>
                                        <li><button id="sub" type="button" onclick="subtract(${status.index},${dish.price*dish.discount/10})">-</button></li>
                                        <li><input type="text"  style="height:27px;"
                                                   id="dishes[${status.index}].count"
                                                   readonly="readonly"
                                                   name="dishes[${status.index}].count"
                                                   value="0" /></li>
                                        <li><button id="pl" type="button" onclick="plus(${status.index},${dish.price*dish.discount/10})">+</button></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-sm-3 banner-body-right33">
                                <p>评分：${dish.score}</p>
                                <p>月售：${dish.saleAmount}</p>
                                <p><fmt:formatDate value="${dish.startTime}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="settlement" style="position: fixed; right: 0;bottom: 50%;">
                        <input id="total" type="hidden" value="0"/>
                        <button type="button"  class="btn btn-outline-warning" id="totalValue" value="0" >
                            结算 ￥
                        </button>
                    </div>
                </form>
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
<script src="<%=basePath%>/static/js/bootstrap.js"></script>
<script>
    $(document).ready(function(){
        $("#totalValue").click(function(){
            if(document.getElementById("total").value>0.0001)
                $("#submit_form").submit();
        });
    })
</script>
</body>
</html>
