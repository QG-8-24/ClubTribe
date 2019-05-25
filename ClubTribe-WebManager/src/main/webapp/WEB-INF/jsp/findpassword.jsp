<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<HTML>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <title>找回账号密码</title>
    <script type="application/javascript" src="../../js/jquery-3.3.1.min.js"></script>
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css" />
  <link rel="stylesheet" href="../bootstrap/css/font-awesome.min.css">
  <link rel="stylesheet" href="../dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="../bootstrap/css/all-skins.min.css">
  <link rel="stylesheet" href="../bootstrap/css/main.css">
</head>
<body class="hold-transition login-page">
<div class="login-box" id="rrapp">
  <div class="login-box-body">
      <p class="login-box-msg"><b>找回账号密码</b></p>
       <div class="alert alert-danger alert-dismissible" style="display:none">
        <h4 style="margin-bottom: 0px;"><i class="fa fa-exclamation-triangle" id="errorMessage"></i></h4>
      </div>
      <div class="form-group has-feedback">
          <input type="text" class="form-control" id="username" placeholder="登录名">
          <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
          <input type="text" class="form-control" id="mailbox" placeholder="邮箱地址">
          <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
      </div>
      <div class="form-group">
          <input type="text" class="" id="vcode" placeholder="验证码">
          <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
      </div>
      <div class="form-group">
          <button type="button" id="btn-mailbox" class="btn btn-success">send</button>
          <span class="glyphicon"></span>
      </div>
      <div class="row">
        <div class="col-xs-12">
          <button type="button" class="btn btn-success btn-block btn-flat" id="btn-password" disabled="disabled">立即找回</button>
        </div>
      </div>
</div>
</div>
</body>
</HTML>

<script type="text/javascript">
$(document).ready(function(){
	//回车按钮
	$(document).keyup(function(event) {
		if (event.keyCode == 13) {
			$("#btn-password").trigger("click");
		}
	});
	//点击登录按钮
    $('#btn-mailbox').click(sendCode);
	$('#btn-password').click(findPassword);
})
function sendCode() {
    var userName = $('#username').val();
    var useremail = $('#mailbox').val();
    var errorMessage=$('#errorMessage');
    var btnpassword=$('#btn-password');
    if(userName=='')
    {
        errorMessage.parent().parent().css('display','block');
        errorMessage.text('用户名不能为空！');
        return false;
    }
    if(useremail=='')
    {
        errorMessage.parent().parent().css('display','block');
        errorMessage.text('邮箱不能为空！');
        return false;
    }
    errorMessage.parent().parent().css('display','none');
    var url="${pageContext.request.contextPath}/user/VMailBox";
    var param={"useremail":useremail};
    $.post(url,param,function (code)
    {
        alert("验证码："+code);
        btnpassword.removeAttr("disabled");
    });
}
function findPassword(){
	var userName = $('#username').val();
	var mailbox = $('#mailbox').val();
	alert(mailbox);
	if(userName==''){
		$('#errorMessage').parent().parent().css('display','block');
		$('#errorMessage').text('登录名不能为空！');
		return false;
	}
	if(mailbox ==''){
		$('#errorMessage').parent().parent().css('display','block');
		$('#errorMessage').text('邮箱地址不能为空！');
		return false;
	}
    errorMessage.parent().parent().css('display','none');
	var url = '${pageContext.request.contextPath}/user/userFindPassword';
	var params = {'username':userName,'useremail':mailbox};
	$.post(url,params,function(result){
		if(result == "true"){
			location.href='${pageContext.request.contextPath}/user/toLogin';
		}else{
			$('#errorMessage').parent().parent().css('display','block');
			$('#errorMessage').text("请检查您输入的用户名!");
		}
	})
}
</script>
