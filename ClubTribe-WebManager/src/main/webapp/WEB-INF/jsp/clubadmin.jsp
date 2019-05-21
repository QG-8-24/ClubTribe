<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员操作</title>
    <link rel="stylesheet" type="text/css" href="../css/clubadminstyle.css">
    <script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var uid = '${userid}';
            var cid = '${clubid}';

            function gitmsg() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/getmsg",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        var str = jQuery.parseJSON(resp);
                        $.each(str, function (i, item) {
                            $("#msg").prepend("<li id='" + item + "'>用户" + item + "申请加入社团<span class='agree'>同意</span><span class='reject'>拒绝</span></li>");
                        });
                    }
                });
            }

            gitmsg();

            //同意加入
            function agree(userid) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/agree",
                    data: {
                        "userid": userid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp == "true") {
                            alert("成功!");
                            var str = "#" + userid;
                            $(str).remove();
                        } else {
                            alert("失败！");
                        }
                    }
                });
            }

            //拒绝加入
            function reject(userid) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/reject",
                    data: {
                        "userid": userid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp == "true") {
                            alert("已拒绝!");
                            var str = "#" + userid;
                            $(str).remove();
                        } else {
                            alert("失败！");
                        }
                    }
                });
            }

            $("#msg").on("click", ".agree", function () {
                agree($(this).parent().attr("id"));
            });

            $("#msg").on("click", ".reject", function () {
                reject($(this).parent().attr("id"));
            });
            $("#leftbox").on("click", "ul li", function () {
                var sel = $(this).attr("id").split("sel");
                var box = "#box" + sel[1];
                $(box).siblings().fadeOut(2000, function () {
                    $(box).fadeIn(2000);
                });
            });
        });
    </script>
</head>
<body>
<div id="top">
    <div id="title">管 理 员 操 作</div>
    <div style="height: 4px;width: 100%;background: skyblue;margin-top: 10px"></div>
</div>
<div id="context">
    <div id="leftbox">
        <ul>
            <li id="sel1">加入申请</li>
            <li id="sel2">2</li>
            <li id="sel3">3</li>
            <li id="sel4">4</li>
            <li id="sel5">5</li>
        </ul>
    </div>
    <div id="rightbox">
        <div id="box1">
            <ul id="msg"></ul>
        </div>
        <div id="box2" style="background: skyblue"></div>
        <div id="box3" style="background: pink"></div>
        <div id="box4" style="background: green"></div>
        <div id="box5" style="background: yellow"></div>
    </div>
</div>
</body>
</html>
