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
    <div>
       <c:if test="${teacher.insName=='体育学院'}">
         <button type="button" onclick="insertTi()" class="layui-btn layui-btn-lg layui-btn-warm" style="margin-top:15px;">添加体育课程</button>
       </c:if>
       <c:if test="${teacher.insName!='体育学院'}">
         <button type="button" onclick="insert()" class="layui-btn layui-btn-lg " style="margin-top:15px;">添加非体育课程</button>       
       </c:if>
    </div>
    <script>
        function insert() {
            window.location.href="<%=basePath%>teacher/insertCourse";
        }
        function insertTi() {
            window.location.href="<%=basePath%>teacher/insertTiCourse";
        }
    </script>
    <table class="layui-table" style="margin-top:15px;">
        <colgroup>
            <col width="80">
            <col width="80">
            <col width="60">
            <col width="120">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="50">
            <col width="200">
            <col width="120">
        </colgroup>
        <thead>
            <tr>
                <th>开课学年</th>
                <th>开课学期</th>
                <th>课程编号</th>
                <th>课程名称</th>
                <th>课程项目</th>
                <th>课程性质</th>
                <th>课程类别</th>
                <th>课程学分</th>
                <th>人数限制</th>
                <th>已选人数</th>
                <th>专业限制</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${paging.dataList}" var="course">
                <tr>
                    <td>${course.year}</td>
                    <td>${course.term}</td>
                    <td>${course.classId}</td>
                    <td>${course.className}</td>
                    <td>${course.item}</td>
                    <td>${course.type}</td>
                    <td>${course.classify}</td>
                    <td>${course.credit}</td>
                    <td>${course.classNum}</td>
                    <td>${course.classChooseNum}</td>
                    <td>
                        <c:forEach items="${course.classLimitProName}" var="proname">
                            ${proname}&nbsp;
                        </c:forEach>
                    </td>
                    <td>
                        <button class="layui-btn layui-btn-radius" onclick="edit(${course.classId})">修改</button>
                        <button class="layui-btn layui-btn-radius layui-btn-danger" onclick="delete_fun(${course.classId})">删除</button>
                        <button class="layui-btn layui-btn-radius layui-btn-primary" onclick="detail_fun(${course.classId})">录入成绩</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div style="text-align:center; margin-top:10px; margin-left:-100px;" >
        <c:if test="${paging.totalPage >=0}">
            <p style=" color: black; font-size:16px; margin-bottom:10px;">当前第 ${paging.currentPage } 页/共  ${paging.totalPage} 页</p>
            <c:choose>
                <c:when test="${paging.totalPage==0}">
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage==1 && paging.totalPage==1}">
                    <button class="layui-btn" onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage==1 && paging.totalPage>1}">
                    <button class="layui-btn" onclick="goPage(1)">首页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage>1 && paging.currentPage<paging.totalPage}">
                    <button class="layui-btn" onclick="goPage(1)">首页</button>
                    <button class="layui-btn" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
                <c:when test="${paging.currentPage>1 && paging.currentPage==paging.totalPage}">
                    <button class="layui-btn" onclick="goPage(1)">首页</button>
                    <button class="layui-btn" onclick="goPage(${paging.currentPage-1})">上一页</button>
                    <button class="layui-btn layui-btn-disabled" onclick="goPage(${paging.currentPage+1})">下一页</button>
                    <button class="layui-btn" onclick="goPage(${paging.totalPage})">末页</button>
                </c:when>
            </c:choose>
        </c:if>
    </div>
    <script>
        function goPage(page){
            window.location.href="<%=basePath%>teacher/courseList?page="+page;
        }
        function edit(classId) {
            window.location.href="<%=basePath%>teacher/editCourse?courseid="+classId;
        }
        function delete_fun(classId) {
            var r=confirm("确认删除吗？")
            if (r==true)
            {
                window.location.href="<%=basePath%>teacher/deleteCourse?courseid="+classId;
            }
            else
            {
                return;
            }
        }
        function detail_fun(classId) {
            window.location.href="<%=basePath%>teacher/detailCourse?courseid="+classId+"&page="+1;
        }
    </script>
</rapid:override>
<%@ include file="base.jsp" %>
