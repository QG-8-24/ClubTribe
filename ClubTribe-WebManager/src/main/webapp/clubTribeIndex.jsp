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

        .banner #firstbtn a {
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
            top: 20%;
            left: 20%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
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
            top: 20%;
            left: 60%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .banner #Dselect1 {
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
            top: 5%;
            left: 5%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .banner #Dselect1 select {
            background: none;
            font-size: 15px;
        }

        .banner #Dselect2 {
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
            top: 5%;
            left: 25%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .banner #Dselect2 select {
            background: none;
            font-size: 15px;
        }

        .banner #Dselect3 {
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
            top: 5%;
            left: 45%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .banner #Dselect3 select {
            background: none;
            font-size: 15px;
        }

        .banner #searchClub {
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
            top: 5%;
            left: 65%;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: inline-block;
        }

        .main {
            width: 80%;
            height: 600px;
            margin: 10px auto;
            background-color: skyblue;
            border-radius: 10px;
            position: relative;
        }

        .footer {
            height: 300px;
            background-color: black;
            position: relative;
        }
    </style>
    <script>
        $(function () {
            var userid = '222222222';
            var FirstData = null;

            function searchMyClub() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/search/myClub",
                    data: {
                        "userid": userid
                    },
                    success: function (resp) {
                        $(window).attr('location', '${pageContext.request.contextPath}/jsp/myclub_CJN.jsp');
                    }
                })
            };
            $("#secondbtn").click(function () {
                searchMyClub();
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
                var seled = $("#select3 option:selected").val();
                $.getJSON("${pageContext.request.contextPath}/search/searchClubByName?Clubname=" + seled, function (data) {
                    // $("#select2").html("");
                    var club = data;
                    var res = "";
                    for (var i = 0; i < club.length; i++) {
                        res += "uid:" + userid + ",cid:" + club[i].clubid;
                        alert(res);
                        $(window).attr('location', '${pageContext.request.contextPath}/user/clubhome?userid=' + userid + '&clubid=' + club[i].clubid);
                    }

                });
            });
        })
    </script>
</head>
<body>
<div>
    <div class="top">
        <div><img src="img/title.png"></div>
        <div id="topbtn">
            <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
            <a href="#" id="log">登录</a>
            <a href="#" id="username"></a>
        </div>
    </div>
    <div class="banner">
        <img src="img/back.jpg" alt="#">
        <div id="firstbtn">
            <a href="/search/allClub">查找所有社团</a>
        </div>
        <div id="secondbtn">
            查找个人社团
        </div>
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

</div>
<div class="main">

</div>
<div class="footer"></div>
</div>

</body>
</html>
