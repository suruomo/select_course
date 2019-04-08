<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid" %>
<rapid:override name="head">
    <title>添加新课程</title>
</rapid:override>
<rapid:override name="content">
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <form class="layui-form" id="changeform" method="post" action="<%=basePath%>teacher/changeTeaPass" style="margin:80px 400px; width:450px;">
        <div class="layui-form-item">
            <label class="layui-form-label">开课学年</label>
            <div class="layui-input-block">
            <select name="year" lay-verify="">
                <option value="2017-2018">2017-2018学年</option>
                <option value="2018-2019">2018-2019学年</option>
                <option value="2019-2020">2019-2020学年</option>
           </select>
           </div>
        </div>
         <div class="layui-form-item">
            <label class="layui-form-label">开课学期</label>
            <div class="layui-input-block">
            <select name="term" lay-verify="">
                <option value="1">第一学期</option>
                <option value="2">第二学期</option>
           </select>
           </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程名称</label>
            <div class="layui-input-block">
                <input type="text" name="coursename" id="name" placeholder="请输入课程名称" autocomplete="off" class="layui-input">
            </div>
        </div>
         <div class="layui-form-item">
            <label class="layui-form-label">课程性质</label>
            <div class="layui-input-block">
                 <input type="radio" name="type" value="必修" title="必修" checked>
                 <input type="radio" name="type" value="选修" title="选修" >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程学分</label>
            <div class="layui-input-block">
                <input type="text" name="coursecredit" id="credit" placeholder="请输入课程学分" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">人数限制</label>
            <div class="layui-input-block">
                <input type="text" name="coursenum" id="num" placeholder="请输入人数" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学院限制</label>
            <div class="layui-input-block">
                <c:forEach items="${insList}" var="ins">
                    <input type="checkbox" name="ins" value="${ins.insId}" title="${ins.insName}">
                </c:forEach>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程简介</label>
            <div class="layui-input-block">
                <textarea name="introduction" required lay-verify="required" placeholder="请输入课程简介" class="layui-textarea"></textarea>
            </div>
        </div>
    </form>
    <button type="button" id="success" class="layui-btn layui-btn-danger layui-btn-lg" style="margin:0 550px;">
        确认提交
    </button>
    <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(function () {
            $("#success").click(function () {
                var name = $("#name").val();
                var num = $("#num").val();
                var ins = "";
                var count=0;
                $("input[name='ins']:checked").each(function () {
                    count++;
                    if (count === 1) {
                        ins = ins + $(this).attr("value");
                    }
                    else {
                        ins = ins + "," + $(this).attr("value");
                    }
                })
                var content=name+"|"+num+"|"+ins;
                var myform=document.createElement("form");
                myform.id = "form1";
                myform.name = "form1";
                document.body.appendChild(myform);
                var input = document.createElement("input");
                input.type = "text";
                input.name = "content";
                input.value = encodeURIComponent(encodeURIComponent(content));
                myform.appendChild(input);
                myform.method = "POST";
                myform.action = "<%=basePath%>teacher/insertCourseSuccess?page="+1;
                myform.submit();
                document.body.removeChild(myform);
            })
        })
    </script>
</rapid:override>
<%@ include file="base.jsp" %>
