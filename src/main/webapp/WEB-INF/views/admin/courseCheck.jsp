<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<rapid:override name="head">
	<title>学生列表</title>
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
                <div class="layui-input-inline" style="float:left; width:200px;">
                   <input type="text" id="search" class="layui-input" 
                       placeholder="请输入课程编号">
                </div>
                <div class="layui-input-inline">
                    <button type="button" id="tea" class="layui-btn layui-btn-radius " style="margin-left:0px;">查询</button>
                </div>
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
 <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="modify">
    <i class="layui-icon">&#xe642;</i>
  </button>
 <button type="button" class="layui-btn layui-btn-primary layui-btn-sm" lay-event="del">
    <i class="layui-icon">&#xe640;</i>
  </button>
</script>
<script type="text/html"  id="toolbarDemo">
  <div class="layui-btn-container" >
    <button type="button" class="layui-btn layui-btn-radius layui-btn-sm" lay-event="checked"><i class="layui-icon">&#xe605;</i> 审核通过</button>
    <button type="button" class="layui-btn layui-btn-radius layui-btn-warm layui-btn-sm" lay-event="unchecked"><i class="layui-icon">&#x1006;</i> 审核不通过</button>
    <button type="button" class="layui-btn layui-btn-danger layui-btn-sm" lay-event="deleteAll"><i class="layui-icon">&#xe640;</i> 批量删除</button>
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
            ,url: 'courseList.Action' //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'课程审核表'
            ,id:'checkList'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
            	{type: 'checkbox', fixed: 'left'}
                ,{field:'classId', title:'课程编号', width:100, fixed: 'left', sort: true}
                ,{field:'className', title:'课程名', width:140}
                ,{field:'type', title:'类型', width:70}
                ,{field:'credit', title:'学分', width:70}
                ,{field:'year', title:'开课学年', width:120}
                ,{field:'term', title:'开课学期', width:120}                      
                ,{field:'classify', title:'课程类别', width:100}   
                ,{field:'classCheck', title:'审核情况', width:100} 
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:180}
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
           case 'checked':
        	   if(checkStatus.data.length==0){
            		parent.layer.msg('请先选择要审核的数据行！', {icon: 2});
            		return;
            	}
        	    var ids = "";
            	for(var i=0;i<checkStatus.data.length;i++){
            		ids += checkStatus.data[i].classId+",";
            	}
            	layer.confirm('真的审核通过所选课程吗？', function(index){
        	    $.ajax({
		    		url:'${pageContext.request.contextPath}/admin/checkedCourse?id='+ids,
		    		method:'GET',
		    		dataType:'text',
		    		success:function(data){	
		    			layer.msg("审核已通过");
		    			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						layer.close(index); //再执行关闭
						location.reload();
		    		}
		    	   });
            	 });
        	   break;
           case 'unchecked':
        	   if(checkStatus.data.length==0){
           		parent.layer.msg('请先选择要审核的数据行！', {icon: 2});
           		return;
           	}
        	   var ids = "";
           	for(var i=0;i<checkStatus.data.length;i++){
           		ids += checkStatus.data[i].classId+",";
           	}
           	layer.confirm('真的审核不通过所选课程吗？', function(index){
       	    $.ajax({
		    		url:'${pageContext.request.contextPath}/admin/uncheckedCourse?id='+ids,
		    		method:'GET',
		    		dataType:'text',
		    		success:function(data){	
		    			layer.msg("审核不通过");
		    			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
						layer.close(index); //再执行关闭
						location.reload();
		    		}
		    	   });
           	 });
        	   break;
       };
	});
       	 //按照学院进行搜索 ，表格重载
          var active =
       	              {
       	                  reload: function () {
       	                     var insId = $("#ins option:selected").val();//获取下拉框的值
       	                      //执行重载 
                             table.reload('studentList', {
                                 where: {
                                     insId:$("#ins option:selected").val()
                                }
                                 , page: {
                                 curr: 1
                             }
                              });                      
       	            }
       	          };
       	            //这个是用于创建点击事件的实例
       	            $('#select').on('click', function ()
       	            {
       	                var type = $(this).data('type');
       	                active[type] ? active[type].call(this) : '';
       	            });
  	  //监听行工具事件
		table.on('tool(test)', function(obj){  //注：tool是工具条事件名，demo是table原始容器的属性 lay-filter="对应的值"
		    var data = obj.data;   //获得当前行数据  
		    if(obj.event === 'del'){   //删除数据
		    	//执行ajax请求
           layer.confirm('真的删除行么', function(index){
		    	$.ajax({
		    		url:'${pageContext.request.contextPath}/admin/deleteStudent?id='+data.classId,
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
					  title:'修改数据'   //标题 s
					   ,maxmin: true
					  ,area:['380px','520px']    //宽高
					  ,content:['${pageContext.request.contextPath}/admin/updateCourse?id='+data.classId,'yes']
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