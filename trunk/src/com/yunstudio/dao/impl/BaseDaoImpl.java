package com.yunstudio.dao.impl;

import java.io.Serializable;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.yunstudio.dao.BaseDao;
import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepGscatalog;

/**
 * 通用数据访问Dao实现类
 * @author tocean
 * @param <T> T 为需要持久化的实体类型，具体的业务Dao须指定具体实体类型
 */
//写项目总结的时候可以尝试解决spring声名式事务失败的问题
/*http://developer.51cto.com/art/200906/127423.htm
 * http://melin.iteye.com/blog/123555
 * 还有手册上关于hibernateTemplate
 */
public abstract class BaseDaoImpl<T> implements BaseDao<T> {

	//每个具体传入的实体类型对象
	private Class<T> entityClass;
	private HibernateTemplate hibernateTemplate;

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}
	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
//	@Resource
//	private SessionFactory sessionFactory;
	
	/*
	 * 初始化entityClass对象
	*/
	@SuppressWarnings("unchecked")
	public BaseDaoImpl() {
		Type genType = getClass().getGenericSuperclass();
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		entityClass = (Class) params[0];
	}

	/**
	 * 更新非空值
	 * @param id
	 * @param entity
	 * @return 更新后的对象实体
	 */
	@Transactional
	public void updateNotNullField(T entity) {
		try {
			Method getId = entityClass.getDeclaredMethod("getId");
			Integer id = (Integer) getId.invoke(entity);
			T newEntity = get(id);
			Method[] methods = entityClass.getDeclaredMethods();
			for (Method method : methods) {
				String methodName = method.getName();
				if (methodName.startsWith("get")) // 枚举出所有get方法
				{
					Object object = method.invoke(entity);
					if (object != null) {
						    /*
						     * 1,将entityClass.getDeclaredMethod的第二个参数由object.class改成了
  					         *method.getReturnType()，避免由于泛型导致的类型不一致
  					         *
  					         *	2,对set类型增加了判断，避免了set里面没有元素时也会进行保存的情况.
						     * @author 杨真 2013-8-18 11;48
						     */
						if(object instanceof Set){
							if(((Set) object).size()>0){
								Method setMethod = entityClass.getDeclaredMethod("set"
										+ methodName.substring(3), method.getReturnType());
								setMethod.invoke(newEntity, object);
							}
						}else {
							Method setMethod = entityClass.getDeclaredMethod("set"
									+ methodName.substring(3), method.getReturnType());
							setMethod.invoke(newEntity, object);
						}
					}
				}
			}
			update(newEntity);//更新实体
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 参数化查询
	 * @param hql
	 * @param params
	 * @return 查询实体对象的结果列表
	 */
	@SuppressWarnings("unchecked")
	@Transactional
	public List find(String hql, Object... params) {
//		Session session=getSessionBeginTx();
//		Query query=session.createQuery(hql);
//		if(params!=null){
//			for (int i = 0; i < params.length; i++) {
//				query.setParameter(i, params[i]);
//			}
//		}
//		List list=query.list();
//		
//		closeCommitTx(session);
//		return list;
		
		return getHibernateTemplate().find(hql, params);
	}

	/**
	 * 创建Query对象
	 * @param hql
	 * @param values
	 * @return 返回Query对象
	 */
//	public Query createQuery(Session session ,String hql, Object... values) {
//		Assert.hasText(hql);
//		Query query = session.createQuery(hql);
//		if(values!=null){
//			for (int i = 0; i < values.length; i++) {
//				query.setParameter(i, values[i]);
//			}
//		}
//		return query;
//	}

	/**
	 * 加载一个实体，属性延迟加载
	 * @param id
	 * @return
	 */
	
	public T load(Serializable id) {
		return get(id);

	}

	/**
	 * 通过Criterion和Order来创建Criteria对象
	 * @param criterions
	 * @param orders
	 * @return Criteria对象
	 */
//	public Criteria criteriaQuery(Session session,Collection<Criterion> criterions,
//			Collection<Order> orders) {
//		Criteria criteria = session.createCriteria(entityClass);
//
//		if (criterions != null) {
//			for (Criterion criterion : criterions) {
//				criteria.add(criterion);
//			}
//		}
//		if (orders != null) {
//			for (Order order : orders) {
//				criteria.addOrder(order);
//			}
//		}
//		return criteria;
//	}

	/**
	 * 通过Criteria来分页查询
	 * @param page			页码
	 * @param row			每页记录数	
	 * @param criterion		条件
	 * @param order			排序条件
	 * @return 查询对象列表的Page对象,包含分页信息和列表信息
	 */
	@Transactional
	public Page pageCQuery(final int page, final int row, final Collection<Criterion> criterions,
			final Collection<Order> orders,final String desc) {
//		Session session=getSessionBeginTx();
		
		long count=  (Long) getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Criteria countCriteria=session.createCriteria(entityClass);
				if(orders!=null){
					for (Order order : orders) {
						countCriteria.addOrder(order);
					}
				}
				
				if(criterions!=null){
					for (Criterion criterion : criterions) {
						countCriteria.add(criterion);
					}
				}
				countCriteria.setProjection(Projections.count(desc));
				return  countCriteria.list();

			}
		}).get(0);
		
		

		//total:总页数
		int total = (int) ((count + row - 1) / row);
		//startIndex:每页第一条记录开始位置
		final int startIndex = Page.calStartIndex(page, row);

		

		List list =getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Criteria criteria = session.createCriteria(entityClass);
				if(orders!=null){
					for (Order order : orders) {
						criteria.addOrder(order);
					}
				}
				if(criterions!=null){
					for (Criterion criterion : criterions) {
						criteria.add(criterion);
					}
				}
				return criteria.setFirstResult(startIndex).setMaxResults(row).list();
			}
		});

		System.out.println(list.size()+".......");
		Page p=new Page(startIndex, total, page, count, list);
		p.setPageSize(row);
		return p;
		
	}


	/**
	 * 通过Criteria来查询
	 * @param criterion
	 * @param order
	 * @return 查询实体对象的结果列表
	 */
	@Transactional
	public List<T> cquery(Collection<Criterion> criterions,
			Collection<Order> orders) {
//		Session session=getSessionBeginTx();
//		
//		Criteria criteria = criteriaQuery(session,criterions, orders);
//		
//		List<T> list= criteria.list();
//		//提交事务
//		closeCommitTx(session);
		DetachedCriteria dc=DetachedCriteria.forClass(entityClass);
		if(criterions!=null){
			for (Criterion criterion : criterions) {
				dc.add(criterion);
			}
		}
		if(orders!=null){
			for (Order order : orders) {
				dc.addOrder(order);
			}
		}
		
		return getHibernateTemplate().findByCriteria(dc);
	}

	/**
	 * 取出一个实体，所有属性都取出
	 * @param id
	 * @return
	 */
	@Transactional
	public T get(Serializable id) {
//		Session session=getSessionBeginTx();
//		T e=(T) session.get(entityClass, id);
//		closeCommitTx(session);
		
		return getHibernateTemplate().get(entityClass, id);
	}

	/**
	 * 加载所有实体
	 * @return 查询实体对象的结果列表
	 */
	@Transactional
	public List<T> loadAll() {
//		Session session=getSessionBeginTx();
//		Criteria criteria=session.createCriteria(entityClass);
//		List<T> list=criteria.list();
//		
//		closeCommitTx(session);
		DetachedCriteria dCriteria=DetachedCriteria.forClass(entityClass);
		return getHibernateTemplate().findByCriteria(dCriteria);
	}

	/**
	 * 添加实体
	 * @param entity
	 * @return
	 */
	@Transactional
	public Serializable save(T entity) {
//		Session session=getSessionBeginTx();
//		Serializable s=session.save(entity);
//		closeCommitTx(session);
		return  getHibernateTemplate().save(entity);
	}

	/**
	 * 删除实体
	 * @param id
	 */
	@Transactional
	public void remove(Serializable id) {
		
//		Session session=getSessionBeginTx();
//		try {
//			T e=entityClass.newInstance();
//			Method setIdMethod=entityClass.getMethod("setId", Integer.class);
//			setIdMethod.invoke(e, id);
//			session.delete(e);
//			closeCommitTx(session);
//			
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			session.getTransaction().rollback();
//		}
		Object o=getHibernateTemplate().get(entityClass, id);
		getHibernateTemplate().delete(o);
	}

	/**
	 * 保存或更新实体
	 * @param entity
	 */
	@Transactional
	public void saveOrUpdate(T entity) {
//		Session session=getSessionBeginTx();
//		session.saveOrUpdate(entity);
//		closeCommitTx(session);
		getHibernateTemplate().saveOrUpdate(entity);
	}

	/**
	 * 更新实体
	 * @param entity
	 */
	@Transactional
	public void update(T entity) {
//		Session session=getSessionBeginTx();
//		session.update(entity);
//		closeCommitTx(session);
		getHibernateTemplate().update(entity);
	}

	/**
	 * 利用hql执行更新操作
	 * @param hql
	 * @param values
//	 */
//	public void exeUpdate(String hql, Object... values) {
//		Session session=getSessionBeginTx();
//		
//		Query query = session.createQuery(hql);
//		try {
//			for (int i = 0; i < values.length; i++) {
//				query.setParameter(i, values[i]);
//			}
//			query.executeUpdate();
//			closeCommitTx(session);
//		} catch (HibernateException e) {
//			// TODO Auto-generated catch block
//			if(!session.getTransaction().wasRolledBack()){
//				session.getTransaction().rollback();
//				session.close();
//			}
//			e.printStackTrace();
//		}
//	}

	/**
	 * 直接调用hql语句来查询
	 * @param hql  hql语句
	 * @param page 页码
	 * @param row  每页记录数
	 * @param obj  参数列表
	 * @return 查询对象列表的Page对象,包含分页信息和列表信息
	 */
	@SuppressWarnings("unchecked")
	@Transactional
	public Page pageQuery(final String hql, int page, final int row, final Object... values) {
		Assert.hasText(hql);
		Assert.isTrue(page >= 1, "pageNo should start from 1");
		// Count 返回总的记录数
		String countQueryString = " select count (*) "
				+ removeSelect(removeOrders(hql));
		List countlist = find(countQueryString, values);

		long totalCount = (Long) countlist.get(0);

		if (totalCount < 1)
			return new Page();

		int total = (int) (totalCount + row - 1) / row;
		// 返回起始页面
		final int startIndex = Page.calStartIndex(page, row);
		
		
//		Session session=getSessionBeginTx();

//		Query query = createQuery(session,hql, values);
//		Iterator iterator = query.setFirstResult(startIndex).setMaxResults(row)
//				.iterate();
//		List list = new LinkedList();
//		while (iterator.hasNext()) {
//			list.add(iterator.next());
//		}
		//避免懒加载时导致读取数据时已经提交事务。。。@author 杨真 8-16 9:29
//		List<T> list=query.setFirstResult(startIndex).setMaxResults(row).list();
		List<T> list=getHibernateTemplate().executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query=session.createQuery(hql);
				query.setFirstResult(startIndex);
				
				if(values!=null){
					for (int i = 0; i < values.length; i++) {
						query.setParameter(i, values[i]);
					}
				}
				
				query.setMaxResults(row);
				return query.list();
			}
		});
		Page p=new Page(startIndex, total, page, totalCount, list);
		p.setPageSize(row);
		//提交事务
//		closeCommitTx(session);
		return p;
	}

	private static String removeSelect(String hql) {
		Assert.hasText(hql);
		int beginPos = hql.toLowerCase().indexOf("from");
		Assert.isTrue(beginPos != -1, " hql : " + hql
				+ " must has a keyword 'from'");
		return hql.substring(beginPos);
	}

	private static String removeOrders(String hql) {
		Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	public void initialize(Object entity) {
		this.getHibernateTemplate().initialize(entity);
	}




	@Transactional
	public List find(final String hql, final Integer maxResults,final Object... params) {
//		HibernateTemplate hibernateTemplate=this.getHibernateTemplate();
//		hibernateTemplate.setMaxResults(maxResults);

//		Session session=getSessionBeginTx();
//
//		Query query=session.createQuery(hql);
//		if(maxResults!=null&&maxResults>0){
//			query.setMaxResults(maxResults);
//		}
//		if(params!=null){
//			for (int i = 0; i < params.length; i++) {
//				query.setParameter(i, params[i]);
//			}
//		}
//		List list=query.list();
//		closeCommitTx(session);
		//watchC3p0();
		return hibernateTemplate.executeFind(new HibernateCallback() {

			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query=session.createQuery(hql);
				if(maxResults>0){
					query.setMaxResults(maxResults);
				}
				
				if(params!=null&&params.length>0){
					for (int i=0;i<params.length;i++) {
						query.setParameter(i, params[i]);
					}
				}
				
				return query.list();
			}
		});
	}

	@Transactional
	public void deleteAll(Collection<Integer> ids){
		List<T> list=new ArrayList<T>();
		for (Integer id : ids) {
			try {
				
				T e=entityClass.newInstance();
				Method setIdMethod=entityClass.getMethod("setId", Integer.class);
				setIdMethod.invoke(e, id);
				list.add(e);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		getHibernateTemplate().deleteAll(list);
//
//		Session session=getSessionBeginTx();
//		for (T t : list) {
//			session.delete(t);
//		}
//
//		closeCommitTx(session);
	}
	
	
	public Query createQuery(String hql, Object... values) {
		// TODO Auto-generated method stub
		return null;
	}
	
	private static int flag=0;
	private static int count=0;
	
	private void closeCommitTx(Session session){
//		session.getTransaction().commit();
//		session.close();
//		synchronized (BaseDaoImpl.class) {
//			BaseDaoImpl.flag--;
//			System.out.println("到底关闭连接没有啊??____close session"+flag);
//		}
	}
	public Session getSessionBeginTx() {
//		/*return SessionFactoryUtils.getSession(hibernateTemplate
//				.getSessionFactory(), true);*/
//		Session session=sessionFactory.openSession();
//		session.beginTransaction();
//		synchronized (BaseDaoImpl.class) {
//			BaseDaoImpl.flag++;
//			count++;
//			System.out.println("到底关闭连接没有啊??____open session"+flag+"总数:"+count);
//		}
		return null;
	}
	
	
	/*@Resource
	private ComboPooledDataSource dataSource;
	public void watchC3p0() {
		dataSource.addPropertyChangeListener(new PropertyChangeListener() {
			
			public void propertyChange(PropertyChangeEvent evt) {
				// TODO Auto-generated method stub
			}
		});
		 // make sure it's a c3p0 PooledDataSource   
		if ( dataSource instanceof PooledDataSource) {   
			try {
				System.out.println("=============================================================");
				PooledDataSource pds = (PooledDataSource) dataSource; 
				System.err.println("num_connections: " + pds.getNumConnectionsDefaultUser());   
				System.err.println("num_busy_connections: " + pds.getNumBusyConnectionsDefaultUser()); 
				System.err.println("num_idle_connections: " + pds.getNumIdleConnectionsDefaultUser());
				System.out.println("=============================================================");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		} else{
			System.err.println("Not a c3p0 PooledDataSource!");  
		}
	}
*/
	
	@Transactional
	public void testTx(T t1,T t2){
		this.save(t1);
		
		int i=1/0;
			
		this.save(t2);
	}
}
