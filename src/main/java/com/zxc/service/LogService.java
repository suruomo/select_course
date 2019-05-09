package com.zxc.service;

import java.util.List;

import com.zxc.model.LogEntity;
import com.zxc.model.Logging_event;

public interface LogService {

	List<Logging_event> queryAll();

	public void addLog(LogEntity log);

}
