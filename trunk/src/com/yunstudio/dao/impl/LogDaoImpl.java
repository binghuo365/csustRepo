package com.yunstudio.dao.impl;

import org.springframework.stereotype.Repository;

import com.yunstudio.dao.LogDao;
import com.yunstudio.entity.RepLog;

@Repository("logDao")
public class LogDaoImpl extends BaseDaoImpl<RepLog> implements LogDao{

}
