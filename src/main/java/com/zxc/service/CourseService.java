package com.zxc.service;

import com.zxc.model.Course;
import com.zxc.model.Institution;
import com.zxc.model.Student;

import java.util.List;

public interface CourseService {
    public List<Course> queryAllById(int id);
   // public List<String> queryInsNameByCourse(int id);
    public List<Institution> queryAllIns();
    public int insertCourse(String name,String num,String credit,String introduction,String year,String term,String type,String classify,String item,String classCheck,int teaid);   //添加课程
    //public void insertInsLimit(String det,int classId);     //no  
    public Course queryInfoById(int id);
    public List<Integer> selectCourseLimit(int classId);
    public int updateCourse(int id,String num,String credit,String introduction,String year,String term,String type,String classify,String name,String item,String classCheck,int teaid);
   //    public void updateInsLimit(String det,int classId);   //no
    public void deleteCourse(int id);
    public List<Student> queryStuByCourseId(int id);
    public void updateScore(int classId,int stuId,String score);   //改成绩
    public List<Student> queryStuByStuId(int classid,int stuid);
    public List<Course> queryAllCourse(int stuid);
    public Course queryCourse(int id);
    public void chooseSuccess(int classId,int stuId);
    public boolean checkStuPro(int classId,int stuId);
    public void deleteCourseChoose(int stuId,int classId);
    public List<Course> queryStuCourse(int stuId);
    public List<Course> queryAllByInsId(int id);
	public List<Course> queryBiXiu(String bixiu);
	public List<Course> queryXuanXiu(String xuanxiu);
	public List<Institution> queryAllproByIns(int insid);
	public void insertProLimit(String det,int classId);
	public void updateProLimit(String det,int classId);
	public List<Course> queryCourseByName(String courseName);   //通过课程名查找所有挂牌课程
	public List<Course> queryStuCourseByProfession(int stuId);   //通过学生专业查找所有专业课
	public List<Course> queryCourseByItem(String courseName);    //通过体育项目查找所有挂牌课程
	public List queryTongShi();   //查找全校通识课
	public List<Course> queryAllCourse();
	public List<Student> queryUnStuByCourseId(int classId); //查找该必修课程未选的学生名单
	public int insertWenCourse(String name,String num,String credit,String introduction,String year,String term,String type,String classify,String check,int teaid);
	public int queryTeaByCourse(int classId);
	public void updateCourseCheck(int classId, String classCheck);
	public List<Course> queryAllCourseByAdmin();
	public List<Course> queryCourseByCheck(String classCheck);
}
