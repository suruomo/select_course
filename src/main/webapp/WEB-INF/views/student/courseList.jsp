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
    <form class="layui-form" style="margin:10px 15px 10px;">
        <div class="layui-form-item">
            <div class="layui-input-block">
                <div style="display: inline-block">
                    <div style="width: 180px; float: left; margin-left:-100px;">
                        <select class="layui-select" id="teasearch">
                            <option value="0">必修</option>
                            <option value="1">选修</option>
                        </select>
                    </div>
                    <button type="button" id="tea" class="layui-btn layui-btn-radius " style="margin-left:10px;">筛选</button>
                </div>
                <button id="sea" type="button" class="layui-btn layui-btn-radius"style="float:right;" onclick="search()">搜索</button>
                <input type="text" id="search" class="layui-input" style="float:right; width:200px;"
                       placeholder="请输入课程编号">
            </div>
        </div>
    </form>
    <p style="color:red; margin-top:10px; font-size:30px;">${msg}</p>
    <p style="color:red; margin-top:10px; font-size:30px;">${alert}</p>
    <table class="layui-table" style="margin-top:15px;">
        <colgroup>
            <col width="10">
            <col width="10">
            <col width="100">
            <col width="120">
            <col width="80">
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
                <td>${course.teaName}</td>
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
                    <c:choose>
                        <c:when test="${course.classNum==course.classChooseNum}">
                            <button class="layui-btn layui-btn-radius" onclick="detail_fun(${course.classId})" disabled
                                    style="background-color: gray;">已满
                            </button>
                        </c:when>
                        <c:when test="${course.isChoose==1}">
                            <button class="layui-btn layui-btn-radius" onclick="detail_fun(${course.classId})" disabled
                                    style="background-color: gray;">已选
                            </button>
                            <button class="layui-btn layui-btn-radius layui-btn-danger"  onclick="delete_fun(${course.classId})">退课
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="layui-btn layui-btn-radius " onclick="detail_fun(${course.classId})">选择
                            </button>
                        </c:otherwise>
                    </c:choose>
                </td>
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
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
    <script>
      layui.use(['layer','form'],  function(){
    	var layer = layui.layer;
    	var form = layui.form; 
    	form.render();  
      });
    </script>
    <script>
        function goPage(page) {
            window.location.href = "<%=basePath%>student/courseList?page=" + page;
        }

        function detail_fun(classId) {
            window.location.href = "<%=basePath%>student/courseDetail?flag=<%=0%>&classId=" + classId;
        }

        function delete_fun(classId) {
            var r = layer.confirm("确认退课吗？")
            if (r == true) {
                window.location.href = "<%=basePath%>student/deleteCourse?flag=<%=0%>&courseid=" + classId;
            }
            else {
                return;
            }
        }
    </script>
    <script>
        $(function () {
            $("#tea").click(function () {
                var id=$("#teasearch option:selected").val();
                if(id==0){    //必修
                	window.location.href="<%=basePath%>student/searchListBybixiu";
                }
                else{   //选修
                    window.location.href="<%=basePath%>student/searchListByxuanxiu";
                }
            });
            $("#sea").click(function () {
            	 var courseid =$("#search").val();
            	 if(courseid==""){
            		 layer.msg('搜索项为空！', {icon: 2});
            	 }
            	 else{
            		 window.location.href = "<%=basePath%>student/searchCourse?courseid=" + courseid;
            	 }
                 
            });

        })
        
    </script>
</rapid:override>
<%@ include file="base.jsp" %>
