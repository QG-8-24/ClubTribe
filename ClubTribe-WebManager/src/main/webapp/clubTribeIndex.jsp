<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/clubTribeIndexStyle_CJN.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- CSS -->
    <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'>
    <link rel="stylesheet" href="../assets/css/reset.css">
    <link rel="stylesheet" href="../assets/css/supersized.css">
    <link rel="stylesheet" href="../assets/css/style.css">
    <script src="../assets/js/jquery-1.8.2.min.js"></script>
    <script src="../assets/js/supersized.3.2.7.min.js"></script>
    <script src="../assets/js/supersized-init.js"></script>
    <script src="../assets/js/scripts.js"></script>
    <script>
        $(function () {
            var map = getParamsByGet();
            var userid = '${userid}'
            var flag = 1;
            var check = 1

            function init() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/search/init",
                    data: {
                        "userid": userid
                    },
                    success: function (resp) {
                        var username = resp;
                        if (username != "") {
                            $("#log").css({
                                "display": "none"
                            });
                            $("#username").append(username);
                        }
                    }
                })
            }

            init();

            function searchMyClub() {
                $(window).attr('location', '${pageContext.request.contextPath}/search/myClub?userid=' + userid);
            };
            $("#secondbtn").click(function () {
                if (userid == "") {
                    alert('请先登录');
                } else {
                    searchMyClub();
                }
            });

            function findFirstData() {
                $.getJSON("${pageContext.request.contextPath}/search/firstData", function (data) {
                    var school = data;
                    var res = "";
                    for (var i = 0; i < school.length; i++) {
                        if (i == 0) {
                            res += "<option>" + school[i].schoolAddress + "</option>";
                        } else {
                            for (var j = 0; j <= i - 1; j++) {
                                if (school[j].schoolAddress == school[i].schoolAddress) {
                                    break;
                                } else {
                                    res += "<option>" + school[i].schoolAddress + "</option>";
                                }
                            }
                        }

                    }
                    $("#select1").append(res);
                });
            }

            findFirstData();
            $("#select1").change(function () {
                var seled = $("#select1 option:selected").val();
                $.getJSON("${pageContext.request.contextPath}/search/secondData?SchoolAddress=" + seled, function (data) {
                    $("#select2").html("");
                    // $("#select2").empty();
                    $("#select2").append("<option>--请选择--</option>");
                    $("#select3").html("");
                    // $("#select3").empty();
                    $("#select3").append("<option>--请选择--</option>");
                    var school = data;
                    var res = "";
                    for (var i = 0; i < school.length; i++) {
                        res += "<option>" + school[i].schoolname + "</option>";
                    }
                    $("#select2").append(res);
                });
            });
            $("#select2").change(function () {
                var seled = $("#select2 option:selected").val();
                $.getJSON("${pageContext.request.contextPath}/search/thirdData?Schoolname=" + seled, function (data) {
                    $("#select3").html("");
                    // $("#select3").empty();
                    $("#select3").append("<option>--请选择--</option>");
                    var club = data;
                    var res = "";
                    for (var i = 0; i < club.length; i++) {
                        res += "<option>" + club[i].clubname + "</option>";
                    }
                    $("#select3").append(res);
                });
            });
            $("#searchClub").click(function () {
                var sel1 = $("#select1 option:selected").val();
                var sel2 = $("#select2 option:selected").val();
                var sel3 = $("#select3 option:selected").val();
                if (sel1 == "--请选择--" || sel3 == "--请选择--" || sel2 == "--请选择--") {
                    alert('请查看是否有未选择的选项');
                } else {
                    $.getJSON("${pageContext.request.contextPath}/search/searchClubByName?Clubname=" + sel3, function (data) {
                        var club = data;
                        var res = "";
                        for (var i = 0; i < club.length; i++) {
                            res += "uid:" + userid + ",cid:" + club[i].clubid;
                            alert(res);
                            $(window).attr('location', '${pageContext.request.contextPath}/user/clubhome?clubid=' + club[i].clubid);
                        }
                    });
                }
            });
            $("#footer").click(function () {
                if (flag == 1) {
                    $("#aboutimg").fadeOut(2000, function () {
                        $("#secondinfo").fadeIn(2000);
                    });
                    flag = 0;
                } else {
                    $("#secondinfo").fadeOut(2000, function () {
                        $("#aboutimg").fadeIn(2000);
                    });
                    flag = 1;
                }
            })
            $("#ourwork").click(function () {
                if (check == 1) {
                    $("#ourworkimg #our #work").fadeOut(2000, function () {
                        $("#workinfo").fadeIn(2000);
                    });
                    check = 0;
                } else {
                    $("#workinfo").fadeOut(2000, function () {
                        $("#ourworkimg #our #work").fadeIn(2000);
                    });
                    check = 1;
                }
            });
            //logout
            $("#logout").click(function () {
                if (userid.length == 0) {
                    alert("请先登录!");
                } else {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/user/logout",
                        success: function () {
                            alert("退出成功!");
                            window.location.reload();
                        }
                    });
                }

            });
        })
    </script>
</head>
<body>
<div>
    <div class="top">

        <%--<div><img src="../img/title.png"></div>--%>
        <div id="indextitle">
            ClubTribe
        </div>
        <div id="topbtn">
            <a href="/">首页</a>
            <a href="${pageContext.request.contextPath}/user/toLogin" id="log">登录</a>
            <a href="#" id="username"></a>
            <a id="logout" href="${pageContext.request.contextPath}/user/logout" onclick="return false">退出</a>
        </div>
    </div>
    <div class="no-js">
        <div class="banner">
            <div style="height: 36px;width: 100%;margin:0px auto;font-size: 24px;background: black;text-align: center;color: white">
                C L U B T R I B E
            </div>
            <img src="../img/back.jpg" alt="#">
            <div id="secondbtn">
                查找个人社团
            </div>
        </div>
        <div class="mid">
            <img src="../img/search.gif" alt="#">
            <div id="Dselect1">
                地区:<select style="width: 100px" id="select1">
                <option value="null">--请选择--</option>
            </select>
            </div>
            <div id="Dselect2">
                学校:<select style="width: 100px" id="select2">
                <option value="null">--请选择--</option>
            </select>
            </div>
            <div id="Dselect3">
                社团:<select style="width: 100px" id="select3">
                <option value="null">--请选择--</option>
            </select>
            </div>
            <div id="searchClub">
                查找社团
            </div>
        </div>
        <div class="footer" id="footer">
            <div id="firstinfo">
                <img src="../img/about.jpg" alt="#" id="aboutimg">
            </div>
            <div id="secondinfo">
                ClubTribe的目的是使社团管理更加便捷高效；提高社团成员的主观能动性,使社团管理更加便捷高效
                通过网络平台使社团活动打破条件限制进行跨校跨区域的社团活动,提高社团成员的主观能动性
                通过提供诸如英语等多种语言的支持，这个平台也可以作为国内普通高校与国外院校的交流的工具。
            </div>
        </div>
        <div class="ourwork" id="ourwork">
            <img src="../img/ourwork.jpg" alt="#" id="ourworkimg">
            <div id="workinfo">
                ClubTribe的工作是使社团高效管理
                跨校的社团活动建设平台
                将不同社团不同高校的资源整合，
                建立合理的权限分配机制
            </div>
            <div id="our">OUR</div>
            <div id="work">WORK</div>
        </div>
        <div class="tail" id="tail">
            <div id="lookus">
                关注我们
                <a href="#" id="qq">QQ</a>
            </div>
            <div id="Designer">
                @2019 ClubTribe Designer By MQ,CJN,TYC
            </div>
        </div>
    </div>

</div>


</body>
</html>
<script>
    //获取get请求参数封装成一个map集合
    function getParamsByGet() {
        var map = new Map();
        var paramsStr = location.search.split('?')[1];
        if (paramsStr != undefined) {
            var paramsArr = paramsStr.split('&');
            $.each(paramsArr, function (index, item) {
                var itemArr = item.split("=");
                map.set(itemArr[0], itemArr[1]);
            })
            return map;
        }
        return map;
    }
</script>
