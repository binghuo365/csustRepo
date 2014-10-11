package com.yunstudio.service;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;

import com.yunstudio.entity.Page;
/**
 * 通用的Service接口:提供通用的增删改查等业务操作
 * @author tocean
 *
 * @param <T>
 */
/*
 * 在总结项目时可以考虑对service层增加直接调用hql或者sql语句返回List<object>类型的方法
 * 
 */
public interface BaseService<T> {
	Serializable add(T entity);
	T get(Integer id);
	T load(Integer id);
	List<T> loadAll();
	void remove(int id);
	void update(T entity);
	void updateNotNullField(T entity);
	Page pageCQuery(int page,int row,Collection<Criterion> criterion,Collection<Order> order,String desc);
	Page pageQuery(String hql, int page, int row, Object... values);
	List findByhql(String hql,Integer maxResults,Object...values);
	void deleteAll(Collection<Integer> ids);
}
