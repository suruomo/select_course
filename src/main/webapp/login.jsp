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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/loginCss.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
	<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.all.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/modules/layer/default/layer.css">
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
<div class="formdiv" style="height:100%;background-size:cover;background-image:url('${pageContext.request.contextPath}/static/images/HyNiai43z.jpg')">
    <form id="contact" action="<%=basePath%>check" method="post">
        <h3>网上选课系统</h3>
        <h4>欢迎使用</h4>
        <h4 style="color:red;">${msg}</h4>
        <fieldset class="layui-input-inline">
         <i class="layui-icon" style="position: absolute;top:8px;right: 8px;">&#xe66f;</i>
         <input type="text" name="userid" id="userid" placeholder="用户名" >
        </fieldset>
        <fieldset  class="layui-input-inline">
         <i class="layui-icon " style="position: absolute;top:8px;right: 8px;">&#xe673;</i>
            <input type="password" name="userpass" placeholder="密码"  >
        </fieldset>
        <fieldset>   
            <input name="sub" type="button"  id="contact-submit" value="登录" />
        </fieldset>
        <fieldset>
        <div class="layui-footer">
    <!-- 底部固定区域 -->
    <h5 class="copyright">Copyright ©2019 网上选课系统 by suruomo</h5>
  </div>
        </fieldset>
    </form>

    <script>
        $(function () {
            $("#contact-submit").click(function () {   
            	if($("#userid").val()==""||$("#password").val()==""){
            		layer.msg('必填项为空！', {icon: 2});
            	}
            	else{
            		  $("#contact").submit();
            	}
              
                
            })
        })
    </script>
</div>
</body>
</html>
