<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<rapid:override name="head">
	<title>首页</title>
	 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta charset="UTF-8">
	<title >网上选课后台管理</title>
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
	  <!-- 引入 ECharts 文件 -->
    <script src="${pageContext.request.contextPath}/echarts/echarts.js"></script>
     <script src="${pageContext.request.contextPath}/echarts/echarts.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css">
</rapid:override>
<rapid:override name="content">
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">  
       <div id="main" style="width: 800px; height: 500px; margin: 100px 200px; border: 3px solid gray;">

       </div>
  </div>
  </div>
   <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));

        // 指定图表的配置项和数据
option = {
    title : {
        text: '成绩统计',
        subtext: '成绩分布统计报表',
        x:'center'
    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        x : 'center',
        y : 'bottom',
        data:['不及格','60-70','70-80','80-90','90-100']
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {
                show: true,
                type: ['pie', 'funnel']
            },
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    series : [
        {
            name:'面积模式',
            type:'pie',
            radius : [30, 110],
            center : ['50%', '50%'],
            roseType : 'area',
            data:[
                {value:10, name:'不及格'},
                {value:5, name:'60-70'},
                {value:15, name:'70-80'},
                {value:25, name:'80-90'},
                {value:20, name:'90-100'}
            ]
        }
    ]
};
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    </script>
</rapid:override>
<%@ include file="base.jsp"%>