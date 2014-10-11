package com.yunstudio.service.impl;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.yunstudio.dao.AdminDao;
import com.yunstudio.entity.RepAdmin;
import com.yunstudio.service.AdminService;
import com.yunstudio.utils.MD5Util;
/**
 * AdminService实现类
 * @author Z
 *
 */
@Service("adminService")
public class AdminServiceImpl extends BaseServiceImpl<RepAdmin> implements AdminService{
	
	private AdminDao adminDao;

	@Resource(name="adminDao")
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao=adminDao;
		super.setBaseDao(adminDao);
	}



	public AdminDao getAdminDao() {
		return adminDao;
	}



	public RepAdmin login(String username,String password) {

		Set<Criterion> set=new HashSet<Criterion>();
		Criterion cr=Restrictions.eq("username", username);
		set.add(cr);
		cr=Restrictions.eq("password", MD5Util.MD5(password));
		set.add(cr);
		List<RepAdmin> list=adminDao.cquery(set, null);
		if(list.size()==1){
			return list.get(0);
		}else if(list.size()==0){
			return null;
		}else {
			System.out.println("存在同名用户!!");
			return list.get(0);
		}
	}
	


	public RepAdmin findAdminByName(String username) {
		if(username!=null){
			List<RepAdmin> list=adminDao.find("from RepAdmin a where a.username=?", username);
			if(list.size()>0){
				return list.get(0);
			}else {
				return null;
			}
		}else {
			return null;
		}
		
	}
	

	public int countUnLockSuperAdmins() {
		// TODO Auto-generated method stub
		return (Integer) adminDao.find("select count(*) from RepAdmin a where a.islock=0 and a.repRole.name='超级管理员'", null,null).get(0);
	}
}

