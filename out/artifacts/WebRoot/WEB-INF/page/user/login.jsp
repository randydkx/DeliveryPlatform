<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<html>
<head>
    <meta charset="UTF-8">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>测试</title>
    <html>
<body>
<%--<form action="<%=basePath%>/user/login.do" method="post">--%>
<%--    <label>username:</label>--%>
<%--    <input type="text" name="userName"/>--%>
<%--    <br/>--%>
<%--    <br/>--%>
<%--    <label>password:</label>--%>
<%--    <input type="password" name="password"/>--%>
<%--    <br/>--%>
<%--    <br/>--%>
<%--    <input type="submit" value="登录"/>--%>

<%--</form>--%>
<form action="<%=basePath%>/user/insertUser.do" method="post">
    <label>用户名</label>
    <input type="text" name="userName"/>
    <br/>
    <label>密码</label>
    <input type="password" name="password"/>
    <br/>
    <br/>
    <label>地址</label>
    <input type="text" name="address"/>
    <br/>
    <br/>
    <label>邮箱</label>
    <input type="text" name="email"/>
    <br/>
    <br/>
    <label>头像</label>
    <input type="text" name="avatar"/>
    <br/>
    <br/>
    <label>用户状态</label>
    <input type="text" name="userState"/>
    <br/>
    <br/>
    <label>电话</label>
    <input type="text" name="phoneNum"/>
    <label>账户</label>
    <input type="text" name="accountID"/>
    <br/>
    <br/>
    <label>分数</label>
    <input type="text" name="score"/>
    <br/><br/>
    <input type="submit" value="注册"/>

</form>
</body>
</html>
