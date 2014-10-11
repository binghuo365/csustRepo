package com.yunstudio.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.ZyCatalogDao;
import com.yunstudio.entity.RepZycatalog;
import com.yunstudio.service.ZyCatalogService;
@Service("zyCatalogService")
public class ZyCatalogServiceImpl extends BaseServiceImpl<RepZycatalog> implements ZyCatalogService {
	
	private ZyCatalogDao zyCatalogDao;
	

	public ZyCatalogDao getZyCatalogDao() {
		return zyCatalogDao;
	}
	
	@Resource(name="zyCatalogDao")
	public void setZyCatalogDao(ZyCatalogDao zyCatalogDao) {
		this.zyCatalogDao = zyCatalogDao;
		super.setBaseDao(zyCatalogDao);
	}

	public List<RepZycatalog> findZycatalogByName(String name) {
		return zyCatalogDao.find("from RepZycatalog z where z.name=?", name);
	}

}
