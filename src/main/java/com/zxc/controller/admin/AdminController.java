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

import com.zxc.model.Page;
import com.zxc.model.Student;
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
	    @RequestMapping("/deleteStudent")   
	    @ResponseBody
	    public String deleteStudent(Integer id){     //删除学生
	    	System.out.println(id);
	    	userService.delStu(id);   
	        return "admin/updateStudent";   //根据id查找学生信息
	    }
	    @RequestMapping(value="/updateStudentSuccess") 
	    @ResponseBody
	    public String updateStudentSuccess(Student student){
	    	System.out.println(student.getStuName());
	    	userService.updateStuInfo(student);   //修改信息
	        return "修改成功";   
	    }
	    @RequestMapping("/courseList")   //课程管理界面
	    public String courseList(){
	        return "admin/courseList";
	    }
	    @RequestMapping("/adminInfo")   //个人资料界面
	    public String adminInfo(){
	        return "admin/adminInfo";
	    }
	    @RequestMapping("/editPass")   //修改界面
	    public String editPass(){
	        return "admin/editPass";
	    }
}
