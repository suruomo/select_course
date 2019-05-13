package com.zxc.service;

import java.util.List;

import com.zxc.model.LogEntity;


public interface LogService {

	List<LogEntity> queryAll();

	public void addLog(LogEntity log);

	public int getCurrentId();

}
