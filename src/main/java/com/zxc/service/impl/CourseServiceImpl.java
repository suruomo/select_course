package com.zxc.service.impl;

import com.zxc.dao.CourseDao;
import com.zxc.dao.UserDao;
import com.zxc.model.*;
import com.zxc.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseDao courseDao;
    @Autowired
    private UserDao userDao;
    @Override
    public List<Course> queryAllById(int id) {      //查找课程列表    
        List<Course> course_list= courseDao.queryCourseById(id);
        for(Course c:course_list){
            c.setClassLimitInsName(new ArrayList<>());
            List<Integer> limit_list=courseDao.selectInsIdByClassId(c.getClassId());
            for(Integer i:limit_list){
                c.getClassLimitInsName().add(courseDao.selectNameByInsId(i));  //查找课程限制学院列表
            }
        }
        return course_list;
    }

    @Override
    public List<String> queryInsNameByCourse(int id) {   //根据课程id查找学院列表 
        List<String> insNameList=new ArrayList<>();
        List<Integer> insIdList=courseDao.queryInsIdByCourseId(id);
        for(int i:insIdList){
            insNameList.add(courseDao.selectNameByInsId(i));
        }
        return insNameList;
    }

    @Override
    public List<Institution> queryAllIns() {     //查找所有学院
        return courseDao.queryAllIns();
    }

    @Override
    public int insertCourse(String name,String num,String credit,String introduction,String year,String term,String type,String classify,int teaid) {    //录入课程
        Course course=new Course();
        course.setClassName(name);
        course.setClassify(classify);
        course.setCredit(credit);
        course.setIntroduction(introduction);
        course.setYear(year);
        course.setTerm(term);
        course.setType(type);
        course.setClassNum(Integer.parseInt(num));
        course.setClassChooseNum(0);
        course.setTeaId(teaid);
        courseDao.insertCourse(course);
        return course.getClassId();
    }

    @Override
    public void insertInsLimit(String det,int classId) {     //插入课程限制学院
        String[] insList=det.split(",");
        for(String in:insList){
            Course_limit course_limit=new Course_limit();
            course_limit.setClassId(classId);
            course_limit.setInsId(Integer.parseInt(in));
            courseDao.insertInsLimit(course_limit);
        }
    }

    @Override
    public Course queryInfoById(int id) {     //根据课程id查找课程
        return courseDao.queryCourseInfoById(id);
    }

    @Override
    public List<Integer> selectCourseLimit(int classId) {
        return courseDao.selectCourseLimit(classId);
    }

    @Override
    public int updateCourse(String name,String num,String credit,String introduction,String year,String term,String type,String classify,int teaid) {   //修改课程
        Course course=new Course();
        course.setClassName(name);
        course.setClassify(classify);
        course.setCredit(credit);
        course.setIntroduction(introduction);
        course.setYear(year);
        course.setTerm(term);
        course.setType(type);
        course.setTeaId(teaid);
        course.setClassChooseNum(course.getClassChooseNum());
        course.setClassNum(Integer.parseInt(num));
        course.setClassId(courseDao.selectMaxCourseId());
        courseDao.updateCourse(course);
        return course.getClassId();
    }

    @Override
    public void updateInsLimit(String det, int classId) {
        String[] insList=det.split(",");
        courseDao.deleteInsLimit(classId);
        for(String ins:insList){
            Course_limit course_limit=new Course_limit();
            course_limit.setClassId(classId);
            course_limit.setInsId(Integer.parseInt(ins));
            courseDao.insertInsLimit(course_limit);
        }
    }

    @Override
    public void deleteCourse(int id) {          //删除课程
        courseDao.deleteCourseById(id);
        //解除选课表关联
        courseDao.deleteStuByClassId(id);
        //解除学院限制表关联
        courseDao.deleteLimitByClassId(id);
    }

    @Override
    public List<Student> queryStuByCourseId(int id) {     //根据课程id查找选课学生
        List<Student> stu_list=new ArrayList<>();
        List<Course_choose> id_list=courseDao.queryStuIdByCourseId(id);
        for(Course_choose i:id_list){
            Student student=userDao.selectStuById(i.getStuId());
            student.setTempScore(i.getScore());
            stu_list.add(student);
        }
        return stu_list;
    }

    @Override
    public void updateScore(int classId, int stuId, int score) {   //更改课程成绩
        Course_choose course_choose=new Course_choose();
        course_choose.setStuId(stuId);
        course_choose.setClassId(classId);
        course_choose.setScore(score);
        courseDao.updateScore(course_choose);
    }

    @Override
    public List<Student> queryStuByStuId(int classid, int stuid) {   //根据学生id查找学生
        List<Student> stu_list=new ArrayList<>();
        List<Course_choose> id_list=courseDao.queryStuIdByCourseId(classid);
        for(Course_choose i:id_list){
            Student student=userDao.selectStuById(i.getStuId());
            student.setTempScore(i.getScore());
            if(student.getStuId()==stuid){
                stu_list.add(student);
            }
        }
        return stu_list;
    }

    @Override
    public List<Course> queryAllCourse(int stuid){    //根据学生id查找选择的所有课程
        List<Course> course_list= courseDao.queryAllCourse();
        List<Integer> stu_courselist=courseDao.queryCourseIdByStuId(stuid);
        for(Course c:course_list){
            c.setClassLimitInsName(new ArrayList<>());
            List<Integer> limit_list=courseDao.selectInsIdByClassId(c.getClassId());
            for(Integer i:limit_list){
                c.getClassLimitInsName().add(courseDao.selectNameByInsId(i));   //获取课程限制学院名称
            }
            c.setTeaName(courseDao.selectTeaNameByTeaId(c.getTeaId()));
            c.setIsChoose(0);
            for(int i:stu_courselist){
                if(c.getClassId()==i){
                    c.setIsChoose(1);
                    break;
                }
            }
        }
        return course_list;
    }

    @Override
    public Course queryCourse(int id) {    //查找课程详情
        Course course=courseDao.selectCourseByClassId(id);     //课程对象
        List<Integer> limit_list=courseDao.selectInsIdByClassId(id);   //查找开课学院
        course.setClassLimitInsName(new ArrayList<>());
        for(Integer i:limit_list){
            course.getClassLimitInsName().add(courseDao.selectNameByInsId(i));
        }
        course.setTeaName(courseDao.selectTeaNameByTeaId(course.getTeaId()));
        return course;
    }

    @Override
    public void chooseSuccess(int classId, int stuId) {     //学生选课成功，添加成绩表信息（初始成绩为0）
        courseDao.addChooseNum(classId);
        Course_choose course_choose=new Course_choose();
        Course course=new Course();
        course.setIsChoose(1);
        course_choose.setScore(0);
        course_choose.setClassId(classId);
        course_choose.setStuId(stuId);
        courseDao.addCourseChoose(course_choose);
    }

    @Override
    public boolean checkStuIns(int classId, int stuId)   {    //检查学生所属学院是否可以选择该课程
        int stu_insId=userDao.selectStuById(stuId).getInsId();
        List<Integer> class_insId=courseDao.queryInsIdByCourseId(classId);
        for(int i:class_insId){
            if(stu_insId==i)
                return true;
        }
        return false;
    }
    @Override
    public boolean checkStu(int classId, int stuId)   {    //检查学生是否已经选择该课程
    	List<Integer> classId_list=courseDao.selectAllCourseById(stuId);
        for(int i:classId_list){
            if(classId==i)
                return true;
        }
        return false;
    }
    @Override
    public void deleteCourseChoose(int stuId, int classId) {    //删除该选课
        courseDao.downChooseNum(classId);
        Course_choose course_choose=new Course_choose();
        course_choose.setStuId(stuId);
        course_choose.setClassId(classId);
        courseDao.deleteCourseChoose(course_choose);
    }

    @Override
    public List<Course> queryStuCourse(int stuId) {           //查找学生所选课程列表
        List<Integer> classid_list=courseDao.queryCourseIdByStuId(stuId);    //所选课程id列表
        List<Course> course_list=new ArrayList<>();   //所选课程列表
        for(int i:classid_list){
            Course course=courseDao.queryCourseInfoById(i);  //找到课程对象
            course.setTeaName(courseDao.selectTeaNameByTeaId(course.getTeaId()));    //老师姓名
            Course_choose course_choose=new Course_choose();
            course_choose.setClassId(i);   //课程id
            course_choose.setStuId(stuId);  //学生id
            course.setScore(courseDao.selectScore(course_choose));   //通过课程id和学生id查找成绩
            course_list.add(course);    //填写当前课程详情
        }
        return course_list;
    }

    @Override
    public List<Course> queryAllByInsId(int id) {    //根据学院id查找列表
        List<Course> course_list= courseDao.queryAllCourse();   //课程列表
        List<Course> course_Inslist=new ArrayList<>();
        for(Course c:course_list){
        	c.setTeaName(courseDao.selectTeaNameByTeaId(c.getTeaId()));    //老师姓名
            List<Integer> limit_list=courseDao.selectInsIdByClassId(c.getClassId());
            for(int li:limit_list){
                if(id==li){
                    course_Inslist.add(c);   //学院id列表
                    break;
                }
            }
        }
        for(Course cc:course_Inslist){
            cc.setClassLimitInsName(new ArrayList<>());
            List<Integer> limit_list=courseDao.selectInsIdByClassId(cc.getClassId());
            for(Integer i:limit_list){
                cc.getClassLimitInsName().add(courseDao.selectNameByInsId(i));    //学院名称列表
            }
        }
        return course_Inslist;
    }
    @Override
    public List<Course> queryBiXiu(String bixiu) {   //查找必修课程列表
    	List<Course> course_list= courseDao.queryCourseBybixiu("必修");	 //必修列表
    	for(Course cc:course_list){     //每门课程限制学院名称以及授课教师名称
    		   cc.setTeaName(courseDao.selectTeaNameByTeaId(cc.getTeaId()));    //老师姓名
               cc.setClassLimitInsName(new ArrayList<>());
               List<Integer> limit_list=courseDao.selectInsIdByClassId(cc.getClassId());
               for(Integer i:limit_list){
                   cc.getClassLimitInsName().add(courseDao.selectNameByInsId(i));    //限制学院名称列表
               }
           }
		return course_list;    
    	
    }
    @Override
    public List<Course> queryXuanXiu(String xuanxiu) {   //查找选修课程列表
    	List<Course> course_list= courseDao.queryCourseByxuanxiu("选修");	 //选修列表
    	for(Course cc:course_list){     //每门课程限制学院名称以及授课教师名称
    		   cc.setTeaName(courseDao.selectTeaNameByTeaId(cc.getTeaId()));    //老师姓名
               cc.setClassLimitInsName(new ArrayList<>());
               List<Integer> limit_list=courseDao.selectInsIdByClassId(cc.getClassId());
               for(Integer i:limit_list){
                   cc.getClassLimitInsName().add(courseDao.selectNameByInsId(i));    //限制学院名称列表
               }
           }
		return course_list;    
    	
    }
    @Override
	public List<Institution> queryAllproByIns(int insid) {    //根据insId查找该学院的所有专业
		return courseDao.queryAllByIns(insid);	 //某学院的所有专业列表
    }
}
