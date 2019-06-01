<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/6/1
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ClubTribe管理员界面</title>
    <link rel="stylesheet" type="text/css" href="../css/clubTribeAdminStyle_CJN.css">
</head>
<body>
<div class="top">
    <%--<div><img src="../img/title.png"></div>--%>
    <div id="indextitle">
        ClubTribe
    </div>
    <div id="topbtn">
        <a href="${pageContext.request.contextPath}/clubTribeIndex.jsp?userid=${userid}&admin=${admin}">首页</a>
        <%--<a href="#" id="log">登录</a>--%>
        <a href="#" id="username">${username}</a>
    </div>
</div>
<div class="banner">



</div>
</body>
</html>
