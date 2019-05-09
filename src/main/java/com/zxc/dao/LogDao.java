package com.zxc.dao;

import java.util.List;

import com.zxc.model.LogEntity;
import com.zxc.model.Logging_event;

public interface LogDao {

	public List<Logging_event> queryAll();

	public void addLog(LogEntity log);


}
