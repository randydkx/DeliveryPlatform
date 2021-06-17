<%@ page import="cn.edu.njust.entity.Restaurant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
    %>
    <title>餐馆上传菜品</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Great Taste Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
    <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/loaddish.css" rel="stylesheet" type="text/css" media="all" />
    <script src="<%=basePath%>/static/js/jquery-1.11.1.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap.js"></script>
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

    </script>
</head>
<body style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">

<!-- banner-body -->
<div class="banner-body">
    <div class="container">
        <div class="banner-body-content">
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
                            <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                                <nav class="stroke">
                                    <ul class="nav navbar-nav">
                                        <li><a href="<%=basePath%>/rest/getStatistic.do"><i class="home"></i>餐馆数据分析主页</a></li>
                                        <li><a href="<%=basePath%>/rest/toListAllOrders.do" class="hvr-underline-from-left"><i class="picture1"></i>查看订单</a></li>
                                        <li><a href="<%=basePath%>/rest/listAllDish.do" class="hvr-underline-from-left"><i class="picture1"></i>查看上架菜品</a></li>
                                        <li class="active"><a href="#"><i class="edit1"></i>上传菜品</a></li>
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
                            <a href="#">更多消息</a>
                        </div>
                        <h3>平台的优势</h3>
                        <p>理工外卖美食城平台致力于以标准化的管理模式提高资源配置效率，秉承诚信至上的理念，
                            通过增加曝光提升客户量，以不变的成本提高商家收入，平台还提供了各种一站式服务，一对一解决生意难题。</p>
                    </div>
                </div>
                <div class="col-xs-9 banner-body-right2">
                    <form id="loadDish" action="<%=basePath%>/rest/addDish.do" enctype="multipart/form-data" name="loadDish" method="post">
                        <div class="load">
                            <h2 class="text-center">添加菜品</h2>
                            <hr />
                            <h5>添加菜品图片：</h5>
                            <div class="pic"
<%--                                 style="margin-left:175px ;"--%>
                            >
                                <img src="<%=basePath%>/static/img/plus.jpg"
                                     style="width: 150px;height: 150px;" id="icon"/>
                                <input type="file" class="custom-file-input" id="customFile" name="file" onchange="upload('#customFile','#icon')"/>
                            </div>
<%--                            <div class="pic">--%>
<%--                                <img src="<%=basePath%>/static/img/plus.jpg" id="icon" style="width: 150px;height:150px;"/>--%>
<%--                                <input type="file" name="file" onchange="upload(this)"/>--%>
<%--                            </div>--%>

                            <br />
                            <div class="row info">
                                <div class="col-sm-9">
                                    <div class="form-group">
                                        <label class="form-label">菜品名称:</label>
                                        <input type="text" class="form-control" id="name" name="name" required="required" maxlength="15">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class="form-label">菜品类型：</label>
                                        <select class="form-control" id="dishTypeID" name="dishTypeID">
                                            <option value="1">饺子馄饨</option>
                                            <option value="2">快餐便当</option>
                                            <option value="3">汉堡薯条</option>
                                            <option value="4">意面披萨</option>
                                            <option value="5">包子粥类</option>
                                            <option value="6">米粉面类</option>
                                            <option value="7">麻辣烫冒菜</option>
                                            <option value="8">川湘菜</option>
                                            <option value="9">江浙菜</option>
                                            <option value="10">粤菜</option>
                                            <option value="11">东北菜</option>
                                            <option value="12">油炸食品</option>
                                            <option value="13">西餐牛排</option>
                                            <option value="14">夹馍饼类</option>
                                            <option value="15">鸭脖卤味</option>
                                            <option value="16">日料寿司</option>
                                            <option value="17">韩式料理</option>
                                            <option value="18">香锅干锅</option>
                                            <option value="19">火锅</option>
                                            <option value="20">海鲜烧烤</option>
                                            <option value="21">轻食沙拉</option>
                                            <option value="22">粉丝汤</option>
                                            <option value="23">面包</option>
                                            <option value="24">奶茶</option>
                                            <option value="25">果汁</option>
                                            <option value="26">鲜果</option>
                                            <option value="27">冰淇淋</option>
                                            <option value="28">甜品</option>
                                        </select>
                                    </div>
                                </div>
                                <br />
                                <div class="col">
                                    <div class="form-group">
                                        <label class="form-label">菜品描述:</label>
                                        <textarea class="form-control" rows="5" name="description" maxlength="150"></textarea>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <div class="row info">
                                <div class="col-sm-6">
                                    <label class="form-label">价格:</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">￥</span>
                                        </div>
                                        <input type="number" class="form-control"  name="price">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label class="form-label">折扣:</label>
                                        <input type="number" class="form-control modal_input" name="discount" min="1" max="10" step="0.01">
                                    </div>
                                </div>
                                <br />
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <label class="form-label">库存:</label>
                                        <input type="number" class="form-control modal_input" name="remain"  min="0" max="1000">
                                    </div>
                                </div>
                            </div>
                            <hr />
                            <button type="submit" class="btn btn-warning">保存</button>
                            <button type="reset" class="btn btn-outline-info">重置</button>
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
