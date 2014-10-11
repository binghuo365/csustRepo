package com.yunstudio.service.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;

import com.yunstudio.dao.MessageDao;
import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepMessage;
import com.yunstudio.service.MessageService;

@Service("messageService")
public class MessageServiceImpl extends BaseServiceImpl<RepMessage> implements MessageService{
	private MessageDao messageDao;

	@Resource(name="messageDao")
	public void setMessageDao(MessageDao messageDao) {
		this.messageDao = messageDao;
		super.setBaseDao(messageDao);
	}
	
	public MessageDao getMessageDao() {
		return messageDao;
	}


}
