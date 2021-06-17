<%@ page import="cn.edu.njust.entity.Restaurant" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.edu.njust.entity.Dish" %>
<%@ page import="cn.edu.njust.entity.PageBean" %>
<%@ page import="cn.edu.njust.entity.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    %>
    <title>位置经纬度 + 驾车规划路线</title>
    <style type="text/css">
        html,
        body,
        #container {
            width: 500px;
            height: 500px;
            border-radius: 20px;
            margin:50px;
        }
    </style>
    <style type="text/css">
        #bigbox {
            margin:100px;
            width: 1000px;
        }
        #panel {
            position:fixed;
            float: right;
            background-color: white;
            max-height: 90%;
            overflow-y: auto;
            top: 100px;
            right: 100px;
            width: 280px;
            display: none;
        }
        #panel .amap-call {
            background-color: #009cf9;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
        }
        #panel .amap-lib-driving {
            border-bottom-left-radius: 4px;
            border-bottom-right-radius: 4px;
            overflow: hidden;
        }
        #rout {
            background: red;
            height:200px;
            width:200px;
        }
    </style>
    <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css" />
    <script src="https://webapi.amap.com/loader.js"></script>
    <script src="https://a.amap.com/jsapi_demos/static/demo-center/js/demoutils.js"></script>
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=9a3f82651ff0083c9cdd43e66989bac1&plugin=AMap.Riding"></script>
    <script type="text/javascript" src="https://cache.amap.com/lbs/static/addToolbar.js"></script>
</head>
<style type="text/css">
    #mybutton{
        position:fixed;
        bottom:30%;
        right: 30%;
    }
</style>
<body >
<div id="bigbox">
    <div id="container"></div>
    <div id="panel"></div>
    <p id="distance"></p>
    <p id="time"></p>
    <button class="btn btn-success" id="mybutton"
            onclick="window.location.href='<%=basePath%>/user/toViewOrders.do'"
    >查看我的订单</button>
</div>


<script type="text/javascript">
    //基本地图加载
    var map = new AMap.Map("container", {
        resizeEnable: true,
        center: [118.856827, 32.028267],//地图中心点
        zoom: 15 //地图显示的缩放级别
    });
    //构造路线导航类
    var driving = new AMap.Riding({
        map: map,
        panel: "panel"
    });
    // 根据起终点经纬度规划驾车导航路线
    var st_ed=[
        {keyword:'${start}',city:'南京'},
        {keyword:'${end}',city:'南京'},
    ]
    driving.search(st_ed, function(status, result) {
        if (status === 'complete') {
            var dis = result.routes[0].distance;

            var time = result.routes[0].time;

            time=Number(time)/60;
            document.getElementById("distance").innerHTML=
                "<h3 style=\"font-size:30px;\">总共配送路程是："+dis.toFixed(2)+"m</h3>";

            document.getElementById("time").innerHTML=
                "<h3 style=\"font-size:30px;\">预计配送时间："+time.toFixed(2)+"min</h3>";
        } else {
            console.error('获取驾车数据失败：' + result);
        }
    });
</script>
</body>
</html>
