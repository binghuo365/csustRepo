package com.yunstudio.service;
import java.util.Collection;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepUser;
public interface UserService extends BaseService<RepUser> {
	RepUser login(String username,String password);
	RepUser findUserByName(String username);

}
