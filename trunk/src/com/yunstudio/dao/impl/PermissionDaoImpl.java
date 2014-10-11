package com.yunstudio.dao.impl;

import org.springframework.stereotype.Repository;

import com.yunstudio.dao.PermissionDao;
import com.yunstudio.entity.RepPermission;

@Repository("permissionDao")
public class PermissionDaoImpl extends BaseDaoImpl<RepPermission> implements PermissionDao{

}
