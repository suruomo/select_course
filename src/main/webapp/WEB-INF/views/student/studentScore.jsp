<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<rapid:override name="head">
    <title>课程信息</title>
</rapid:override>
<rapid:override name="content">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <p style="color:red; margin-top:10px; font-size:15px;">${msg}</p>
    <table class="layui-table" style="margin-top:15px;">
        <colgroup>
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
            <col width="10">
        </colgroup>
        <thead>
        <tr>
            <th>开课学年</th>
            <th>开课学期</th>
            <th>课程编号</th>
            <th>课程名称</th>
            <th>教师名称</th>
            <th>课程性质</th>
            <th>课程类别</th>
            <th>课程学分</th>
            <th>成绩</th>   
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${paging.dataList}" var="course">
            <tr>
                <td>${course.year}</td>
                <td>${course.term}</td>
                <td>${course.classId}</td>
                <td>${course.className}</td> 
                <td>${course.teaName}</td>
                <td>${course.type}</td>
                <td>${course.classify}</td>
                <td>${course.credit}</td>
                <td>${course.score}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
   <div style="text-align:center; margin-top:10px; margin-left:-100px;">
        <c:if test="${paging.totalPage >=0}">
            <p style=" color: black; font-size:16px; margin-bottom:10px;">当前第 ${paging.currentPage }
                页/共 ${paging.totalPage} 页</p>
            <c:choose>
                <c:when test="${paging.totalPage==0}">
                    <button class="layui-btn layui-btn-radius  layui-btn-disabled" onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-radius  layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-radius  layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn layui-btn-radius  layui-btn-disabled" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage==1 && paging.totalPage==1}">
                    <button class="layui-btn layui-btn-radius " onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-radius  layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-radius  layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn layui-btn-radius " onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage==1 && paging.totalPage>1}">
                    <button class="layui-btn layui-btn-radius " onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-radius  layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-radius l" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn layui-btn-radius " onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage>1 && paging.currentPage<paging.totalPage}">
                    <button class="layui-btn layui-btn-radius " onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-radius " onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-radius " onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn layui-btn-radius " onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage>1 && paging.currentPage==paging.totalPage}">
                    <button class="layui-btn layui-btn-radius " onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-radius " onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-radius  layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn layui-btn-radius " onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
            </c:choose>
        </c:if>
    </div>
     <script>
      layui.use(['layer','form'],  function(){
    	var layer = layui.layer;
    	var form = layui.form; 
    	form.render();  
      });
      function goPage(page) {
    	    window.location.href = "<%=basePath%>student/studentScore?page=" + page;
    	      }
    </script>
</rapid:override>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script>
     
        $(function () {
            $("#out").click(function () { 
                window.location.href="outputScore";  
            });

        })
    </script>
<%@ include file="base.jsp" %>
