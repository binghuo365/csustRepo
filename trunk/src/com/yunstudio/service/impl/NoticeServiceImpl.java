package com.yunstudio.service.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;

import com.yunstudio.dao.NoticeDao;
import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepNotice;
import com.yunstudio.entity.RepNotice;
import com.yunstudio.service.NoticeService;

@Service("noticeService")
public class NoticeServiceImpl extends BaseServiceImpl<RepNotice> implements NoticeService{

	private NoticeDao noticeDao;
	public NoticeDao getNoticeDao() {
		return noticeDao;
	}
	@Resource(name="noticeDao")
	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
		super.setBaseDao(noticeDao);
	}
	
}
