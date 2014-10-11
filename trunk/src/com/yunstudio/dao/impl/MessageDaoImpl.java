package com.yunstudio.dao.impl;

import org.springframework.stereotype.Repository;

import com.yunstudio.dao.MessageDao;
import com.yunstudio.entity.RepMessage;

@Repository("messageDao")
public class MessageDaoImpl extends BaseDaoImpl<RepMessage> implements MessageDao{

}
