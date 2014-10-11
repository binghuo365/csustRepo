package com.yunstudio.service;


import java.util.Collection;
import java.util.Date;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepResource;

public interface ResourceService extends BaseService<RepResource> {

	RepResource findResourceByTitle(String title);
	
	int countResourceByTime(Date startTime,Date endTime);
}
