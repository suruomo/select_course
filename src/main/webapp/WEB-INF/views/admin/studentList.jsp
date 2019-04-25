<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<rapid:override name="head">
	<title>首页</title>
    <rapid:block name="head"></rapid:block>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
	<title>网上选课后台管理</title>
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/table.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/layui.css"   media="all">
</rapid:override>
<rapid:override name="content">
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
<div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">
       <table class="layui-hide" id="test" lay-filter="test"></table>
       </div>
  </div>

<script>
    layui.use('table',  function(){
    	 var table = layui.table;
        //方法渲染
        table.render({
            elem: '#test'  //绑定table表格
            ,height: 450
            ,url: 'studentList.Action' //后台springmvc接收路径
            ,page:true    //true表示分页
            ,limit: 10
            ,title:'学生信息表'
            ,id:'contenttable'
            ,toolbar: '#toolbarDemo'
            ,cols: [[
                 {type: 'checkbox', fixed: 'left'}
                ,{field:'stuId', title:'学号', width:80, fixed: 'left', unresize: true, sort: true}
                ,{field:'stuName', title:'姓名', width:120, edit: 'text'}
                ,{field:'sage', title:'年龄', width:120, edit: 'text'}
                ,{field:'sex', title:'性别', width:80, edit: 'text', sort: true}
                ,{field:'tele', title:'电话', width:100}
                ,{field:'address', title:'地址', width:100, sort: true}
                ,{field:'proName', title:'专业', width:120}                      
                ,{field:'grade', title:'年级', width:120}
                ,{field:'state', title:'状态', width:120}
                ,{field:'insName', title:'学院名称', width:120}       
            ]]
        }); 

        //监听表格行点击
        table.on('tr', function(obj){
            console.log(obj)
        });
 
        //监听表格复选框选择
        table.on('checkbox(test)', function(obj){
            console.log(obj)
        });
 
        //监听表格单选框选择
        table.on('radio(test2)', function(obj){
            console.log(obj)
        });
 
        //监听单元格编辑
        table.on('edit(test2)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段
 
        });
 
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                layer.prompt({
                    formType: 2
                    ,value: data.username
                }, function(value, index){
                    obj.update({
                        username: value
                    });
                    layer.close(index);
                });
            }
        });
 
        var $ = layui.jquery, active = {
            getCheckData: function(){//获取选中数据
                var checkStatus = table.checkStatus('test')
                    ,data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
            ,getCheckLength: function(){//获取选中数目
                var checkStatus = table.checkStatus('test')
                    ,data = checkStatus.data;
                layer.msg('选中了：'+ data.length + ' 个');
            }
            ,isAll: function(){验证是否全选
                var checkStatus = table.checkStatus('test');
                layer.msg(checkStatus.isAll ? '全选': '未全选')
            }
            ,parseTable: function(){
                table.init('parse-table-demo', {
                    limit: 3
                });
            }
            ,add: function(){
                table.addRow('test')
            }
            ,delete: function(){
                layer.confirm('确认删除吗？', function(index){
                    table.deleteRow('test')
                    layer.close(index);
                });
            }
            ,reload:function () {
                var keyWord=$("#keyWord").val();
                var keyType=$("#key_type option:selected").val();
                table.reload('contenttable',{
                    where:{keyWord:keyWord,keyType:keyType}
                });
            }
        };
        $('i').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('.layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
    });
</script>
</rapid:override>
<%@ include file="base.jsp"%>