package com.yunstudio.service.impl;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.TagDao;
import com.yunstudio.entity.RepTag;
import com.yunstudio.service.TagService;
@Service("tagService")
public class TagServiceImpl extends BaseServiceImpl<RepTag> implements TagService{

	private TagDao tagDao;
	
	public TagDao getTagDao() {
		return tagDao;
	}

	@Resource(name="tagDao")
	public void setTagDao(TagDao tagDao) {
		this.tagDao = tagDao;
		super.setBaseDao(tagDao);
	}

	public List<RepTag> findTagByName(String name) {
		return tagDao.find("from RepTag t where t.name=?", name);
	}

	@SuppressWarnings("unchecked")
	public List<String> findHotesTags(Integer maxResults) {
		// TODO Auto-generated method stub
		return tagDao.find(
						"select t.name from RepTag t left join t.repResources r group by t.id order by count(r) desc",maxResults, (Object[])null);
	}

}
