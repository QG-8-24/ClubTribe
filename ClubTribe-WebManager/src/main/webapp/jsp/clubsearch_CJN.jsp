<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/5/17
  Time: 19:46
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
            <th><h2>社团列表</h2></th>
        </tr>
        <tr>
            <th>社团学校id</th>
            <th>社团id</th>
            <th>社团名</th>
            <th>负责人</th>
            <th>管理员</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${clubs}" var="obj">
            <tr>
                <td>${obj.schoolid}</td>
                <td>${obj.clubid}</td>
                <td>${obj.clubname}</td>
                <td>${obj.perid}</td>
                <td>${obj.adminid}</td>
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
