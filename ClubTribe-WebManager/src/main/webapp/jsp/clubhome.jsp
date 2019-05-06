<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <title>clubhome</title>
    <link rel="stylesheet" type="text/css" href="../css/clubhomestyle.css">
    <script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../js/clubhome.js"></script>
    <script>
        $(function () {
            var clubid = '${clubid}';
            console.log("==============" + clubid);
            $.ajax({
                url: "${pageContext.request.contextPath}/user/getclubname",
                data: {
                    "clubid": clubid
                },
                success: function (resp) {
                    console.log(resp);
                    $("#title").append(resp)
                }
            });
            $("#context #aboutus #btn").click(function () {
                $("#context #aboutus #btn").fadeOut(2000, function () {
                    $("#context #aboutus #data").fadeIn(2000);
                });
            });
            $("#context #aboutus #data").click(function () {
                $("#context #aboutus #data").fadeOut(2000, function () {
                    $("#context #aboutus #btn").fadeIn(2000);
                });
            });
        });
    </script>
</head>
<body>
<div id="context">
    <div id="top">
        <div id="clubtribe"><img src="../img/title.png" alt="#"></div>
        <div id="topbtn"><a href="${pageContext.request.contextPath}/index.jsp">首页</a>
            <a href="">注册</a>
            <a href="">登录</a>
            <a href="">反馈</a>
            <a href="">QGshen</a>
            <a href="${pageContext.request.contextPath}/index.jsp">退出</a>
        </div>
    </div>
    <div id="clubbg">
        <img id="img" src="../img/bg.jpg" alt="#">
        <div id="title"></div>
        <div id="join">JOIN&nbspUS</div>
    </div>
    <div id="aboutus">
        <div id="btn">关于我们>>></div>
        <div id="data">景德镇火箭队 休斯顿碰瓷队 反正火箭总冠军✈✈✈</div>
    </div>
    <div id="fun">
        <div style="background: powderblue">1</div>
        <div style="background: skyblue">2</div>
        <div style="background: pink">3</div>
        <div style="background: yellowgreen">4</div>
        <div style="background: greenyellow">5</div>
        <div style="background: cadetblue">6</div>
        <div style="background: lightyellow">7</div>
        <div style="background: indianred">8</div>
    </div>
</div>
<div id="bot"></div>
</body>
</html>
