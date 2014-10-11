package com.yunstudio.service.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;

import com.yunstudio.dao.BaseDao;
import com.yunstudio.dao.impl.BaseDaoImpl;
import com.yunstudio.entity.Page;
import com.yunstudio.service.BaseService;

/**
 * 通用的Service实现类:提供通用的增删改查等业务操作
 * @author tocean
 *
 * @param <T>
 */
public class BaseServiceImpl<T> implements BaseService<T>{

	private BaseDao<T> baseDao;
	
	public BaseDao<T> getBaseDao() {
		return baseDao;
	}
	
	public BaseServiceImpl(){
		
	}
	
	public BaseServiceImpl(BaseDao<T> baseDao){
		this.baseDao=baseDao;
	}
	
	public void setBaseDao(BaseDao<T> baseDao) {
		this.baseDao = baseDao;
	}

	public Serializable add(T entity) {
		return baseDao.save(entity);
	}

	public T get(Integer id) {
		return baseDao.get(id);
	}

	public T load(Integer id) {
		return baseDao.load(id);
	}

	public List<T> loadAll() {
		return baseDao.loadAll();
	}

	public void remove(int id) {
		baseDao.remove(id);

	}

	public void update(T entity) {
		baseDao.update(entity);

	}
	public void updateNotNullField(T entity) {
		// TODO Auto-generated method stub
		baseDao.updateNotNullField(entity);
	}
	public Page pageQuery(String hql, int page, int row, Object... values){
		return baseDao.pageQuery(hql, page, row, values);
	}
	public Page pageCQuery(int page,int row,Collection<Criterion> criterion,Collection<Order> order,String desc){
		return baseDao.pageCQuery(page, row, criterion, order, desc);
	}

	public List findByhql(String hql,Integer maxResults, Object... values) {
		// TODO Auto-generated method stub
		return baseDao.find(hql,maxResults, values);
	}

	public void deleteAll(Collection<Integer> ids) {
		// TODO Auto-generated method stub
		baseDao.deleteAll(ids);
	}
}
