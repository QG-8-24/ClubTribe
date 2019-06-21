<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title id="tit"></title>
    <title>clubhome</title>
    <link rel="stylesheet" type="text/css" href="../css/clubhomestyle.css">
    <link rel="stylesheet" type="text/css" href="../css/jquery.mCustomScrollbar.min.css">
    <script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.mCustomScrollbar.js"></script>
    <script>
        $(function () {
            var uid = '${userid}';
            var cid = '${clubid}';
            var msgboards = ["!没有任何留言!"];
            var index = 0;
            var albums = ["!没有任何照片!"];
            var ifmember = false;
            var ifadmin = false;
            var bg = "/clubtribefile/clubbg/bg" + cid + ".jpg";
            $("#clubbg #img").attr("src", bg);

            function init() {
                initclubmsg();
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
                        } else {
                            $("#logout").css({
                                "display": "none"
                            });
                        }
                        if (clubname != 'null') {
                            $("#title").append(clubname);
                            $("#tit").append(clubname);
                        }
                    }
                });
            };

            function initclubmsg() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/initmsg",
                    data: {
                        "clubid": cid,
                    },
                    success: function (resp) {
                        str = resp.split("@@");
                        $("#data").html(str[1]);
                    },
                });
            }

            //自定义滚动条
            $("#show5 #context1").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#data").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "white"
            });
            $("#show1 #sign").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#show1 #msign").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#show6 #show6con1").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#s2c1").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });
            $("#s2c2").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "dark"
            });

            //验证是否为管理员
            function ifadmins() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/ifadmin",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp == true) {
                            ifadmin = true;
                            $("#admin").attr("href", "${pageContext.request.contextPath}/user/interadmin?clubid=${clubid}");
                            $("#admin").removeAttr("onclick");
                        }
                    }
                });
            }

            //验证是否为成员
            function ifmembers() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/ifmember",
                    data: {
                        "userid": uid,
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp == true) {
                            ifmember = true;
                        }
                    }
                });
            }

            init();
            ifadmins();
            ifmembers();
            msgboaard("");
            initmsgb();

            function initmsgb() {
                setInterval(function () {
                    msgboaard("");
                    sendmsg(msgboards[index]);
                    index++;
                    if (index == msgboards.length) {
                        index = 0;
                    }
                }, 3000);
            }

            $("#context #aboutus #btn").click(function () {
                $("#context #aboutus #btn").fadeOut(1000, function () {
                    $("#context #aboutus #data").fadeIn(1000);
                });
            });
            $("#context #aboutus #data").click(function () {
                $("#context #aboutus #data").fadeOut(1000, function () {
                    $("#context #aboutus #btn").fadeIn(1000);
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

            //获取月签到
            function getmsign() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/getmsign",
                    data: {
                        "clubid": cid,
                    },
                    dataType: "json",
                    success: function (resp) {
                        var resp2 = resp;
                        $.each(resp2, function (i, obj) {
                            for (var j = i + 1; j < resp.length - 1; j++) {
                                if (resp2[j].msign > resp2[i].msign) {
                                    var tep = resp2[i]
                                    resp2[i] = resp2[j];
                                    resp2[j] = tep;
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

            //日签到情况
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
                                $("#sign table").append("<tr class='white'><td>" + (i + 1) + "</td>\n" + "<td>" + obj.username + "</td>\n" + "<td>" + obj.sign + "</td></tr>")
                            }
                        });
                    }
                });
            }

            //签到
            $(".sign").click(function () {
                if (uid.length == 0) {
                    alert("请先登录!");
                } else {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/user/sign",
                        data: {
                            "userid": uid,
                            "clubid": cid,
                        },
                        success: function (resp) {
                            alert(resp);
                            getsignmsg();
                            getmsign();
                        }
                    });
                }
            });
            var barrageColorArray = [
                '#0099CC', 'deeppink', '#009966', '#FFFF66', '#9933FF', '#FFFF99', '#CCCCFF', '#CC9933', '#FFFF66', 'skyblue',
                '#CC0000'
            ];

            function sendmsg(msg) {
                var rand0 = parseInt(Math.random() * 10 + 0);
                var top = parseInt(Math.random() * 80 + 0);
                var col = barrageColorArray[rand0];
                $("#show4").append(" <h1 style=\"position: absolute;color: " + col + ";top:" + top + "%\"> " + msg + "</h1>");
                $("#show4 h1").animate({right: '100%'}, parseInt(Math.random() * 20000 + 5000), function () {
                    $(this).remove();
                });
            }

            $("#msgboard").keyup(function (e) {
                if (e.keyCode == 13) {
                    var msg = $("#msgboard").val();
                    $("#msgboard").val("");
                    msgboaard(msg);
                }
            });

            //留言
            function msgboaard(msg) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/msgboard",
                    data: {
                        "clubid": cid,
                        "msg": msg
                    },
                    success: function (resp) {
                        if (resp.length != 0) {
                            msgboards = resp;
                        }
                        sendmsg(msg);
                    }
                });
            }

            // 初始化相册
            function initalbum() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/initalbum",
                    data: {
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp != false) {
                            albums = resp;
                        }
                        var ulwidth = (albums.length * 1000) + "px";
                        $("#show3 ul").css({
                            "width": ulwidth
                        });
                        $.each(albums, function (i, it) {
                            path = "/clubtribefile/clubalbum/album" + cid + "/" + it;
                            addpicture(path);
                        });
                    }
                });
            }

            function addpicture(str) {
                $("#show3 ul").append("<li><img src='" + str + "' alt=\"#\"></li>");
            }

            //导航栏事件委派
            $("#function").on("click", "div", function () {
                var sel = "#show" + $(this).attr("id").split("fun")[1];
                if (sel == "#show3") {
                    initalbum();
                } else if (sel == "#show5") {
                    $("#show5 div ul").children().remove();
                    initnotice();
                } else if (sel == "#show6") {
                    initsharefile();
                } else if (sel == "#show2") {
                    getallactivity();
                }
                $(sel).siblings().fadeOut(500, function () {
                    $(sel).fadeIn(500);
                });
            });

            //上传图片点击事件
            $("#uploadpic").click(function () {
                if (ifmember == false) {
                    alert("仅限社团成员操作!");
                } else {
                    $("#uploadbox").fadeIn(1500);
                }
            });

            //上传文件点击事件
            $("#uploadfile").click(function () {
                if (ifmember == false) {
                    alert("仅限社团成员操作!");
                } else {
                    $("#uploadfilebox").fadeIn(1500);
                }
            });

            $("#uploadsure").click(function () {
                var formData = new FormData($('#uploadform')[0]);
                formData.append("clubid", "${clubid}");
                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/user/uploadFiles",
                    data: formData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        alert(data);
                        $("#uploadbox").fadeOut(1500);
                        initalbum();
                    },
                    error: function (data) {
                        alert(data);
                    }
                });
            });

            $("#uploadfilesure").click(function () {
                var formData = new FormData($('#uploadfileform')[0]);
                formData.append("clubid", "${clubid}");
                $.ajax({
                    type: 'post',
                    url: "${pageContext.request.contextPath}/user/uploadshareFiles",
                    data: formData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        alert(data);
                        $("#uploadfilebox").fadeOut(1500);
                        initsharefile();
                    },
                    error: function (data) {
                        alert(data);
                    }
                });
            });

            // initnotice
            function initnotice() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/initnotice",
                    data: {
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp != 'null') {
                            notices = $.parseJSON(resp);
                        }
                        $.each(notices, function (i, it) {
                            $("#show5 #context1 ul").prepend(it);
                        })
                    },
                });
            }

            // initsharefile
            function initsharefile() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/initsharefile",
                    data: {
                        "clubid": cid,
                    },
                    success: function (resp) {
                        if (resp != false) {
                            $("#show6 #show6con1 ul").children().remove();
                            $.each(resp, function (i, it) {
                                $("#show6 #show6con1 ul").prepend("<li>" + it + "<span>[下载]</span></li>");
                            })
                        }
                    },
                });
            }

            function getFormatDate() {
                var nowDate = new Date();
                var year = nowDate.getFullYear();
                var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
                var date = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
                var hour = nowDate.getHours() < 10 ? "0" + nowDate.getHours() : nowDate.getHours();
                var minute = nowDate.getMinutes() < 10 ? "0" + nowDate.getMinutes() : nowDate.getMinutes();
                var second = nowDate.getSeconds() < 10 ? "0" + nowDate.getSeconds() : nowDate.getSeconds();
                return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
            }

            function getFormatDate1() {
                var nowDate = new Date();
                var year = nowDate.getFullYear();
                var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
                var date = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
                return year + "-" + month + "-" + date;
            }

            $("#notice").keyup(function (e) {
                if (e.keyCode == 13) {
                    var msg = $("#notice").val();
                    $("#notice").val("");
                    if (ifadmin) {
                        addnotice(msg);
                    } else {
                        alert("仅限管理员!");
                    }

                }
            });

            // addnotice
            function addnotice(msg) {
                var pend = "<li>" + msg + "<br>" + getFormatDate() + "<span class=\"removenotice\">×</span></li>";
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/notice",
                    data: {
                        "clubid": cid,
                        "notice": pend,
                    },
                    success: function (resp) {
                        $("#show5 div ul").prepend(pend);
                    },
                    error: function (resp) {
                        alert("失败");
                    }
                })
            }

            //remove notice
            $("#show5").on("click", ".removenotice", function () {
                if (ifadmin) {
                    $(this).parent().remove();
                    $.ajax({
                        url: "${pageContext.request.contextPath}/user/removenotice",
                        data: {
                            "clubid": cid,
                            "notice": $(this).parent().html().toString(),
                        },
                    });
                } else {
                    alert("仅限管理员!");
                }

            });
            //logout
            $("#logout").click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/logout",
                    success: function () {
                        alert("退出成功!");
                        window.location.reload();
                    }
                });
            });
            $("#vote").click(function () {
                $("#show6con2").fadeIn(500);
            });

            //filedownload
            $("#show6con1 ul").on("click", "li span", function () {
                var filename = $(this).parent().html().split("<span>[下载]</span>")[0];
                var url = "${pageContext.request.contextPath}/user/filedownload?filename=" + filename + "&clubid=" + cid;
                window.location.href = url;
            });
            //
            $("#show2sel1").click(function () {
                $("#s2c1").siblings().fadeOut(500);
                $("#s2c1").fadeIn(500);
            });
            $("#show2sel2").click(function () {
                $("#s2c2").siblings().fadeOut(500);
                $("#s2c2").fadeIn(500);
            });
            $("#creatNewActivity").click(function () {
                $("#s2c3").siblings().fadeOut(500);
                $("#s2c3").fadeIn(500);
                $("#begintime").val(getFormatDate1());
                $("#endtime").val(getFormatDate1());
            });
            //creatNewActivity
            $("#creatNewActivitysure").click(function () {
                var aname = $("#aname").val();
                var begintime = $("#begintime").val();
                var endtime = $("#endtime").val();
                var atype = $("#atype").val();
                var itrdc = $("#itrdc").val();
                var aplace = $("#aplace").val();
                if (ifadmin) {
                    if (aname.length == 0 || aname == null) {
                        alert("活动名称不能为空!");
                    } else if (begintime.length == 0 || begintime == null || endtime.length == 0 || endtime == null) {
                        alert("时间不能为空!");
                    } else if (aplace.length == 0 || aplace == null) {
                        alert("活动地址不能为空!");
                    } else if (itrdc.length == 0 || itrdc == null) {
                        alert("活动介绍最好不要为空!");
                    } else {
                        var time1 = Date.parse(begintime);
                        var time2 = Date.parse(endtime);
                        var time3 = Date.parse(getFormatDate1());
                        if (time1 < time3 || time2 < time3) {
                            alert("不能回到过去展开活动!");
                        } else if (time1 > time2) {
                            alert("请认真填写时间");
                        } else {
                            $.ajax({
                                url: "${pageContext.request.contextPath}/user/createNewActivity",
                                data: {
                                    "clubid": cid,
                                    "aname": aname,
                                    "begintime": begintime,
                                    "endtime": endtime,
                                    "atype": atype,
                                    "aplace": aplace,
                                    "itrdc": itrdc,
                                },
                                success: function (resp) {
                                    alert(resp);
                                }
                            })
                            ;
                        }
                    }

                } else {
                    alert("仅限管理员");
                }

            });

            function getallactivity() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/getallactivity",
                    success: function (resp) {
                        $.each(resp, function (i, it) {
                            if (it.type == 1 && it.clubid == cid) {
                                $("#s2c1 ul").children().remove();
                            } else {
                                $("#s2c2 ul").children().remove();
                            }
                        });
                        $.each(resp, function (i, it) {
                            if (it.type == 1 && it.clubid == cid) {
                                if (it.ifjoin != "1") {
                                    $(".joinactivity").css({"display": "none"});
                                } else {
                                    $(".joinactivity").css({"display": "block"});
                                }
                                $("#s2c1 ul").prepend(" <li>\n" +
                                    "<div class=\"sld1\">\n" +
                                    "<div style=\"display: none\" class=\"aid\">" + it.id + "</div>\n" +
                                    "<div style=\"font-size: 24px;font-weight: bold\">" + it.name + "</div>\n" +
                                    "<div>时间:" + it.begintime + "--" + it.endtime + "<br>地点:<br>已报人数:" + it.memberid.length + "<br>类型:社团活动<br>简介:" + it.itrdc + "</div>\n" +
                                    "</div>\n" +
                                    "<div class=\"sld2\"><span class=\"joinactivity\">参&nbsp加</span></div>\n" +
                                    "</li>");
                            } else {
                                if (it.ifjoin != "1") {
                                    $(".joinactivity").css({"display": "none"});
                                } else {
                                    $(".joinactivity").css({"display": "block"});
                                }
                                $("#s2c2 ul").prepend("<li>\n" +
                                    "<div class=\"sld1\">\n" +
                                    "<div style=\"display: none\" class=\"aid\">" + it.id + "</div>\n" +
                                    "<div style=\"font-size: 24px;font-weight: bold\">" + it.name + "</div>\n" +
                                    "<div>时间:" + it.begintime + "--" + it.endtime + "<br>地点:<br>已报人数:" + it.memberid.length + "<br>类型:社团联合活动<br>简介:" + it.itrdc + "</div>\n" +
                                    "</div>\n" +
                                    "<div class=\"sld2\"><span class=\"joinactivity\">参&nbsp加</span></div>\n" +
                                    "</li>");
                            }
                        });
                    }
                });
            }

            $("#s2c1 ul").on("click", ".joinactivity", function () {
                var id = $(this).parent().siblings().children()[0].innerHTML;
                if (uid.length == 0) {
                    alert("请先登录!");
                } else if (ifmember) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/user/joinactivity",
                        data: {
                            "id": id,
                            "userid": uid
                        },
                        success: function (re) {
                            alert(re)
                        }
                    });
                } else {
                    alert("本活动仅限社团成员参加!");
                }
            });
            $("#s2c2 ul").on("click", ".joinactivity", function () {
                var id = $(this).parent().siblings().children()[0].innerHTML;
                if (uid.length == 0) {
                    alert("请先登录!");
                } else {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/user/joinactivity",
                        data: {
                            "id": id,
                            "userid": uid
                        },
                        success: function (re) {
                            alert(re)
                        }
                    });
                }
            });

            $("#aright").click(function () {
                var pos = $("#show3 ul").position().left;
                var poss="-"+($("#show3 ul").css("width").split("px")[0]-document.body.clientWidth);
                if ((pos-1000)>poss) {
                    pos -= 1000;
                }else {
                    pos=poss;
                }
                $("#show3 ul").animate({left: pos}, 500);
            });

            $("#aleft").click(function () {
                var pos = $("#show3 ul").position().left;
                if ((pos+1000)<0) {
                    pos += 1000;
                }else {
                    pos=0;
                }
                $("#show3 ul").animate({left: pos}, 500);
            });
        });
    </script>
</head>
<body>
<div id="top">
    <div id="clubtribe"><img src="../img/title.png" alt="#"></div>
    <div id="topbtn">
        <a href="/">首页</a>
        <a href="${pageContext.request.contextPath}/user/toLogin" id="log">登录</a>
        <a href="#" id="username"></a>
        <a id="logout" href="${pageContext.request.contextPath}/user/logout" onclick="return false">退出</a>
    </div>
</div>
<div style="height: 36px;width: 100%;margin:0px auto;font-size: 24px;background: black;text-align: center;color: white">
    C L U B T R I B E
</div>
<div id="context">
    <div id="clubbg">
        <img id="img" src="#" alt="#">
        <div id="imgm"></div>
        <div id="title"></div>
        <div id="join">JOIN&nbspUS</div>
    </div>
    <div id="aboutus">
        <div id="btn">关 于 我 们> > ></div>
        <div id="data" style="width: 100%;height: 100%;overflow: auto"></div>
    </div>
    <div id="function">
        <div class="sign" id="fun1"><span>签到</span></div>
        <div id="fun2"><span>社团活动</span></div>
        <div id="fun3"><span>相册</span></div>
        <div id="fun4"><span>留言墙</span></div>
        <div id="fun5"><span>公告</span></div>
        <div id="fun6"><span>文件分享</span></div>
        <div><a id="admin" href="#" onclick="return false;"><span style="color: #8BD8BD">管理员操作</span></a>
        </div>
    </div>
</div>
<div id="bot">
    <div id="show1" style="height: 600px;width: 100%;">
        <div id="sign" style="float: left;width: 50%;height: 100%;overflow: hidden">
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
        <div id="msign" style="float: left;width: 50%;height: 100%;overflow: hidden">
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
    <div id="show2" style="height: 600px;width: 100%;">
        <div id="show2title" style="height: 80px;width: 100%;font-size: 24px">
            <div style="margin: 0 auto;width: 480px;height: 80px">
                <div id="show2sel1">社团活动</div>
                <div id="show2sel2">联合活动</div>
                <div id="creatNewActivity">创建活动</div>
            </div>
        </div>
        <div id="show2con" style="height: 520px;width: 100%;position: relative">
            <div id="s2c1">
                <ul>
                    <div style="height:100px;width: 300px;margin: 210px auto;line-height: 60px;font-size: 36px;text-align: center">
                        暂时没有活动
                    </div>
                </ul>
            </div>
            <div id="s2c2">
                <ul>
                    <div style="height:100px;width: 300px;margin: 210px auto;line-height: 60px;font-size: 36px;text-align: center">
                        暂时没有活动
                    </div>
                </ul>
            </div>
            <div id="s2c3">
                <div style="width: 100%;height: 50%;position: relative">
                    <div style="margin-bottom: 20px;margin-top:10px;width: 100%; height: 30px;">
                        <div style="font-size: 18px;width: 10%;height: 30px;line-height: 30px;text-align: center;float: left">
                            名称
                        </div>
                        <input id="aname" type="text"
                               style="font-size: 18px;width: 50%;height: 30px;line-height: 30px;float: left"
                               placeholder="活动名称（30子以内）" maxlength="30">
                    </div>
                    <div style="margin-bottom: 20px;width: 100%; height: 30px;">
                        <div style="font-size: 18px;width: 10%;height: 30px;line-height: 30px;text-align: center;float: left">
                            时间
                        </div>
                        <input id="begintime" type="date" value="2019-01-01"
                               style=" display:block;font-size: 18px;width: 200px;height: 30px;line-height: 30px;float: left"/>
                        <span style=" display:block;font-size: 18px;text-align:center;width: 2%;height: 30px;line-height: 30px;float: left">&nbsp至&nbsp</span>
                        <input id="endtime" type="date" value="2019-01-01"
                               style=" display:block;font-size: 18px;width: 200px;height: 30px;line-height: 30px;float: left"/>
                    </div>
                    <div style="margin-bottom: 20px;width: 100%; height: 30px;">
                        <div style="font-size: 18px;width: 10%;height: 30px;line-height: 30px;text-align: center;float: left">
                            地点
                        </div>
                        <input id="aplace" type="text"
                               style="font-size: 18px;width: 50%;height: 30px;line-height: 30px;float: left"
                               placeholder="举办活动地点">
                    </div>
                    <div style="margin-bottom: 20px;width: 100%; height: 30px;">
                        <div style="font-size: 18px;width: 10%;height: 30px;line-height: 30px;text-align: center;float: left">
                            类型
                        </div>
                        <select id="atype"
                                style=" display:block;font-size: 18px;width: 10%;height: 30px;line-height: 30px;float: left">
                            <option value="1">社团活动</option>
                            <option value="2">联合活动</option>
                        </select>
                    </div>
                    <span style="position: absolute;bottom: 0;left: 1%;font-size: 18px;">活动介绍</span>

                </div>
                <div style="width: 100%;height: 30%">
                    <textarea id="itrdc"
                              style="display: block;resize: none;height: 100%;width: 98%;font-size: 18px;margin:0 auto"
                              maxlength="500" placeholder="最多500字"></textarea>
                </div>
                <div style="width: 100%;height: 20%;position: relative"><span id="creatNewActivitysure"
                                                                              style="display: block;height: 30px;width: 100px;line-height: 30px;text-align: center;font-size: 18px;background: deepskyblue;position: absolute;right: 20px;top: 20px;cursor: pointer">创建活动</span>
                </div>
            </div>
        </div>
    </div>
    <div id="show3" style="height: 600px;width:100%;position: relative;overflow: hidden">
        <span id="aleft">◀</span>
        <span id="aright">▶</span>
        <ul style="height: 100%;position: absolute">
        </ul>
        <div style="height: 8%;width: 100%;position:absolute;bottom:0;background: black;">
            <span id="uploadpic"
                  style="color: white;display: block;position: absolute;bottom: 0;right: 10%;cursor: pointer;">上 传 图 片</span>
        </div>
        <div id="uploadbox"
             style="border: 1px solid #000000;display: none;position: absolute;bottom: 0;right: 20%;background: white">
            <div style="height: 100%;width: 100%">
                <form id="uploadform" enctype="multipart/form-data">
                    <input type="file" accept='image/*' multiple="multiple" name="file">
                    <input type="button" value="上传" id="uploadsure">
                </form>
            </div>
        </div>
    </div>
    <div id="show4" style="height: 600px;width: 100%;overflow: hidden">
        <input id="msgboard" type="text" placeholder="  Enter 发送留言">
    </div>
    <div id="show5" style="height: 600px;width: 100%;background:#F4F5F9;">
        <div id="context1" style="height: 85%;width: 100%;overflow: hidden">
            <ul>
            </ul>
        </div>
        <div>
            <input id="notice" type="text" placeholder="  Enter 发布公告">
        </div>
    </div>
    <div id="show6" style="height: 600px;width: 100%;background:#F4F5F9;">

        <div style="height: 10%;width: 100%;position: relative;background:#333;text-align: center;font-size: 20px;color: white;line-height:56px;font-weight: bold">
            文 件 目 录
            <span id="uploadfile"
                  style="color: white;display: block;font-size:36px;position: absolute;top:0px;right: 20px;cursor: pointer;"
                  title="上传新文件">＋</span>
            <div id="uploadfilebox"
                 style="display: none;position: absolute;top:0px;right: 60px;">
                <div style="height: 20px;width: 100%">
                    <form id="uploadfileform" enctype="multipart/form-data">
                        <input type="file" multiple="multiple" name="file">
                        <input type="button" value="上传" id="uploadfilesure">
                    </form>
                </div>
            </div>
        </div>
        <div id="show6con1" style="height: 90%;width: 100%;overflow: hidden">
            <ul>
            </ul>
        </div>
    </div>
</div>
<div style="height: 36px;width: 100%;margin:0px auto;font-size: 24px;background: black;text-align: center;color: white">
    C L U B T R I B E
</div>
<div style="height: 36px;width: 100%;margin:0px auto;font-size: 16px;background: black;text-align: center;color: white">
    @2019 ClubTribe Designer By MQ,CJN,TYC
</div>
</body>
</html>
