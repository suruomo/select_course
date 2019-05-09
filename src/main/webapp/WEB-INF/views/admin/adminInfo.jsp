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
    <form id="updateInfoById" action="<%=basePath%>admin/updateInfoById" method="post" >
    <table class="layui-table" style="margin:80px 400px; width:450px;">
        <colgroup>
            <col width="200">
            <col width="250">
        </colgroup>
        <tbody>
        
        <tr style="height:40px;">
            <td>账号</td>
            <td>${admin.adminId}</td>
        </tr>
        <tr>
            <td>姓名</td>
            <td><input value="${admin.adminName}" type="text"  id="name" name="name" ></td> 
        </tr>
    </table>
    
      <button type="button" class="layui-btn   layui-btn-lg"  id="save" style="margin:0 550px;">
        保存修改
    </button>
    </form>
   
    <script>
    function changePass(){
   	 window.location.href = "<%=basePath%>admin/editPass";
   } 
    </script>
    <script>    
    $(function () {
        $("#save").click(function () { 
                	 $("#updateInfoById").submit();
                	 alert("修改已保存");
           
        })
    })
    </script>
</rapid:override>
<%@ include file="base.jsp" %>
