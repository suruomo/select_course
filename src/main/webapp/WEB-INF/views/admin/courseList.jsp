<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<rapid:override name="head">
	<title>课程列表</title>
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
                <input type="text" id="search" class="layui-input" style="float:left; width:200px;"
                       placeholder="请输入课程编号">
                <button data-type="reload" class="layui-btn layui-btn-radius"style="float:left;" onclick="search()">搜索</button>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block"> 
                <table class="layui-hide" id="demo" lay-filter="test"></table>
            </div>
        </div>
        </form>
   </div>
  </div>
     
<script type="text/html" id="barDemo">
  <a class="layui-btn yutons layui-btn-sm yutons-color-detail" lay-event="modify"><i class="layui-icon">&#xe642;</i>修改</a>
  <a class="layui-btn layui-btn-danger yutons layui-btn-sm" lay-event="del"><i class="layui-icon">&#x1006;</i>删除</a>
</script>
<script type="text/html"  id="toolbarDemo">
  <div class="layui-btn-container" >   
<button type="button"  class="layui-btn layui-btn-danger layui-btn-sm" lay-event="deleteAll"><i class="layui-icon">&#xe640;</i> 批量删除</button>
<button type="button"  class="layui-btn  layui-btn-sm" lay-event="tiyu"><i class="layui-icon">&#xe654</i> 添加体育课程</button>
<button type="button"  class="layui-btn  layui-btn-sm" lay-event="notiyu"><i class="layui-icon">&#xe608;</i> 添加文化课程</button>
  </div>
</script>
<script>
    layui.use(['layer','table'],  function(){
    	 var table = layui.table;
    	 var layer = layui.layer;
        //方法渲染
        table.render({
            elem: '#demo'  //绑定table表格 
            ,url: 'courseList.Action' //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'课程信息表'
            ,id:'courseList'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
                 {type: 'checkbox', fixed: 'left'}
                ,{field:'classId', title:'课程编号', width:70, fixed: 'left', sort: true}
                ,{field:'className', title:'课程名', width:120, edit: 'text'}
                ,{field:'teaId', title:'授课教师id', width:100}
                ,{field:'type', title:'类型', width:70}
                ,{field:'credit', title:'学分', width:70}
                ,{field:'year', title:'开课学年', width:120}
                ,{field:'term', title:'开课学期', width:120}                      
                ,{field:'classify', title:'课程类别', width:100}
                ,{field:'item', title:'项目', width:80}
                ,{field:'introduction', title:'简介', width:120}      
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:180}
            ]]
        }); 

        //监听表格复选框选择
       table.on('checkbox(test)', function(obj){     //待修改
       });
        //监听头工具栏事件
       	table.on('toolbar(test)', function(obj){  //注：toolbar是工具条事件名，demo是table原始容器的属性 lay-filter="对应的值"
       	var checkStatus = table.checkStatus(obj.config.id);
        switch(obj.event){
           case 'deleteAll':
         	if(checkStatus.data.length==0){
         		parent.layer.msg('请先选择要删除的数据行！', {icon: 2});
         		return ;
         	}
         	var ids = "";
         	for(var i=0;i<checkStatus.data.length;i++){
         		ids += checkStatus.data[i].id+",";
         	}
            layer.confirm('真的删除行么', function(index){
            parent.layer.msg('删除中...', {icon: 16,shade: 0.3,time:3000});
		    	$.ajax({
		    		url:'${pageContext.request.contextPath}/admin/deleteMultiStu?id='+ids,
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
           break;
           case 'tiyu':
        	   window.location.href = "<%=basePath%>teacher/insertTiCourse";
        	   break;
           case 'notiyu':
        	   window.location.href = "<%=basePath%>teacher/insertCourse";
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
		    		url:'${pageContext.request.contextPath}/admin/deleteCourse?id='+data.classId,
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
					  ,area:['380px','480px']    //宽高
					  ,content:['${pageContext.request.contextPath}/admin/updateCourse?id='+data.classId+'&'+'teaid='+data.teaId,'yes']
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