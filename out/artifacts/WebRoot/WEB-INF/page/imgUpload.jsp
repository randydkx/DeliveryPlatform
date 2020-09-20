<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%
    response.setCharacterEncoding("UTF-8");
%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<head>
    <title>上传文件</title>
    <meta charset="utf-8"/>
</head>
<body>
    <form action="uploadImg.do" method="post" enctype="multipart/form-data">
        <c:if test="${image!=null}">
<%--            <img src="<%=basePath%>/upload/${image}" width="100" height="100"/>--%>
            <img src="/upload/${image}" width="100" height="100"/>
        </c:if>
        <input type="file" name="file"/>
        <input type="submit" value="提交" style="height:50px ;width:100px"/>
    </form>
</body>
</html>
