<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<HTML>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <title>clubtribe用户注册页面</title>
    <script type="application/javascript" src="../../js/jquery-3.3.1.min.js"></script>
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css" />
  <link rel="stylesheet" href="../bootstrap/css/font-awesome.min.css">
  <link rel="stylesheet" href="../dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="../bootstrap/css/all-skins.min.css">
  <link rel="stylesheet" href="../bootstrap/css/main.css">
</head>
<body class="hold-transition register-page">
<div class="register-box" id="rrapp">
  <div class="register-box-body">

   <form action="">
      <p class="register-box-msg"><b>clubtribe 用户注册</b></p>
       <div class="alert alert-danger alert-dismissible" style="display:none">
        <h4 style="margin-bottom: 0px;"><i class="fa fa-exclamation-triangle" id="errorMessage"></i></h4>
      </div>
      <div class="form-group has-feedback">
          <input type="text" class="form-control" id="username" placeholder="用户名">
          <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
       <div class="form-group has-feedback">
           <input type="text" class="form-control" id="useremail" placeholder="用户邮箱">
           <span class="glyphicon glyphicon-pencil form-control-feedback"></span>
       </div>
      <div class="form-group has-feedback">
          <input type="password" class="form-control" id="userpwd" placeholder="设置密码">
          <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
       <div class="form-group has-feedback">
           <input type="password" class="form-control" id="userpwd2" placeholder="确认密码">
           <span class="glyphicon glyphicon-lock form-control-feedback"></span>
       </div>
       <div class="form-group has-feedback">
           <input type="text" class="form-control" id="vcode" placeholder="验证码">
           <span class="glyphicon glyphicon-pencil form-control-feedback"></span>

       </div>
       <div class="form-group">
           <button type="button" id="btn-mailbox-validation" class="btn btn-primary">send</button>
           <span class="glyphicon"></span>
       </div>
       <div class="row">
           <div class="col-xs-12">
               <button type="button" class="btn btn-primary btn-block btn-flat" id="btn-register" >注册</button>
           </div>
       </div>
      </form>
  </div>
</div>
</body>
</HTML>

<script type="text/javascript">
$(document).ready(function(){
	//回车按钮
	$(document).keyup(function(event) {
		if (event.keyCode == 13) {
			//触发btn-login绑定的submit事件
			$("#btn-login").trigger("click");
		}
	});
	//点击注册按钮
    $('#btn-mailbox-validation').click(sendCode);
    $('#btn-register').click(doRegister);

})
function sendCode()
{
    var useremail = $('#useremail').val();
    var errorMessage=$('#errorMessage');
    if(useremail=='')
    {
        errorMessage.parent().parent().css('display','block');
        errorMessage.text('邮箱不能为空！');
        return false;
    }
    var url="${pageContext.request.contextPath}/user/VMailBox";
    var param={"useremail":useremail};
    $.post(url,param,function (code)
    {
        alert("验证码："+code);
    });
}
function doRegister()
{
    var userName = $('#username').val();
    var useremail = $('#useremail').val();
    var userPwd = $('#userpwd').val();
    //获取第二次输入的确认密码
    var userPwd2 = $('#userpwd2').val();
    //邮箱获取的验证码，可以设置失效时间？？
    var vcode=$('#vcode').val();
    var errorMessage=$('#errorMessage');


    if(userName==''){
        errorMessage.parent().parent().css('display','block');
        errorMessage.text('用户名不能为空！');
        return false;
    }
    if(useremail==''){
        errorMessage.parent().parent().css('display','block');
        errorMessage.text('邮箱不能为空！');
        return false;
    }
    if(userPwd==''){
        errorMessage.parent().parent().css('display','block');
        errorMessage.text('密码不能为空！');
        return false;
    }
    if(userPwd2==''){
        errorMessage.parent().parent().css('display','block');
        errorMessage.text('请确认密码！');
        return false;
    }
    if(vcode==''){
        errorMessage.parent().parent().css('display','block');
        errorMessage.text('请填写验证码!');
        return false;
    }
    if(userPwd==userPwd2)
    {
        alert("vcode:"+vcode);
        alert("密码已确认！");
        var url = '${pageContext.request.contextPath}/user/userRegister';
        var params = {'username':userName,'useremail':useremail,'password':userPwd,"vcodeWritted":vcode};
        $.post(url,params,function(result)
        {
            alert(result);
            if(result == "true")
            {   //用户校验成功，跳转到登录页面
                alert("注册成功！")
                location.href='${pageContext.request.contextPath}/user/toLogin';
            }else
            {
                errorMessage.parent().parent().css('display','block');
                errorMessage.text("失败!");
            }
            })
    }
    else
    {
        errorMessage.parent().parent().css("display","block");
        errorMessage.text("请确认密码！");
    }
}
</script>
