<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<HTML>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>clubtribe管理员登录</title>
    <script type="application/javascript" src="../js/jquery-3.3.1.min.js"></script>
    <script type="application/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../bootstrap/css/font-awesome.min.css">
    <link rel="stylesheet" href="../dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="../bootstrap/css/all-skins.min.css">
    <link rel="stylesheet" href="../bootstrap/css/main.css">
</head>
<body class="hold-transition login-page">
<div class="login-box" id="rrapp">
    <div class="login-box-body">
        <p class="login-box-msg"><b>管理员登录</b></p>
        <div class="alert alert-danger alert-dismissible" style="display:none">
            <h4 style="margin-bottom: 0px;"><i class="fa fa-exclamation-triangle" id="errorMessage"></i></h4>
        </div>
        <div class="form-group has-feedback">
            <input type="text" class="form-control" id="username" placeholder="账号/ID">
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <input type="password" class="form-control" id="userpwd" placeholder="密码">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <button type="button" class="btn btn-primary btn-block btn-flat" id="btn-login">登录</button>
            </div>
        </div>
    </div>

</div>
</body>
</HTML>

<script type="text/javascript">
    $(document).ready(function () {
        //回车按钮
        $(document).keyup(function (event) {
            if (event.keyCode == 13) {
                //触发btn-login绑定的submit事件
                $("#btn-login").trigger("click");
            }
        });
        //点击登录按钮
        $('#btn-login').click(doLogin);
    })

    function doLogin() {
        var userName = $('#username').val().trim();
        var userPwd = $('#userpwd').val().trim();
        var errorMessage = $('#errorMessage');
        if (userName == '') {
            $('#errorMessage').parent().parent().css('display', 'block');
            $('#errorMessage').text('用户名不能为空！');
            return false;
        }
        if (userPwd == '') {
            $('#errorMessage').parent().parent().css('display', 'block');
            $('#errorMessage').text('密码不能为空！');
            return false;
        }
        errorMessage.parent().parent().css('display', 'none');
        //判断此用户是否存在于数据库中
        $.ajax({
            url: '${pageContext.request.contextPath}/clubtribeadmin/adminLogin',
            data: {
                "username": userName,
                "password": userPwd,
            },
            // type:'post',
            // async:true,
            success: function (result) {

                if ($.trim(result) == "false") {
                    $('#errorMessage').parent().parent().css('display', 'block');
                    $('#errorMessage').text('管理员不存在或密码错误！');
                } else {
                    var str = result.split("@");
                    var username = str[0];
                    var admin = str[1];
                    location.href = "${pageContext.request.contextPath}/clubTribeIndex.jsp?userid=" + username + '&admin=' + admin;
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest);
                alert(textStatus);
                $('#errorMessage').parent().parent().css('display', 'block');
                $('#errorMessage').text('系统错误！');
            }
        });
    }
</script>
