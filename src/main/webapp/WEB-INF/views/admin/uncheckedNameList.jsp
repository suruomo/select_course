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
<script type="text/html" id="barDemo">
  <a class="layui-btn yutons layui-btn-sm yutons-color-detail" lay-event="send"><i class="layui-icon">&#xe655;</i>发送邮件</a>
</script>
<script type="text/html"  id="toolbarDemo">
  <div class="layui-btn-container" >
    <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="sendAll"><i class="layui-icon">&#xe613;</i>批量发送邮件</button>
  </div>
</script>
<script>
function sendmail(){
	layer.confirm('确认您将向所有未选课学生发送选课通知？', function(index){
	    parent.layer.msg('发送中...', {icon: 16,shade: 0.3,time:5000});
	    	$.ajax({
	    		url:'${pageContext.request.contextPath}/admin/sengmail?id='+ids,
	    		method:'GET',
	    		dataType:'text',
	    		success:function(data){	
	    			layer.msg("删除成功");
	    			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
	    			obj.del();   //删除对应行（tr）的DOM结构，并更新缓存
	    		}
	    	});
}
</script>  
<script>
    layui.use(['layer','table'],  function(){
    	 var table = layui.table;
    	 var layer = layui.layer;
        //方法渲染
        table.render({
            elem: '#demo'  //绑定table表格 
            ,url: 'queryUncheckedNameList?classId='+${course.classId} //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'未选名单'
            ,id:'courseList'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
            	 {type: 'checkbox', fixed: 'left'}
                ,{field:'stuId', title:'学号', width:120, fixed: 'left', sort: true}
                ,{field:'stuName', title:'姓名', width:70, edit: 'text'}
                ,{field:'proName', title:'专业', width:100}
                ,{field:'insName', title:'学院', width:100} 
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:180}
            ]]
        }); 
        //监听头工具栏事件
       	table.on('toolbar(test)', function(obj){  //注：toolbar是工具条事件名，demo是table原始容器的属性 lay-filter="对应的值"
       	var checkStatus = table.checkStatus(obj.config.id);
        switch(obj.event){
           case 'sendAll':
         	if(checkStatus.data.length==0){
         		parent.layer.msg('请先选择要发送的数据行！', {icon: 2});
         		return ;
         	}
         	var ids = "";
         	for(var i=0;i<checkStatus.data.length;i++){
         		ids += checkStatus.data[i].id+",";
         	}
            layer.confirm('确认您将向选中的学生发送选课通知', function(index){
            parent.layer.msg('发送中...', {icon: 16,shade: 0.3,time:5000});
		    	$.ajax({
		    		url:'${pageContext.request.contextPath}/admin/sendmail?classId=<%=request.getAttribute("classId")%>&id='+ids,
		    		method:'GET',
		    		dataType:'text',
		    		success:function(data){	
		    			layer.msg("发送成功");
		    			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						parent.layer.close(index); //再执行关闭
		    		}
		    	});
           });
           break;
               };
	});
  	  //监听行工具事件
		table.on('tool(test)', function(obj){  //注：tool是工具条事件名，demo是table原始容器的属性 lay-filter="对应的值"
		    var data = obj.data;   //获得当前行数据  
		    if(obj.event === 'send'){   //删除数据
		    	//执行ajax请求
           layer.confirm('确认发送通知邮件么', function(index){
        	 parent.layer.msg('发送中...', {icon: 16,shade: 0.3,time:5000});
        	   $.ajax({
		    		url:'${pageContext.request.contextPath}/admin/sendmail?classId=<%=request.getAttribute("classId")%>&id='+data.stuId,
		    		method:'GET',
		    		dataType:'text',
		    		success:function(data){
		    			layer.msg("发送成功");
		    			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						parent.layer.close(index); //再执行关闭
		    		}
		    	});
             });
		    }
		 });
      });
</script>
</body>
</html>