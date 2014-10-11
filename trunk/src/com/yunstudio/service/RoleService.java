package com.yunstudio.service;
import com.yunstudio.entity.RepRole;
public interface RoleService extends BaseService<RepRole> {

	RepRole findRoleByName(String parameter);
	void remove(RepRole r);

}
