package com.yunstudio.utils;

import java.io.File;

public class Office2Pdf {
	/*//避免用静态字段造成死锁问题
//	private static File sourceFile; // 转换源文件
//	private static File pdfFile; // PDF目标文件

	public static Boolean word2Pdf(String spath,String dpath){
		// 转换源文件
		File sourceFile = new File(spath);
		// PDF目标文件
		File pdfFile = new File(dpath);

		// swf文件名不能有中文或者特殊字符，否则会出现找不到文件路径的问题，并且文件名不能存在特殊字符（如%），否则转换会失败
		//swfFile =new File(sourceFile);
			//new File(getServletContext().getRealPath(	"/preview/swf/a.swf"));
	//	System.out.println("第一步：生成文件对象，准备转换");
		// 转换成pdf文件
		if (sourceFile.exists()) {
			if (!pdfFile.exists()) {
				OpenOfficeConnection connection = new SocketOpenOfficeConnection(
						8100);
				try {
					connection.connect();
					DocumentConverter converter = new OpenOfficeDocumentConverter(
							connection);
					converter.convert(sourceFile, pdfFile);
					pdfFile.createNewFile();
					connection.disconnect();
					System.out.println("第二步：转换为PDF格式 路径" + pdfFile.getPath());
				} catch (java.net.ConnectException e) {
					e.printStackTrace();
					System.out.println("OpenOffice服务未启动");
					return false;
				} catch (com.artofsolving.jodconverter.openoffice.connection.OpenOfficeException e) {
					e.printStackTrace();
					System.out.println("读取文件失败");
					return false;
				} catch (Exception e) {
					e.printStackTrace();
					try {
						throw e;
					} catch (Exception e1) {
						e1.printStackTrace();
						return false;
					}
				}
			} else {
				System.out.println("已转换为PDF，无需再次转换");
				return true;
			}
		} else {
			System.out.println("要转换的文件不存在");
			return false;
		}
		return true;		
	}*/
}
