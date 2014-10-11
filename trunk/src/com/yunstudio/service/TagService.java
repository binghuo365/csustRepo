package com.yunstudio.service;

import java.util.List;

import com.yunstudio.entity.RepTag;

public interface TagService extends BaseService<RepTag>{
	List<RepTag> findTagByName(String name);
	List<String> findHotesTags(Integer maxResults);
}
