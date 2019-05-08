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
            c.setClassLimitProName(new ArrayList<>());
            List<Integer> limit_list=courseDao.selectProIdByClassId(c.getClassId());
            for(Integer i:limit_list){
                c.getClassLimitProName().add(courseDao.selectNameByProId(i));  //查找课程限制专业列表
            }
        }
        return course_list;
    }

    @Override
    public List<Institution> queryAllIns() {     //查找所有学院
        return courseDao.queryAllIns();
    }
 
    @Override
    public int insertCourse(String name,String num,String credit,String introduction,String year,String term,String type,String classify,String item,int teaid) {    //录入课程
        Course course=new Course();
        course.setClassName(name);
        course.setClassify(classify);
        course.setCredit(credit);
        course.setIntroduction(introduction);
        course.setYear(year);
        course.setTerm(term);
        course.setType(type);
        course.setItem(item);
        course.setClassNum(Integer.parseInt(num));
        course.setClassChooseNum(0);
        course.setTeaId(teaid);
        courseDao.insertCourse(course);
        return course.getClassId();
    }

    @Override
    public void insertProLimit(String det,int classId) {     //插入课程限制学院
        String[] proList=det.split(",");
        for(String in:proList){
            Course_limit course_limit=new Course_limit();
            course_limit.setClassId(classId);
            course_limit.setProId(Integer.parseInt(in));
            courseDao.insertProLimit(course_limit);
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
    public int updateCourse(int id,String num,String credit,String introduction,String year,String term,String type,String classify,String name,String item,int teaid) {   //修改课程
        Course course=new Course();
        course.setClassName(name);
        course.setClassify(classify);
        course.setCredit(credit);
        course.setIntroduction(introduction);
        course.setYear(year);
        course.setTerm(term);
        course.setType(type);
        course.setTeaId(teaid);
        course.setItem(item);
        course.setClassChooseNum(course.getClassChooseNum());
        course.setClassNum(Integer.parseInt(num));
        course.setClassId(id);
        courseDao.updateCourse(course);
        return course.getClassId();
    }

    @Override
    public void updateProLimit(String det, int classId) {
        String[] proList=det.split(",");
        courseDao.deleteProLimit(classId);
        for(String ins:proList){
            Course_limit course_limit=new Course_limit();
            course_limit.setClassId(classId);
            course_limit.setProId(Integer.parseInt(ins));
            courseDao.insertProLimit(course_limit);
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
    public List<Student> queryUnStuByCourseId(int id) {     //根据课程id查找未选课学生
        List<Student> stu_list=new ArrayList<>();    //未选课学生列表
        List<Integer> limit_list=courseDao.selectCourseLimit(id);   //查找该课程的限制专业列表Id
        List<Course_choose> checked_list=courseDao.queryStuIdByCourseId(id);   //查找已选列表（包括所有专业）
        for(Integer i:limit_list){    //对限制专业逐个筛选
        	List<Integer> checked=new ArrayList<>();  
        	for(Course_choose c:checked_list) {   //将Course_choose转化成Student  的id    		
        		 Student student=userDao.selectStuById(c.getStuId());  //学生
        		 if(student.getProId()==i) {    //如果当前学生的专业是所筛选专业的
        			 checked.add(student.getStuId());
        		 }
        		 else {
        			 continue;
        		 }
        	}
        	List<Student> all_list=userDao.queryAllByProId(i); //查找该专业的所有人
        	for(Student stu:all_list) {   //对每一个人判断        		
        		 if(checked.contains(stu.getStuId())) {
        			 continue;
        	           //若已选名单不包含该学生，则加入未选课名单
        		 }
        		 System.out.println(stu.getStuName());
        		 stu_list.add(stu);		 
        	}
        }
        return stu_list;
    }
    @Override
    public void updateScore(int classId, int stuId, String score) {   //更改课程成绩
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
        List<Course> course_list= courseDao.queryAllCourse();    //所有课程
        List<Integer> stu_courselist=courseDao.queryCourseIdByStuId(stuid);   //查找该学生选择的课程
        for(Course c:course_list){
            c.setClassLimitProName(new ArrayList<>());
            List<Integer> limit_list=courseDao.selectProIdByClassId(c.getClassId());
            for(Integer i:limit_list){
                c.getClassLimitProName().add(courseDao.selectNameByProId(i));   //获取课程限制专业名称
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
        List<Integer> limit_list=courseDao.selectProIdByClassId(id);   //查找开课学院
        course.setClassLimitProName(new ArrayList<>());
        for(Integer i:limit_list){
            course.getClassLimitProName().add(courseDao.selectNameByProId(i));
        }
        course.setTeaName(courseDao.selectTeaNameByTeaId(course.getTeaId()));
        return course;
    }

    @Override
    public void chooseSuccess(int classId, int stuId) {     //学生选课成功,添加初始成绩信息为（暂无成绩）
        courseDao.addChooseNum(classId);
        Course_choose course_choose=new Course_choose();
        Course course=new Course();
        course.setIsChoose(1);
        System.out.println(course.getIsChoose());
        course_choose.setScore("无");
        course_choose.setClassId(classId);
        course_choose.setStuId(stuId);
        courseDao.addCourseChoose(course_choose);
    }

    @Override
    public boolean checkStuPro(int classId, int stuId)   {    //检查学生所属专业是否可以选择该课程
        int stu_proId=userDao.selectStuById(stuId).getProId();
        System.out.println(stu_proId);
        List<Integer> class_proId=courseDao.selectCourseLimit(classId);
        for(int i:class_proId){
            if(stu_proId==i)
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
        List<Integer> classid_list=courseDao.queryCourseIdByStuId(stuId);    //已选课程id列表
        List<Course> course_list=new ArrayList<>();   //所选总课程列表
        List<Course> cList=new ArrayList<>(); //该选但未选的专业必修课
        List<Integer> limitId=courseDao.queryClassByProId(userDao.selectStuById(stuId).getProId()); //查找该专业可选的课程id列表
        for(int i:limitId) {
        	Course course=courseDao.queryCourseInfoById(i);//查找课程信息
        	if(course.getClassify().equals("专业课")&&course.getType().equals("必修")) {  //符合选课条件
        		if(!classid_list.contains(course.getClassId())) {    //且当前课程未选
        			System.out.println(course.getClassName()+"符合条件");
        			chooseSuccess(course.getClassId(),stuId);
        			System.out.println(course.getClassName()+"选课成功");
        		}
        	}
        }
        List<Integer> class_list=courseDao.queryCourseIdByStuId(stuId);    //已选课程id列表
        for(int i:class_list){
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
            List<Integer> limit_list=courseDao.selectProIdByClassId(c.getClassId());
            for(int li:limit_list){
                if(id==li){
                    course_Inslist.add(c);   //学院id列表
                    break;
                }
            }
        }
        for(Course cc:course_Inslist){
            cc.setClassLimitProName(new ArrayList<>());
            List<Integer> limit_list=courseDao.selectProIdByClassId(cc.getClassId());
            for(Integer i:limit_list){
                cc.getClassLimitProName().add(courseDao.selectNameByProId(i));    //学院名称列表
            }
        }
        return course_Inslist;
    }
    @Override
    public List<Course> queryBiXiu(String bixiu) {   //查找必修课程列表
    	List<Course> course_list= courseDao.queryCourseBybixiu("必修");	 //必修列表
    	for(Course cc:course_list){     //每门课程限制学院名称以及授课教师名称
    		   cc.setTeaName(courseDao.selectTeaNameByTeaId(cc.getTeaId()));    //老师姓名
               cc.setClassLimitProName(new ArrayList<>());
               List<Integer> limit_list=courseDao.selectProIdByClassId(cc.getClassId());
               for(Integer i:limit_list){
                   cc.getClassLimitProName().add(courseDao.selectNameByProId(i));    //限制学院名称列表
               }
           }
		return course_list;    
    	
    }
    @Override
    public List<Course> queryXuanXiu(String xuanxiu) {   //查找选修课程列表
    	List<Course> course_list= courseDao.queryCourseByxuanxiu("选修");	 //选修列表
    	for(Course cc:course_list){     //每门课程限制学院名称以及授课教师名称
    		   cc.setTeaName(courseDao.selectTeaNameByTeaId(cc.getTeaId()));    //老师姓名
               cc.setClassLimitProName(new ArrayList<>());
               List<Integer> limit_list=courseDao.selectProIdByClassId(cc.getClassId());
               for(Integer i:limit_list){
                   cc.getClassLimitProName().add(courseDao.selectNameByProId(i));    //限制学院名称列表
               }
           }
		return course_list;    
    	
    }
    @Override
	public List<Institution> queryAllproByIns(int insid) {    //根据insId查找该学院的所有专业
		return courseDao.queryAllByIns(insid);	 //某学院的所有专业列表
    }

	@Override
	public List<Course> queryCourseByName(String courseName) {   //根据className查找挂牌课程
		// TODO Auto-generated method stub
		List<Course> course_list= courseDao.queryCourseByName(courseName);	 //课程列表
    	for(Course cc:course_list){     //每门课程限制专业名称以及授课教师名称
    		   cc.setTeaName(courseDao.selectTeaNameByTeaId(cc.getTeaId()));    //老师姓名
               cc.setClassLimitProName(new ArrayList<>());
               List<Integer> limit_list=courseDao.selectProIdByClassId(cc.getClassId());
               for(Integer i:limit_list){
                   cc.getClassLimitProName().add(courseDao.selectNameByProId(i));    //限制学院名称列表
               }
           }
		return course_list;  
	}

	@Override
	public List<Course> queryStuCourseByProfession(int stuId) {    //通过学生id查找所在专业的所有专业课
		// TODO Auto-generated method stub
		int proId=courseDao.queryProIdByStuId(stuId);  //学生专业id
		List<Course> course_list= courseDao.queryAllCourse();   //所有课程列表
		List<Course> course_prolist=new ArrayList<>();  //限制专业课程列表
		List<Course> professionlist=new ArrayList<>();    //专业课程列表;
		List<Integer> stu_courselist=courseDao.queryCourseIdByStuId(stuId);   //查找该学生选择的课程
	        for(Course c:course_list){
	        	c.setTeaName(courseDao.selectTeaNameByTeaId(c.getTeaId()));    //老师姓名
	            List<Integer> limit_list=courseDao.selectProIdByClassId(c.getClassId());
	            for(int li:limit_list){
	                if(proId==li){
	                	course_prolist.add(c);   //查找所有限制专业id列表
	                    break;
	                }
	            }
	        }
	        for(Course cc:course_prolist){
	            cc.setClassLimitProName(new ArrayList<>());
	            List<Integer> limit_list=courseDao.selectProIdByClassId(cc.getClassId());
	            for(Integer i:limit_list){
	                cc.getClassLimitProName().add(courseDao.selectNameByProId(i));    //专业名称列表
	            }
	        }
	        for(Course c:course_prolist){
	        	c.setClassify(courseDao.selectClassifyByClassId(c.getClassId()));
	            for(int i:stu_courselist){
	                if(c.getClassId()==i){
	                    c.setIsChoose(1);          //已选专业课标记
	                    break;
	                }
	            }
	        	if(c.getClassify().equals("专业课")) {
	        	     System.out.println(c.getClassName());
	        	     professionlist.add(c);    //最终查询结果
	        	}
	        }
	        return professionlist;
	}

	@Override
	public List<Course> queryCourseByItem(String courseName) {    //根据体育项目选择所有课程
		// TODO Auto-generated method stub
		List<Course> course_list= courseDao.queryCourseByItem(courseName);	 //课程列表
    	for(Course cc:course_list){     //每门课程限制专业名称以及授课教师名称
    		   cc.setTeaName(courseDao.selectTeaNameByTeaId(cc.getTeaId()));    //老师姓名
               cc.setClassLimitProName(new ArrayList<>());
               List<Integer> limit_list=courseDao.selectProIdByClassId(cc.getClassId());
               for(Integer i:limit_list){
                   cc.getClassLimitProName().add(courseDao.selectNameByProId(i));    //限制学院名称列表
               }
           }
		return course_list; 
	}

	@Override 
	public List queryTongShi() {            //查找通识课
		// TODO Auto-generated method stub
		List<Course> course_list= courseDao.queryCourseByTongShi("通识课");	 //通识列表
    	for(Course cc:course_list){     //每门课程限制学院名称以及授课教师名称
    		   cc.setTeaName(courseDao.selectTeaNameByTeaId(cc.getTeaId()));    //老师姓名
               cc.setClassLimitProName(new ArrayList<>());
               List<Integer> limit_list=courseDao.selectProIdByClassId(cc.getClassId());
               for(Integer i:limit_list){
                   cc.getClassLimitProName().add(courseDao.selectNameByProId(i));    //限制学院名称列表
               }
           }
		return course_list;    
	}

	@Override
	public List<Course> queryAllCourse() {
		// TODO Auto-generated method stub
		List<Course> course_list=courseDao.queryAllCourse();  //查询所有课程
		for(Course cc:course_list) {
			 cc.setTeaName(courseDao.selectTeaNameByTeaId(cc.getTeaId()));    //老师姓名
			 cc.setIns(courseDao.selectInsNameByTeaId(cc.getTeaId()));    //开课学院名称，即老师所在学院
		}
		return course_list;
	}

	@Override
	 public int insertWenCourse(String name,String num,String credit,String introduction,String year,String term,String type,String classify,String check,int teaid) {    //录入课程
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
        System.out.println(check);
        course.setClassCheck(check);;
        System.out.println(course.getClassCheck());
        courseDao.insertWenCourse(course);
        System.out.println("添加成功");
        return course.getClassId();
    }

	@Override
	public int queryTeaByCourse(int classId) {
		// TODO Auto-generated method stub
		return courseDao.queryTeaByCourse(classId);
	}
	@Override
	public void updateCourseCheck(int classId, String classCheck){
		// TODO Auto-generated method stub
		 System.out.println(classCheck);
		 if(classCheck.equals("审核通过")) {
			 Course course=new Course();
			 course.setClassId(classId);
			 course.setClassCheck(classCheck);
			 courseDao.updateCourseCheck(course);
		 }
		
		 System.out.println("修改成功");
	}
}
