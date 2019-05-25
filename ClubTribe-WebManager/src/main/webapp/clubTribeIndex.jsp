<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
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

        .banner {
            height: 600px;
            width: 80%;
            margin: 10px auto;
            background-color: skyblue;
            border-radius: 10px;
            position: relative;

        }

        .banner img {
            text-align: center;
            display: block;
            height: 100%;
            width: 100%;
            border-radius: 10px;
            position: absolute;
        }

        .banner #secondbtn {
            height: 60px;
            width: 200px;
            border: 6px solid skyblue;
            text-align: center;
            line-height: 60px;
            -webkit-border-radius: 50px;
            border-radius: 50px;
            font-size: 24px;
            cursor: pointer;
            position: absolute;
            top: 40%;
            left: 70%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .mid #Dselect1 {
            height: 60px;
            width: 200px;
            border: 6px solid skyblue;
            text-align: center;
            line-height: 60px;
            -webkit-border-radius: 50px;
            border-radius: 50px;
            font-size: 24px;
            cursor: pointer;
            position: absolute;
            top: 10%;
            left: 10%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .mid #Dselect1 select {
            background: none;
            font-size: 15px;
        }

        .mid #Dselect2 {
            height: 60px;
            width: 200px;
            border: 6px solid skyblue;
            text-align: center;
            line-height: 60px;
            -webkit-border-radius: 50px;
            border-radius: 50px;
            font-size: 24px;
            cursor: pointer;
            position: absolute;
            top: 10%;
            left: 30%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .mid #Dselect2 select {
            background: none;
            font-size: 15px;
        }

        .mid #Dselect3 {
            height: 60px;
            width: 200px;
            border: 6px solid skyblue;
            text-align: center;
            line-height: 60px;
            -webkit-border-radius: 50px;
            border-radius: 50px;
            font-size: 24px;
            cursor: pointer;
            position: absolute;
            top: 10%;
            left: 50%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .mid #Dselect3 select {
            background: none;
            font-size: 15px;
        }

        .mid #searchClub {
            height: 60px;
            width: 200px;
            border: 6px solid skyblue;
            text-align: center;
            line-height: 60px;
            -webkit-border-radius: 50px;
            border-radius: 50px;
            font-size: 24px;
            cursor: pointer;
            position: absolute;
            top: 10%;
            left: 70%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }
        .mid {
            height: 100px;
            width: 80%;
            margin: 10px auto;
            background-color: skyblue;
            border-radius: 10px;
            position: relative;
            /*background:url("../img/search.gif") no-repeat;*/
            /*background-size:100% 100%;*/
        }
        .mid img {
            text-align: center;
            display: block;
            height: 100%;
            width: 100%;
            border-radius: 10px;
            position: absolute;
        }
        .main {
            width: 80%;
            height: 200px;
            margin: 10px auto;
            background-color: skyblue;
            border-radius: 10px;
            position: relative;
        }
        .main img {
            text-align: center;
            display: block;
            height: 100%;
            width: 100%;
            border-radius: 10px;
            position: absolute;
        }
        .footer {
            height: 300px;
            width: 100%;
            position: relative;
            background:url("../img/footer.jpg") no-repeat;
            background-size: 100%;
        }
        .footer #firstinfo{
            height: 300px;
            text-align: center;
            line-height: 300px;
            font-weight: bold;
            display: inline-block;
            color: white;
            font-size: 24px;
            float: left;
            margin-left: 45%;
        }
        .footer #secondinfo{
            display: none;
            text-align: center;
            line-height: 60px;
            font-weight: bold;
            color: white;
            font-size: 24px;
            margin: 0 100px;
            position: absolute;
        }
    </style>
    <script>
        $(function () {
            var userid = '222222222';
            var flag=1;
            function init() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/search/init",
                    data: {
                        "userid": userid
                    },
                    success: function (resp) {
                        var username=resp;
                        if (username != 'null') {
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
                if (userid == null) {
                    alert('请先登录');
                }else {
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
                        }
                        for (var j = 0; j <= i - 1; j++) {
                            if (school[j].schoolAddress == school[i].schoolAddress) {

                            } else {
                                res += "<option>" + school[i].schoolAddress + "</option>";
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
                    // $("#select2").html("");
                    $("#select2").empty();
                    $("#select2").append("<option>--请选择--</option>");
                    $("#select3").empty();
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
                    // $("#select3").html("");
                    $("#select3").empty();
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
                var sel1=$("#select1 option:selected").val();
                var sel2=$("#select2 option:selected").val();
                var sel3=$("#select3 option:selected").val();
                if (sel1==null||sel3==null||sel2==null) {
                    alert('请查看是否有未选择的选项');
                }else {
                    $.getJSON("${pageContext.request.contextPath}/search/searchClubByName?Clubname=" + sel3, function (data) {
                        var club = data;
                        var res = "";
                        for (var i = 0; i < club.length; i++) {
                            res += "uid:" + userid + ",cid:" + club[i].clubid;
                            alert(res);
                            $(window).attr('location', '${pageContext.request.contextPath}/user/clubhome?userid=' + userid + '&clubid=' + club[i].clubid);
                        }
                    });
                }
            });
            $("#mainimg").click(function () {

                if (flag == 1) {
                    $("#firstinfo").fadeOut(2000, function () {
                        $("#secondinfo").fadeIn(2000);
                    });
                    flag=0;
                }else {
                    $("#secondinfo").fadeOut(2000, function () {
                        $("#firstinfo").fadeIn(2000);
                    });
                    flag=1;
                }
            })
        })
    </script>
</head>
<body>
<div>
    <div class="top">
        <div><img src="../img/title.png"></div>
        <div id="topbtn">
            <a href="/">首页</a>
            <a href="#" id="log">登录</a>
            <a href="#" id="username"></a>
        </div>
    </div>
    <div class="banner">
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
    <div class="main" id="main">
        <img src="../img/about.jpg" alt="#" id="mainimg">
    </div>
    <div class="footer">
        <div id="firstinfo">
            关于我们
        </div>
        <div id="secondinfo">
            我们的目的是使社团管理更加便捷高效；提高社团成员的主观能动性；
            通过网络平台使社团活动打破条件限制进行跨校跨区域的社团活动；
            通过提供诸如英语等多种语言的支持，这个平台也可以作为国内普通高校与国外院校的交流的工具。
            我们的目的是使社团管理更加便捷高效；提高社团成员的主观能动性；
            通过网络平台使社团活动打破条件限制进行跨校跨区域的社团活动；
            通过提供诸如英语等多种语言的支持，这个平台也可以作为国内普通高校与国外院校的交流的工具。
        </div>
    </div>
</div>


</body>
</html>
