package com.yunstudio.utils;

import java.io.File;

public class UploadUtils {
	
	public static String relativePath="/uploads";
	
	/**
	 * 通过hashcode生成文件目录，在一个目录下生成256*256个目录，
	 * 据教程里的老师说这样的目录计算机的查询效率高
	 * @param uploadPath
	 * @param fileName
	 * @return
	 */
	public static String makeDirs(String rootPath, String filename) {
		int hashCode = filename.hashCode();//内存地址
		int dir1 = hashCode&0x0f;//取hashCode的低4位   0~15  16个取值
		int dir2 = (hashCode&0xf0)>>4;//取hashCode的高4位   0~15  16个取值

		StringBuilder newPathBuilder=new StringBuilder(rootPath)
								.append("/")
								.append(relativePath)
								.append("/")
								.append(dir1)
								.append("/")
								.append(dir2);
		
		File file = new File(newPathBuilder.toString());
		if(!file.exists()){
			file.mkdirs();
		}
		
		StringBuilder relativePathBuilder=new StringBuilder(relativePath)
								.append("/")
								.append(dir1)
								.append("/")
								.append(dir2)
								.append("/")
								.append(filename);
		
		return relativePathBuilder.toString();
	}
}
