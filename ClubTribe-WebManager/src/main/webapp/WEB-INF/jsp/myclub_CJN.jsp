<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        ul {
            list-style: none; /*取消列表默认样式*/
        }

        .top {
            border-bottom: 4px solid deepskyblue;
            height: 60px;
            text-align: center;
            position: relative;
        }
        .top img {
            float: left;
            margin-left: 60px;
        }

        .top #topbtn {
            float: right;
            height: 60px;
            margin-right: 30px;
            line-height: 60px;
        }

        .top #topbtn a {
            float: left;
            display: inline-block;
            text-decoration: none;
            color: deepskyblue;
            margin-left: 10px;
            font-weight: bolder;
        }
        table.imagetable {
            height: 300px;
            width: 600px;
            font-family: verdana,arial,sans-serif;
            font-size:25px;
            color:#333333;
            border-width: 1px;
            border-color: #999999;
            border-collapse: collapse;
        }
        table.imagetable th {
            background:#b5cfd2 url('../img/back.jpg');
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #999999;
        }
        table.imagetable td {
            background:#dcddc0 url('../img/bg.jpg');
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #999999;
        }
        a{
            text-decoration: none;
            text-align: center;
        }

    </style>
    <script>
        $(function () {
        })
    </script>
</head>

<body>
<div class="top">
    <div><img src="../img/title.png"></div>
    <div id="topbtn">
        <a href="/">首页</a>
        <%--<a href="#" id="log">登录</a>--%>
        <a href="#" id="username">${username}</a>
    </div>
</div>
<div class="banner">
    <div style="margin:0 auto; width: 600px;">
        <table class="imagetable">
            <thead>
            <tr>

                <th colspan="6"><h2>个人社团列表</h2></th>
            </tr>

            <tr>
                <th>社团名</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${clubList}" var="obj">
                <tr id="info">
                    <td>${obj.clubname}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/user/clubhome?userid=${userid}&clubid=${obj.clubid}">查看</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
