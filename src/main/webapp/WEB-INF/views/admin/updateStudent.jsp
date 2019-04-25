<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>修改学生信息</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
	<title>网上选课后台管理</title>
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/table.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/layui.css"   media="all">
  <style>
  	.layui-input{
		width:200px;
	}
	h1,button{margin-left:130px;}
  </style>
  <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
  <script>
  	$(function(){
  		$("button").click(function(){
  			//取得表单的值
  			var id = $("input[name=id]").val()
  			var musicName = $("input[name=musicName]").val(); 
  			var singerId = $("input[name=singerId]").val(); 
  			var musicURL = $("input[name=musicURL]").val(); 
  			var typeId = $("input[name=typeId]").val(); 
  			var photo = $("input[name=photo]").val(); 
  			
  			$.ajax({
  				url:'${pageContext.request.contextPath}/updateStudentSuccess',
  				method:'POST',
  				data:{"id":id,"musicName":musicName,"singerId":singerId,
					   "musicURL":musicURL,"typeId":typeId,"photo":photo},
				dataType:'text',
				success:function(data){
					alert(data);
				}
  			});
  		});
  	});
  </script>
</head>
<body>

<div class="layui-form-item">
    <label class="layui-form-label">学号</label>
    <div class="layui-input-block">
      <input type="text" name="id" disabled="disabled" value="${student.stuId}" class="layui-input">
    </div>
  </div>
	<div class="layui-form-item">
    <label class="layui-form-label">姓名</label>
    <div class="layui-input-block">
      <input type="text" name="name" value="${student.stuName}" placeholder="请输入姓名" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">性别</label>
    <div class="layui-input-block">
      <input type="text" name="sex" value="${student.sex}" placeholder="请输入年级" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">年级</label>
    <div class="layui-input-block">
      <input type="text" name="grade" value="${student.grade}" placeholder="请输入年级" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">专业</label>
    <div class="layui-input-block">
      <input type="text" name="pro" value="${student.proName}" placeholder="请输入专业" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">学院</label>
    <div class="layui-input-block">
      <input type="text" name="ins" value="${student.insName}" placeholder="请输入学院" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">联系电话</label>
    <div class="layui-input-block">
      <input type="text" name="tele" value="${student.tele}" placeholder="请输入电话" autocomplete="off" class="layui-input">
    </div>
  </div>
  <button class="layui-btn">确定修改</button>
</body>
</html>