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
	<title >网上选课后台管理</title>
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	  <!-- 引入 ECharts 文件 -->
    <script src="${pageContext.request.contextPath}/echarts/echarts.js"></script>
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
    <div class="layui-logo" style="font-size:18px;">网上选课系统后台管理</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <div class="left_open">
		<i title="展开左侧栏" class="iconfont">&#xe699;</i>
	</div>
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item ">
         <a href="<%=basePath%>admin/message" style="font-size:15px;">公告管理</a>
     </li>
     
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item" style="float:right; "><a href="<%=basePath%>exit" style="font-size: 20px;">退出登录</a></li>
      <li class="layui-nav-item" style="float:right; font-size:20px;"><i class="layui-icon " style="font-size:18px;" >&#xe612;</i>&nbsp;${sessionScope.username}&nbsp;${sessionScope.id}
        <dl class="layui-nav-child">
          <dd><a href="<%=basePath%>admin/adminInfo">基本资料</a></dd>
          <dd><a href="<%=basePath%>admin/editPass">修改密码</a></dd>
        </dl>
      </li>
    </ul>
  </div>
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
       <li class="layui-nav-item layui-nav-itemd" >
        <a href="<%=basePath%>admin/studentList" style="font-size:20px;"><i class="layui-icon " style="font-size:18px;" >&#xe66f;</i>&nbsp;学生管理</a>
       </li>
        <li class="layui-nav-item layui-nav-itemd">
          <a href="<%=basePath%>admin/teacherList" style="font-size:20px;"><i class="layui-icon " style="font-size:18px;" >&#xe770;</i>&nbsp;教师管理</a>
        </li>
        <li class="layui-nav-item layui-nav-itemd">
          <a href="<%=basePath%>admin/courseList" style="font-size:20px;"><i class="layui-icon " style="font-size:18px;" >&#xe6b2;</i>&nbsp;课程管理</a>
        </li>
        <li class="layui-nav-item layui-nav-itemd">
          <a href="javascript:;" style="font-size:20px;"><i class="layui-icon " style="font-size:18px;" >&#xe62a;</i>&nbsp;课程统计</a>
          <dl class="layui-nav-child">
           <dd><a href="<%=basePath%>admin/courseStatistic"><i class="layui-icon " style="font-size:18px;" >&#xe621;</i>&nbsp;选课统计</a></dd> 
           <dd><a href="<%=basePath%>admin/scoreStatistic"><i class="layui-icon " style="font-size:18px;" >&#xe60a;</i>&nbsp;成绩统计</a></dd> 
          </dl>
        </li>
         <li class="layui-nav-item ">
         <a href="<%=basePath%>admin/courseCheck" style="font-size:20px;"><i class="layui-icon " style="font-size:18px;" >&#xe615;</i>&nbsp;课程审核</a>
        </li>
     <li class="layui-nav-item ">
         <a href="<%=basePath%>admin/log" style="font-size:20px;"><i class="layui-icon " style="font-size:18px;" >&#xe637;</i>&nbsp;日志管理</a>
     </li>
      </ul>
    </div>
  </div>
    <div class="layui-body">
    <!-- 内容主体区域 -->
    
    </div>
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    <div class="copyright">Copyright ©2019 网上选课系统 by suruomo</div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui/layui.all.js"></script>
<rapid:block name="content"></rapid:block>
</body>

</html>
