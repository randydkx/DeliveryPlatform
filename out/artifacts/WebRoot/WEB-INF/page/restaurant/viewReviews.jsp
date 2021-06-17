<%@ page import="cn.edu.njust.entity.Restaurant" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="timer" class="java.util.Date"/>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Restaurant restaurant=(Restaurant) session.getAttribute("restaurant");
    %>
    <title>餐馆查看评论</title>
    <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/resreview.css" rel="stylesheet" type="text/css" media="all" />
    <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
    <script src="<%=basePath%>/static/js/bootstrap.js"></script>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Great+Vibes' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Comfortaa:400,300,700' rel='stylesheet' type='text/css'>
</head>

<body style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">
    <div class="banner-body">
        <div class="container">
            <div class="banner-body-content">
                <div>
                    <div class="col-xs-3 banner-body-left">
                        <div style="padding-left: 30px">
                            <c:if test="${!empty restaurant}">
                                <img src="<%=basePath%>/static/upload/${restaurant.image}" style="height:150px;width:150px;border-radius: 50%;" />
                            </c:if>
                        </div>
                        <div class="top-nav">
                            <nav class="navbar navbar-default">
                                <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                                    <nav class="stroke">
                                        <ul class="nav navbar-nav">
                                            <li><a href="<%=basePath%>/rest/getStatistic.do"><i class="home"></i>餐馆数据分析主页</a></li>
                                            <li><a href="<%=basePath%>/rest/toListAllOrders.do" class="hvr-underline-from-left"><i class="picture1"></i>查看订单</a></li>
                                            <li><a href="<%=basePath%>/rest/listAllDish.do" class="hvr-underline-from-left"><i class="picture1"></i>查看上架菜品</a></li>
                                            <li><a href="<%=basePath%>/rest/toUploadDish.do" class="hvr-underline-from-left"><i class="edit1"></i>上传菜品</a></li>
                                            <li class="active"><a href="#"><i class="text-size1"></i>查看评论</a></li>
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
                                <a href="#">更多消息</a>
                            </div>
                            <h3>平台的优势</h3>
                            <p>理工外卖美食城平台致力于以标准化的管理模式提高资源配置效率，秉承诚信至上的理念，
                                通过增加曝光提升客户量，以不变的成本提高商家收入，平台还提供了各种一站式服务，一对一解决生意难题。</p>
                        </div>
                    </div>

                    <div class="col-xs-9 banner-body-right">
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <h2>用户评论</h2>
                            <hr />
                            <c:forEach var="review" items="${requestScope.listOfReviews}" varStatus="status">
                                <div class="comment-row-item">
                                    <div class="avatar-preview">
                                        <a href="#">
                                            <img src="<%=basePath%>/static/upload/${review.avatar}"/>
                                        </a>
                                    </div>
                                    <div class="tbl comment-row-item-header">
                                        <div class="tbl-row">
                                            <div class="tbl-cell tbl-cell-name">${review.userName}</div>
                                            <div class="tbl-cell tbl-cell-date">${review.time}</div>
                                        </div>
                                    </div>
                                    <div class="comment-row-item-content">
                                        <p>${review.content}</p>
                                        <button type="button" class="comment-row-item-action edit">
                                            <i class="font-icon font-icon-pencil"></i>
                                        </button>
                                        <button type="button" class="comment-row-item-action del">
                                            <i class="font-icon font-icon-trash"></i>
                                        </button>
                                    </div>
                                    <a href="#" class="comment-row-item-reply">回复</a>
                                    <i class="fa fa-gittip"></i>
                                </div>
                                <!--.comment-row-item-->

                            </c:forEach>
                        </div>
                        <div class="col-sm-1"></div>

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
