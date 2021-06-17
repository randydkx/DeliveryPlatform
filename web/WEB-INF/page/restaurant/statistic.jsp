<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="cn.edu.njust.entity.Restaurant" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>数据分析主页面</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Great Taste Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template,
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
    function hideURLbar(){ window.scrollTo(0,1); } </script>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        Restaurant restaurant = (Restaurant)session.getAttribute("restaurant");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    %>
    <!-- //for-mobile-apps -->
    <link href="<%=basePath%>/static/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.css">
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" media="all" />
    <link href="<%=basePath%>/static/css/dish2res.css" rel="stylesheet" type="text/css" media="all" />

    <link href="<%=basePath%>/static/css/bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" media="all"/>
<%--    <link href="<%=basePath%>/static/css/main.css" type="text/css" rel="stylesheet" media="all"/>--%>

    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
    <script src="http://code.highcharts.com/highcharts-3d.js"></script>

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Great+Vibes' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Comfortaa:400,300,700' rel='stylesheet' type='text/css'>
    <style type="text/css">
        .statistic-box {
            -webkit-border-radius: 4px;
            border-radius: 4px;
            text-align: center;
            color: #fff;
            background: no-repeat 50% 50%;
            background-size: cover;
            margin: 0 0 30px
        }

        .statistic-box>div {
            -webkit-border-radius: inherit;
            border-radius: inherit;
            height: 142px;
            background: url(<%=basePath%>/static/img/statistic-box-grid.png) 50% 0;
            background-size: 21px 20px;
            position: relative
        }

        .statistic-box .number {
            font-size: 3.125rem;
            line-height: 1;
            padding: 32px 0 0
        }

        .statistic-box .caption {
            font-size: 1.0625rem;
            font-weight: 600;
            position: relative;
            min-height: 35px;
            line-height: 1
        }

        .statistic-box .caption>div {
            position: absolute;
            left: 0;
            bottom: 0;
            width: 100%;
            padding: 0 10px
        }

        .statistic-box .percent {
            position: absolute;
            right: 10px;
            bottom: 8px;
            text-align: center;
            font-size: .8125rem;
            font-weight: 600;
            line-height: 1
        }

        .statistic-box .arrow {
            display: inline-block;
            width: 0;
            height: 0;
            border-style: solid;
            border-width: 0 7.5px 8px 7.5px;
            border-color: transparent transparent #fff transparent;
            margin: 0 0 2px
        }

        .statistic-box .arrow.up {
            -webkit-transform: rotate(360deg);
            -ms-transform: rotate(360deg);
            transform: rotate(360deg)
        }

        .statistic-box .arrow.down {
            -webkit-transform: rotate(180deg);
            -ms-transform: rotate(180deg);
            transform: rotate(180deg)
        }
    </style>
</head>

<body style="background: url(<%=basePath%>/static/img/2030474.jpg) no-repeat;background-size: cover;background-attachment: fixed">
<!-- banner-body -->
<div class="banner-body">
    <div class="container">
        <div class="banner-body-content clearfix">
<%--            <div class=" clearfix">--%>
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
                                        <li class="active"><a href="#"><i class="home"></i>餐馆数据分析主页</a></li>
                                        <li><a href="<%=basePath%>/rest/toListAllOrders.do" class="hvr-underline-from-left"><i class="picture1"></i>查看订单</a></li>
                                        <li><a href="<%=basePath%>/rest/listAllDish.do" class="hvr-underline-from-left"><i class="picture1"></i>查看上架菜品</a></li>
                                        <li><a href="<%=basePath%>/rest/toUploadDish.do" class="hvr-underline-from-left"><i class="edit1"></i>上传菜品</a></li>
                                        <li><a href="<%=basePath%>/rest/toViewReviews.do" class="hvr-underline-from-left"><i class="text-size1"></i>查看评论</a></li>
                                        <li><a href="<%=basePath%>/rest/logout.do" class="hvr-underline-from-left"><i class="text-size1"></i>注销账号</a></li>
                                    </ul>
                                </nav>
                            </div>
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

                    <div class="columns mt-lg-4">
                        <div class="col-sm-12">
                            <article class="statistic-box red" style="
                                    background-color:#fa424a;
                                    background-image:url(<%=basePath%>/static/img/statistic-box-red.png)">
                                <div>
                                    <div class="number">${requestScope.total_score_of_res}</div>
                                    <div class="caption">
                                        <div>累计点赞数量</div>
                                    </div>
                                    <div class="percent">
                                        <div class="arrow down"></div>
                                        <p>15%</p>
                                    </div>
                                </div>
                            </article>
                        </div>

                        <div class="col-sm-12">
                            <article class="statistic-box purple" style="
                                    background-color: #ac6bec;
                                    background-image: url(<%=basePath%>/static/img/statistic-box-purple.png)
                                    ">
                                <div>
                                    <div class="number">${total_balance}</div>
                                    <div class="caption">
                                        <div>总盈余</div>
                                    </div>
                                    <div class="percent">
                                        <div class="arrow up"></div>
                                        <p>11%</p>
                                    </div>
                                </div>
                            </article>
                        </div>
                        <!--.col-->
                        <div class="col-sm-12">
                            <article class="statistic-box yellow" style="
                                    background-color: #fdad2a;
                                    background-image: url(<%=basePath%>/static/img/statistic-box-yellow.png)
                                    ">
                                <div>
                                    <div class="number">0</div>
                                    <div class="caption">
                                        <div>差评数量</div>
                                    </div>
                                    <div class="percent">
                                        <div class="arrow down"></div>
                                        <p>5%</p>
                                    </div>
                                </div>
                            </article>
                        </div>
                        <!--.col-->
                        <div class="col-sm-12">
                            <article class="statistic-box green" style="
                                    background-color: #46c35f;
                                    background-image: url(<%=basePath%>/static/img/statistic-box-green.png)
                                    ">
                                <div>
                                    <div class="number">${requestScope.avg_sale_amount}</div>
                                    <div class="caption">
                                        <div>月平均销量</div>
                                    </div>
                                    <div class="percent">
                                        <div class="arrow up"></div>
                                        <p>84%</p>
                                    </div>
                                </div>
                            </article>
                        </div>
                    </div>


                </div>
                <%--            <div class="clearfix"></div>--%>
                <div class="col-xs-9 banner-body-right">
                    <div class="row">
                        <div class="col-sm-3 banner-body-right21">
                            <img src="<%=basePath%>/static/upload/${sessionScope.restaurant.image}" />
                        </div>
                        <div class="col-sm-9 banner-body-right22">
                            <h2>${sessionScope.restaurant.name}</h2>
                            <p>地址：${sessionScope.restaurant.locate}</p>
                            <p>营业时间：${sessionScope.restaurant.startTime}:00-${sessionScope.restaurant.endTime}:00</p>
                            <p>联系方式：${sessionScope.restaurant.resPhone}</p>
                        </div>
                    </div>
                    <br />

                    <hr />

                    <c:if test="${CanDraw}">
<%--                     各类菜品销售数量所占比重   --%>
                        <div id="container5" style="width:500px;height:400px;margin:0 auto"></div>
                        <div class="clearfix"></div>
<%--                   餐馆每月订单数量     --%>
                        <div id="container3" style="width:500px;height:400px;margin:0 auto"></div>
                        <div class="clearfix"></div>
                    </c:if>
<%--菜品月销售数量折线图--%>
                    <div id="container" style="width:600px;height:400px;margin:0 auto"></div>
                    <c:if test="${CanDraw}">
<%--                      餐馆各类菜品的销售金额柱状图  --%>
                        <div id="container2" style="width:600px;height:400px;margin:0 auto"></div>
                        <div class="clearfix"></div>
                    </c:if>
<%--                餐馆月销售金额折线图   --%>
                    <div id="container4" style="width:600px;height:400px;margin:0 auto"></div>
                    <script language="JavaScript">
                        $(document).ready(function() {
                            var title = {
                                text: '餐馆2020年菜品的月销售数量'
                            };
                            var subtitle = {
                                text: '截止至<%=sdf.format(new Date())%>'
                            };
                            var xAxis = {
                                categories: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
                            };
                            var yAxis = {
                                title: {
                                    text: '数量（个）'
                                },
                                plotLines: [{
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }]
                            };

                            var tooltip = {
                                valueSuffix: '（个）'
                            }

                            var legend = {
                                layout: 'vertical',
                                align: 'right',
                                verticalAlign: 'middle',
                                borderWidth: 0
                            };

                            var series =  [
                                {
                                    name: '菜品月销售数量',
                                    data: ${total_sales_in_a_month}
                                }
                            ];

                            var json = {};

                            json.title = title;
                            json.subtitle = subtitle;
                            json.xAxis = xAxis;
                            json.yAxis = yAxis;
                            json.tooltip = tooltip;
                            json.legend = legend;
                            json.series = series;

                            $('#container').highcharts(json);
                        });
                    </script>


                    <script language="JavaScript">
                        $(document).ready(function() {
                            var title = {
                                text: '餐馆2020年月销售金额'
                            };
                            var subtitle = {
                                text: '截止至<%=new Timestamp(new Date().getTime())%>'
                            };
                            var xAxis = {
                                categories: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
                            };
                            var yAxis = {
                                title: {
                                    text: '金额（元）'
                                },
                                plotLines: [{
                                    value: 0,
                                    width: 1,
                                    color: '#202020'
                                }]
                            };

                            var tooltip = {
                                valueSuffix: '（元）'
                            }

                            var legend = {
                                layout: 'vertical',
                                align: 'right',
                                verticalAlign: 'middle',
                                borderWidth: 0
                            };

                            var series =  [
                                {
                                    name: '餐馆2020年月销售金额',
                                    color:"yellow",
                                    data: ${total_money_in_a_month}
                                }
                            ];

                            var json = {};

                            json.title = title;
                            json.subtitle = subtitle;
                            json.xAxis = xAxis;
                            json.yAxis = yAxis;
                            json.tooltip = tooltip;
                            json.legend = legend;
                            json.series = series;

                            $('#container4').highcharts(json);
                        });
                    </script>

                    <script language="JavaScript">
                        $(document).ready(function() {
                            var chart = {
                                type: 'pie',
                                options3d: {
                                    enabled: true,
                                    alpha: 45,
                                    beta: 0
                                }
                            };
                            var title = {
                                text: '各类菜品销售数量所占比重'
                            };
                            var tooltip = {
                                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                            };

                            var plotOptions = {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    depth: 35,
                                    dataLabels: {
                                        enabled: true,
                                        format: '{point.name}'
                                    }
                                }
                            };
                            var series= [{
                                type: 'pie',
                                name: '类型作占比重',
                                data: ${total_count_of_dishType}
                            }];

                            var json = {};
                            json.chart = chart;
                            json.title = title;
                            json.tooltip = tooltip;
                            json.plotOptions = plotOptions;
                            json.series = series;
                            $('#container5').highcharts(json);
                        });
                    </script>

                    <script type="text/javascript">
                        // 基于准备好的dom，初始化echarts实例
                        var myChart = echarts.init(document.getElementById('container2'));

                        // 指定图表的配置项和数据
                        var option = {
                            title: {
                                text: "餐馆各类菜品的销售金额（累计值）"
                            },
                            tooltip: {},
                            legend: {
                                data:['餐馆各类别菜品的销售金额']
                            },
                            xAxis: {
                                data:${total_sales_of_dishType_keys}
                            },
                            yAxis: {},
                            series: [{
                                name: '销售金额',
                                type: 'bar',
                                color: ['red'],
                                data:${total_sales_of_dishType_values}
                            }]
                        };

                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option);
                    </script>

                    <script language="JavaScript">
                        $(document).ready(function() {
                            var chart = {
                                plotBackgroundColor: null,
                                plotBorderWidth: null,
                                plotShadow: false
                            };
                            var title = {
                                text: '餐馆每月的订单数量占比'
                            };
                            var tooltip = {
                                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                            };
                            var plotOptions = {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    dataLabels: {
                                        enabled: true,
                                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                                        style: {
                                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                        }
                                    }
                                }
                            };
                            var series= [{
                                type: 'pie',
                                name: '该月订单数量占比',
                                data:${total_orders_in_all_month}
                            }];
                            // Radialize the colors
                            Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
                                return {
                                    radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
                                    stops: [
                                        [0, color],
                                        [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
                                    ]
                                };
                            });

                            var json = {};
                            json.chart = chart;
                            json.title = title;
                            json.tooltip = tooltip;
                            json.series = series;
                            json.plotOptions = plotOptions;
                            $('#container3').highcharts(json);
                        });
                    </script>



                    <div class="clearfix"> </div>

                </div>
<%--                <div class="clearfix"></div>--%>
            </div>
<%--            </div>--%>
            <div class="clearfix"></div>
            <div class="footer">
                <div class="footer-left">
                    <ul>
                        <li><a href="#">相关法律</a>|</li>
                        <li><a href="#">加入我们</a>|</li>
                        <li><a href="#">联系我们</a></li>
                    </ul>
                    <div class="clearfix"></div>
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

    <script src="<%=basePath%>/static/js/bootstrap.js"></script>
</div>
</body>
</html>
