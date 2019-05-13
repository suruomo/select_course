package com.zxc.service;

import java.util.List;

import com.zxc.model.Message;

public interface MessageService {

	public List<Message> queryAll();

	public void insertMessage(Message message);

	public Message queryNewMessage();


}
