package com.yunstudio.dao.impl;

import org.springframework.stereotype.Repository;

import com.yunstudio.dao.UserDao;
import com.yunstudio.entity.RepUser;

@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<RepUser> implements UserDao {


}
