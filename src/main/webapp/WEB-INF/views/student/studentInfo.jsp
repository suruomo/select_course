<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<rapid:override name="head">
    <title>个人资料</title>
</rapid:override>
<rapid:override name="content">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <form id="updateInfoById" action="<%=basePath%>student/updateInfoById" method="post" >
    <table class="layui-table" style="margin:80px 400px; width:450px;">
        <colgroup>
            <col width="200">
            <col width="250">
        </colgroup>
        <tbody>
        
        <tr style="height:40px;">
            <td>学号</td>
            <td>${student.stuId}</td>
        </tr>
        <tr>
            <td>姓名</td>
            <td>${student.stuName}</td>
        </tr>
        <tr>
            <td>年级</td>
            <td>${student.grade}</td>
        </tr>
         <tr>
            <td>用户状态</td>
            <td>${student.state}</td>
        </tr>
         <tr>
            <td>性别</td>
            <td>${student.sex}</td>
        </tr>
        <tr>
            <td>年龄</td>
            <td>${student.sage}</td>
        </tr>
         <tr>
            <td>电话</td>
            <td><input value="${student.tele}" type="text"  id="tele" name="tele" ></td>           
        </tr>
         <tr>
            <td>专业</td>
            <td>${student.proName}</td>
        </tr>
         <tr>
            <td>学院</td>
            <td>${student.insName}</td>
        </tr>
        <tr>
            <td>地址</td>
           <td><input value="${student.address}" type="text"  id="address" name="address" ></td>           
        </tr>
        </tbody>
    </table>
    </form>
    <button class="layui-btn layui-btn-danger  layui-btn-lg" onClick="changePass()" style="margin:0 550px;">
        修改密码
    </button>
      <button type="button" class="layui-btn   layui-btn-lg"  id="save" style="margin:0 550px;">
        保存修改
    </button>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script>
    function changePass(){
   	 window.location.href = "<%=basePath%>student/editStuPass";
   } 
    </script>
    <script>    
    $(function () {
        $("#save").click(function () { 
        	if($("#tele").val()==""||$("#address").val()==""){
        		alert("部分数据为空，请重新填写！");
        	}
        	else {
        		 var testnum = /^1[34578]\d{9}$/;
                 var tele=$("#tele").val();    
                 if (testnum.test(tele)) {         //检验是数字提交服务器
                	 $("#updateInfoById").submit();
                	 alert("修改已保存");
                 }
                 else {
                     alert("请输入正确电话号码");}       
        	}		
        })
    })
    </script>
</rapid:override>
<%@ include file="base.jsp" %>
