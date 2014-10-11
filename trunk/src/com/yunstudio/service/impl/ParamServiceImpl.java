package com.yunstudio.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.ParamDao;
import com.yunstudio.entity.RepParam;
import com.yunstudio.service.ParamService;
@Service("paramService")
public class ParamServiceImpl extends BaseServiceImpl<RepParam> implements ParamService{

	private ParamDao paramDao;
	
	public static RepParam params;
	
	public ParamDao getParamDao() {
		return paramDao;
	}

	@Resource(name="paramDao")
	public void setParamDao(ParamDao paramDao) {
		this.paramDao = paramDao;
		super.setBaseDao(paramDao);
		updateStaticParams();
	}

	public RepParam getParams() {
		// TODO Auto-generated method stub
		return ParamServiceImpl.params;
	}
	
	public synchronized void updateStaticParams(){
		ParamServiceImpl.params=paramDao.loadAll().get(0);
	}

}
