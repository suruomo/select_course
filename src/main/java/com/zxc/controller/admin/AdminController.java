package com.zxc.controller.admin;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zxc.service.CourseService;
import com.zxc.service.PageService;
import com.zxc.service.UserService;

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
	    public String studentIndex(){
	        return "admin/adminIndex";
	    }
	    @RequestMapping("/studentList")   //学生管理界面
	    public String studentList(){
	        return "admin/studentList";
	    }
	    @RequestMapping("/teacherList")   //教师管理界面
	    public String teacherList(){
	        return "admin/teacherList";
	    }
	    @RequestMapping("/adminIndex")   //课程管理界面
	    public String adminIndex(){
	        return "admin/adminIndex";
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
