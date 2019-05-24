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
                            $("#admin").attr("href", "${pageContext.request.contextPath}/user/interadmin?userid=${userid}&clubid=${clubid}");
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
                if ($("#admin").attr("href") == "#") {
                    alert("仅限管理员！");
                }
            });

            function getsignmsg() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/getsignmsg",
                    data: {
                        "clubid": cid,
                    },
                    dataType: "json",
                    success: function (resp) {
                        $("#sign table").children().remove();
                        $("#sign table").append("<tr class='white'>\n" + "<td>名次</td>\n" + "<td>用户名</td>\n" + "<td>签到时间</td>\n" + "</tr>");
                        $("#msign table").children().remove();
                        $("#msign table").append("<tr class='white'>\n" + "<td>名次</td>\n" + "<td>用户名</td>\n" + "<td>总签到天数</td>\n" + "</tr>");
                        $.each(resp, function (i, obj) {
                            if (i == 0) {
                                $("#sign table").append("<tr class='gold'><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.sign + "</td></tr>")
                            } else if (i == 1) {
                                $("#sign table").append("<tr class='silver'><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.sign + "</td></tr>")
                            } else if (i == 2) {
                                $("#sign table").append("<tr class='bronze'><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.sign + "</td></tr>")
                            } else {
                                $("#sign table").append("<tr class='white><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.sign + "</td></tr>")
                            }
                        });
                        var resp2 = resp;
                        $.each(resp2, function (i, obj) {
                            if (i + 1 < resp.length) {
                                if (resp2[i + 1].msign > resp2[i].msign) {
                                    tep = resp2[i]
                                    resp2[i] = resp2[i + 1];
                                    resp2[i + 1] = tep;
                                }
                            }
                        });
                        $.each(resp2, function (i, obj) {
                            if (i == 0) {
                                $("#msign table").append("<tr class='gold'><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.msign + "</td></tr>")
                            } else if (i == 1) {
                                $("#msign table").append("<tr class='silver'><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.msign + "</td></tr>")
                            } else if (i == 2) {
                                $("#msign table").append("<tr class='bronze'><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.msign + "</td></tr>")
                            } else {
                                $("#msign table").append("<tr class='white'><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.msign + "</td></tr>")
                            }
                        });
                    }
                });
            }

            //签到
            $(".sign").click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/sign",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        alert(resp);
                        getsignmsg();
                    }
                });
            });
            var barrageColorArray = [
                '#0099CC', '#333333', '#009966', '#FFFF66', '#9933FF', '#FFFF99', '#CCCCFF', '#CC9933', '#FFFF66'
            ];

            function sendmsg(msg) {
                $("#show4").append(" <h1 style=\"position: absolute\"> " + msg + "</h1>");
                $("#show4 h1").animate({right: '100%'}, 10000);
            }

            $("#msgboard").keyup(function (e) {
                if (e.keyCode == 13) {
                    var msg = $("#msgboard").val();
                    $("#msgboard").val("");
                    sendmsg(msg);
                    console.log("sadas");
                }
            });
            $("#function").on("click", "div", function () {
                var sel = "#show" + $(this).attr("id").split("fun")[1];
                $(sel).siblings().fadeOut(2000, function () {
                    $(sel).fadeIn(2000);
                });
            });
        });
    </script>
</head>
<div id="top">
    <div id="clubtribe"><img src="../img/title.png" alt="#"></div>
    <div id="topbtn">
        <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
        <a href="#" id="log">登录</a>
        <a href="#" id="username"></a>
        <%--            <a href="${pageContext.request.contextPath}/user/logout">退出</a>--%>
    </div>
</div>
<div style="height: 6px;width: 100%;background: deepskyblue;"></div>
<div id="context">
    <div id="clubbg">
        <img id="img" src="../img/bg.jpg" alt="#">
        <div id="imgm"></div>
        <div id="title"></div>
        <div id="join">JOIN&nbspUS</div>
    </div>
    <div id="aboutus">
        <div id="btn">关于我们>>></div>
        <div id="data">景德镇火箭队 休斯顿碰瓷队 火箭没搞了</div>
    </div>
    <div id="function">
        <div class="sign" id="fun1"><span>签到</span></div>
        <div id="fun2"><span>社团活动</span></div>
        <div id="fun3"><span>相册</span></div>
        <div id="fun4"><span>留言墙</span></div>
        <div id="fun5"><span>公告</span></div>
        <div id="fun6"><span>投票</span></div>
        <div id="fun7"><span>抽奖</span></div>
        <div><a id="admin" href="#" onclick="return false;"><span style="color: white">管理员操作</span></a>
        </div>
    </div>
</div>
<div id="bot">
    <div id="show1" style="height: 100%;width: 100%;">
        <div id="sign" style="float: left;width: 50%;height: 100%;">
            <div style="margin:10px auto;font-size: 24px;width: 50%;text-align: center" class="white">今 日 签 到 榜</div>
            <div style="width: 100%;height: 92%;">
                <table style="width:100%;">
                    <tr class="white">
                        <td>名次</td>
                        <td>用户名</td>
                        <td>签到时间</td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="msign" style="float: left;width: 50%;height: 100%;">
            <div style="margin:10px auto;font-size: 24px;width: 50%;text-align: center" class="white">本 月 签 到 榜</div>
            <div style="width: 100%;height: 92%;">
                <table style="width:100%" cellspacing="0" cellpadding="0">
                    <tr class="white">
                        <td>名次</td>
                        <td>用户名</td>
                        <td>总签到天数</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div id="show2" style="height: 100%;width: 100%;background:green;"></div>
    <div id="show3" style="height: 100%;width: 100%;background:skyblue;"></div>
    <div id="show4" style="height: 100%;width: 100%;overflow: hidden">
        <input id="msgboard" type="text" placeholder="Enter 发送留言">
    </div>
    <div id="show5" style="height: 100%;width: 100%;background:deepskyblue;"></div>
    <div id="show6" style="height: 100%;width: 100%;background:palegreen;"></div>
    <div id="show7" style="height: 100%;width: 100%;background:peru;"></div>
</div>
<div style="height: 24px;width: 100%;margin:5px auto;font-size: 24px">
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
    ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
</div>
</body>
</html>
