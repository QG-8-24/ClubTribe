<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title id="tit"></title>
    <title>clubhome</title>
    <link rel="stylesheet" type="text/css" href="../css/clubhomestyle.css">
    <script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            var uid = '${userid}';
            var cid = '${clubid}';

            function init() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/init",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        var str = resp.split("@");
                        var username = str[0];
                        var clubname = str[1];
                        if (username != 'null') {
                            $("#log").css({
                                "display": "none"
                            });
                            $("#username").append(username);
                        }
                        if (clubname != 'null') {
                            $("#title").append(clubname);
                            $("#tit").append(clubname);
                        }
                    }
                });
            };

            //验证是否为管理员
            function ifadmin() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/ifadmin",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp == "true") {
                            $("#admin").attr("href", "${pageContext.request.contextPath}/user/interadmin?userid=${userid}&clubid=${clubid}")
                            $("#admin").removeAttr("onclick");
                        }
                    }
                });
            }

            init();
            ifadmin();
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

            // 加入社团
            function join() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/joinapply",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        alert(resp);
                    }
                });
            }

            //加入事件
            $("#join").click(function () {
                if (uid.length == 0) {
                    alert("请先登录!");
                } else {
                    join();
                }
            });

            $("#admin").click(function () {
                if($("#admin").attr("href")=="#"){
                    alert("仅限管理员！");
                }
            });
        });
    </script>
</head>
<body>

<div id="top">
    <div id="clubtribe"><img src="../img/title.png" alt="#"></div>
    <div id="topbtn">
        <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
        <a href="#" id="log">登录</a>
        <a href="#" id="username"></a>
        <%--            <a href="${pageContext.request.contextPath}/user/logout">退出</a>--%>
    </div>
</div>
<div style="height: 4px;width: 100%;background: deepskyblue;margin-bottom: 5px"></div>
<div id="context">
    <div id="clubbg">
        <img id="img" src="../img/bg.jpg" alt="#">
        <div id="title"></div>
        <div id="join">JOIN&nbspUS</div>
    </div>
    <div id="aboutus">
        <div id="btn">关于我们>>></div>
        <div id="data">景德镇火箭队 休斯顿碰瓷队 火箭没搞了</div>
    </div>
    <div id="function">
        <div style="background: powderblue">签到</div>
        <div style="background: skyblue">社团活动</div>
        <div style="background: pink">相册</div>
        <div style="background: yellowgreen">留言墙</div>
        <div style="background: greenyellow">公告</div>
        <div style="background: cadetblue">投票</div>
        <div style="background: lightyellow">抽奖</div>
        <div style="background: indianred"><a id="admin" href="#" onclick="return false;">管理员操作</a>
        </div>
    </div>
</div>
<div style="height: 4px;width: 100%;background: deepskyblue;margin-bottom: 5px"></div>
</body>
</html>