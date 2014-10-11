package com.yunstudio.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.LogDao;
import com.yunstudio.entity.RepLog;
import com.yunstudio.service.LogService;
@Service("logService")
public class LogServiceImpl extends BaseServiceImpl<RepLog> implements LogService{

	private LogDao logDao;

	@Resource(name="logDao")
	public void setLogDao(LogDao logDao) {
		this.logDao = logDao;
		super.setBaseDao(logDao);
	}

	public LogDao getLogDao() {
		return logDao;
	}
	

}
