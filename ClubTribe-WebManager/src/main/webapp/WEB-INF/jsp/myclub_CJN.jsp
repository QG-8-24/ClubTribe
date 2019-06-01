<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>我的社团</title>
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <!-- Javascript goes in the document HEAD -->
    <script type="text/javascript">
        function altRows(id){
            if(document.getElementsByTagName){
                var table = document.getElementById(id);
                var rows = table.getElementsByTagName("tr");
                for(i = 0; i < rows.length; i++){
                    if(i % 2 == 0){
                        rows[i].className = "evenrowcolor";
                    }else{
                        rows[i].className = "oddrowcolor";
                    }
                }
            }
        }
        window.onload=function(){
            altRows('alternatecolor');
        }
    </script>
    <!-- CSS goes in the document HEAD or added to your external stylesheet -->
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
        .top #indextitle{
            line-height: 60px;
            font-size: 50px;
            float: left;
            margin-left: 60px;
            font-family: "Microsoft YaHei UI";
        }
        .top #topbtn a {
            float: left;
            display: inline-block;
            text-decoration: none;
            color: deepskyblue;
            margin-left: 10px;
            font-weight: bolder;
        }
        .banner{
            width: 100%;
            height: 100%;
            border: none;
            text-align: center;
        }

        a{
            text-decoration: none;
            text-align: center;
        }
        table.altrowstable {
            width: 1080px;
            margin: 0 auto;
            text-align: center;
            font-family: verdana,arial,sans-serif;
            font-size:15px;
            color:#333333;
            border-width: 1px;
            border-color: #a9c6c9;
            border-collapse: collapse;
        }
        table.altrowstable th {
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #a9c6c9;
        }
        table.altrowstable td {
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #a9c6c9;
        }
        .oddrowcolor{
            background-color:#d4e3e5;
        }
        .evenrowcolor{
            background-color:#c3dde0;
        }
    </style>
    <script>
        $(function () {
        })
    </script>
</head>

<body>
<div class="top">
    <%--<div><img src="../img/title.png"></div>--%>
        <div id="indextitle">
            ClubTribe
        </div>
    <div id="topbtn">
        <a href="${pageContext.request.contextPath}/clubTribeIndex.jsp?userid=${userid}">首页</a>
        <%--<a href="#" id="log">登录</a>--%>
        <a href="#" id="username">${username}</a>
    </div>
</div>
<div>
    <div class="banner">
    <div>
        <table class="altrowstable" id="alternatecolor">
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
</div>
</body>
</html>
