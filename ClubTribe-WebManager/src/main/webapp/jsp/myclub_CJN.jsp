<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/5/17
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <table border="1">
        <thead>
        <tr>
            <th><h2>我的社团列表</h2></th>
        </tr>
        <tr>
            <th>社团名</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${clubList}" var="obj">
            <tr>
                <td>${obj.clubname}</td>
                <td>
                    <a href="/user/clubhome">查看</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
