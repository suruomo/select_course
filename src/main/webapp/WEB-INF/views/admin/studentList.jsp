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
               
                <div class="layui-input-inline">
                     <select class="layui-select" id="ins">
                            <option value="1001">计算机学院</option>
                            <option value="1002">医学院</option>
                            <option value="1003">体育学院</option>
                            <option value="1004">管理学院</option>
                            <option value="1005">经济学院</option>
                            <option value="1006">文学院</option>
                            <option value="1007">理学院</option>
                      </select>
                </div>
                 <div class="layui-input-inline">
                   <button data-type="reload" type="button" name="select" id="select" onClick="return select()" class="layui-btn layui-btn-radius " style="margin-left:0px;">
                                    筛选   
            </button>
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
    <button type="button" class="layui-btn  layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe608;</i> 添加学生</button>
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
                ,{field:'sex', title:'性别', width:70}
                ,{field:'address', title:'地址', width:70}
                ,{field:'proName', title:'专业', width:120}                      
                ,{field:'grade', title:'年级', width:100}
                ,{field:'state', title:'状态', width:80}
                ,{field:'insName', title:'学院名称', width:120}      
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
           case 'add':
        	   window.location.href = "<%=basePath%>admin/insertStudent";
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
                                     insId:$("#ins option:selected").val(),
                                   
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
      	            //这个是用于创建点击事件的实例
      	          
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