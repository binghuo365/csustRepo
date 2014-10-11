package com.yunstudio.service.impl;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.yunstudio.dao.UserDao;
import com.yunstudio.entity.RepUser;
import com.yunstudio.service.UserService;
import com.yunstudio.utils.MD5Util;
/**
 * UserService实现类
 * @author Z
 *
 */
@Service("userService")
public class UserServiceImpl extends BaseServiceImpl<RepUser> implements UserService{
	
	private UserDao userDao;
	
	public UserDao getUserDao() {
		return userDao;
	}

	@Resource(name="userDao")
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
		super.setBaseDao(userDao);
	}

	public RepUser login(String username,String password) {

		Set<Criterion> set=new HashSet<Criterion>();
		Criterion cr=Restrictions.eq("username", username);
		set.add(cr);
		cr=Restrictions.eq("password", MD5Util.MD5(password));
		set.add(cr);
		List<RepUser> list=userDao.cquery(set, null);
		if(list.size()==1){
			return list.get(0);
		}else if(list.size()==0){
			return null;
		}else {
			System.out.println("存在同名用户!!");
			return list.get(0);
		}
	}
	
	public RepUser findUserByName(String username) {
		if(username!=null){
			List<RepUser> list=userDao.find("select u from RepUser u where u.username=?", username);
			if(list.size()>0){
				return list.get(0);
			}else {
				return null;
			}
		}else {
			return null;
		}
		
	}
	
}

