package com.yunstudio.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.CommentDao;
import com.yunstudio.entity.RepComment;
import com.yunstudio.service.CommentService;

@Service("commentService")
public class CommentServiceImpl extends BaseServiceImpl<RepComment> implements CommentService{
	private CommentDao commentDao;

	@Resource(name="commentDao")
	public void setCommentDao(CommentDao commentDao) {
		this.commentDao = commentDao;
		super.setBaseDao(commentDao);
	}

	public CommentDao getCommentDao() {
		return commentDao;
	}

}
