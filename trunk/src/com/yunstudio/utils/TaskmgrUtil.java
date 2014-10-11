package com.yunstudio.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TaskmgrUtil {
	public static boolean killProcess(String...processNames) {
		
		try {
			Process listprocess = Runtime.getRuntime().exec("cmd.exe /c tasklist");
			InputStream is = listprocess.getInputStream();
			BufferedReader r = new BufferedReader(new InputStreamReader(is));
			String str = null;
			Set<String> processNamesSet=new HashSet<String>();
			processNamesSet.addAll(Arrays.asList(processNames));
			
			while ((str = r.readLine()) != null) {
			    String id = null; 
			    String processName=null;
			    
		    	Matcher matcher = Pattern.compile("(.+?)\\s+([0-9]+)").matcher(str); 
		    	if (matcher.find()) {  
		    		if (matcher.groupCount() >= 2) {   
		    			processName=matcher.group(1);
		    			
		    			if(!processNamesSet.contains(processName)){
		    				continue;
		    			}
		    			
		    			id = matcher.group(2);  
		    			Integer pid = Integer.parseInt(id);    
    					Runtime.getRuntime().exec("cmd.exe /c taskkill /f /pid " + pid);     
    					System.err.println("kill progress successfully. processName:"+processName+" pid: "+pid);    
		    		}
		    	}
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return false;
	}
	public static void main(String[] args) {
		TaskmgrUtil.killProcess("360chrome.exe");
	}
}
