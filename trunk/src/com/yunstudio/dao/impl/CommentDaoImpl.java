package com.yunstudio.dao.impl;

import org.springframework.stereotype.Repository;

import com.yunstudio.dao.CommentDao;
import com.yunstudio.entity.RepComment;

@Repository("commentDao")
public class CommentDaoImpl extends BaseDaoImpl<RepComment> implements CommentDao{

}
