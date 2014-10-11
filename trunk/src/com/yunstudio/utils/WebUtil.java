package com.yunstudio.utils;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

public class WebUtil {
	
	public static String PARAMS="params";
	public static String MESSAGE="message";
	public static String RETURNURL="returnUrl";
	
	public static <T> T params2FormBean(
			Map<String, Object> params2,Class<T> class1){
		try{
			T t = class1.newInstance();
			BeanUtils.populate(t, params2);
			return t;
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	}
	public static <T> T params2Bean(Map<String, Object> params,Class<T> entity){
		try {
			
			T t=entity.newInstance();
			BeanUtils.populate(t, params);
			return t;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
}
