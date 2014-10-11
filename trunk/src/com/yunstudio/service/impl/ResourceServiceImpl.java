package com.yunstudio.service.impl;

import java.util.Date;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.ResourceDao;
import com.yunstudio.entity.RepResource;
import com.yunstudio.service.ResourceService;

@Service("resourceService")
public class ResourceServiceImpl extends BaseServiceImpl<RepResource> implements ResourceService  {

	private ResourceDao resourceDao;
	

	public ResourceDao getResourceDao() {
		return resourceDao;
	}
	@Resource(name="resourceDao")
	public void setResourceDao(ResourceDao resourceDao) {
		this.resourceDao = resourceDao;
		super.setBaseDao(resourceDao);
	}

	public RepResource findResourceByTitle(String title) {
		if(title!=null){
			List<RepResource> list=resourceDao.find("from RepResource r where r.title=?", title);
			if(list.size()>0){
				return list.get(0);
			}else {
				return null;
			}
		}else {
			return null;
		}
	}
	public int countResourceByTime(Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		if(startTime==null||endTime==null){
			return ((Long)resourceDao.find(
					"select count(*) from RepResource r", 1, 
					null).get(0)).intValue();
		}
		return ((Long)resourceDao.find(
				"select count(*) from RepResource r where r.addtime between ? and ?", 1, 
				new Object[]{startTime,endTime}).get(0)).intValue();
	}

}
