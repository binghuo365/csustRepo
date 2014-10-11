package com.yunstudio.utils;

import java.util.UUID;
/**
 * 生成随机的uuid，
 * 在项目总结时把UUIDutils、hqlutils、md5utils都放到StringUtils里面
 * @author Z
 *
 */
public class UUIDUtils {
	public static String uuid() {
		return UUID.randomUUID().toString();
	}
}
