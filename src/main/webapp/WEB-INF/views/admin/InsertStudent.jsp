<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
 <%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<rapid:override name="head">
	<title>添加学生</title>
</rapid:override>
<rapid:override name="content">
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
<div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 80px;border:45px;">
     <form class="layui-form"  style="padding: 80px;border:45px; width:700px;height: 500px;">
        <div class="layui-form-item">
    <label class="layui-form-label">姓名</label>
    <div class="layui-input-block">
      <input type="text" name="name"   class="layui-input">
    </div>
            </div>
	<div class="layui-form-item">
    <label class="layui-form-label">年龄</label>
    <div class="layui-input-block">
      <input type="text" name="age"  placeholder="请输入姓名" autocomplete="off" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">性别</label>
    <div class="layui-input-block" id="sex">
                 <input type="radio" name="sex" value="女" title="女" checked>
                 <input type="radio" name="sex" value="男" title="男" >
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">年级</label>
    <div class="layui-input-block">
      <input type="text" name="grade"  placeholder="请输入年级" autocomplete="off" class="layui-input">
    </div>
  </div>
   <div class="layui-form-item">
    <label class="layui-form-label">学院</label>
    <div class="layui-input-block">
      <select name="ins" id="ins" lay-filter="ins" >
        <option value="">请选择学院</option>
        <option value="1001">计算机学院</option>
        <option value="1006">文学院</option>
        <option value="1004">管理学院</option>
        <option value="1005">经济学院</option>
        <option value="1007">理学院</option>
        <option value="1002">医学院</option>
        <option value="1003">体育学院</option>
      </select>
    </div>
  </div>
    <div class="layui-form-item">
    <label class="layui-form-label">专业</label>
    <div class="layui-input-block">
      <select name="pro"  id="pro" lay-filter="pro">
        <option value="">专业</option>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">联系电话</label>
    <div class="layui-input-block">
      <input type="text" name="tele"  placeholder="请输入电话" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">地址</label>
    <div class="layui-input-block">
      <input type="text" name="address"  placeholder="请输入年级" autocomplete="off" class="layui-input">
    </div>
  </div>
  <button class="layui-btn" style="margin:0 220px;">确定修改</button>
  <button class="layui-btn layui-btn-danger" style="margin:0 220px;">取消保存</button>
  </form>
  </div>
  </div>
  <script type="text/javascript">
    layui.use(['layer','form'], function(){
      var layer = layui.layer;
      var form = layui.form; 
      form.render();
      form.on('select(ins)', function(data){ //no是那个lay-filter的值
    	   var ins =$("#ins option:selected").val();//获得选中的option的值
    	       alert(ins);//没啥用
    	        $.ajax({
    	                     url: '<%=basePath%>admin/queryPro?ins='+ins,   //带参数将这个传到后台条件查询方法里面
    	                     type: "Get",
    	                     contentType : "application/json",
    	                     async: false,//同步
    	                     success: function (result) {
    	                       var data = result.data;
    	                       alert(data);
    	                       var str="";
    	                       for(var x in data){
    	                       str += '<option value = "' + data[x].proId + '">' + data[x].proName + '</option>';
    	                            } 
    	                       $("#pro").html(str);
    	                      }
    	               });
    	             form.render('select');//最后记得渲染
    	       });
     });

    
  </script>
</rapid:override>
<%@ include file="base.jsp"%>