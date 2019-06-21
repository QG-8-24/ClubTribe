<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="basePath" value="${pageContext.request.contextPath}"></c:set>
<HTML>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <title>校园认证</title>
    <link rel="stylesheet" type="text/css" href="/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/bootstrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/css/all-skins.min.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/css/main.css">
    <link rel="stylesheet" href="/bootstrap/js/bootstrap.min.js" />
    <script type="application/javascript" src="../../js/jquery-3.3.1.min.js"></script>
    <style type="text/css">
    </style>
</head>
<body >
<div class="container header ">
    <div class="text-center"><h1>学校申请</h1></div>
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
    <div id="photobox" style="width: 1132px;height: 500px;display: none">
       <img id="img">
    </div>
    <div class="input-append;" style="margin-bottom: 5px">
        <input id="lefile" type="file" style="display:none" accept="image/jpg">
        <a onclick="$('#lefile').click();"><img src="../img/upload.jpeg" alt="upload"/></a>
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
                $('#lefile').change(photoSwitch);
            }
    )
    function fileUpload() {
        var formdata=new FormData();
        formdata.append("img",$('#lefile').prop("files")[0]);
        $.ajax({
            type:'post',
            url:'${basePath}/user/fileUpload',
            async:true,
            data:formdata,
            processData:false,
            contentType:false,
            success:function (result) {
                var photobox=$('#photobox');
                var img=$('#img');
                photobox.removeAttr("style");
                img.attr('src',result);
            },
            error:function (msg) {
                alert(" ");
            }
        });
    }
    function photoSwitch() {
        var schoolname=$("#schoolname").val();
        var schooladress=$("#schooladress").val();
        var errorMessage=$("#errorMessage");
        var photobox=$('#photobox');
        var src = window.URL.createObjectURL(this.files[0]); //转成可以在本地预览的格式
        if(schoolname=='' || schooladress==''){
            $('#schoolname').css("backgroundColor","#dd4b39");
            $('#schooladress').css("backgroundColor","#dd4b39");
            setTimeout(function (){
                $('#schoolname').css("backgroundColor","");
                $('#schooladress').css("backgroundColor","");
            },750);
            setTimeout(function () {
                errorMessage.parent().parent().css('display','block');
                errorMessage.text("请先完成以上信息填写！");
            },1000);
            return;
        }
        var image=new Image();
        image.src=src;
        $('#photoCover').val($(this).val());
        image.onload=function () {
            if(this.width>photobox.width() || this.height>photobox.height()){
                errorMessage.parent().parent().css('display','block');
                errorMessage.text("图片过大无法上传，请压缩图片！");
            }else {
                alert("上传成功！");
                fileUpload();
            }
        }
    }

    function doAccr() {
        var schoolname=$("#schoolname").val();
        var schooladress=$("#schooladress").val();
        var img=$('#photoCover').val();
        var errorMessage=$("#errorMessage");
        var URL=$('#img').attr('src');
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
        if(img==undefined){
            errorMessage.parent().parent().css('display','block');
            errorMessage.text("图片未上传！");
            return false;
        }
        errorMessage.parent().parent().css('display','none');
        var url="${basePath}/user/schoolAccr";
        var params={"schoolname":schoolname,"schooladress":schooladress,"img":img,"URL":URL};
        $.post(url,params,function (result) {
            result=result.trim();
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
                location.href="../../clubTribeIndex.jsp?userid=${userid}&admin=${admin}";
            }
        })
    }
</script>
