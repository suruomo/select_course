<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://www.rapid-framework.org.cn/rapid" prefix="rapid"%>
<rapid:override name="head">
	<title>首页</title>
</rapid:override>
<rapid:override name="content">
	<%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
	<div
		style="width: 600px; height: 450px; margin: 100px 350px; border: 3px solid gray; background-size: cover; background: #D3D3D3">
		<h2 style="text-align: center; margin-top: 25px; margin-bottom: 25px;">西安建筑科技大学选课系统（学生界面）</h2>
		<h3 style="margin-left: 50px; margin-bottom: 10px;">1.
			2016级：形势与政策4（必修）

			2017级：材料力学Ⅰ（必修）、材料力学Ⅱ1（机械类）（必修）、理论力学Ⅱ2（机械类）（必修）、物理化学B（必修）、工程力学（必修/选修）、复变函数与积分变换（必修/选修）、计算方法（选修）、数学物理方程（选修）、运筹学（必修/选修）、分析化学（必修/选修）、大学英语4+大学英语拓展课2、马克思主义基本原理（必修）、毛泽东思想和中国特色社会主义理论体系概论（必修）、电工电子技术（必修/选修）、大学体育4（必修）。

			2018级:高等数学Ⅰ2（必修）、概率论与数理统计（选修）、大学物理1（必修）、无机化学Ⅰ2（必修/选修）、土木工程制图（必修/选修）、机械制图I（必修）、机械制图Ⅱ（必修/选修）、机械测绘（必修）、建筑透视与阴影2（选修）、大学英语2（必修）、思想道德修养与法律基础（必修）、中国近现代史纲要（必修）、大学体育2（必修）。

			2.各学院挂牌上课课程：以各学院通知为准。

			3.2018级需网上预约《无机化学实验2》的专业：环境学院环科、环工（卓越工程师）专业，资源工程学院矿加专业，冶金学院冶金、冶金（卓越工程师）、新能源专业，材料学院、化学与化工学院所有专业。

			4.2015级（建筑学院2014级）毕业班学生不参与本学期网上选课。 5.网络通识拓展课程网上报名及选课安排在下学期开学初第4周左右。</h3>
		<h3 style="margin-left: 50px; margin-bottom: 10px;">2.在（选课）中进行选课、查看、管理已选课程</h3>
	</div>
</rapid:override>
<%@ include file="base.jsp"%>