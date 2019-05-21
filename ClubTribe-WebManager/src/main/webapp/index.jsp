<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <script>
        $(function () {
            console.log("666");
        });
    </script>
</head>
<body>
<form action="user/clubhome">
    用户名：<input name="userid" type="text" oninput="value=value.replace(/[^\d]/g,'')">
    社团id:<input name="clubid" type="text" oninput="value=value.replace(/[^\d]/g,'')">
    <input type="submit" value="进入" name="">
    <a href="jsp/clubTribeIndex_CJN.jsp">CJN</a>
</form>
</body>
</html>