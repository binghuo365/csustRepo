package com.yunstudio.service;

import java.util.List;

import com.yunstudio.entity.RepTopic;

public interface TopicService extends BaseService<RepTopic>{
	List<RepTopic> findTopicByTitle(String title);
}
