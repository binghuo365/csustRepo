package com.yunstudio.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yunstudio.entity.RepFormat;

public class StringUtil {
	public static boolean isNullOrEmpty(String s) {
		return s==null||s.isEmpty();
	}
	public static List<RepFormat> paramsFormatParseList(String formatStr) {
		List<RepFormat> list=new ArrayList<RepFormat>();
		if (isNullOrEmpty(formatStr)) {
			return list;
		}
		String[] formatItems=formatStr.split(",");
		if(formatItems==null){
			return list;
		}
		for (String formatItem : formatItems) {
			String[] str=formatItem.split(":");
			
			RepFormat format=new RepFormat();
			format.setName(str[0]);
			format.setSize(Integer.parseInt(str[1]));
			
			list.add(format);
		}
		return list;
	}
	/**
	 * 对系统配置中支持的文件格式以及大小进行解码，
	 * 
	 * @param formatStr
	 * @return 输出为map格式，大小为long类型,单位仍为mb
	 */
	public static Map<String,Long> paramsFormatParseMap(String formatStr) {
		Map<String, Long> formatItemMap=new HashMap<String, Long>();
		if (isNullOrEmpty(formatStr)) {
			return formatItemMap;
		}
		String[] formatItems=formatStr.split(",");
		if(formatItems==null){
			return formatItemMap;
		}
		for (String formatItem : formatItems) {
			String[] str=formatItem.split(":");
			
			formatItemMap.put(str[0], Long.parseLong(str[1]));
		}
		return formatItemMap;
	}
	
	/**
	 * 从文件的路径提取出文件名称
	 * @param encodefilepath
	 * @return
	 */
	public static String filepath2filename(String encodefilepath){
		int i1=encodefilepath.lastIndexOf("/");
		int i2=encodefilepath.lastIndexOf("\\");
		int i=i1>i2?i1:i2;
		return encodefilepath.substring(i+1, encodefilepath.lastIndexOf("_"));
	}
	public static String encodeFilename(String filename){
		String filenameExt=filename.substring(filename.lastIndexOf("."));
		StringBuilder sb=new StringBuilder(UUIDUtils.uuid().toString());
		sb.append(filenameExt.toLowerCase());
		return sb.toString();
	}
}
