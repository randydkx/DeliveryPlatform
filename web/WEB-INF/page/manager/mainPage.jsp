<%@ page import="cn.edu.njust.entity.Manager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Manager manager = (Manager) session.getAttribute("manager");
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <script src="<%=basePath%>/static/js/jquery-1.11.1.min.js"></script>
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
            <div class="banner-body-content clearfix">
                <div>
                    <div class="col-xs-3 banner-body-left">
                        <div style="padding-left: 30px">
                            <c:if test="${!empty sessionScope.manager}">
                                <img src="<%=basePath%>/static/upload/${sessionScope.manager.image}" style="height:150px;width:150px;border-radius: 50%;" />
                            </c:if>
                        </div>
                        <div class="top-nav">
                            <nav class="navbar navbar-default">
                                <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                                    <nav class="stroke">
                                        <ul class="nav navbar-nav">
                                            <li class="active"><a href="#"><i class="home"></i>审批订单</a></li>
<%--                                            <li><a href="<%=basePath%>/manager/toManagerViewInfo.do" class="hvr-underline-from-left"><i class="picture1"></i>餐馆数据总览</a></li>--%>
                                            <li><a href="<%=basePath%>/manager/logout.do" class="hvr-underline-from-left"><i class="home"></i>退出登录</a></li>
                                        </ul>
                                    </nav>
                                </div>
                                <!-- /.navbar-collapse -->
                            </nav>
                        </div>


                    </div>

                    <div class="col-xs-9 banner-body-right">

                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <h2>餐馆入驻请求</h2>
                            <hr />

                            <c:forEach var="NotAcceptedRest" items="${requestScope.listOfNotAccepted}" varStatus="status">
                                <div class="row" style="border: 1px solid #E0BD62; height: 60px;">
                                    <div class="col-sm-5" style="height: 100%; display: table;">
                                            <span style="display: table-cell; vertical-align: middle;">
                                                <img src="<%=basePath%>/static/upload/${NotAcceptedRest.image}" class="center-block" style="width: 40px;height: 40px;" />
                                            </span>
                                        <span style="display: table-cell; vertical-align: middle;"><h6>${NotAcceptedRest.name}</h6></span>
                                    </div>
                                    <div class="col-sm-4" style="height: 100%; display: table;">
                                        <div style="display: table-cell; vertical-align: middle;">
                                            <button type="button" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#myModal-1" onclick="viewInfo(${NotAcceptedRest.resID})">
                                                详细信息
                                            </button>
                                        </div>

                                    </div>
                                    <div class="col-sm-3" style="height: 100%; display: table;">
                                        <p style="display: table-cell; vertical-align: middle;"><b>待审批</b></p>
                                    </div>
                                </div>
                                <br />
                                <%--                            查阅菜馆信息的模态框--%>
                                <form action="<%=basePath%>/manager/rejectOrAccept.do" method="post">
                                    <div class="modal fade" id="myModal-1">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <div class="pic" style="margin-left:175px;">
                                                        <img src="" style="width: 80px;height: 80px;" id="image" alt=""/>
                                                    </div>
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                </div>
                                                <div class="modal-body">
                                                    <h6  id="name"></h6>
                                                    <h6  id="resType"></h6>
                                                    <h6  id="accountID"></h6>
                                                    <h6  id="locate"></h6>
                                                    <h6  id="time"></h6>
                                                    <h6 id="resPhone"></h6>
                                                </div>
                                                <div class="modal-footer">
                                                    <form>
                                                        <button type="button" class="btn btn-danger" id="reject" value="${NotAcceptedRest.resID}">拒绝审批</button>
                                                        <button type="button" class="btn btn-success" id="accept" value="${NotAcceptedRest.resID}">同意审批</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </c:forEach>



                            <c:forEach varStatus="status" items="${requestScope.listOfAccepted}" var="AcceptedRes">
                                <div class="row" style="border: 1px solid #E0BD62; height: 60px;">
                                    <div class="col-sm-5" style="height: 100%; display: table;">
                                            <span style="display: table-cell; vertical-align: middle;">
                                             <img src="<%=basePath%>/static/upload/${AcceptedRes.image}" class="center-block" style="width: 40px;height: 40px;" />
                                            </span>
                                        <span style="display: table-cell; vertical-align: middle;"><h6>${AcceptedRes.name}</h6></span>
                                    </div>
                                    <div class="col-sm-4" style="height: 100%; display: table;">
                                        <div style="display: table-cell; vertical-align: middle;">
                                            <button type="button" class="btn btn-outline-info btn-sm" data-toggle="modal" data-target="#myModal-2" onclick="viewInfo2(${AcceptedRes.resID})">
                                                详细信息
                                            </button>
                                        </div>
                                        <div class="modal fade" id="myModal-2">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <div class="pic" style="margin-left:175px;">
                                                            <img src="" style="width: 80px;height: 80px;" id="image1"/>
                                                        </div>
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <h6  id="name1"></h6>
                                                        <h6  id="resType1"></h6>
                                                        <h6  id="accountID1"></h6>
                                                        <h6  id="locate1"></h6>
                                                        <h6  id="time1"></h6>
                                                        <h6 id="resPhone1"></h6>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-warning" data-dismiss="modal">关闭</button>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3" style="height: 100%; display: table;">
                                        <p style="display: table-cell; vertical-align: middle;color: blue"><b>已审批</b></p>
                                    </div>
                                </div>
                                <br />
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
                        <p>Copyright &copy; <a href="http://www.njust.edu.cn/" target="_blank">理工团队课设团队----罗文水&nbsp;|&nbsp;宋涛&nbsp;|&nbsp;王安文</a>
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
<script>
<%--    异步获取一个餐馆的信息--%>
    function viewInfo(resID){
        $.ajax({
            url:'<%=basePath%>/manager/viewOneResInfo.do',
            type:'POST',
            dataType:'json',
            contentType: 'application/json;charset=UTF-8',
            data:JSON.stringify({
                resID:resID
            }),
            success: function(data){
                $("#image").attr('src','<%=basePath%>/static/upload/'+data.image);
                $("#name").html('餐馆名称： '+data.name);
                $("#time").html('营业时间： '+data.startTime+":00-"+data.endTime+":00");
                $("#accountID").html("餐馆账户： "+data.accountID);
                $("#locate").html("餐馆地址： "+data.locate);
                $("#resPhone").html("餐馆电话："+data.resPhone);
                if(data.resTypeID=='1'){
                    $("#resType").html("餐馆类型： "+"快餐便当")
                }
                if(data.resTypeID=='2'){
                    $("#resType").html("餐馆类型： "+"火锅烤鱼")
                }
                if(data.resTypeID=='3'){
                    $("#resType").html("餐馆类型： "+"日韩料理")
                }
                if(data.resTypeID=='4'){
                    $("#resType").html("餐馆类型： "+"甜品饮品")
                }
                if(data.resTypeID=='5'){
                    $("#resType").html("餐馆类型： "+"水果店铺")
                }
                if(data.resTypeID=='6'){
                    $("#resType").html("餐馆类型： "+"小吃烧烤")
                }
                if(data.resTypeID=='7'){
                    $("#resType").html("餐馆类型： "+"米粉面馆")
                }
                if(data.resTypeID=='8'){
                    $("#resType").html("餐馆类型： "+"地方菜馆")
                }
            },
            error: function(data){
                console.log(data);
                alert("错误");
            }
        });
    }

    //管理员已经审批过的餐馆的异步请求
    function viewInfo2(resID){
        $.ajax({
            url:'<%=basePath%>/manager/viewOneResInfoOfAccepted.do',
            type:'POST',
            dataType:'json',
            contentType: 'application/json;charset=UTF-8',
            data:JSON.stringify({
                resID:resID
            }),
            success: function(data){
                $("#image1").attr('src','<%=basePath%>/static/upload/'+data.image);
                $("#name1").html('餐馆名称： '+data.name);
                $("#time1").html('营业时间： '+data.startTime+":00-"+data.endTime+":00");
                $("#accountID1").html("餐馆账户： "+data.accountID);
                $("#locate1").html("餐馆地址： "+data.locate);
                $("#resPhone1").html("餐馆电话："+data.resPhone);
                if(data.resTypeID=='1'){
                    $("#resType1").html("餐馆类型： "+"快餐便当")
                }
                if(data.resTypeID=='2'){
                    $("#resType1").html("餐馆类型： "+"火锅烤鱼")
                }
                if(data.resTypeID=='3'){
                    $("#resType1").html("餐馆类型： "+"日韩料理")
                }
                if(data.resTypeID=='4'){
                    $("#resType1").html("餐馆类型： "+"甜品饮品")
                }
                if(data.resTypeID=='5'){
                    $("#resType1").html("餐馆类型： "+"水果店铺")
                }
                if(data.resTypeID=='6'){
                    $("#resType1").html("餐馆类型： "+"小吃烧烤")
                }
                if(data.resTypeID=='7'){
                    $("#resType1").html("餐馆类型： "+"米粉面馆")
                }
                if(data.resTypeID=='8'){
                    $("#resType1").html("餐馆类型： "+"地方菜馆")
                }
            },
            error: function(data){
                console.log(data);
                alert("错误");
            }
        });
    }
    $("#reject").click(function(){
        window.location.href='<%=basePath%>/manager/reject.do?resID='+$(this).attr('value');
    });
    $("#accept").click(function(){
        window.location.href='<%=basePath%>/manager/accepted.do?resID='+$(this).attr('value');
    })
</script>
</html>
