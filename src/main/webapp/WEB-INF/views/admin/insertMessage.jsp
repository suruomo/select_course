<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
 <%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<rapid:override name="head">
	<title>添加教师</title>
</rapid:override>
<rapid:override name="content">
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
<div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 40px;border:45px;">
  <form class="layui-form"  style="padding:80px;border:45px; width:400px;height: 400px;">
    <div class="layui-form-item">
    <label class="layui-form-label">标题</label>
    <div class="layui-input-block">
      <input type="text" name="title" id="title" placeholder="请输入标题"   class="layui-input" lay-verify="required">
    </div>
     </div>
	<div class="layui-form-item">
    <label class="layui-form-label">内容</label>
    <div class="layui-input-block">
      <input type="text" name="content" id="content" placeholder="请输入内容" autocomplete="off" class="layui-textarea">
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">发布对象</label>
    <div class="layui-input-block">
     <select name="receiver" id="receiver" lay-filter="receiver" >
        <option value="">请选择对象</option>  
        <option value="student">student</option>
        <option value="teacher">teacher</option>
      </select>
    </div>
  </div>
   <div class="layui-input-inline">
      <button name="add" id="add" class="layui-btn" style="margin:0 150px;" type="button" onClick="return check()">确定发布</button>
   </div>
      </form>   
    </div>  
  </div>
  <script type="text/javascript">
    layui.use(['layer','form'], function(){
      var layer = layui.layer;
      var form = layui.form; 
      form.render();  
     });

    
  </script>
  <script>
  function check() {
      if($("input[title=title]").val()=='') {
            layer.alert("请输入公告标题!");
       }
      else  if( $("input[name=tele]").val()==''){
            layer.alert("请输入公告内容!");
         }
		var title = $("input[name=title]").val(); 
		var content = $("input[name=content]").val();
		var receiver = $("#receiver option:selected").val();
		//执行ajax请求
		$.ajax({
			url:'${pageContext.request.contextPath}/admin/addMes.action',
			method:'POST',
			data:{"title":title,"content":content,"receiver":receiver},
			dataType:'text',
			success:function(data){
				 alert("添加成功");
				 window.location.href = "<%=basePath%>admin/message";
			}
		});
 }
  
  </script>
</rapid:override>
<%@ include file="base.jsp"%>