package com.zxc.controller.student;

import com.zxc.model.Course;
import com.zxc.model.Student;
import com.zxc.service.CourseService;
import com.zxc.service.PageService;
import com.zxc.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.apache.xpath.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("student")
public class StudentController {
    @Resource
    private UserService userService;
    @Resource
    private PageService pageService;
    @Resource
    private CourseService courseService;

    @RequestMapping("/studentIndex")   //头部导航栏
    public String studentIndex(){
        return "student/studentIndex";
    }
    @RequestMapping("/studentScore")   //查看个人成绩
    public String studentScore(Model model,HttpServletRequest request){
    	 model.addAttribute("courseList",courseService.queryStuCourse((int)request.getSession().getAttribute("stuid")));
        return "student/studentScore";
    }
    
    @RequestMapping("/studentInfo")    //查找学生个人信息
    public String studentInfo(@RequestParam("stuid") int id, Model model){
        model.addAttribute("student",userService.getStuInfoById(id));
        return "student/studentInfo";
    }
    @RequestMapping("/editStuPass")    //个人资料页点击修改个人密码
    public String editTeaPass(){
        return "student/editStuPass";
    }

    @RequestMapping("/changeStuPass")   //修改密码
    public String changPass(@RequestParam("prepass") String prepass, @RequestParam("nowpass") String nowpass, Model model, HttpServletRequest request){
        int id=(int)request.getSession().getAttribute("stuid");  //从当前会话获取stuid
        if(userService.checkAccount(id,prepass)==0){
            model.addAttribute("msg","原始密码输入错误!");
            return "student/editStuPass";
        }
        else{
            Student student=new Student();
            student.setStuId(id);
            student.setStuPass(nowpass);
            userService.changeStuPass(student);
            model.addAttribute("student",userService.getStuInfoById(id));
            return "student/studentInfo";
        }
    }

    @RequestMapping("/courseList")      //选课列表
    public String courseList(@Param("page") int page, Model model,HttpServletRequest request){
        model.addAttribute("paging",pageService.subList(page,courseService.queryAllCourse((int)request.getSession().getAttribute("stuid"))));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    }

    @RequestMapping("/courseDetail")    //通过classid查找课程详情并显示
    public String courseDetail(@Param("classId") int classId,Model model,HttpServletRequest request){
        if(courseService.checkStuIns(classId,(int)request.getSession().getAttribute("stuid"))){   //检查学生所在学院是否可选当前课程
            model.addAttribute("course",courseService.queryCourse(classId));
            return "student/courseDetail";   //进入课程详情页
        }
        else{
            model.addAttribute("msg","请注意课程的学院限制");
            model.addAttribute("paging",pageService.subList(1,courseService.queryAllCourse((int)request.getSession().getAttribute("stuid"))));
            model.addAttribute("teaList",userService.queryAllTeacher());
            model.addAttribute("insList",courseService.queryAllIns());
            return "student/courseList";
        }
    }

    @RequestMapping("/chooseSuccess")       //选择课程成功，继续选课界面
    public String chooseSuccess(@Param("stuid") int stuid,@Param("courseid") int courseid,Model model,HttpServletRequest request){
    	if(courseService.checkStu(courseid,(int)request.getSession().getAttribute("stuid"))){
    		model.addAttribute("msg","已选择!");
    		return "student/courseList";
    	}else {
    	courseService.chooseSuccess(courseid,stuid);
        model.addAttribute("paging",pageService.subList(1,courseService.queryAllCourse(stuid)));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    	}
    }

    @RequestMapping("/deleteCourse")   //删除选课，继续选课界面
    public String deleteCourse(@Param("courseid") int courseid,Model model,HttpServletRequest request){
        courseService.deleteCourseChoose((int)request.getSession().getAttribute("stuid"),courseid);
        model.addAttribute("paging",pageService.subList(1,courseService.queryAllCourse((int)request.getSession().getAttribute("stuid"))));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    }

    @RequestMapping("/checkedCourseList")      //通过stuid查找已选课程列表
    public String checkedCourseList(Model model,HttpServletRequest request){
        model.addAttribute("courseList",courseService.queryStuCourse((int)request.getSession().getAttribute("stuid")));
        return "student/checkedCourseList";
    }

    @RequestMapping("/searchCourse")   //通过courseid查找课程，继续选课界面
    public String searchCourse(@Param("courseid") int courseid, Model model){
        List<Course> cor_list=new ArrayList<>();
        cor_list.add(courseService.queryCourse(courseid));
        model.addAttribute("paging",pageService.subList(1,cor_list));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    }

    @RequestMapping("/searchListBybixiu")    //查找必修课程列表
    public String searchListByTeaId(Model model){
        List<Course> cor_list=courseService.queryBiXiu("必修");
        model.addAttribute("paging",pageService.subList(1,cor_list));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    }
    @RequestMapping("/searchListByxuanxiu")    //查找选修课程列表
    public String searchListByxuanxiu(Model model){
        List<Course> cor_list=courseService.queryXuanXiu("选修");
        model.addAttribute("paging",pageService.subList(1,cor_list));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    }
    @RequestMapping("/searchListByInsId")    //通过学院查找课程列表
    public String searchListByInsId(@Param("insid") int insid,Model model){
        List<Course> cor_list=courseService.queryAllByInsId(insid);
        model.addAttribute("paging",pageService.subList(1,cor_list));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    }
    @RequestMapping("updateInfoById")   //修改学生个人信息
    public String updateInfoById(@RequestParam("tele") String tele,@RequestParam("address") String address,Model model,HttpServletRequest request) {
    	int id=(int)request.getSession().getAttribute("stuid");  //从当前会话获取stuid
    	 Student student=new Student();
         student.setStuId(id);
         student.setTele(tele);
         student.setAddress(address);
         userService.changeStuInfo(student);
         model.addAttribute("student",userService.getStuInfoById(id));
         return "student/studentInfo";
    	
    }
}
