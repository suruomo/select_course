<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
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
	<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
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
  			var stuId = $("input[name=id]").val()
  			var stuName = $("input[name=name]").val(); 
  			var sex = $('#sex input[name="sex"]:checked ').val()
  			var grade = $("input[name=grade]").val(); 
  			var proName = $("input[name=pro]").val(); 
  			var insName= $("input[name=ins]").val(); 
  			var tele = $("input[name=tele]").val(); 
  			$.ajax({
  				url:'<%=basePath%>admin/updateStudentSuccess',   //提交修改数据
  				method:'POST',
  				data:{"stuId":stuId,"stuName":stuName,"sex":sex,
					   "grade":grade,"proName":proName,"insName":insName,"tele":tele},
				dataType:'text',
				success:function(data){
					layer.alert("已修改"); 
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
			},
				error:function(data){
					layer.alert("已修改");
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
				}, 
  			});
  		});
  	});
  </script>
</head>
<body>
<form class="layui-form">
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
    <div class="layui-input-block" id="sex">
     <c:if test="${student.sex=='女'}">
                 <input type="radio" name="sex" value="女" title="女" checked>
                 <input type="radio" name="sex" value="男" title="男" >
               </c:if>
      <c:if test="${student.sex=='男'}">
                  <input type="radio" name="sex" value="女" title="女" >
                  <input type="radio" name="sex" value="男" title="男" checked>
      </c:if>
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
      <input type="text" name="pro" value="${student.proName}" disabled="disabled"  placeholder="请输入专业" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">学院</label>
    <div class="layui-input-block">
      <input type="text" name="ins" value="${student.insName}" disabled="disabled"  placeholder="请输入学院" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">联系电话</label>
    <div class="layui-input-block">
      <input type="text" name="tele" value="${student.tele}" placeholder="请输入电话" autocomplete="off" class="layui-input">
    </div>
  </div>
  </form>
    <button type="button" class="layui-btn">确定修改</button>
</body>

</html>