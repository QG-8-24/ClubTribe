<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<HTML>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <title>校园认证</title>
    <script type="application/javascript" src="../../js/jquery-3.3.1.min.js"></script>
    <script src="../../bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../bootstrap/css/font-awesome.min.css">
    <link rel="stylesheet" href="../dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="../bootstrap/css/all-skins.min.css">
    <link rel="stylesheet" href="../bootstrap/css/main.css">
</head>
<body >
<div class="container header ">
    <div class="text-center"><h1>校园认证</h1></div>
    <div class="alert alert-danger alert-dismissible" style="display:none">
        <h4 style="margin-bottom: 0px;"><i class="fa fa-exclamation-triangle" id="errorMessage"></i></h4>
    </div>
    <div class="text-right"><small>暂时不要认证？<a href="../../clubTribeIndex.jsp">返回上一级</a></small></div>
    <div class="form-group">
        <label>学校名称</label>
        <input type="text" class="form-control" id="schoolname">
    </div>
    <div class="form-group">
        <label>学校地址</label>
        <input type="text" class="form-control" id="schooladress">
    </div>
    <input id="lefile" type="file" style="display:none">
    <div class="input-append">
        <input id="photoCover" class="input-large" type="text" style="height:30px;">
        <a class="btn" onclick="$('input[id=lefile]').click();">Browse</a>
    </div>
    <div class="form-group">
        <button class="btn btn-primary btn-block" id="idenify">认证</button>
    </div>
</div>

</body>
</HTML>
<script type="text/javascript">
    $(document).ready(
            function () {
                $(document).keyup(
                    function (event) {
                        if(event.keyCode==13){
                            $('#idenify').trigger("click");
                        }
                    }
                )
                $('#idenify').click(doAccr)
                $('input[id=lefile]').change(function() {
                    $('#photoCover').val($(this).val());
                });
            }
    )
    function doAccr() {
        var schoolname=$("#schoolname").val();
        var schooladress=$("#schooladress").val();
        var img=$('#photoCover').val();
        var errorMessage=$("#errorMessage");
        if(schoolname==''){
            errorMessage.parent().parent().css('display','block');
            errorMessage.text("学校名称为空！");
            return false;
        }
        if(schooladress==''){
            errorMessage.parent().parent().css('display','block');
            errorMessage.text("学校地址为空！");
            return false;
        }
        errorMessage.parent().parent().css('display','none');
        var url="${basePath}/user/schoolAccr";
        var params={"schoolname":schoolname,"schooladress":schooladress,"img":img};
        $.post(url,params,function (result) {
            if(result=='false'){
                errorMessage.parent().parent().css('display','block');
                errorMessage.text("认证失败！");
                return false;
            }else if(result=='existed'){
                errorMessage.parent().parent().css('display','block');
                errorMessage.text("此学校已认证过！");
                return false;
            }else {
                alert("已发送认证！");
                location.href="../../clubTribeIndex.jsp";
            }
        })
    }
</script>
