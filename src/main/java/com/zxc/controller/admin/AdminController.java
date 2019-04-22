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

	    @RequestMapping("/adminIndex")   //头部导航栏
	    public String studentIndex(){
	        return "admin/adminIndex";
	    }
	    @RequestMapping("/welcome")   
	    public String welcome(){
	        return "admin/welcome";
	    }
}
