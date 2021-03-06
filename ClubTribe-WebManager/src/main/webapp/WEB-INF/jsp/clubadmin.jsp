<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员操作</title>
    <link rel="stylesheet" type="text/css" href="../css/clubadminstyle.css">
    <link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.min.css">
    <script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.mCustomScrollbar.js"></script>
    <script type="text/javascript">
        $(function () {
            var uid = '${userid}';
            var cid = '${clubid}';
            var perid = "";
            var bg = "/clubtribefile/clubbg/bg" + cid + ".jpg";
            $("#bg").attr("src", bg);

            function init() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/ifper",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    success: function (re) {
                        perid = re;
                        if (perid == "") {
                            window.location = "${pageContext.request.contextPath}/clubTribeIndex.jsp"
                        }
                    }, error: function () {
                        window.location = "${pageContext.request.contextPath}/clubTribeIndex.jsp"
                    }
                });
            }

            //获取通知
            function gitmsg() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/getmsg",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    dataType: "json",
                    success: function (resp) {
                        if (resp == null || resp == "") {
                            $("#msg").prepend("<li>没有任何申请!</li>");
                        } else {
                            $.each(resp, function (i, item) {
                                $("#msg").prepend("<li id='" + item + "'>用户" + item + "申请加入社团<span class='agree'>同意</span><span class='reject'>拒绝</span></li>");
                            });
                        }

                    }
                });
            }

            gitmsg();
            init();
            //自定义滚动条
            $("#box1").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#box3").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#box4").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#box2ul").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#box6ul").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#box7ul").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });

            //同意加入
            function agree(userid) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/agree",
                    data: {
                        "userid": userid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp == true) {
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
                        if (resp == true) {
                            alert("已拒绝!");
                            var str = "#" + userid;
                            $(str).remove();
                        } else {
                            alert("失败！");
                        }
                    }
                });
            }

            //社员信息
            function initmembermsg() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/getmembermsg",
                    data: {
                        "clubid": cid
                    },
                    success: function (resp) {
                        $("#box2ul").children().remove();
                        $.each(resp, function (i, it) {
                            var ifadmin = "否";
                            if (it.ifadmin == 1) {
                                ifadmin = "是";
                            }
                            $("#box2ul").append("<li><span class=\"box2span2id\">" + it.userid + "</span><span class=\"box2span2\">" + it.username + "</span><span class=\"ifadmin\">" + ifadmin + "</span><span class='removemember'>[删除]</li>")
                        })
                    }
                });
            }

            // 活动成员
            function initact() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/initact",
                    data: {
                        "clubid": cid
                    },
                    success: function (resp) {
                        $("#box6ul").children().remove();
                        $("#box7ul").children().remove();
                        $.each(resp, function (i, it) {
                            var type = i.split("type=")[1].split("}")[0];
                            var acname = i.split("name=")[1].split("'")[1];
                            var acid = i.split("id=")[2].split(",")[0];
                            if (type == 1) {
                                $.each(it, function (ii, itt) {
                                        $("#box6ul").append("<li><span style=\"display: none;\" class=\"dd\">" + acid + "@" + itt.userid + "</span><span class=\"box2span2id\">" + itt.username + "</span><span class=\"box2span2\">" + itt.useremail + "</span><span\n" + "class=\"box2span2id\">" + acname + " </span><span class=\"removemember\">[删除]</span>\n" + "</li>");
                                    }
                                )
                            } else {
                                $.each(it, function (ii, itt) {
                                        $("#box7ul").append(" <li><span style=\"display: none;\" class=\"dd\">" + acid + "@" + itt.userid + "</span><span class=\"box2span2id\">" + itt.username + "</span><span class=\"box2span2\">" + itt.useremail + "</span><span\n" + "class=\"box2span2id\">" + acname + " </span><span class=\"removemember\">[删除]</span>\n" + "</li>");
                                    }
                                )
                            }
                        })
                    }
                });
            }

            // 活动
            function initactt() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/initact",
                    data: {
                        "clubid": cid
                    },
                    success: function (resp) {
                        $("#box8ul").children().remove();
                        $.each(resp, function (i, it) {
                            var type = i.split("type=")[1].split("}")[0];
                            var acname = i.split("name=")[1].split("'")[1];
                            var acid = i.split("id=")[2].split(",")[0];
                            var begintime = i.split("begintime=")[1].split("'")[1];
                            var endtime = i.split("endtime=")[1].split("'")[1];
                            if (type == 1) {
                                $("#box8ul").append("<li><span style=\"display: none;\" class=\"dd\">" + acid + "</span><span class=\"box2span2id\">" + acname + "</span><span class=\"box2span2\">" + begintime + "至" + endtime + "</span><span\n" + "class=\"box2span2id\">社团活动</span><span class=\"removemember\">[删除]</span>\n" + "</li>");
                            } else {
                                $("#box8ul").append("<li><span style=\"display: none;\" class=\"dd\">" + acid + "</span><span class=\"box2span2id\">" + acname + "</span><span class=\"box2span2\">" + begintime + "至" + endtime + "</span><span\n" + "class=\"box2span2id\">联合活动</span><span class=\"removemember\">[删除]</span>\n" + "</li>");
                            }
                        });
                    }
                });
            }

            //设置管理员
            function setadmin(id) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/setadmin",
                    data: {
                        "userid": id,
                        "clubid": cid
                    },
                    success: function (resp) {
                        alert(resp);
                    }
                });
            }

            //去除管理员
            function removeadmin(id) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/removeadmin",
                    data: {
                        "userid": id,
                        "clubid": cid
                    },
                    success: function (resp) {
                        alert(resp);
                    }
                });
            }

            //删除成员
            function removemember(id) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/removemember",
                    data: {
                        "userid": id,
                        "clubid": cid
                    },
                    success: function (resp) {
                        alert(resp);
                    }
                });
            }

            //删除活动成员
            function removeacmember(id, userid) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/removeacmember",
                    data: {
                        "id": id,
                        "userid": userid,
                    },
                    success: function (resp) {
                        alert(resp);
                    }
                });
            }

            //删除活动
            function removeac(id, userid) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/removeac",
                    data: {
                        "id": id,
                    },
                    success: function (resp) {
                        alert(resp);
                    }
                });
            }

            $("#box2ul").on("click", "li .ifadmin", function () {
                var id = $(this).siblings(".box2span2id").html();
                if (id == perid) {
                    alert("失败!");
                } else {
                    if (perid != "") {
                        if ($(this).html() == "否") {
                            setadmin(id);
                            $(this).html("是");
                        } else {
                            removeadmin(id);
                            $(this).html("否");
                        }
                    } else {
                        alert("仅限社长操作!");
                    }
                }
            });

            $("#box6ul").on("click", "li .removemember", function () {
                var str = $(this).siblings(".dd").html();
                var acid = str.split("@")[0];
                var userid = str.split("@")[1];
                removeacmember(acid, userid);
                $(this).parent().remove();
            });

            $("#box7ul").on("click", "li .removemember", function () {
                var str = $(this).siblings(".dd").html();
                var acid = str.split("@")[0];
                var userid = str.split("@")[1];
                removeacmember(acid, userid);
                $(this).parent().remove();
            });

            $("#box8ul").on("click", "li .removemember", function () {
                var acid = $(this).siblings(".dd").html();
                removeac(acid);
                $(this).parent().remove();
            });

            $("#box2ul").on("click", "li .removemember", function () {
                var id = $(this).siblings(".box2span2id").html();
                if (id == perid) {
                    alert("不能删除社长!");
                } else {
                    removeadmin(id);
                    removemember(id);
                    $(this).parent().remove();

                }
            });

            $("#msg").on("click", ".agree", function () {
                agree($(this).parent().attr("id"));
            });

            $("#msg").on("click", ".reject", function () {
                reject($(this).parent().attr("id"));
            });

            $("#leftbox").on("click", "ul li", function () {
                var sel = $(this).attr("id").split("sel");
                var box = "#box" + sel[1];
                if (sel[1] == 2) {
                    initmembermsg();
                } else if (sel[1] == 3) {
                    alert("提示:双击可删除照片");
                    initalbum();
                } else if (sel[1] == 4) {
                    initsharefile();
                } else if (sel[1] == 5) {
                    initmsg();
                } else if (sel[1] == 6) {
                    initact()
                } else if (sel[1] == 7) {
                    initact()
                } else if (sel[1] == 8) {
                    initactt()
                }
                $(box).siblings().fadeOut(500, function () {
                    $(box).fadeIn(500);
                });
            });

            //初始化相册
            function initalbum() {
                $("#box3").children().remove();
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/initalbum",
                    data: {
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp != false) {
                            albums = resp;
                        }
                        $.each(albums, function (i, it) {
                            path = "../clubtribefile/clubalbum/album" + cid + "/" + it;
                            addalbum(path);
                        })
                    }
                });
            }

            function addalbum(path) {
                $("#box3").append("<img class=\"album\" src=\"" + path + "\" alt=\"\">")
            }

            $("#box3").on("dblclick", ".album", function () {
                var str = $(this).attr("src").split("../clubtribefile/clubalbum/album" + cid + "/")[1];
                delabum(str);
                $(this).remove();
            });

            function delabum(str) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/delalbum",
                    data: {
                        "clubid": cid,
                        "album": str
                    },
                })
            }

            //initsharefile
            function initsharefile() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/initsharefile",
                    data: {
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp != false) {
                            $("#box4 ul").children().remove();
                            $.each(resp, function (i, it) {
                                $("#box4 ul").prepend("<li>" + it + "<span>[删除]</span></li>");
                            })
                        }
                    },
                });
            }

            $("#box4 ul").on("click", "li", function () {
                var str = $(this).html().split("<span>[删除]</span>")[0];
                console.log(str);
                delfile(str);
                $(this).remove();
            });

            //delfile
            function delfile(str) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/delfile",
                    data: {
                        "clubid": cid,
                        "file": str
                    },
                })
            }

            $("#change").click(function () {
                $("#uploadbox").fadeIn(500);
            });
            $("#uploadsure").click(function () {
                var formData = new FormData($('#uploadform')[0]);
                formData.append("clubid", "${clubid}");
                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/admin/uploadbg",
                    data: formData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        alert(data);
                        $("#uploadbox").fadeOut(500);
                    },
                    error: function (data) {
                        alert(data);
                    }
                });
            });
            $("#chreset").click(function () {
                $("#clubname").val("");
                $("#clubmsg").val("");
            });

            function initmsg() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/initmsg",
                    data: {
                        "clubid": cid,
                    },
                    success: function (resp) {
                        console.log(resp);
                        str = resp.split("@@");
                        $("#clubname").val(str[0]);
                        $("#clubmsg").val(str[1].replace(/<br>/g, "\n"));
                    },
                });
            }

            $("#chsure").click(function () {
                chagemsg();
            });

            function chagemsg() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/chagemsg",
                    data: {
                        "clubid": cid,
                        "clubname": $("#clubname").val(),
                        "itrdc": $("#clubmsg").val().replace(/\n/g, "<br>")
                    },
                    success: function (re) {
                        alert(re)
                    }, error: function () {
                        alert("失败");
                    }
                });
            }
        });
    </script>
</head>
<body>
<div id="top">
    <div id="title">管 理 员 操 作</div>
    <div style="height: 36px;width: 100%;margin:0px auto;font-size: 24px;background: black;text-align: center;color: white">
        C L U B T R I B E
    </div>
</div>
<div id="context">
    <div id="leftbox">
        <ul>
            <li id="sel1">加 入 申 请</li>
            <li id="sel2">社 员 管 理</li>
            <li id="sel3">相 册 管 理</li>
            <li id="sel4">文 件 管 理</li>
            <li id="sel5">资 料 更 改</li>
            <li id="sel6">社团活动成员</li>
            <li id="sel7">联合活动成员</li>
            <li id="sel8">活 动 管 理</li>
        </ul>
    </div>
    <div id="rightbox">
        <div id="box1">
            <ul id="msg"></ul>
        </div>
        <div id="box2">
            <div style="position: relative;height: 30px"><span class="box2span1">账号</span><span
                    class="box2span1">用户名</span><span
                    class="box2span1">是否为管理员</span>
                <span class="box2span1">删除成员</span></div>
            <ul id="box2ul" style="display:block;position: relative">
            </ul>
        </div>
        <div id="box3" style="height: 100%;width: 100%;overflow: auto;">
        </div>
        <div id="box4" style="height: 100%;width: 100%;overflow: hidden;">
            <ul>

            </ul>
        </div>
        <div id="box5">
            <span style="display: block;float: left">社 团 名&nbsp&nbsp</span><input id="clubname" type="text"
                                                                                  style="display: block;width: 200px;height: 26px;float: left "><br><br>
            <span style="display: block;float: left">社团简介&nbsp&nbsp</span><textarea id="clubmsg"
                                                                                    style="resize: none;width: 600px;height: 200px;"
                                                                                    placeholder="最多500字"
                                                                                    maxlength="500"></textarea><br><br>
            <span style="display: block;float: left">主页图片&nbsp&nbsp</span><img id="bg"
                                                                               style="display: block;width: 600px;height: 300px;border: 1px solid #333"
                                                                               src="#">
            <span id="change" style="display: block;float: left;cursor: pointer">更换图片&nbsp</span>
            <div id="uploadbox"
                 style="display: none;background: white;width: 500px;height: 22px;float: left">
                <div style="height: 100%;width: 100%">
                    <form id="uploadform" enctype="multipart/form-data">
                        <input type="file" accept='image/*' name="file">
                        <input type="button" value="上传" id="uploadsure">
                    </form>
                </div>
            </div>
            <br><br>
            <div style="height: 30px;width: 700px;position: relative;">
                <span id="chreset"
                      style="display: block;position: absolute;left:0;height: 32px;width: 100px;border-bottom:2px solid #333;font-size: 26px;text-align: center;cursor: pointer">重&nbsp&nbsp&nbsp&nbsp置</span>
                <span id="chsure"
                      style="display: block;position: absolute;right:0;height: 32px;width: 110px;border-bottom:2px solid #333;font-size: 26px;text-align: center;cursor: pointer">确认修改</span>
            </div>
        </div>
        <div id="box6">
            <div style="position: relative;height: 30px"><span class="box2span1">用户名</span><span
                    class="box2span1">邮箱</span><span
                    class="box2span1">参与活动</span>
                <span class="box2span1">删除成员</span></div>
            <ul id="box6ul" style="display:block;position: relative">

            </ul>
        </div>
        <div id="box7">
            <div style="position: relative;height: 30px"><span class="box2span1">用户名</span><span
                    class="box2span1">邮箱</span><span
                    class="box2span1">参与活动</span>
                <span class="box2span1">删除成员</span></div>
            <ul id="box7ul" style="display:block;position: relative"></ul>
        </div>
        <div id="box8">
            <div style="position: relative;height: 30px"><span class="box2span1">活动名</span><span
                    class="box2span1">活动时间</span><span
                    class="box2span1">类型</span>
                <span class="box2span1">删除活动</span></div>
            <ul id="box8ul" style="display:block;position: relative"></ul>
        </div>
    </div>
</div>
</body>
</html>
