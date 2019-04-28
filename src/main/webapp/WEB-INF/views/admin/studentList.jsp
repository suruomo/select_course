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
                <input type="text" id="search" class="layui-input" style="float:left; width:200px;"
                       placeholder="请输入学生编号">
                <button data-type="reload" class="layui-btn layui-btn-radius"style="float:left;" onclick="search()">搜索</button>
            </div>
        </div>
        </form>
     <table class="layui-hide" id="demo" lay-filter="test"></table>
   </div>
  </div>
     
<script type="text/html" id="barDemo">
  <a class="layui-btn yutons layui-btn-sm yutons-color-detail" lay-event="modify"><i class="layui-icon">&#xe642;</i>修改</a>
  <a class="layui-btn layui-btn-danger yutons layui-btn-sm" lay-event="del"><i class="layui-icon">&#x1006;</i>删除</a>
</script>
<script type="text/html"  id="toolbarDemo">
  <div class="layui-btn-container" >
    <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="deleteAll"><i class="layui-icon">&#xe640;</i> 批量删除</button>
    <button class="layui-btn layui-btn-sm" lay-event="out">导出</button>
    <button class="layui-btn layui-btn-sm" lay-event="print">打印</button> 
  </div>
</script>
<script>
    layui.use(['layer','table'],  function(){
    	 var table = layui.table;
    	 var layer = layui.layer;
        //方法渲染
        table.render({
            elem: '#demo'  //绑定table表格 
            ,url: 'studentList.Action' //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'学生信息表'
            ,id:'studentList'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
                 {type: 'checkbox', fixed: 'left'}
                ,{field:'stuId', title:'学号', width:110, fixed: 'left', sort: true}
                ,{field:'stuName', title:'姓名', width:80, edit: 'text'}
                ,{field:'sage', title:'年龄', width:70}
                ,{field:'sex', title:'性别', width:70}
                ,{field:'tele', title:'电话', width:120}
                ,{field:'address', title:'地址', width:70}
                ,{field:'proName', title:'专业', width:120}                      
                ,{field:'grade', title:'年级', width:100}
                ,{field:'state', title:'状态', width:80}
                ,{field:'insName', title:'学院名称', width:120}      
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:180}
            ]]
        }); 

        //监听表格复选框选择
       table.on('checkbox(test)', function(obj){     //待修改
    	   alert(obj.type);
        	 layer.confirm('真的删除所选行么', function(index){
                                
              });
       });
        //监听头工具栏事件
       	table.on('toolbar(test)', function(obj){  //注：toolbar是工具条事件名，demo是table原始容器的属性 lay-filter="对应的值"
       	 alert("s");
       	var checkStatus = table.checkStatus(obj.config.id);
        alert(checkStatus);
         switch(obj.event){
           case 'deleteAll':
             layer.msg('批量删除');
           break;
           case 'out':
             layer.msg('导出');
           break;
           case 'print':
             layer.msg('打印');
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
					  ,area:['380px','480px']    //宽高
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