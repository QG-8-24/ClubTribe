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
    <link rel="stylesheet" type="text/css" href="../css/myClub_CJN.css">
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
