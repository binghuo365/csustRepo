package com.yunstudio.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
/**
 * hqlutils工具类，
 * 对用hql语句进行条件查询时的拼接操作进行了简单的封装，
 * conditionMap保存的是条件
 * 
 * @author Z
 *
 */
public class HqlUtils {
	
	private List<Object> list=new ArrayList<Object>();
	
	/**
	 * 
	 * example:
	 * 	Map<String, Object> conditionMap=new HashMap<String, Object>();
	 * 	conditionMap.put("u.username = ?","user");
	 * 	String hql=HqlUtils.condition2hql("select u from RepUser",conditionMap,"order by u.id desc");
	 * @param hql
	 * @param conditionMap条件和参数
	 * @param orderBy
	 * @return hql
	 */
	public String condition2hql(String hql,Map<String, Object> conditionMap,String orderBy){
		StringBuilder where=new StringBuilder(hql);
		if(conditionMap.size()>0){
			where.append(" where ");
		}
		
		boolean flag=true;
		for (Map.Entry<String, Object> condition : conditionMap.entrySet()) {
			String key=condition.getKey();
			Object value=condition.getValue();
			
			if(flag){
				where.append(key);
				flag=false;
			}else {
				where.append(" and "+key);
			}
			list.add(value);
			
		}
		
		return where.append(" ").append(orderBy).toString();
	}
	
	public String condition2hql(StringBuilder hql,Map<String, Object> conditionMap,String orderBy){
		StringBuilder where=new StringBuilder(hql);
		if(conditionMap.size()>0){
			where.append(" where ");
		}
		
		boolean flag=true;
		for (Map.Entry<String, Object> condition : conditionMap.entrySet()) {
			String key=condition.getKey();
			Object value=condition.getValue();
			
			if(flag){
				where.append(key);
				flag=false;
			}else {
				where.append(" and "+key);
			}
			
			if(value!=null){
				list.add(value);
			}
			
		}
		
		return where.append(" ").append(orderBy).toString();
	}
	
	
	public Object[] getObjects(){
		return list.toArray();
	}
}
