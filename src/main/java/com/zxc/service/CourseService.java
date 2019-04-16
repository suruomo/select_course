package com.zxc.service;

import com.zxc.model.Course;
import com.zxc.model.Institution;
import com.zxc.model.Student;

import java.util.List;

public interface CourseService {
    public List<Course> queryAllById(int id);
    public List<String> queryInsNameByCourse(int id);
    public List<Institution> queryAllIns();
    public int insertCourse(String name,String num,String credit,String introduction,String year,String term,String type,String classify,int teaid);   //添加课程
    //public void insertInsLimit(String det,int classId);     //no  
    public Course queryInfoById(int id);
    public List<Integer> selectCourseLimit(int classId);
    public int updateCourse(String name,String num,String credit,String introduction,String year,String term,String type,String classify,int teaid);
   //    public void updateInsLimit(String det,int classId);   //no
    public void deleteCourse(int id);
    public List<Student> queryStuByCourseId(int id);
    public void updateScore(int classId,int stuId,int score);
    public List<Student> queryStuByStuId(int classid,int stuid);
    public List<Course> queryAllCourse(int stuid);
    public Course queryCourse(int id);
    public void chooseSuccess(int classId,int stuId);
    public boolean checkStuIns(int classId,int stuId);
    public void deleteCourseChoose(int stuId,int classId);
    public List<Course> queryStuCourse(int stuId);
    public List<Course> queryAllByInsId(int id);
	public List<Course> queryBiXiu(String bixiu);
	public List<Course> queryXuanXiu(String xuanxiu);
	public boolean checkStu(int classId,int stuId);
	public List<Institution> queryAllproByIns(int insid);
	public void insertProLimit(String det,int classId);
	public void updateProLimit(String det,int classId);
}