package com.yunstudio.service.impl;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;

import com.yunstudio.dao.TopicDao;
import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepTopic;
import com.yunstudio.service.TopicService;
/**
 * UserService实现类
 * @author Z
 *
 */
@Service("topicService")
public class TopicServiceImpl extends BaseServiceImpl<RepTopic> implements TopicService{
	
	private TopicDao topicDao;
	
	public TopicDao getTopicDao() {
		return topicDao;
	}

	@Resource(name="topicDao")
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
		super.setBaseDao(topicDao);
	}

	public List<RepTopic> findTopicByTitle(String title){
			return topicDao.find("from RepTopic t where t.title=?", title);
	}
	
	public void remove(RepTopic r) {
		topicDao.remove(r.getId());
	}
}

