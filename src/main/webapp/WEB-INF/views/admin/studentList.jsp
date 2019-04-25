<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<rapid:override name="head">
	<title>首页</title>
    <rapid:block name="head"></rapid:block>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
	<title>网上选课后台管理</title>
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/table.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/layui.css"   media="all">
</rapid:override>
<rapid:override name="content">
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
<div class="layui-body">
    <!-- 内容主体区域 -->
     <div style="padding: 80px;border:45px;">
        <form class="layui-form" style="border:45px;">
        <div class="layui-form-item">
            <div class="layui-input-block"> 
                <input type="text" id="search" class="layui-input" style="float:left; width:200px;"
                       placeholder="请输入学生编号">
                <button data-type="reload" class="layui-btn layui-btn-radius"style="float:left;" onclick="search()">搜索</button>
            </div>
        </div>
    </form>
       <table class="layui-hide" id="demo" lay-filter="demo"></table>
       </div>
  </div>
  <script type="text/html" id="barDemo">
  
  <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="modify">修改</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    layui.use('table',  function(){
    	 var table = layui.table;
        //方法渲染
        table.render({
            elem: '#demo'  //绑定table表格 
            ,url: 'studentList.Action' //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'学生信息表'
            ,id:'contenttable'
            ,toolbar: '#toolbarDemo'  //开启表格头部工具栏区域
            ,cols: [[
                 {type: 'checkbox', fixed: 'left'}
                ,{field:'stuId', title:'学号', width:150, fixed: 'left', sort: true}
                ,{field:'stuName', title:'姓名', width:120, edit: 'text'}
                ,{field:'sage', title:'年龄', width:80}
                ,{field:'sex', title:'性别', width:80}
                ,{field:'tele', title:'电话', width:100}
                ,{field:'address', title:'地址', width:100}
                ,{field:'proName', title:'专业', width:120}                      
                ,{field:'grade', title:'年级', width:120}
                ,{field:'state', title:'状态', width:120}
                ,{field:'insName', title:'学院名称', width:120}      
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:180}
            ]]
        }); 

        //监听表格行点击
        table.on('tr', function(obj){
            console.log(obj)
        });
 
        //监听表格复选框选择
        table.on('checkbox(demo)', function(obj){
            console.log(obj)
        });
  	  //监听行工具事件
		  table.on('tool(demo)', function(obj){  //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		    var data = obj.data;   //获得当前行数据
		    alert(data.stuId);
		    if(obj.event === 'del'){   //删除数据
		    	//执行ajax请求
		    	$.ajax({
		    		url:'${pageContext.request.contextPath}/admin/deleteStudent?id='+data.stuId,
		    		method:'GET',
		    		dataType:'text',
		    		success:function(data){
		    			alert("删除成功");
		    			layer.msg(data);
		    			obj.del();   //删除对应行（tr）的DOM结构，并更新缓存
		    		}
		    	});
		     }else if(obj.event === 'modify'){   //修改数据
		    var data = obj.data;   //获得当前行数据
		    	layer.open({
					  type: 2, 
					  title:'修改数据'   //标题 
					  ,area:['500px','550px']    //宽高
					  ,content:'<%=basePath%>/admin/updateStudent?id='+data.stuId 
				}); 			  
		    } 
		 });
    });
</script>
</rapid:override>
<%@ include file="base.jsp"%>