<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>"> 
<html>
<head>
    <title>登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
    <style type="text/css">
        .formdiv{
            padding:120px 500px;
        }
        /*解决Chrome下表单自动填充后背景色为黄色*/
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0px 1000px white inset;
        }
    </style>
</head>
<body>
<div class="formdiv" style="height:100%;background-size:cover;background-image:url('${pageContext.request.contextPath}/static/images/bg1.jpg')">
    <form id="contact" action="<%=basePath%>check" method="post">
        <h3>网上选课系统</h3>
        <h4>欢迎使用</h4>
        <h4 style="color:red;">${msg}</h4>
        <fieldset class="layui-input-inline">
         <i class="layui-icon" style="position: absolute;top:8px;right: 8px;">&#xe612;</i>
         <input placeholder="账号" type="text" name="userid" id="userid" >
        </fieldset>
        <fieldset  class="layui-input-inline">
         <i class="layui-icon " style="position: absolute;top:8px;right: 8px;">&#xe673;</i>
            <input placeholder="密码" type="password" name="userpass" >
        </fieldset>
        <fieldset>   
            <input name="sub" type="button" onclick="tijiao()" id="contact-submit" value="登录" />
        </fieldset>
    </form>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(function () {
            $("#contact-submit").click(function () {
                var testnum = /^\d{10}$/;
                var id=$("#userid").val();    
                if (testnum.test(id)) {         //检验是数字提交服务器
                    $("#contact").submit();
                }
                else {
                    alert("请输入正确学号");}
            })
        })
    </script>
</div>
</body>
</html>
