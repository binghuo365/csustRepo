package com.yunstudio.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.junit.Test;

import com.yunstudio.entity.Page;

/**
 * 通用数据访问Dao接口
 * @author tocean
 * @param <T> T 为需要持久化的实体类型
 */
public interface BaseDao<T> {
	
	/**
	 * 加载一个实体，属性延迟加载
	 * @param id
	 * @return
	 */
	T load(Serializable id);
	
	/**
	 * 取出一个实体，所有属性都取出
	 * @param id
	 * @return
	 */
	T get(Serializable id);
	
	Session getSessionBeginTx();
	
	/**
	 * 加载所有实体
	 * @return
	 */
	List<T> loadAll();
	
	/**
	 * 添加实体
	 * @param entity
	 * @return
	 */
	Serializable save(T entity);
	
	/**
	 * 删除实体
	 * @param id
	 */
	void remove(Serializable id);
	
	/**
	 * 保存或更新实体
	 * @param entity
	 */
	void saveOrUpdate(T entity);
	
	/**
	 * 更新实体
	 * @param entity
	 */
	void update(T entity);
	
	
	/**
	 * 通过Criteria来查询
	 * @param criterion
	 * @param order
	 * @return
	 */
	List<T> cquery(Collection<Criterion> criterion,Collection<Order> order);
	
	/**
	 * 通过Criteria来分页查询
	 * @param page			页码
	 * @param row			每页记录数	
	 * @param criterion		条件
	 * @param order			排序条件
	 * @return
	 */
	Page pageCQuery(int page,int row,Collection<Criterion> criterion,Collection<Order> order,String desc);
	
	
	/**
	 * 直接调用hql语句来查询
	 * @param hql
	 * @param page
	 * @param row
	 * @param obj
	 * @return
	 */
	Page pageQuery(String hql,int page,int row,Object...obj);
	
	/**
	 * 更新非空实体
	 * @param entity
	 */
	void updateNotNullField(T entity);
	 
	
	/**
	 * 参数化查询
	 * @param hql
	 * @param params
	 * @return
	 */
	List<T> find(String hql, Object... params);
	
	/**
	 * 创建Query对象
	 * @param hql
	 * @param values
	 * @return 返回Query对象
	 */
	//Query createQuery(String hql, Object... values);

	/**
	 * 利用hql执行更新操作
	 * @param hql
	 * @param values
	 */
	//void exeUpdate(String hql, Object...values);
	
	List find(String hql,Integer maxResults,Object... values);
	
	/**
	 * 通过一个id数组批量删除所有的元素
	 * @param ids
	 */
	void deleteAll(Collection<Integer> ids);
	

	void testTx(T t1,T t2);

}
