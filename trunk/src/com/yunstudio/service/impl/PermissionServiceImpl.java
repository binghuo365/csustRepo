package com.yunstudio.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.yunstudio.dao.PermissionDao;
import com.yunstudio.entity.RepPermission;
import com.yunstudio.service.PermissionService;

@Service("permissionService")
public class PermissionServiceImpl extends BaseServiceImpl<RepPermission> implements PermissionService{
	
	private PermissionDao permissionDao;
	
	public PermissionDao getPermissionDao() {
		return permissionDao;
	}

	@Resource(name="permissionDao")
	public void setPermissionDao(PermissionDao permissionDao) {
		this.permissionDao = permissionDao;
		super.setBaseDao(permissionDao);
	}

	
}

