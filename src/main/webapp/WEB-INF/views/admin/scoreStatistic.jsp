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
  <a class="layui-btn yutons layui-btn-sm yutons-color-detail" lay-event="table"><i class="layui-icon">&#xe62d;</i>成绩统计</a>
  <a class="layui-btn layui-btn-danger yutons layui-btn-sm" lay-event="chart"><i class="layui-icon">&#xe629;</i>图表统计</a>
</script>
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
            ,url: 'courseList.Action' //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'课程信息表'
            ,id:'courseList'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
                {field:'classId', title:'课程编号', width:100, fixed: 'left', sort: true}
                ,{field:'className', title:'课程名称', width:125, edit: 'text'}
                ,{field:'ins', title:'开课学院', width:110}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:230}
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
            parent.layer.msg('删除中...', {icon: 16,shade: 0.3,time:5000});
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
               };
	});
  	  //监听行工具事件
		table.on('tool(test)', function(obj){  //注：tool是工具条事件名，demo是table原始容器的属性 lay-filter="对应的值"
		    var data = obj.data;   //获得当前行数据  
		    if(obj.event === 'table'){   //表格成绩
		    	//执行ajax请求
		    	layer.open({
					  type: 2, 
					  title:'成绩统计'   //标题 
					  ,maxmin: true
					  ,area:['800px','400px']    //宽高
					  ,content:['${pageContext.request.contextPath}/admin/scoreList?id='+data.classId,'yes']
		    	      ,end: function () {
		    	    	// location.reload();
		               }
		    	});
		     }else if(obj.event === 'chart'){   //图表统计 	
		    window.location.href = "<%=basePath%>admin/chart";	 	 
		    } 
		 });
    });
</script>

</rapid:override>
<%@ include file="base.jsp"%>