package com.zxc.dao;

import java.util.List;

import com.zxc.model.LogEntity;


public interface LogDao {

	public List<LogEntity> queryAll();

	public void addLog(LogEntity log);


}
