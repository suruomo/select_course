package com.zxc.dao;

import com.zxc.model.Admin;
import com.zxc.model.Student;
import com.zxc.model.Teacher;

import java.util.List;

public interface UserDao {
    public Student selectStuById(int id);
    public Teacher selectTeaById(int id);
    public void updateStuPass(Student student);
    public void updateTeaPass(Teacher teacher);
    public List<Teacher> queryAllTeacher();
    public void updateStuInfo(Student student);
	public void updateTeaInfo(Teacher teacher);
	public Admin selectAdminById(int id);
	public List<Student> queryAllStu();
	public void delStu(int id);
	public void insertStuInfo(Student student);
	public void insertTeaInfo(Teacher teacher);
	public void delTea(Integer id);
	public List<Student> queryAllByProId(Integer id);
	public List<Student> queryStuByIns(int insId);
	public void updateAdminInfo(Admin admin);
	public void changePass(Admin admin);
}
