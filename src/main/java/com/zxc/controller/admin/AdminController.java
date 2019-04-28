package com.zxc.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
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

	    @RequestMapping("/adminIndex")   //导航栏
	    public String adminIndex(){
	        return "admin/adminIndex";
	    }
	    @RequestMapping("/studentList")   //学生管理界面
	    public  String studentList(){    	
	    	return "admin/studentList";
	    }
	    @RequestMapping(value="/studentList.Action",method = RequestMethod.GET,produces="application/json;charset=utf-8")   //学生管理界面
	    public @ResponseBody Map<String, Object> studentListAction(@Param("page") int page, @Param("limit") int limit){
	    	int before = limit * (page - 1) + 1;
            int after = page * limit;
            System.out.println(before+","+after);
	    	List<Student> stuList=userService.queryAllStu();
	    	Map<String, Object> map = new HashMap<>();
	    	int count=stuList.size();
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
            //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常    
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
            //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常    	    
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
}
