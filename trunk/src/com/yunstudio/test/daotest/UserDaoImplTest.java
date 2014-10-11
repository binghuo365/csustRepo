package com.yunstudio.test.daotest;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yunstudio.dao.UserDao;
import com.yunstudio.dao.impl.UserDaoImpl;
import com.yunstudio.entity.RepResource;
import com.yunstudio.entity.RepUser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath*:applicationContext.xml"})
public class UserDaoImplTest{
	
	public UserDao getUserDao() {
		return userDao;
	}
	
	@Resource
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	private UserDao userDao;
	
	@Test
	public void testTx() {
		RepUser u1=new RepUser();
		u1.setUsername("测试1");
		u1.setPassword("123445");

		RepUser u2=new RepUser();
		u2.setUsername("测试2");
		u2.setPassword("123445");
		userDao.testTx(u1,u2);
	}

}
