<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<html>
<head>
    <rapid:block name="head"></rapid:block>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
	<title >网上选课</title>
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
</head>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<body>
<!-- 顶部开始 -->
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item" ><a href="<%=basePath%>student/studentIndex" style="font-size: 20px;">首页</a></li>
     <li class="layui-nav-item ">
         <a href="<%=basePath%>student/studentInfo?stuid=${sessionScope.id}" style="font-size: 20px;">个人资料管理</a>
     </li>
      <li class="layui-nav-item">
        <a href="javascript:;" style="font-size: 20px;">选课</a>
        <dl class="layui-nav-child">
          <dd><a href="<%=basePath%>student/courseList?page=1">所有选课</a></dd>
          <dd><a href="<%=basePath%>student/selectCourse">分类选课</a></dd>
          <dd><a href="<%=basePath%>student/checkedCourseList">查看选课信息</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item ">
         <a href="<%=basePath%>student/studentScore" style="font-size: 20px;">查看成绩</a>
      </li>
     
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item" style="float:right; "><a href="<%=basePath%>exit" style="font-size: 20px;">退出登录</a></li>
      <li class="layui-nav-item" style="float:right; font-size:20px;"><i class="layui-icon " style="font-size:18px;" >&#xe612;</i>&nbsp;${sessionScope.username}&nbsp;${sessionScope.id}
      </li>
    </ul>
  </div>
  </div>
<script src="${pageContext.request.contextPath}/lib/layui/layui.all.js"></script>
<rapid:block name="content"></rapid:block>
</body>

</html>
