package com.zxc.dao;

import java.util.List;

import com.zxc.model.Message;

public interface MessageDao {

	public List<Message> queryAll();

	public void insertMessage(Message message);

	public List<Message> queryStuMessage();

	public Message queryMessageInfo(int id);

}
