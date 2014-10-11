package com.yunstudio.service;

import com.yunstudio.entity.RepAdmin;

public interface AdminService extends BaseService<RepAdmin>{
	RepAdmin login(String username,String password);
	RepAdmin findAdminByName(String username);
	int countUnLockSuperAdmins();
}
