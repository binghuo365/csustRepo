package com.fivestars.interfaces.bbs.client;

import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

import com.fivestars.interfaces.bbs.util.Base64;
/**
 * ================================================
 * Discuz! Ucenter API for JAVA
 * ================================================
 * 构造本接口运行所需要PHP的内置函数
 * 
 * 更多信息：http://code.google.com/p/discuz-ucenter-api-for-java/
 * 作者：梁平 (no_ten@163.com) 
 * 创建时间：2009-2-20
 */
public abstract class PHPFunctions {
	//JAVA EXTRA METHOD
	
	protected String urlencode(String value){
		return URLEncoder.encode(value);
	}
	protected String md5(String input){
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}	
		return byte2hex(md.digest(input.getBytes()));
	}
	protected String md5(long input){
		return md5(String.valueOf(input));
	}
	protected String base64_decode(String input){
		try {
			return new String(com.fivestars.interfaces.bbs.util.Base64.decode(input.toCharArray()),"iso-8859-1");
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	
	protected String base64_encode(String input){
		try {
			return new String(Base64.encode(input.getBytes("iso-8859-1")));
		} catch (Exception e) {
			return e.getMessage();
		}
	}
	protected String byte2hex(byte[] b) {
		StringBuffer hs = new StringBuffer();
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
				hs.append("0").append(stmp);
			else
				hs.append(stmp);
		}
		return hs.toString();
	}
	protected String substr(String input,int begin, int length){
		return input.substring(begin, begin+length);
	}
	protected String substr(String input,int begin){
		if(begin>0){
			return input.substring(begin);
		}else{
			return input.substring(input.length()+ begin);
		}
	}
	protected long microtime(){
		return System.currentTimeMillis();
	}
	protected long time(){
		return System.currentTimeMillis()/1000;
	}	
	protected String sprintf(String format, long input){
		String temp = "0000000000"+input;
		return temp.substring(temp.length()-10);
	}
	protected String call_user_func(String function, String model, String action, Map<String,Object> args){
		if("uc_api_mysql".equals(function)){
			return this.uc_api_mysql(model, action, args);
		}
		if("uc_api_post".equals(function)){
			return this.uc_api_post(model, action, args);
		}
		return "";
	}
	
	public abstract String uc_api_post(String $module, String $action, Map<String,Object> $arg );
	
	public abstract String uc_api_mysql(String $model, String $action, Map $args);

}
