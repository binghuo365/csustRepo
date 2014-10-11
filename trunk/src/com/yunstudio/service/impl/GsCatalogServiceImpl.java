package com.yunstudio.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.GsCatalogDao;
import com.yunstudio.entity.RepGscatalog;
import com.yunstudio.service.GsCatalogService;
@Service("gsCatalogService")
public class GsCatalogServiceImpl extends BaseServiceImpl<RepGscatalog> implements GsCatalogService {
	private GsCatalogDao gsCatalogDao;
	

	public GsCatalogDao getGsCatalogDao() {
		return gsCatalogDao;
	}
	
	@Resource(name="gsCatalogDao")
	public void setGsCatalogDao(GsCatalogDao gsCatalogDao) {
		this.gsCatalogDao = gsCatalogDao;
		super.setBaseDao(gsCatalogDao);
	}

	public List<RepGscatalog> findGscatalogByName(String name) {
		return gsCatalogDao.find("from RepGscatalog g where g.name=?", name);
	}

}
