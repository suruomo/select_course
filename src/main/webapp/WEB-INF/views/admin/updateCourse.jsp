<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>修改学生信息</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
	<title>网上选课后台管理</title>
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
	<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
  <style>
  	.layui-input{
		width:200px;
	}
	h1,button{margin-left:130px;}
  </style>
  <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <script type="text/javascript">
    layui.use(['layer','form'], function(){
      var layer = layui.layer;
      var form = layui.form; 
      form.render();  
     });
  </script>
</head>
<body>
<form class="layui-form">
 <div class="layui-form-item">
           <div class="layui-form-item">
            <label class="layui-form-label">开课老师id</label>
            <div class="layui-input-block">
                <input value="${tea}" disabled="disabled"type="text" name="teaId" id="teaId" autocomplete="off" class="layui-input">
            </div>
        </div>
            <label class="layui-form-label">开课学年</label>
            <div class="layui-input-block">
            <select id="year">
               <c:if test="${courseInfo.year=='2017-2018'}">
                <option value="2017-2018" selected="selected">2017-2018</option>
                <option value="2018-2019">2018-2019</option>
                <option value="2019-2020">2019-2020</option>
               </c:if>
                <c:if test="${courseInfo.year=='2018-2019'}">
                <option value="2017-2018" >2017-2018</option>
                <option value="2018-2019" selected="selected">2018-2019</option>
                <option value="2019-2020">2019-2020</option>
               </c:if>
                <c:if test="${courseInfo.year=='2019-2020'}">
                <option value="2017-2018" >2017-2018</option>
                <option value="2018-2019">2018-2019</option>
                <option value="2019-2020" selected="selected">2019-2020</option>
               </c:if>        
           </select>
           </div>
        </div>
         <div class="layui-form-item">
            <label class="layui-form-label">开课学期</label>
            <div class="layui-input-block">
            <select id="term" >
               <c:if test="${courseInfo.term=='第一学期'}">
                 <option value="第一学期" selected="selected">第一学期</option>
                 <option value="第二学期">第二学期</option>
               </c:if>
                <c:if test="${courseInfo.term=='第二学期'}">
                 <option value="第一学期" >第一学期</option>
                 <option value="第二学期" selected="selected">第二学期</option>
               </c:if>
           </select>
           </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程名称</label>
            <div class="layui-input-block">
                <input value="${courseInfo.className}" type="text" name="coursename" id="name" placeholder="请输入课程名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程性质</label>
            <div class="layui-input-block"id="ty">
               <c:if test="${courseInfo.type=='必修'}">
                 <input type="radio" name="type" value="必修" title="必修" checked>
                 <input type="radio" name="type" value="选修" title="选修" >
               </c:if>
               <c:if test="${courseInfo.type=='选修'}">
                  <input type="radio" name="type" value="必修" title="必修" >
                  <input type="radio" name="type" value="选修" title="选修" checked>
               </c:if>
  
            </div>
        </div>
         <div class="layui-form-item">
            <label class="layui-form-label">课程类别</label>
            <div class="layui-input-block" id="le">
             <c:if test="${courseInfo.classify=='公共课'}">
                <input type="radio" id="classify" name="classify" value="公共课" title="公共课" checked >
                <input type="radio" id="classify" name="classify" value="专业课" title="专业课" >
                <input type="radio" id="classify" name="classify" value="通识课" title="通识课" >
             </c:if>
             <c:if test="${courseInfo.classify=='专业课'}">
                <input type="radio" id="classify" name="classify" value="公共课" title="公共课"  >
                <input type="radio" id="classify" name="classify" value="专业课" title="专业课" checked>
                <input type="radio" id="classify" name="classify" value="通识课" title="通识课" >
             </c:if>
              <c:if test="${courseInfo.classify=='通识课'}">
                <input type="radio" id="classify" name="classify" value="公共课" title="公共课"  >
                <input type="radio" id="classify" name="classify" value="专业课" title="专业课" >
                <input type="radio" id="classify" name="classify" value="通识课" title="通识课" checked>
             </c:if>   
            </div>
        </div>
       <div class="layui-form-item">
            <label class="layui-form-label">课程项目</label>
            <div class="layui-input-block" >
              <select id="item" lay-verify="">
               <c:if test="${courseInfo.className=='大学体育'}">
                   <option value="乒乓球" selected="selected">乒乓球</option>
                   <option value="羽毛球">羽毛球</option>
                   <option value="田径">田径</option>
                   <option value="篮球">篮球</option>
               </c:if>
               <c:if test="${courseInfo.className!='大学体育'}">
                   <option value="无" selected="selected">无</option>
               </c:if>  
             </select>
            </div>    
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程学分</label>
            <div class="layui-input-block">
                <input type="text" name="coursecredit" id="credit" value="${courseInfo.credit}"autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">人数限制</label>
            <div class="layui-input-block">
                <input value="${courseInfo.classNum}" type="text" name="coursenum" id="num" placeholder="请输入人数" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学院限制</label>
            <div class="layui-input-block">
                <label class="layui-form-label">计算机学院</label>   
                   <div class="layui-form-item">  
                       <c:forEach items="${jisuanjiList}" var="pro">
                         <input type="checkbox" name="pro" value="${pro.proId}" title="${pro.proName}"
                            <c:forEach items="${checkpro}" var="checkpro">
                               <c:if test="${pro.proId==checkpro}">
                                checked
                               </c:if>
                            </c:forEach>
                         >
                        </c:forEach>   
                    </div>  
            <label class="layui-form-label">医学院</label>  
                   <div class="layui-form-item">  
                        <c:forEach items="${yiList}" var="pro">
                         <input type="checkbox" name="pro" value="${pro.proId}" title="${pro.proName}"
                          <c:forEach items="${checkpro}" var="checkpro">
                               <c:if test="${pro.proId==checkpro}">
                                checked
                               </c:if>
                            </c:forEach>
                         >
                        </c:forEach>   
                   </div>   
            <label class="layui-form-label">文学院</label>  
                   <div class="layui-form-item">  
                        <c:forEach items="${wenList}" var="pro">
                         <input type="checkbox" name="pro" value="${pro.proId}" title="${pro.proName}"
                          <c:forEach items="${checkpro}" var="checkpro">
                               <c:if test="${pro.proId==checkpro}">
                                checked
                               </c:if>
                            </c:forEach>
                         >
                        </c:forEach>   
                   </div>  
            <label class="layui-form-label">管理学院</label>  
                   <div class="layui-form-item">  
                        <c:forEach items="${guanliList}" var="pro">
                         <input type="checkbox" name="pro" value="${pro.proId}" title="${pro.proName}"
                          <c:forEach items="${checkpro}" var="checkpro">
                               <c:if test="${pro.proId==checkpro}">
                                checked
                               </c:if>
                            </c:forEach>
                         >
                        </c:forEach>   
                   </div>  
             <label class="layui-form-label">经济学院</label>  
                   <div class="layui-form-item">  
                        <c:forEach items="${jingjiList}" var="pro">
                         <input type="checkbox" name="pro" value="${pro.proId}" title="${pro.proName}"
                          <c:forEach items="${checkpro}" var="checkpro">
                               <c:if test="${pro.proId==checkpro}">
                                checked
                               </c:if>
                            </c:forEach>
                         >
                        </c:forEach>   
                   </div>  
              <label class="layui-form-label">理学院</label>  
                   <div class="layui-form-item">  
                        <c:forEach items="${liList}" var="pro">
                         <input type="checkbox" name="pro" value="${pro.proId}" title="${pro.proName}"
                          <c:forEach items="${checkpro}" var="checkpro">
                               <c:if test="${pro.proId==checkpro}">
                                checked
                               </c:if>
                            </c:forEach>
                         >
                        </c:forEach>   
                   </div>    
            </div>
        </div>
         <div class="layui-form-item">
            <label class="layui-form-label">课程简介</label>
            <div class="layui-input-block">
                <textarea name="introduction" id="introduction" required lay-verify="required" placeholder="${courseInfo.introduction}" class="layui-textarea"></textarea>
            </div>
        </div>
          <button type="button"  id="success" class="layui-btn">确定修改</button>
  </form>
  
<script src="${pageContext.request.contextPath}/lib/layui/layui.all.js"></script>
</body>
 <script>
        $(function () {
            $("#success").click(function () {
            	var year=$("#year option:selected").val();     //下拉框选学年
            	var term=$("#term option:selected").val();   //学期
            	var type=$('#ty input[name="type"]:checked ').val();    //单选框选课程性质
            	var credit=$("#credit").val();    //学分
                var name = $("#name").val();     //课程名称
                var teaId = $("#teaId").val();     
                var id = ${courseInfo.classId}
                var item=$("#item option:selected").val();   //体育项目
                var introduction = $("#introduction").val();    //简介
                var num = $("#num").val();         //课程容量
                var classify = $('#le input[name="classify"]:checked ').val();      //课程类别
                var ins = "";
                var count=0;
                $("input[name='pro']:checked").each(function () {
                    count++;
                    if (count === 1) {
                        ins = ins + $(this).attr("value");
                    }
                    else {
                        ins = ins + "," + $(this).attr("value");
                    }
                })
                var content=id+"|"+num+"|"+ins+"|"+credit+"|"+introduction+"|"+year+"|"+term+"|"+type+"|"+classify+"|"+name+"|"+item+"|"+teaId;
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
                myform.action = "<%=basePath%>admin/updateCourseSuccess";
                myform.submit();
                alert("修改已保存");
               document.body.removeChild(myform);
            })
        })
    </script>
</html>