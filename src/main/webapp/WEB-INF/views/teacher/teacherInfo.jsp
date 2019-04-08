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
     <form id="updateInfoById" action="<%=basePath%>teacher/updateInfoById" method="post" >
    <table class="layui-table" style="margin:80px 400px; width:450px;">
        <colgroup>
            <col width="200">
            <col width="250">
            <col width="200">
            <col width="250">
            <col width="200">
            <col width="250">
        </colgroup>
        <tbody>
        <tr style="height:40px;">
            <td>教师编号</td>
            <td>${teacher.teaId}</td>
        </tr>
        <tr>
            <td>姓名</td>
            <td>${teacher.teaName}</td>
        </tr>
         <tr>
            <td>年龄</td>
            <td>${teacher.tage}</td>
        </tr>
         <tr>
            <td>性别</td>
            <td>${teacher.tsex}</td>
        </tr>
         <tr>
            <td>所属学院</td>
            <td>${teacher.insName}</td>
        </tr>
         <tr>
            <td>电话</td>
           <td><input value="${teacher.tele}" type="text"  id="tele" name="tele" ></td> 
        </tr>
         <tr>
            <td>地址</td>
            <td><input value="${teacher.address}" type="text"  id="address" name="address" ></td> 
        </tr>
        </tbody>
    </table>
    </form>
    <button class="layui-btn layui-btn-danger  layui-btn-lg" onclick="change()" style="margin:0 550px;">
        修改密码
    </button>
     <button type="button" class="layui-btn   layui-btn-lg"  id="save" style="margin:0 550px;">
        保存修改
    </button>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script>
        function change() {
            window.location.href="<%=basePath%>teacher/editTeaPass";
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
