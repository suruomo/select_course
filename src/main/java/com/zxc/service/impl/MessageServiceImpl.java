package com.zxc.service.impl;

import java.util.ArrayList;
import java.util.Collections;
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
	public List<Message> queryAll() {       //查询所有公告
		// TODO Auto-generated method stub
		return messageDao.queryAll();
	}
	@Override
	public void insertMessage(Message message) { //发布公告
		// TODO Auto-generated method stub
		messageDao.insertMessage(message);
	}
	@Override
	public Message queryNewMessage() {
		// TODO Auto-generated method stub
		List<Message> msgList=messageDao.queryStuMessage();
		List<Integer> msgId=new ArrayList<>();  
		for(Message msg:msgList) {    //编号列表
			msgId.add(msg.getId());
		}
		int max=Collections.max(msgId);   //找最新公告
		return messageDao.queryMessageInfo(max);   //查询最新公告信息
	}

}
