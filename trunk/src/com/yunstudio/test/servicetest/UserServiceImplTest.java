package com.yunstudio.test.servicetest;

import static org.junit.Assert.fail;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yunstudio.entity.RepAdmin;
import com.yunstudio.entity.RepUser;
import com.yunstudio.service.AdminService;
import com.yunstudio.service.UserService;
import com.yunstudio.utils.MD5Util;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath*:applicationContext.xml"})
public class UserServiceImplTest {

	private UserService userService;
	
	@Resource
	private AdminService adminService;
	

	public UserService getUserService() {
		return userService;
	}
	
	@Resource
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Test
	public void testLogin() {
		System.out.println(MD5Util.MD5("user1"));
		RepUser user=userService.login("user1", "user1");
		if(user==null){
			System.out.println("null");
		}else {
			System.out.println(user.getUsername());
		}
	}
	
	@Test
	public void testNoLazy(){
//		RepUser u=userService.loadAll().get(0);
//		userService.updateNotNullField(u);
		
		RepAdmin admin=adminService.get(1);
		adminService.updateNotNullField(admin);
	}

	@Test
	public void testGetBaseDao() {
		fail("Not yet implemented");
	}
	
	

	@Test
	public void testSetBaseDao() {
		fail("Not yet implemented");
	}

	@Test
	public void testAdd() {
		RepUser user=new RepUser();
		user.setUsername("test1");
		userService.add(user);
	}

	@Test
	public void testGet() {
		fail("Not yet implemented");
	}

	@Test
	public void testLoad() {
		fail("Not yet implemented");
	}

	@Test
	public void testLoadAll() {
		fail("Not yet implemented");
	}

	@Test
	public void testRemove() {
		fail("Not yet implemented");
	}

	@Test
	public void testUpdate() {
		fail("Not yet implemented");
	}

	@Test
	public void testUpdateNotNullField() {
		fail("Not yet implemented");
	}

}
