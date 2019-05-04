package com.zxc.controller.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zxc.model.Course;
import com.zxc.model.Institution;
import com.zxc.model.Page;
import com.zxc.model.Student;
import com.zxc.model.Teacher;
import com.zxc.service.CourseService;
import com.zxc.service.PageService;
import com.zxc.service.UserService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
@Controller
@RequestMapping("admin")
public class AdminController {
	    @Resource
	    private UserService userService;
	    @Resource
	    private PageService pageService;
	    @Resource
	    private CourseService courseService;
	    @Autowired
	    private JavaMailSender javaMailSender;//在spring中配置的邮件发送的bean
	    @RequestMapping("/adminIndex")   //导航栏
	    public String adminIndex(){
	        return "admin/adminIndex";
	    }
	    @RequestMapping("/studentList")   //学生管理界面
	    public  String studentList(){    	
	    	return "admin/studentList";
	    }
	    @RequestMapping(value="/studentList.Action",method = RequestMethod.GET,produces="application/json;charset=utf-8")   //学生管理界面
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
	    public @ResponseBody Map<String, Object> courseListAction(@Param("page") int page, @Param("limit") int limit){
	    	int before = limit * (page - 1) + 1;
            int after = page * limit;
            System.out.println(before+","+after);
	    	List<Course> courseList=courseService.queryAllCourse();
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
	    public String teacherList(){
	        return "admin/teacherList";
	    }
	    @RequestMapping("/courseCheck")   //课程审核界面
	    public String courseCheck(){
	        return "admin/courseCheck";
	    }
	    @RequestMapping("/updateStudent")   
	    public String updateStudent(Integer id,Model model){
	    	System.out.println(id);
	    	model.addAttribute("student",userService.getStuInfoById(id));   //根据id查找学生信息
	        return "admin/updateStudent";   //根据id查找学生信息
	    }
	    @RequestMapping("/updateTeacher")   
	    public String updateTeacher(Integer id,Model model){
	    	System.out.println(id);
	    	model.addAttribute("teacher",userService.getTeaInfoById(id));   //根据id查找教师信息
	        return "admin/updateTeacher";   //根据id查找学生信息
	    }
	    @RequestMapping("/checkedList")    //查看已选课程名单
	    public String checkedList(Integer id,Model model){
	    	System.out.println(id);
	    	model.addAttribute("course",courseService.queryInfoById(id));   
	        return "admin/checkedNameList";   
	    }
	    @RequestMapping(value="/queryCheckedNameList",method = RequestMethod.GET,produces="application/json;charset=utf-8")  
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
	    public String uncheckedList(Integer id,Model model){
	    	System.out.println(id);
	    	model.addAttribute("course",courseService.queryInfoById(id));  
	    	model.addAttribute("classId",id);  
	        return "admin/uncheckedNameList";   
	    }
	    @RequestMapping("/deleteStudent")   
	    @ResponseBody
	    public String deleteStudent(Integer id){     //删除学生
	    	System.out.println(id);
	    	userService.delStu(id);   
	        return "删除成功";   //根据id查找学生信息
	    }
	    @RequestMapping("/deleteCourse")   
	    @ResponseBody
	    public String deleteCourse(Integer id){     //删除课程
	    	System.out.println(id);
	    	courseService.deleteCourse(id);   
	        return "删除成功";   
	    }
	    @RequestMapping("/deleteteacher")   
	    @ResponseBody
	    public String deleteteacher(Integer id){     //删除教师
	    	System.out.println(id);
	    	userService.delTea(id);   
	        return "删除成功"; 
	    }
	    @RequestMapping("/sendmail")   
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
	    @ResponseBody
	    public String updateStudentSuccess(Student student){     //学生修改信息
	    	System.out.println(student.getStuName());
	    	userService.updateStuInfo(student);   
	        return "修改成功";   
	    }
	    @RequestMapping(value="/updateTeacherSuccess") 
	    @ResponseBody
	    public String updateTeacherSuccess(Teacher teacher){     //教师修改信息
	    	System.out.println(teacher.getTeaName());
	    	System.out.println(teacher.getTsex());
	    	userService.changeTeaInfo(teacher);   
	        return "修改成功";   
	    }
	    @RequestMapping(value="/addStu.action") 
	    @ResponseBody
	    public String addStu(Student student){         //添加学生信息
	    	System.out.println(student.getStuName());
	    	userService.insertStuInfo(student);   
	        return "添加成功";   
	    }
	    @RequestMapping(value="/addTea.action") 
	    @ResponseBody
	    public String addTea(Teacher teacher){         //添加学生信息
	    	System.out.println(teacher.getTeaName());
	    	userService.insertTeaInfo(teacher);   
	        return "添加成功";   
	    }
	    @RequestMapping("/courseList")   //课程管理界面
	    public String courseList(){
	        return "admin/courseList";
	    }
	    @RequestMapping("/adminInfo")   //个人资料界面
	    public String adminInfo(){
	        return "admin/adminInfo";
	    }
	    @RequestMapping("/insertStudent")  
	    public String insertStudent(Model model){	
	        return "admin/insertStudent";
	    }
	    @RequestMapping("/insertTeacher")  
	    public String insertTeacher(Model model){	
	        return "admin/insertTeacher";
	    }
	    @RequestMapping("/editPass")   //修改界面
	    public String editPass(){
	        return "admin/editPass";
	    }
	    @RequestMapping("/courseStatistic")   //选课统计
	    public String courseStatistic(){
	        return "admin/courseStatistic";
	    }
}
