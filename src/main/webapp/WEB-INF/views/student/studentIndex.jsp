<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<rapid:override name="head">
	<title>首页</title>
</rapid:override>
<rapid:override name="content">
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
	<div style="width: 600px; height: 450px; margin: 100px 350px; border: 3px solid gray; background-size: cover; background: #D3D3D3">
		<h2 style="text-align: center; margin-top: 25px; margin-bottom: 25px;">${message.title}</h2>
		<h3  style="margin-left:50px; margin-bottom: 10px;">
		${message.content}</h3>
		<h4 style="margin-left:50px; margin-bottom: 10px;">&nbsp;${message.user}&nbsp;${message.date}</h4>
	</div>
</rapid:override>
<%@ include file="base.jsp"%>