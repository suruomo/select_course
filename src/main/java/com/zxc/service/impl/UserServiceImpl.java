package com.zxc.service.impl;

import com.zxc.dao.UserDao;
import com.zxc.model.Student;
import com.zxc.model.Teacher;
import com.zxc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public int checkAccount(int id, String pass) {     //检查账户和密码是否正确
    	
        if(Integer.toString(id).charAt(4)=='1'){   //若账号第四位是1则是老师账号
            if(userDao.selectTeaById(id).getTeaPass().equals(pass))  //验证正确
                return 2;
            else
                return 0;
        }
        else if(Integer.toString(id).charAt(2)=='0'){     //管理员账号
        	if(userDao.selectAdminById(id).getAdminPass().equals(pass))   
                 return 3;
             else
                 return 0;
        }
        else {
            if(userDao.selectStuById(id).getStuPass().equals(pass))   //否则是学生账号
                return 1;
            else
                return 0;
        }
    }

    @Override
    public String getStuNameById(int id) {
        return userDao.selectStuById(id).getStuName();
    }

    @Override
    public String getTeaNameById(int id) {
        return userDao.selectTeaById(id).getTeaName();
    }

    @Override
    public Student getStuInfoById(int id) {
        return userDao.selectStuById(id);
    }

    @Override
    public Teacher getTeaInfoById(int id) {
        return userDao.selectTeaById(id);
    }

    @Override
    public void changeStuPass(Student student) {
        userDao.updateStuPass(student);
    }

    @Override
    public void changeTeaPass(Teacher teacher) {
        userDao.updateTeaPass(teacher);
    }
    
    @Override
    public void changeStuInfo(Student student) {
        userDao.updateStuInfo(student);
    }
    @Override
    public void changeTeaInfo(Teacher teacher) {
        userDao.updateTeaInfo(teacher);
    }
    @Override
    public List<Teacher> queryAllTeacher() {
        return userDao.queryAllTeacher();
    }

	@Override
	public String getAdminNameById(int id) {
		// TODO Auto-generated method stub
		return userDao.selectAdminById(id).getAdminName();
	}

	@Override
	public List<Student> queryAllStu() {
		// TODO Auto-generated mequeryAllStuthod stub
		return userDao.queryAllStu();
	}

	@Override
	public void updateStuInfo(Student student) {
		// TODO Auto-generated method stub
		userDao.updateStuInfo(student);
		
	}

	@Override
	public void delStu(Integer id) {
		// TODO Auto-generated method stub
		userDao.delStu(id);
	}

	@Override
	public void insertStuInfo(Student student) {
		// TODO Auto-generated method stub
		userDao.insertStuInfo(student);
	}
	@Override
	public void insertTeaInfo(Teacher teacher) {
		// TODO Auto-generated method stub
		userDao.insertTeaInfo(teacher);
	}

	@Override
	public void delTea(Integer id) {
		// TODO Auto-generated method stub
		userDao.delTea(id);
	}

	@Override
	public List<Student> queryStuByIns(int insId) {
		// TODO Auto-generated method stub
		return userDao.queryStuByIns(insId);
	}


}
