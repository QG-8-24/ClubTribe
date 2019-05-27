<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<HTML>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>clubtribe用户登录</title>
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
        <p class="login-box-msg"><b>clubtribe 用户登录</b></p>
        <div class="alert alert-danger alert-dismissible" style="display:none">
            <h4 style="margin-bottom: 0px;"><i class="fa fa-exclamation-triangle" id="errorMessage"></i></h4>
        </div>
        <div class="form-group has-feedback">
            <input type="text" class="form-control" id="username" placeholder="账号">
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
    <div class="login-page">
        <a href="${pageContext.request.contextPath}/user/toPassword" class="attachment-img">忘记密码>></a>
        &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
        &nbsp&nbsp
        <a href="${pageContext.request.contextPath}/user/toRegister" class="attachment-img">注册？成为新用户>></a>
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
        var userName = $('#username').val();
        var userPwd = $('#userpwd').val();
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
            url: '${pageContext.request.contextPath}/user/userLogin',
            data: {
                "username": userName,
                "password": userPwd,
            },
            success: function (resp) {
                console.log(resp);
                if (resp ==true) {
                    location.href = "${pageContext.request.contextPath}/clubTribeIndex.jsp?userid=111111111";
                } else {
                    alert("密码错误！");
                }
            }
        });
    }
</script>
