package com.zxc.service;

import com.zxc.model.Admin;
import com.zxc.model.Student;
import com.zxc.model.Teacher;

import java.util.List;

public interface UserService {
    public int checkAccount(int id,String pass);
    public String getStuNameById(int id);
    public String getTeaNameById(int id);
    public Student getStuInfoById(int id);
    public Teacher getTeaInfoById(int id);
    public void changeStuPass(Student student);
    public void changeTeaPass(Teacher teacher);
    public void changeStuInfo(Student student);
    public List<Teacher> queryAllTeacher();
	public void changeTeaInfo(Teacher teacher);
	public String getAdminNameById(int id);
	public List<Student> queryAllStu();
	public void updateStuInfo(Student student);
	public void delStu(Integer id);
	public void insertStuInfo(Student student);
	public void insertTeaInfo(Teacher teacher);
	public void delTea(Integer id);
	public List<Student> queryAllStuByIns(int insId);
	public Admin queryAdminById(int id);
	public void changeAdminInfo(Admin admin);
	public void changePass(Admin admin);

}
