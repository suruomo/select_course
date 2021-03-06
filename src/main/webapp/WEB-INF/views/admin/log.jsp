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
                    <label class="layui-form-label" style="float:left; font-size:15px;">日期筛选：</label>
                 </div>
                 <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test1" placeholder="年--月--日">
                    </div>
                   <div class="layui-input-inline"> 
                     <button data-type="reload" class="layui-btn layui-btn-radius"style="float:left;" onclick="search()">确定</button>
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
</script>
<script type="text/html"  id="toolbarDemo">
  <div class="layui-btn-container" >
   
  </div>
</script>
<script>
    layui.use(['layer','table','form','laydate'],  function(){
    	var table = layui.table;
    	var layer = layui.layer;
    	var form = layui.form; 
        var laydate = layui.laydate;
    	//日期选择
        laydate.render({
    	    elem: '#test1' 
    	  });
    	form.render();  
        //方法渲染
        table.render({
            elem: '#demo'  //绑定table表格 
            ,url: 'log.Action' //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'日志信息表'
            ,id:'logList'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
            	
                {field:'userId', title:'用户账号', width:150}
                ,{field:'username', title:'用户姓名', width:120, edit: 'text'}
                ,{field:'module', title:'访问模块', width:100}
                ,{field:'method', title:'访问方法', width:150}
                ,{field:'response_date', title:'响应时间(ms)', width:150}                      
                ,{field:'data', title:'时间', width:200}
                ,{field:'commit', title:'执行结果', width:100}
                   

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