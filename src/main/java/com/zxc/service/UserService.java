package com.zxc.service;

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
}
