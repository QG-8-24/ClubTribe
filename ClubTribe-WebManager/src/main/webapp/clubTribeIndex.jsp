<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
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
            var map=getParamsByGet();
            var userid = '${userid}'
            var admin = '${admin}';
            var flag=1;
            var check=1;
            function init() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/search/init",
                    data: {
                        "userid": userid
                    },
                    success: function (resp) {
                        var username=resp;
                        if (username != "") {
                            $("#userlog").css({
                                "display": "none"
                            });
                            $("#adminlog").css({
                                "display": "none"
                            });
                            if (admin == ""||admin==null) {
                                $("#username").append(username);
                                $("#schoolapply").append('学校申请');
                                $("#clubapply").append('社团申请');
                            }else {
                                $("#admin").append(username);
                                $("#schoolcheck").append('校园认证');
                                $("#clubcheck").append('社团认证');
                            }
                            $("#quit").append('退出');
                        }
                    }
                })
            }


            init();
            $("#username").click(function () {
                $(window).attr('location', '${pageContext.request.contextPath}/search/myClub?userid=' + userid);
            });
            $("#schoolcheck").click(function () {
                $(window).attr('location', '${pageContext.request.contextPath}/clubtribeadmin/intoAdmin?userid=' + userid+ '&admin=' + admin);
            });
            $("#clubcheck").click(function () {
                $(window).attr('location', '${pageContext.request.contextPath}/clubtribeadmin/clubCheck?userid=' + userid+ '&admin=' + admin);
            });
            $("#schoolapply").click(function () {
                $(window).attr('location', '${pageContext.request.contextPath}/user/toCompusAccr?userid=' + userid+ '&admin=' + admin);
            });
            $("#clubapply").click(function () {
                $(window).attr('location', '${pageContext.request.contextPath}/user/toClubsaccr?userid=' + userid+ '&admin=' + admin);
            });
            function findFirstData() {
                $.getJSON("${pageContext.request.contextPath}/search/firstData", function (data) {
                    var school = data;
                    var res = "";
                    for (var i = 0; i < school.length; i++) {
                        if (i == 0) {
                            res += "<option>" + school[i].schoolAddress + "</option>";
                        }
                        else{
                            for (var j = 0; j <= i - 1; j++) {
                                if (school[j].schoolAddress == school[i].schoolAddress) {
                                    break;
                                } else {
                                    res += "<option>" + school[i].schoolAddress + "</option>";
                                    break;
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
                    $("#select2").append("<option value='null'>--请选择--</option>");
                    $("#select3").html("");
                    // $("#select3").empty();
                    $("#select3").append("<option value='null'>--请选择--</option>");
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
                    $("#select3").append("<option value='null'>--请选择--</option>");
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
                var select1=document.getElementById("select1").value;
                var select2=document.getElementById("select2").value;
                var select3=document.getElementById("select3").value;
                // alert(sel1);alert(sel2);alert(sel3);
                if (userid == undefined) {
                    userid='';
                }
                if (select1==="null"||select2==="null"||select3==="null") {
                    alert('请查看是否有未选择的选项');
                }else {
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
                    flag=0;
                }else {
                    $("#secondinfo").fadeOut(2000, function () {
                        $("#aboutimg").fadeIn(2000);
                    });
                    flag=1;
                }
            })
            $("#ourwork").click(function () {
                if (check == 1) {
                    $("#imginfo").fadeOut(2000, function () {
                        $("#workinfo").fadeIn(2000);
                    });
                    check=0;
                }else {
                    $("#workinfo").fadeOut(2000, function () {
                        $("#imginfo").fadeIn(2000);
                    });
                    check=1;
                }
            })
            $("#qq").click(function () {
                alert('qq:1023707811');
            })
            $("#open").click(function (){
                if($("#quitbox").css("display")=="none"){
                    $("#quitbox").show();
                }
            });
            /*关闭弹出框*/
            $("#gbaaa").click(function (){
                if($("#quitbox").css("display")=="block"){
                    $("#quitbox").hide();
                }
            });
            $("#quit").click(function () {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/logout",
                    success: function () {
                        alert("退出成功!");
                        window.location.reload();
                    }
                });
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
            <a href="#">首页</a>
            <a href="${pageContext.request.contextPath}/clubtribeadmin/toLogin" id="adminlog">管理员登录</a>
            <a href="${pageContext.request.contextPath}/user/toLogin" id="userlog">用户登录</a>
            <a href="#" id="username"></a>
            <a href="#" id="admin"></a>
            <a href="#" id="schoolcheck"></a>
            <a href="#" id="clubcheck"></a>
            <a href="#" id="schoolapply"></a>
            <a href="#" id="clubapply"></a>

            <a href="${pageContext.request.contextPath}/user/logout" id="quit" onclick="return false"></a>
        </div>
    </div>
    <div  class="no-js">
        <div class="banner">
            <div style="height: 36px;width: 100%;margin:0px auto;font-size: 24px;background: black;text-align: center;color: white">
                C L U B T R I B E
            </div>
            <img src="../img/back.jpg" alt="#">
            <%--<div id="secondbtn">--%>
                <%--查找个人社团--%>
            <%--</div>--%>
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
            <div id="workinfo">
                ClubTribe的工作是使社团高效管理<br>
                跨校的社团活动建设平台<br>
                将不同社团不同高校的资源整合<br>
                建立合理的权限分配机制<br>
            </div>
            <div id="imginfo">
                <img src="../img/ourwork.jpg" alt="#" id="ourworkimg">
                <div id="our">OUR</div>
                <div id="work">WORK</div>
            </div>

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
    function getParamsByGet(){
        var map=new Map();
        var paramsStr=location.search.split('?')[1];
        var paramsArr=(paramsStr||"").split('&');
        $.each(paramsArr,function (index,item) {
            var itemArr=item.split("=");
            map.set(itemArr[0],itemArr[1]);
        });
        return map;
    }
</script>
