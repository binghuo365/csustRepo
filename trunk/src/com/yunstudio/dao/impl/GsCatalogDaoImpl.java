package com.yunstudio.dao.impl;

import org.springframework.stereotype.Repository;

import com.yunstudio.dao.GsCatalogDao;
import com.yunstudio.entity.RepGscatalog;
@Repository("gsCatalogDao")
public class GsCatalogDaoImpl extends BaseDaoImpl<RepGscatalog> implements GsCatalogDao {
	public void saveTransaction(){
		RepGscatalog gs=new RepGscatalog();
		gs.setName("格式1");
		this.save(gs);
		
		int i=1/0;
		gs=new RepGscatalog();
		gs.setName("格式2");
		this.save(gs);
	}
}
