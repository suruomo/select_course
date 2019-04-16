<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<rapid:override name="head">
    <title>课程信息</title>
</rapid:override>
<rapid:override name="content">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <p style="color:red; margin-top:10px; font-size:15px;">${msg}</p>


</rapid:override>
<%@ include file="base.jsp" %>
