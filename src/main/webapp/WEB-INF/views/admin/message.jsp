<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<rapid:override name="head">
	<title>公告列表</title>
</rapid:override>
<rapid:override name="content">
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
<div class="layui-body">
    <!-- 内容主体区域 -->
 <div style="padding: 70px;border:30px;">
        <form class="layui-form">
        <div class="layui-form-item">
            <div class="layui-input-block"> 
                <table class="layui-hide" id="demo" lay-filter="test"></table>
            </div>
        </div>
        </form>
   </div>
  </div>
     
<script type="text/html" id="barDemo">
 <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="del">
    <i class="layui-icon">&#xe640;</i>
  </button>
</script>
<script type="text/html"  id="toolbarDemo">
  <div class="layui-btn-container" >
    <button type="button" class="layui-btn  layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe608;</i> 发布公告</button>
    <button type="button" class="layui-btn layui-btn-danger layui-btn-sm" lay-event="deleteAll"><i class="layui-icon">&#xe640;</i> 批量删除历史</button>
  </div>
</script>
<script>
    layui.use(['layer','table','form'],  function(){
    	var table = layui.table;
    	var layer = layui.layer;
    	var form = layui.form; 
    	form.render();  
        //方法渲染
        table.render({
            elem: '#demo'  //绑定table表格 
            ,url: 'MessageList.Action' //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'公告信息表'
            ,id:'MessageList'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
                 {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'编号', width:80, fixed: 'left', sort: true}
                ,{field:'title', title:'标题', width:120, edit: 'text'}
                ,{field:'content', title:'内容', width:400}
                ,{field:'user', title:'发布人', width:100}
                ,{field:'receiver', title:'接受对象', width:100}
                ,{field:'date', title:'发布日期', width:200}                         
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:100}
            ]]
        }); 

        //监听头工具栏事件
       	table.on('toolbar(test)', function(obj){  //注：toolbar是工具条事件名，demo是table原始容器的属性 lay-filter="对应的值"
       	var checkStatus = table.checkStatus(obj.config.id);
        switch(obj.event){
           case 'deleteAll': 
         	if(checkStatus.data.length==0){
         		parent.layer.msg('请先选择要删除的数据行！', {icon: 2});
         		return;
         	}
         	var ids = "";
         	for(var i=0;i<checkStatus.data.length;i++){
         		ids += checkStatus.data[i].id+",";
         	}
            layer.confirm('真的删除行么', function(index){
            layer.msg('删除中...', {icon: 16,shade: 0.3,time:3000});
		    	$.ajax({
		    		url:'${pageContext.request.contextPath}/admin/deleteMultiStu?id='+ids,
		    		method:'GET',
		    		dataType:'text',
		    		success:function(data){	
		    			layer.msg("删除成功");
		    			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						layer.close(index); //再执行关闭
		    			obj.del();   //删除对应行（tr）的DOM结构，并更新缓存
		    		}
		    	});
           });
           break;
           case 'add':
        	   window.location.href = "<%=basePath%>admin/insertMessage";
        	   break;
               };
	});
  	  //监听行工具事件
		table.on('tool(test)', function(obj){  //注：tool是工具条事件名，demo是table原始容器的属性 lay-filter="对应的值"
		    var data = obj.data;   //获得当前行数据  
		    if(obj.event === 'del'){   //删除数据
		    	//执行ajax请求
           layer.confirm('真的删除行么', function(index){
		    	$.ajax({
		    		url:'${pageContext.request.contextPath}/admin/deleteStudent?id='+data.stuId,
		    		method:'GET',
		    		dataType:'text',
		    		success:function(data){
		    			layer.msg("删除成功");
		    			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						parent.layer.close(index); //再执行关闭
		    			obj.del();   //删除对应行（tr）的DOM结构，并更新缓存
		    		}
		    	});
           });
		     }else if(obj.event === 'modify'){   //修改数据
		    	layer.open({
					  type: 2, 
					  title:'修改数据'   //标题 
					   ,maxmin: true
					  ,area:['380px','520px']    //宽高
					  ,content:['${pageContext.request.contextPath}/admin/updateStudent?id='+data.stuId,'no']
		    	      ,end: function () {
		    	    	 location.reload();
		               }
		    	}); 			  
		    } 
		 });
    });
</script>
</rapid:override>
<%@ include file="base.jsp"%>