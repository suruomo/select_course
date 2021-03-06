<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
	<title>网上选课后台管理</title>
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
	<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.all.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/modules/layer/default/layer.css">
</head>
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
<body>
    <!-- 内容主体区域 -->
     <table class="layui-hide" id="demo" lay-filter="test"></table>

 <script type="text/html"  id="toolbarDemo">
  <div class="layui-btn-container" >

  </div>
</script>    
<script>
    layui.use(['layer','table'],  function(){
    	 var table = layui.table;
    	 var layer = layui.layer;
        //方法渲染
        table.render({
            elem: '#demo'  //绑定table表格 
            ,url: 'queryCheckedNameList?classId='+${course.classId} //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,width : 400
            ,height : 400
            ,title:'已选名单'
            ,id:'courseList'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
                {field:'stuId', title:'学号', width:120, fixed: 'left', sort: true}
                ,{field:'stuName', title:'姓名', width:70, edit: 'text'}
                ,{field:'proName', title:'专业', width:100}
                ,{field:'insName', title:'学院', width:100}     
            ]]
        }); 
    });
</script>
</body>
</html>