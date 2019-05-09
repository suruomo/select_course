package com.zxc.controller.student;

import com.zxc.controller.common.LoginController;
import com.zxc.controller.log.SystemLog;
import com.zxc.model.Course;
import com.zxc.model.Student;
import com.zxc.service.CourseService;
import com.zxc.service.PageService;
import com.zxc.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.apache.xpath.operations.Mod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.spi.http.HttpContext;

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
    @SystemLog(module="学生模块",methods="查看个人成绩")
    public String studentScore(Model model,HttpServletRequest request){
    	 List<Course> cor_list=courseService.queryStuCourse((int)request.getSession().getAttribute("id"));
         model.addAttribute("paging",pageService.subList(1,cor_list));
         model.addAttribute("teaList",userService.queryAllTeacher());
         model.addAttribute("insList",courseService.queryAllIns());
        return "student/studentScore";
    }
    
    @RequestMapping("/studentInfo")    //查找学生个人信息
    @SystemLog(module="学生模块",methods="查看个人信息")
    public String studentInfo(@RequestParam("stuid") String id, Model model){
    	System.out.println(id);
        model.addAttribute("student",userService.getStuInfoById(Integer.parseInt(id)));
        return "student/studentInfo";
    }
    @RequestMapping("/editStuPass")    //个人资料页点击修改个人密码
    @SystemLog(module="学生模块",methods="修改个人密码界面")
    public String editTeaPass(){
        return "student/editStuPass";
    }
    @RequestMapping("/selectCourse")    //选课主页面
    public String selectCourse(){
        return "student/selectCourse";
    }
    @RequestMapping("/publicCourse")    //公共课页面
    @SystemLog(module="学生模块",methods="公共课选课")
    public String publicCourse(){
        return "student/publicCourse";
    }
    @RequestMapping("/professionCourse")    //专业课页面
    @SystemLog(module="学生模块",methods="专业课选课")
    public String professionCourse(Model model,HttpServletRequest request){
       // model.addAttribute("courseList",courseService.queryStuCourseByProfession((int)request.getSession().getAttribute("stuid")));
        List<Course> cor_list=courseService.queryStuCourseByProfession((int)request.getSession().getAttribute("id"));
        model.addAttribute("paging",pageService.subList(1,cor_list));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/professionCourse";
    }
    @RequestMapping("/tongShiCourse")    //通识课页面
    @SystemLog(module="学生模块",methods="通识课选课")
    public String tongShiCourse(@Param("page") int page, Model model,HttpServletRequest request){
        model.addAttribute("paging",pageService.subList(page,courseService.queryTongShi()));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/tongShiCourse";
    }


    @RequestMapping("/changeStuPass")   //修改密码
    @SystemLog(module="学生模块",methods="修改密码-数据库")
    public String changPass(@RequestParam("prepass") String prepass, @RequestParam("nowpass") String nowpass, Model model, HttpServletRequest request){
        int id=(int)request.getSession().getAttribute("id");  //从当前会话获取stuid
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
    @SystemLog(module="学生模块",methods="所有选课列表")
    public String courseList(@Param("page") int page, Model model,HttpServletRequest request){
        model.addAttribute("paging",pageService.subList(page,courseService.queryAllCourse((int)request.getSession().getAttribute("id"))));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    }

    @RequestMapping("/courseDetail")    //通过classid查找课程详情并显示
    @SystemLog(module="学生模块",methods="查看课程详情")
    public String courseDetail(@Param("flag") int flag,@Param("classId") int classId,Model model,HttpServletRequest request){
        if(courseService.checkStuPro(classId,(int)request.getSession().getAttribute("id"))){   //检查学生所在专业是否可选当前课程
            model.addAttribute("course",courseService.queryCourse(classId));
            System.out.println("详情的"+flag);
            model.addAttribute("flag",flag);
            return "student/courseDetail";   //进入课程详情页
   
        } 
        else {
            model.addAttribute("msg","请注意课程的专业限制");
            model.addAttribute("paging",pageService.subList(1,courseService.queryAllCourse((int)request.getSession().getAttribute("id"))));
            model.addAttribute("teaList",userService.queryAllTeacher());
            model.addAttribute("insList",courseService.queryAllIns());
            return "student/courseList";
        }
    }

    @RequestMapping("/chooseSuccess")       //选择课程成功，继续选课界面
    public String chooseSuccess(@Param("flag") int flag,@Param("stuid") int stuid,@Param("courseid") int courseid,Model model,HttpServletRequest request){ 	
        courseService.chooseSuccess(courseid,stuid);    //选课
        System.out.println("选课的"+flag);
        String url="";
        switch(flag) {
        case 0:   //全部课程页面
        	 model.addAttribute("paging",pageService.subList(1,courseService.queryAllCourse(stuid)));
             model.addAttribute("teaList",userService.queryAllTeacher());
             model.addAttribute("insList",courseService.queryAllIns());
             url="student/courseList";
             break;
        case 1:    //公共课页面
        	url="student/publicCourse";
        	break;
        case 2:    //专业选课页面
        	 List<Course> cor_list=courseService.queryStuCourseByProfession((int)request.getSession().getAttribute("id"));
             model.addAttribute("paging",pageService.subList(1,cor_list));
             model.addAttribute("teaList",userService.queryAllTeacher());
             model.addAttribute("insList",courseService.queryAllIns());
             url="student/professionCourse";
             break;
        }
        return url;
    }

    @RequestMapping("/deleteCourse")   //删除选课，继续选课界面
    @SystemLog(module="学生模块",methods="删除选课")
    public String deleteCourse(@Param("flag") int flag,@Param("courseid") int courseid,Model model,HttpServletRequest request){
        courseService.deleteCourseChoose((int)request.getSession().getAttribute("id"),courseid);
        System.out.println("删除的"+flag);
        String url="";
        switch(flag) {
        case 0:   //全部课程页面
        	 model.addAttribute("paging",pageService.subList(1,courseService.queryAllCourse((int)request.getSession().getAttribute("id"))));
             model.addAttribute("teaList",userService.queryAllTeacher());
             model.addAttribute("insList",courseService.queryAllIns());
             url="student/courseList";
             break;
        case 1:    //公共课页面
        	url="student/publicCourse";
        	break;
        case 2:    //专业选课页面
        	 List<Course> cor_list=courseService.queryStuCourseByProfession((int)request.getSession().getAttribute("id"));
             model.addAttribute("paging",pageService.subList(1,cor_list));
             model.addAttribute("teaList",userService.queryAllTeacher());
             model.addAttribute("insList",courseService.queryAllIns());
             url="student/professionCourse";
             break;
        case 3:    //已选课程页面
        	List<Course> list=courseService.queryStuCourse((int)request.getSession().getAttribute("id"));
            model.addAttribute("paging",pageService.subList(1,list));
            model.addAttribute("teaList",userService.queryAllTeacher());
            model.addAttribute("insList",courseService.queryAllIns());
            url="student/checkedCourseList";
            break;
        }
        return url;
     
    }

    @RequestMapping("/checkedCourseList")      //通过stuid查找已选课程列表
    @SystemLog(module="学生模块",methods="查看已选课程")
    public String checkedCourseList(Model model,HttpServletRequest request){
    	List<Course> cor_list=courseService.queryStuCourse((int)request.getSession().getAttribute("id"));
        model.addAttribute("paging",pageService.subList(1,cor_list));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/checkedCourseList";
    }

    @RequestMapping("/searchCourse")   //通过courseid查找课程，继续选课界面
    public String searchCourse(@Param("courseid") int courseid, Model model){
    	System.out.println(courseid);
        List<Course> cor_list=new ArrayList<>();
        cor_list.add(courseService.queryCourse(courseid));
        model.addAttribute("paging",pageService.subList(1,cor_list));
        model.addAttribute("teaList",userService.queryAllTeacher());
        model.addAttribute("insList",courseService.queryAllIns());
        return "student/courseList";
    }
    @RequestMapping("/searchTea")   //通过className查找所有挂牌课程，继续选课界面
    public String searchTea(@Param("id") int id, Model model){
    	   System.out.println("文化"+id);
    	   String courseName;
    	   if(id==0) {
    		   courseName="大学物理";
    	   }
    	   else if(id==1) {
    		   courseName="大学英语";
    	   }
    	   else {
    		   courseName="高等数学";
    	   }
    	   List<Course> cor_list=courseService.queryCourseByName(courseName);
           model.addAttribute("paging",pageService.subList(1,cor_list));
           model.addAttribute("teaList",userService.queryAllTeacher());
           model.addAttribute("insList",courseService.queryAllIns());
           return "student/publicCourse";
    }
    @RequestMapping("/searchTiTea")   //通过体育项目查找所有挂牌课程，继续选课界面
    public String searchTiTea(@Param("id") int id, Model model){
    	   System.out.println("体育"+id);
    	   String courseName;
    	   if(id==0) {
    		   courseName="乒乓球";
    	   }
    	   else if(id==1) {
    		   courseName="羽毛球";
    	   }
    	   else if(id==2){
    		   courseName="篮球";
    	   }
    	   else {
    		   courseName="田径";
    	   }
    	   List<Course> cor_list=courseService.queryCourseByItem(courseName);
           model.addAttribute("paging",pageService.subList(1,cor_list));
           model.addAttribute("teaList",userService.queryAllTeacher());
           model.addAttribute("insList",courseService.queryAllIns());
           return "student/publicCourse";
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
    @SystemLog(module="学生模块",methods="修改个人信息-数据库")
    public String updateInfoById(@RequestParam("email") String email,@RequestParam("tele") String tele,@RequestParam("address") String address,Model model,HttpServletRequest request) {
    	int id=(int)request.getSession().getAttribute("id");  //从当前会话获取stuid
    	 Student student=new Student();
    	 student.setStuName(userService.getStuInfoById(id).getStuName());
    	 student.setGrade(userService.getStuInfoById(id).getGrade());
         student.setStuId(id);
         student.setTele(tele);
         student.setAddress(address);
         student.setEmail(email);;
         userService.changeStuInfo(student);
         model.addAttribute("student",userService.getStuInfoById(id));
         return "student/studentInfo";
    	
    }
}
