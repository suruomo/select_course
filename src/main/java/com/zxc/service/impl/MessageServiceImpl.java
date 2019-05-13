package com.zxc.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zxc.dao.MessageDao;
import com.zxc.model.Message;
import com.zxc.service.MessageService;

@Service
public class MessageServiceImpl implements MessageService{
	@Autowired
	private MessageDao messageDao;
	@Override
	public List<Message> queryAll() {

		// TODO Auto-generated method stub
		System.out.println("进来了service");
		return messageDao.queryAll();
	}
	@Override
	public void insertMessage(Message message) {
		// TODO Auto-generated method stub
		System.out.println("进来了service");
		messageDao.insertMessage(message);
	}

}
