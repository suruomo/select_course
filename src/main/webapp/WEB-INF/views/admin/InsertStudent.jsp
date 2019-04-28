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
     <form class="layui-form"  style="padding: 80px;border:45px; width:550px;height: 450px;">
        <div class="layui-form-item">
    <label class="layui-form-label">姓名</label>
    <div class="layui-input-block">
      <input type="text" name="name"  placeholder="请输入姓名"   class="layui-input" lay-verify="required">
    </div>
            </div>
	<div class="layui-form-item">
    <label class="layui-form-label">年龄</label>
    <div class="layui-input-block">
      <input type="text" name="age"  placeholder="请输入年龄" autocomplete="off" class="layui-input">
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
     <select name="grade" id="grade" lay-filter="grade" >
        <option value="">请选择年级</option>  
        <option value="2014级">2014级</option>
        <option value="2015级">2015级</option>
        <option value="2016级">2016级</option>
      </select>
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
      <input type="text" name="tele"  placeholder="请输入电话"  lay-verify="phone" autocomplete="off" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">地址</label>
    <div class="layui-input-block">
      <input type="text" name="address"  placeholder="请输入地址" autocomplete="off" class="layui-input">
    </div>
  </div>    
  </form>
    <div class="layui-input-inline">
          <button name="add" id="add" class="layui-btn" style="margin:0 250px;" type="button" onClick="return check()">确定修改</button>
         </div>
         <div class="layui-input-inline">
          <button class="layui-btn layui-btn-danger" style="margin:0 250px;" type="button">取消保存</button>
         </div>
    </div>
  </div>
  <script type="text/javascript">
    layui.use(['layer','form'], function(){
      var layer = layui.layer;
      var form = layui.form; 
      form.render();  
      form.on('select(ins)', function(data){ //ins是那个lay-filter的值
    	   var ins =$("#ins option:selected").val();//获得选中的option的值
    	        $.ajax({
    	                     url: '<%=basePath%>admin/queryPro?ins='+ins,   //带参数将这个传到后台条件查询方法里面
    	                     type: "Get",
    	                     contentType : "application/json",
    	                     async: false,//同步
    	                     success: function (result) {
    	                       var data = result.data;
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
  <script>
  function check() {
      if($("input[name=name]").val()=='') {
            alert("请输入用户姓名!");
       }
      else  if( $("input[name=tele]").val()==''){
            alert("请输入联系方式!");
         }
		var stuName = $("input[name=name]").val(); 
		var sage = $("input[name=age]").val(); 
		var sex = $('#sex input[name="sex"]:checked ').val();
		var insId = $("#ins option:selected").val();
		var insName = $("#ins option:selected").text();
		var proId = $("#pro option:selected").val();
		var proName = $("#pro option:selected").text();
		var grade = $("#grade option:selected").val();
		var tele = $("input[name=tele]").val(); 
		var address = $("input[name=address]").val(); 
		//执行ajax请求
		$.ajax({
			url:'${pageContext.request.contextPath}/admin/addStu.action',
			method:'POST',
			data:{"stuName":stuName,"sage":sage,
					"sex":sex,"proId":proId,"proName":proName,"grade":grade,
					"tele":tele,"address":address,"insId":insId,"insName":insName},
			dataType:'text',
			success:function(data){
				 alert("添加成功");
				 window.location.href = "<%=basePath%>admin/studentList";
			}
		});
 }
  
  </script>
</rapid:override>
<%@ include file="base.jsp"%>