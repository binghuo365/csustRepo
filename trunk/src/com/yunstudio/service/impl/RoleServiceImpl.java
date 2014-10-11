package com.yunstudio.service.impl;
import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.RoleDao;
import com.yunstudio.entity.RepRole;
import com.yunstudio.service.RoleService;
/**
 * UserService实现类
 * @author Z
 *
 */
@Service("roleService")
public class RoleServiceImpl extends BaseServiceImpl<RepRole> implements RoleService{
	
	private RoleDao roleDao;
	
	public RoleDao getRoleDao() {
		return roleDao;
	}
	
	@Resource(name="roleDao")
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
		super.setBaseDao(roleDao);
	}
	
	public RepRole findRoleByName(String name){
		if(name!=null){
			List<RepRole> list=roleDao.find("from RepRole r where r.name=?", name);
			if(list.size()>0){
				return list.get(0);
			}else {
				return null;
			}
		}else {
			return null;
		}
	}
	
	public void remove(RepRole r) {
		roleDao.remove(r.getId());
	}
}

