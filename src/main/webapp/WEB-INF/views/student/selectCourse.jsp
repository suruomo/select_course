<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<rapid:override name="head">
    <title>课程信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" media="screen" type="text/css" />
</rapid:override>

<rapid:override name="content">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <p style="color:red; margin-top:10px; font-size:15px;">${msg}</p>
    <div class="distribution-map">
    <img src="${pageContext.request.contextPath}/static/images/M7aUkuS.jpg"> 
  <button class="map-point" style="top:39%;left:27%" onclick="location.href='publicCourse'" >
  </button>
  <button class="map-point" style="top:35%;left:50%" onclick="location.href='professionCourse'">
  </button>
  <button class="map-point" style="top:45%;left:75%" onclick="location.href='tongShiCourse'">
  </button>
</div>
</rapid:override>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="${pageContext.request.contextPath}/static/js/modernizr.js"></script>
<script src='${pageContext.request.contextPath}/static/js/angular.js'></script>
    <script>
   // function changePass() {
   // window.location.href = "courseList?page=1";
    //}
    </script>
<%@ include file="base.jsp" %>
