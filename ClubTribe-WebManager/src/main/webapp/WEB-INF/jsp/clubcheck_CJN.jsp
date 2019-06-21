<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ClubTribe社团认证界面</title>
    <link rel="stylesheet" type="text/css" href="../css/clubTribeAdminStyle_CJN.css">
    <script type="text/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            function init() {
                $.getJSON("${pageContext.request.contextPath}/clubtribeadmin/getclub",function (data) {
                    $.each(data,function (i, item) {
                        var clubList=item.split("@");
                        var clubname=clubList[0];
                        var schoolname=clubList[1];
                        var applyman=clubList[2];
                        var photopath=clubList[3];
                        var agree='认证';
                        var reject='拒绝';
                        var agreeid = 'agree' + i;
                        var rejectid = 'reject' + i;
                        var check='查看图片';
                        var photoid='photo'+i;
                        var res = "";
                        res+="<tr>";
                        res += "<td>" + clubname + "</td>";
                        res += "<td>" + schoolname + "</td>";
                        res += "<td>" + applyman + "</td>";
                        res += "<td><a id='"+photoid+"'>" + check + "</a></td>";
                        // res += "<td><a id='"+"agree_"+i+"'>" + agree + "</a></td>";
                        res += "<td><a id='"+agreeid+"'>" + agree + "</a></td>";
                        res += "<td><a id='"+rejectid+"'>" + reject + "</a></td>";
                        res+="</tr>";
                        $("#" + agreeid + "").attr("href","${pageContext.request.contextPath}/clubtribeadmin/clubagree?clubname="+clubname+"&schoolname="+schoolname+"&applyman="+applyman+"&username=${username}&userid=${userid}&admin=${admin}");
                        $("#" + rejectid + "").attr("href","${pageContext.request.contextPath}/clubtribeadmin/clubreject?clubname="+clubname+"&schoolname="+schoolname+"&applyman="+applyman+"&username=${username}&userid=${userid}&admin=${admin}");
                        $("#" + photoid + "").attr("href",photopath);
                        $("#info").append(res);
                        $("#" + photoid + "").click(function () {
                            if(confirm("查看图片吗")){
                                $(this).attr("href",photopath);
                                return true;
                            }
                            return false;
                        })
                        $("#" + agreeid + "").click(function () {
                            if(confirm("确定认证吗")){
                                $(this).attr("href","${pageContext.request.contextPath}/clubtribeadmin/clubagree?clubname="+clubname+"&schoolname="+schoolname+"&applyman="+applyman+"&username=${username}&userid=${userid}&admin=${admin}");
                                alert("认证成功");
                                init();
                                return true;
                            }
                            return false;
                        })
                        $("#" + rejectid + "").click(function () {
                            if(confirm("确定拒绝吗")){
                                $(this).attr("href","${pageContext.request.contextPath}/clubtribeadmin/clubreject?clubname="+clubname+"&schoolname="+schoolname+"&applyman="+applyman+"&username=${username}&userid=${userid}&admin=${admin}");
                                alert("已拒绝");
                                init();
                                return true;
                            }
                            return false;
                        })
                    });
                })
            }


            init();
        })


    </script>
    <script type="text/javascript">
        function altRows(id){
            if(document.getElementsByTagName){
                var table = document.getElementById(id);
                var rows = table.getElementsByTagName("tr");
                for(i = 0; i < rows.length; i++){
                    if(i % 2 == 0){
                        rows[i].className = "evenrowcolor";
                    }else{
                        rows[i].className = "oddrowcolor";
                    }
                }
            }
        }
        window.onload=function(){
            altRows('alternatecolor');
        }
    </script>
    <!-- CSS goes in the document HEAD or added to your external stylesheet -->
    <link rel="stylesheet" type="text/css" href="../css/myClub_CJN.css">
    <script>
        $(function () {
        })
    </script>
</head>
<body>
<div class="top">
    <%--<div><img src="../img/title.png"></div>--%>
    <div id="indextitle">
        ClubTribe
    </div>
    <div id="topbtn">
        <a href="${pageContext.request.contextPath}/clubTribeIndex.jsp?userid=${userid}&admin=${admin}">首页</a>
        <%--<a href="#" id="log">登录</a>--%>
        <a href="#" id="username">${username}</a>
    </div>
</div>
<div class="banner">
    <div>
        <table class="altrowstable" id="alternatecolor">
            <thead>
            <tr>
                <th colspan="6"><h2>社团认证申请列表</h2></th>
            </tr>
            <tr>
                <th>社团名</th>
                <th>入驻学校</th>
                <th>申请人id</th>
                <th>图片</th>
                <th colspan="2">操作</th>
            </tr>
            </thead>
            <tbody id="info">


            </tbody>
        </table>
    </div>
</div>
</body>
</html>
