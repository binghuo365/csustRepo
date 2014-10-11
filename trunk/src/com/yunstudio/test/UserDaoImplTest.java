package com.yunstudio.test;

import java.util.Date;

import javax.annotation.Resource;

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
	
	
	public void testBaseDaoImpl() {
	}

	public void testUpdateNotNullField() {
	}

	@Test
	public void testFind() {
		RepUser user= userDao.find("from RepUser u where u.username=?","test1").get(0);
		System.out.println(user.getUsername());
	}

	public void testCreateQuery() {
	}

	public void testLoad() {
	}

	public void testCriteriaQuery() {
	}

	public void testPageCQuery() {
	}

	public void testCquery() {
	}

	public void testGet() {
	}

	public void testLoadAll() {
	}
	
	@Test
	public void testSave() {
		RepUser user=new RepUser();
		user.setBirthday(new Date());
		user.setUsername("这是xxx");
		userDao.save(user);
	}

	public void testRemove() {
	}

	public void testSaveOrUpdate() {
	}

	public void testUpdate() {
	}

	public void testExeUpdate() {
	}

	public void testPageQuery() {
	}

	public void testInitialize() {
	}

	public void testGetHibernateTemplate() {
	}

	public void testSetHibernateTemplate() {
	}

	public void testGetSession() {
	}

}
