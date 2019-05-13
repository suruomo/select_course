package com.zxc.controller.admin;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.zxc.controller.log.SystemLog;
import com.zxc.model.Admin;
import com.zxc.model.Course;
import com.zxc.model.Institution;
import com.zxc.model.LogEntity;
import com.zxc.model.Message;
import com.zxc.model.Student;
import com.zxc.model.Teacher;
import com.zxc.service.CourseService;
import com.zxc.service.LogService;
import com.zxc.service.MessageService;
import com.zxc.service.PageService;
import com.zxc.service.UserService;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("admin")
public class AdminController {
	    @Resource
	    private UserService userService;
	    @Resource
	    private PageService pageService;
	    @Resource
	    private CourseService courseService;
	    @Resource
	    private LogService logService;
	    @Resource
	    private MessageService messageService;
	    @Autowired
	    private JavaMailSender javaMailSender;//在spring中配置的邮件发送的bean
	    
	    @RequestMapping("/adminIndex")   //导航栏
	    @SystemLog(module="登陆模块",methods="管理员管理页面")
	    public String adminIndex(){
	        return "admin/adminIndex";
	    }
	    @RequestMapping("/studentList")   //学生管理界面
	    @SystemLog(module="学生模块",methods="学生管理页面")
	    public  String studentList(){    	
	    	return "admin/studentList";
	    }
	    @RequestMapping("/log")  
	    public  String log(){    	
	    	return "admin/log";
	    }
	    @RequestMapping(value="/log.Action",method = RequestMethod.GET,produces="application/json;charset=utf-8") 
	    @SystemLog(module="日志模块",methods="查看日志")
	    public @ResponseBody Map<String, Object> logListAction(@Param("page") int page, @Param("limit") int limit,HttpServletRequest request){
	    	int before = limit * (page - 1) + 1;
            int after = page * limit;
            System.out.println(before+","+after);
            List<LogEntity> stuList=new ArrayList<>();
            int count=0;
            stuList=logService.queryAll();
            count=stuList.size();
	    	Map<String, Object> map = new HashMap<>();
	    	//用json来传值     	
	    	JSONArray json = JSONArray.fromObject(stuList);
	    	System.out.println(json);
            //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常    
	    	map.put("code",0);
	    	map.put("msg","");
	    	map.put("data",json);
	    	map.put("count",count);
	    	return map;    	
	    }
	    @RequestMapping(value="/MessageList.Action",method = RequestMethod.GET,produces="application/json;charset=utf-8") 
	    @SystemLog(module="公告模块",methods="查看公告")
	    public @ResponseBody Map<String, Object> MessageListAction(@Param("page") int page, @Param("limit") int limit,HttpServletRequest request){
	    	int before = limit * (page - 1) + 1;
            int after = page * limit;
            System.out.println(before+","+after);
            List<Message> List=new ArrayList<>();
            int count=0;
            List=messageService.queryAll();
            count=List.size();
	    	Map<String, Object> map = new HashMap<>();
	    	//用json来传值     	
	    	JSONArray json = JSONArray.fromObject(List);
	    	System.out.println(json);
            //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常    
	    	map.put("code",0);
	    	map.put("msg","");
	    	map.put("data",json);
	    	map.put("count",count);
	    	return map;    	
	    }
	    @RequestMapping(value="/studentList.Action",method = RequestMethod.GET,produces="application/json;charset=utf-8")   //学生管理界面
	    @SystemLog(module="学生模块",methods="查看学生列表")
	    public @ResponseBody Map<String, Object> studentListAction(@Param("page") int page, @Param("limit") int limit,HttpServletRequest request){
	    	int before = limit * (page - 1) + 1;
            int after = page * limit;
            System.out.println(before+","+after);
            String ins=request.getParameter("insId");
            System.out.println(ins);
            List<Student> stuList=new ArrayList<>();
            int count=0;
            if(ins==null) {
            	stuList=userService.queryAllStu();
            	count=stuList.size();
            }
            else {
            	stuList=userService.queryAllStuByIns(Integer.parseInt(ins));
            	 count=stuList.size();
            }
	    	Map<String, Object> map = new HashMap<>();
	    	//用json来传值     	
	    	JSONArray json = JSONArray.fromObject(stuList);
	    	System.out.println(json);
            //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常    
	    	map.put("code",0);
	    	map.put("msg","");
	    	map.put("data",json);
	    	map.put("count",count);
	    	return map;    	
	    }
	    @RequestMapping(value="/teacherList.Action",method = RequestMethod.GET,produces="application/json;charset=utf-8")   //学生管理界面
	    @SystemLog(module="教师模块",methods="查看教师列表")
	    public @ResponseBody Map<String, Object> teacherListAction(@Param("page") int page, @Param("limit") int limit){
	    	int before = limit * (page - 1) + 1;
            int after = page * limit;
            System.out.println(before+","+after);
	    	List<Teacher> teaList=userService.queryAllTeacher();
	    	Map<String, Object> map = new HashMap<>();
	    	
	    	int count=teaList.size();
	    	//用json来传值     	
	    	JSONArray json = JSONArray.fromObject(teaList);
	    	System.out.println(json);
            //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常    
	    	map.put("code",0);
	    	map.put("msg","");
	    	map.put("data",json);
	    	map.put("count",count);
	    	return map;    	
	    }
	    @RequestMapping(value="/courseList.Action",method = RequestMethod.GET,produces="application/json;charset=utf-8")   //学生管理界面
	    @SystemLog(module="课程模块",methods="查看课程列表")
	    public @ResponseBody Map<String, Object> courseListAction(@Param("page") int page, @Param("limit") int limit,HttpServletRequest request){
	    	int before = limit * (page - 1) + 1;
            int after = page * limit;
            System.out.println(before+","+after);
            String classCheck=request.getParameter("classCheck");
            List<Course> courseList=new ArrayList<>();
            System.out.println(classCheck);
            if(classCheck==null) {
            	courseList=courseService.queryAllCourseByAdmin();
            }
            else {
            	courseList=courseService.queryCourseByCheck(classCheck);
            }
	    	//List<Course> courseList=courseService.queryAllCourseByAdmin();
	    	Map<String, Object> map = new HashMap<>();
	    	int count=courseList.size();
	    	//用json来传值     	
	    	JSONArray json = JSONArray.fromObject(courseList);
	    	System.out.println(json);
            //*****转为layui需要的json格式，必须要这一步，
	    	map.put("code",0);
	    	map.put("msg","");
	    	map.put("data",json);
	    	map.put("count",count);
	    	return map;    	
	    }
	    
	    @RequestMapping(value="/queryPro",method = RequestMethod.GET,produces="application/json;charset=utf-8")   //学生管理界面
	    public @ResponseBody Map<String, Object> queryPro(int ins){
            System.out.println(ins);
	    	List<Institution> proList=courseService.queryAllproByIns(ins);
	    	Map<String, Object> map = new HashMap<>();
	    	int count=proList.size();
	    	//用json来传值     	
	    	JSONArray json = JSONArray.fromObject(proList);
            //*****转为layui需要的json格式，必须要这一步，  
	    	map.put("code",0);
	    	map.put("msg","");
	    	map.put("data",json);
	    	map.put("count",count);
	    	return map;    	
	    }
	    @RequestMapping("/teacherList")   //教师管理界面
	    @SystemLog(module="教师模块",methods="查看教师列表")
	    public String teacherList(){
	        return "admin/teacherList";
	    }
	    @RequestMapping("/courseCheck")   //课程审核界面
	    @SystemLog(module="审核模块",methods="查看课程审核列表")
	    public String courseCheck(){
	        return "admin/courseCheck";
	    }
	    @RequestMapping("/updateStudent")   
	    @SystemLog(module="学生模块",methods="修改学生信息页面")
	    public String updateStudent(Integer id,Model model){
	    	System.out.println(id);
	    	model.addAttribute("student",userService.getStuInfoById(id));   //根据id查找学生信息
	        return "admin/updateStudent";   //根据id查找学生信息
	    }
	    @RequestMapping("/updateTeacher")  
	    @SystemLog(module="教师模块",methods="修改教师信息页面")
	    public String updateTeacher(Integer id,Model model){
	    	System.out.println(id);
	    	model.addAttribute("teacher",userService.getTeaInfoById(id));   //根据id查找教师信息
	        return "admin/updateTeacher";   //根据id查找学生信息
	    }
	    @RequestMapping("/insertCourse")    //录入非体育课程
	    @SystemLog(module="课程模块",methods="增加课程页面")
	    public String insertCourse(Model model){
	        //model.addAttribute("insList",courseService.queryAllIns());
	        model.addAttribute("jisuanjiList",courseService.queryAllproByIns(1001));
	        model.addAttribute("yiList",courseService.queryAllproByIns(1002));
	        model.addAttribute("guanliList",courseService.queryAllproByIns(1004));
	        model.addAttribute("wenList",courseService.queryAllproByIns(1006));
	        model.addAttribute("jingjiList",courseService.queryAllproByIns(1005));
	        model.addAttribute("liList",courseService.queryAllproByIns(1007));
	        return "admin/insertCourse";
	    }
	    @RequestMapping("/insertCourseSuccess")    //插入文化课程成功
	    @SystemLog(module="课程模块",methods="增加课程-数据库")
	    public String insertCourseSuccess(@Param("content") String content, Model model, HttpServletRequest request)throws UnsupportedEncodingException{
	    	System.out.println(content);
	    	String[] det= URLDecoder.decode(URLDecoder.decode(content,"utf-8"),"utf-8").split("\\|");
	        //获取插入后的课程编号
	    	for(int i=0;i<det.length;i++) {
	    		System.out.println(det[i]);
	    	}
	        int courseId=courseService.insertWenCourse(det[0],det[1],det[3],det[4],det[5],det[6],det[7],det[8],"审核通过",Integer.parseInt(det[9]));
	        courseService.insertProLimit(det[2],courseId);
	        return "admin/courseList";
	    }
	    @RequestMapping("/insertTiCourse")    //录入体育课程
	    @SystemLog(module="课程模块",methods="增加课程页面")
	    public String insertTiCourse(Model model){
	        //model.addAttribute("insList",courseService.queryAllIns());
	        model.addAttribute("jisuanjiList",courseService.queryAllproByIns(1001));
	        model.addAttribute("yiList",courseService.queryAllproByIns(1002));
	        model.addAttribute("guanliList",courseService.queryAllproByIns(1004));
	        model.addAttribute("wenList",courseService.queryAllproByIns(1006));
	        model.addAttribute("jingjiList",courseService.queryAllproByIns(1005));
	        model.addAttribute("liList",courseService.queryAllproByIns(1007));
	        return "admin/insertTiCourse";
	    }
	    @RequestMapping("/insertTiCourseSuccess")    //插入体育课程成功
	    @SystemLog(module="课程模块",methods="增加课程-数据库")
	    public String insertTiCourseSuccess(@Param("content") String content, Model model, HttpServletRequest request)throws UnsupportedEncodingException{
	    	System.out.println(content);
	    	String[] det= URLDecoder.decode(URLDecoder.decode(content,"utf-8"),"utf-8").split("\\|");
	        //获取插入后的课程编号
	    	for(int i=0;i<det.length;i++) {
	    		System.out.println(det[i]);
	    	}
	        int courseId=courseService.insertCourse(det[0],det[1],det[3],det[4],det[5],det[6],det[7],det[8],det[9],"审核通过",Integer.parseInt(det[10]));
	        courseService.insertProLimit(det[2],courseId);
	        return "admin/courseList";
	    }
	    @RequestMapping("/updateCourse")  
	    @SystemLog(module="课程模块",methods="修改课程信息页面")
	    public String updateCourse(Integer id,Integer teaid,Model model){
	    	System.out.println(id);
	    	 model.addAttribute("courseInfo",courseService.queryCourse(id));   //根据id查找课程信息
	    	 model.addAttribute("tea",courseService.queryTeaByCourse(id));  
	    	 model.addAttribute("checkpro",courseService.selectCourseLimit(id));
	         model.addAttribute("jisuanjiList",courseService.queryAllproByIns(1001));
	         model.addAttribute("yiList",courseService.queryAllproByIns(1002));
	         model.addAttribute("guanliList",courseService.queryAllproByIns(1004));
	         model.addAttribute("wenList",courseService.queryAllproByIns(1006));
	         model.addAttribute("jingjiList",courseService.queryAllproByIns(1005));
	         model.addAttribute("liList",courseService.queryAllproByIns(1007));
	        return "admin/updateCourse";   //根据id查找学生信息
	    }
	    @RequestMapping("/updateCourseSuccess")   //修改课程成功
	    @SystemLog(module="课程模块",methods="修改课程-数据库")
	    public String updateCourseSuccess(@Param("content") String content, Model model, HttpServletRequest request)throws UnsupportedEncodingException{
	        String[] det= URLDecoder.decode(URLDecoder.decode(content,"utf-8"),"utf-8").split("\\|");
	        for(int i=0;i<det.length;i++) {
	        	System.out.println(det[i]);
	        }
	         System.out.println("老师"+det[11]);
	         int courseId=courseService.updateCourse(Integer.parseInt(det[0]),det[1],det[3],det[4],det[5],det[6],det[7],det[8],det[9],det[10],"待审核",Integer.parseInt(det[11]));
	         System.out.println(det[2]);
	         courseService.updateProLimit(det[2],courseId);   //修改数据
	         model.addAttribute("tea",det[11]);  
	         model.addAttribute("courseInfo",courseService.queryCourse(Integer.parseInt(det[0])));   //根据id查找课程信息
	    	 model.addAttribute("teaId",Integer.parseInt(det[11]));   
	    	 model.addAttribute("checkpro",courseService.selectCourseLimit(Integer.parseInt(det[0])));
	         model.addAttribute("jisuanjiList",courseService.queryAllproByIns(1001));
	         model.addAttribute("yiList",courseService.queryAllproByIns(1002));
	         model.addAttribute("guanliList",courseService.queryAllproByIns(1004));
	         model.addAttribute("wenList",courseService.queryAllproByIns(1006));
	         model.addAttribute("jingjiList",courseService.queryAllproByIns(1005));
	         model.addAttribute("liList",courseService.queryAllproByIns(1007));
	        return "admin/updateCourse";
	    }
	    @RequestMapping("/checkedList")    //查看已选课程名单
	    @SystemLog(module="选课模块",methods="查看已选名单页面")
	    public String checkedList(Integer id,Model model){
	    	System.out.println(id);
	    	model.addAttribute("course",courseService.queryInfoById(id));   
	        return "admin/checkedNameList";   
	    }
	    @RequestMapping(value="/queryCheckedNameList",method = RequestMethod.GET,produces="application/json;charset=utf-8")  
	    @SystemLog(module="选课模块",methods="查看已选名单请求")
	    public @ResponseBody Map<String, Object> queryCheckedNameList(int classId){     //已选名单查询，表格渲染
            System.out.println(classId);
	    	List<Student> List=courseService.queryStuByCourseId(classId);
	    	Map<String, Object> map = new HashMap<>();
	    	int count=List.size();
	    	//用json来传值     	
	    	JSONArray json = JSONArray.fromObject(List);
            //*****转为layui需要的json格式，必须要这一步，	    
	    	map.put("code",0);
	    	map.put("msg","");
	    	map.put("data",json);
	    	map.put("count",count);
	    	return map;    	
	    }
	    @RequestMapping(value="/queryUncheckedNameList",method = RequestMethod.GET,produces="application/json;charset=utf-8")  
	    @SystemLog(module="选课模块",methods="查看未选名单请求")
	    public @ResponseBody Map<String, Object> queryUncheckedNameList(int classId){     //未选名单查询，表格渲染
            System.out.println(classId);
	    	List<Student> List=courseService.queryUnStuByCourseId(classId);
	    	Map<String, Object> map = new HashMap<>();
	    	int count=List.size();
	    	//用json来传值     	
	    	JSONArray json = JSONArray.fromObject(List);
            //*****转为layui需要的json格式，必须要这一步，    
	    	map.put("code",0);
	    	map.put("msg","");
	    	map.put("data",json);
	    	map.put("count",count);
	    	return map;    	
	    }
	    @RequestMapping("/uncheckedList")    //查看未选课程名单
	    @SystemLog(module="选课模块",methods="查看未选名单页面")
	    public String uncheckedList(Integer id,Model model){
	    	System.out.println(id);
	    	model.addAttribute("course",courseService.queryInfoById(id));  
	    	model.addAttribute("classId",id);  
	        return "admin/uncheckedNameList";   
	    }
	    @RequestMapping("/deleteStudent")   
	    @SystemLog(module="学生模块",methods="删除学生-数据库")
	    @ResponseBody
	    public String deleteStudent(Integer id){     //删除学生
	    	System.out.println(id);
	    	userService.delStu(id);   
	        return "删除成功";   //根据id查找学生信息
	    }
	    @RequestMapping("/deleteCourse")  
	    @SystemLog(module="课程模块",methods="删除课程-数据库")
	    @ResponseBody
	    public String deleteCourse(Integer id){     //删除课程
	    	System.out.println(id);
	    	courseService.deleteCourse(id);   
	        return "删除成功";   
	    }
	    @RequestMapping("/checkedCourse")   
	    @SystemLog(module="审核模块",methods="审核通过课程")
	    @ResponseBody
	    public String checkedCourse(String id){     //审核通过课程
	    	 System.out.println(id);
	    	 String ids[]=id.split(",");
	    	 int classId[]=new int[ids.length];
		     for(int i=0;i<ids.length;i++) {
		    	    System.out.println(ids[i]);
		    	    classId[i]=Integer.parseInt(ids[i]);
		    	    courseService.updateCourseCheck(classId[i],"审核通过");
		    	}   
	        return "成功";   
	    }
	    @RequestMapping("/uncheckedCourse")   
	    @SystemLog(module="审核模块",methods="审核不通过课程")
	    @ResponseBody
	    public String uncheckedCourse(String id){     //审核不通过课程
	    	 System.out.println(id);
	    	 String ids[]=id.split(",");
	    	 int classId[]=new int[ids.length];
		     for(int i=0;i<ids.length;i++) {
		    	    System.out.println(ids[i]);
		    	    classId[i]=Integer.parseInt(ids[i]);
		    	    courseService.updateCourseCheck(classId[i],"审核不通过");
		    	}   
	        return "成功";   
	    }
	    @RequestMapping("/deleteteacher")  
	    @SystemLog(module="教师模块",methods="删除教师")
	    @ResponseBody
	    public String deleteteacher(Integer id){     //删除教师
	    	System.out.println(id);
	    	userService.delTea(id);   
	        return "删除成功"; 
	    }
	    @RequestMapping("/sendmail")  
	    @SystemLog(module="通知模块",methods="向未选课学生发送邮件通知")
	    @ResponseBody
	    public String sendmail(int classId,int id){     //发送邮件
	    	Student student=userService.getStuInfoById(id);
	    	String mail=student.getEmail();
	    	Course course=courseService.queryInfoById(classId);
	    	MimeMessage mMessage=javaMailSender.createMimeMessage();//创建邮件对象
	        MimeMessageHelper mMessageHelper;
	        Properties prop = new Properties();
	        String from;
	        try {
	            //从配置文件中拿到发件人邮箱地址
	            prop.load(this.getClass().getResourceAsStream("/mail.properties"));
	            from = prop.get("mail.smtp.username")+"";
	            mMessageHelper=new MimeMessageHelper(mMessage,true);
	            mMessageHelper.setFrom(from);//发件人邮箱
	            mMessageHelper.setTo(mail);//收件人邮箱
	            mMessageHelper.setSubject("提醒选课通知");//邮件的主题
	            mMessageHelper.setText("<p>"+student.getStuName()+"您好，选课时间即将截止，您的"+course.getClassName()+"未选，请尽快登陆选课系统进行选课</p><br/>" ,true);//邮件的文本内容，true表示文本以html格式打开
	            javaMailSender.send(mMessage);//发送邮件
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        return "发送成功";
	    }
	    @RequestMapping("/sendAllMail")   
	    @SystemLog(module="通知模块",methods="向未选课学生发送邮件通知")
	    @ResponseBody
	    public String sendAllMail(int classId,String id){     //批量发送邮件
	    	System.out.println("发送邮件");
	    	System.out.println(classId);
	    	System.out.println(id);
	    	String ids[]=id.split(",");
	    	int stuId[]=new int[ids.length];
	    	for(int i=0;i<ids.length;i++) {
	    	    System.out.println(ids[i]);
	    	    stuId[i]=Integer.parseInt(ids[i]);
	    	    Student student=userService.getStuInfoById(stuId[i]);
		    	String mail=student.getEmail();
		    	Course course=courseService.queryInfoById(classId);
		    	MimeMessage mMessage=javaMailSender.createMimeMessage();//创建邮件对象
		        MimeMessageHelper mMessageHelper;
		        Properties prop = new Properties();
		        String from;
		        try {
		            //从配置文件中拿到发件人邮箱地址
		            prop.load(this.getClass().getResourceAsStream("/mail.properties"));
		            from = prop.get("mail.smtp.username")+"";
		            mMessageHelper=new MimeMessageHelper(mMessage,true);
		            mMessageHelper.setFrom(from);//发件人邮箱
		            mMessageHelper.setTo(mail);//收件人邮箱
		            mMessageHelper.setSubject("提醒选课通知");//邮件的主题
		            mMessageHelper.setText("<p>"+student.getStuName()+"您好，选课时间即将截止，您的"+course.getClassName()+"未选，请尽快登陆选课系统进行选课</p><br/>" ,true);//邮件的文本内容，true表示文本以html格式打开
		            javaMailSender.send(mMessage);//发送邮件
		        } catch (MessagingException e) {
		            e.printStackTrace();
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
	    	}	    	 
	        return "发送成功";
	    }
	    @RequestMapping(value="/updateStudentSuccess") 
	    @SystemLog(module="学生模块",methods="修改学生-数据库")
	    @ResponseBody
	    public String updateStudentSuccess(Student student){     //学生修改信息
	    	System.out.println(student.getStuName());
	    	userService.updateStuInfo(student);   
	        return "修改成功";   
	    }
	    @RequestMapping(value="/updateTeacherSuccess") 
	    @SystemLog(module="教师模块",methods="修改教师-数据库")
	    @ResponseBody
	    public String updateTeacherSuccess(Teacher teacher){     //教师修改信息
	    	System.out.println(teacher.getTeaName());
	    	System.out.println(teacher.getTsex());
	    	userService.changeTeaInfo(teacher);   
	        return "修改成功";   
	    }
	    @RequestMapping(value="/addStu.action") 
	    @SystemLog(module="学生模块",methods="增加学生-数据库")
	    @ResponseBody
	    public String addStu(Student student){         //添加学生信息
	    	System.out.println(student.getStuName());
	    	userService.insertStuInfo(student);   
	        return "添加成功";   
	    }
	    @RequestMapping(value="/addTea.action") 
	    @SystemLog(module="教师模块",methods="增加教师-数据库")
	    @ResponseBody
	    public String addTea(Teacher teacher){         //添加学生信息
	    	System.out.println(teacher.getTeaName());
	    	userService.insertTeaInfo(teacher);   
	        return "添加成功";   
	    }
	    @RequestMapping(value="/addMes.action") 
	    @SystemLog(module="公告模块",methods="发布公告-数据库")
	    @ResponseBody
	    public String addMes(Message message, HttpServletRequest request){         //添加公告信息
	    	System.out.println("公告标题是"+message.getTitle());
	    	message.setUser(request.getSession().getAttribute("username").toString());
	    	System.out.println(request.getSession().getAttribute("username").toString());
	    	  //获取系统时间
	        String time = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss").format(new Date());
	        message.setDate(time);
	        System.out.println("开始添加");
	    	messageService.insertMessage(message);   
	        return "添加成功";   
	    }
	    @RequestMapping("/courseList")   //课程管理界面
	    @SystemLog(module="课程模块",methods="管理课程页面")
	    public String courseList(){
	        return "admin/courseList";
	    }
	    @RequestMapping("/adminInfo")   //个人资料界面
	    @SystemLog(module="管理员模块",methods="个人信息页面")
	    public String adminInfo(Model model,HttpServletRequest request){
	    	int id=(int)request.getSession().getAttribute("id");
	    	model.addAttribute("admin",userService.queryAdminById(id));  
	        return "admin/adminInfo";
	    }
	    @RequestMapping("updateInfoById")   //修改个人信息
	    @SystemLog(module="管理员模块",methods="修改个人信息-数据库")
	    public String updateInfoById(@RequestParam("name") String name,Model model,HttpServletRequest request) {
	    	 int id=(int)request.getSession().getAttribute("id");  //从当前会话获取stuid
	    	 Admin admin=new Admin();
	    	 admin.setAdminName(userService.queryAdminById(id).getAdminName());
	         admin.setAdminId(id);
	         userService.changeAdminInfo(admin);
	         model.addAttribute("admin",userService.queryAdminById(id));
	         return "student/studentInfo";
	    }
	    @RequestMapping("/insertStudent")  
	    @SystemLog(module="学生模块",methods="添加学生页面")
	    public String insertStudent(Model model){	
	        return "admin/insertStudent";
	    }
	    @RequestMapping("/insertTeacher")  
	    @SystemLog(module="教师模块",methods="添加教师页面")
	    public String insertTeacher(Model model){	
	        return "admin/insertTeacher";
	    }
	    @RequestMapping("/editPass")   //修改界面
	    @SystemLog(module="管理员模块",methods="修改密码页面")
	    public String editPass(){
	        return "admin/editPass";
	    }
	    @RequestMapping("/courseStatistic")   //选课统计
	    @SystemLog(module="选课模块",methods="查看选课统计")
	    public String courseStatistic(){
	        return "admin/courseStatistic";
	    }
	    @RequestMapping("/message")   //公告管理
	    @SystemLog(module="公告模块",methods="查看公告")
	    public String message(){
	        return "admin/message";
	    }
	    @RequestMapping("/insertMessage")   //增加公告
	    @SystemLog(module="公告模块",methods="增加公告")
	    public String insertMessage(){
	        return "admin/insertMessage";
	    }
	    @RequestMapping("/changePass")   //修改密码
	    @SystemLog(module="管理员模块",methods="修改密码-数据库")
	    public String changPass(@RequestParam("prepass") String prepass, @RequestParam("nowpass") String nowpass, Model model, HttpServletRequest request){
	        int id=(int)request.getSession().getAttribute("id");  //从当前会话获取stuid
	        if(userService.checkAccount(id,prepass)==0){
	            model.addAttribute("msg","原始密码输入错误!");
	            return "admin/editPass";
	        }
	        else{
	            Admin admin=new Admin();
	            admin.setAdminId(id);
	            admin.setAdminPass(nowpass);
	            return "admin/adminIndex";
	        }
	    }
}
