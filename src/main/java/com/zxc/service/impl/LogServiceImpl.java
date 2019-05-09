package com.zxc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zxc.dao.CourseDao;
import com.zxc.dao.LogDao;
import com.zxc.model.Institution;
import com.zxc.model.LogEntity;

import com.zxc.service.LogService;

@Service
public class LogServiceImpl implements  LogService{
	 @Autowired
	    private LogDao logDao;
	 @Override
	    public List<LogEntity> queryAll() {     //查找所有
	        return logDao.queryAll();
	    }
	 @Override
	 public void addLog(LogEntity log) {
		// TODO Auto-generated method stub
		 logDao.addLog(log);
	}
}
