<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userid="2222222222";
    String username="cjn";
    String password="123";

%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="send_msg">
    <form action="club/activity?userid=<%=userid%>">
        <p>有什么精彩活动想告诉大家</p>
        <input type="text" name="msg">
        <input type="submit"  value="发布">
    </form>
    <c:if test="${count==0}">
        <%
            out.print("alert('未加入社团')");
        %>
    </c:if>
    <c:if test="${flag==0}">
        <%
            out.print("alert('不可可发表')");
        %>
    </c:if>
    <c:if test="${flag==1}">
        <%
            out.print("alert('可发表')");
        %>
    </c:if>
</div>
</body>
</html>
