package com.yunstudio.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;


public class Pdf2Swf   {
	//避免用静态字段造成死锁问题
//	private static File swfFile; // SWF目标文件
//	private static Runtime r;
//	private static File pdfFile; // PDF目标文件
//	private String rootPath;
//	private static int pageSize=1;//预览页数
	public  static Boolean pdf2Swf(String spath,String dpath,Integer pageSize){
		File pdfFile = new File(spath);
		File swfFile = new File(dpath);
		Runtime r = Runtime.getRuntime();
		
		if(pageSize==null){
			pageSize=20;
		}
		
		if (!swfFile.exists()) {
			if (pdfFile.exists()) {
				try {
					ActionContext ac = ActionContext.getContext();
					HttpServletRequest request =(HttpServletRequest)ac.get(ServletActionContext.HTTP_REQUEST);
					/*Process p = r.exec(request.getRealPath("/thirdparty/officetranslate/tools/pdf2swf.exe")
							+ " "
							+ pdfFile.getPath()
							+ " -o "
							+ swfFile.getPath() 
							+ " -T9" 
							+ " -p 1-"+pageSize);*/
					StringBuilder commandBuilder=new StringBuilder(
							request.getSession().getServletContext().getRealPath(
									"/thirdparty/officetranslate/tools/pdf2swf.exe"));
					
					commandBuilder.append(" ");
					commandBuilder.append(pdfFile.getPath());
					commandBuilder.append(" -o ");
					commandBuilder.append(swfFile.getPath());
					commandBuilder.append(" -T9 ");
					commandBuilder.append(" -p 1-");
					commandBuilder.append(pageSize);
					/*String command=request.getSession()
							.getServletContext().getRealPath(
									"/thirdparty/officetranslate/tools/pdf2swf.exe")
									+" "
									+pdfFile.getPath()
									+" -o "
									+swfFile.getPath()
									+" -T9 "
									+"";*/
					//command= command.toString().replace("\\", "//");
					System.out.println(commandBuilder.toString());
					Process p=r.exec(commandBuilder.toString());
					/*BufferedReader bufferedReader=new BufferedReader(new InputStreamReader(p.getInputStream()));
					String s=null;
					while((s=bufferedReader.readLine())!=null){
						  try {  
					            p.waitFor();  
					        } catch (InterruptedException e) {  
					            // TODO Auto-generated catch block  
					            e.printStackTrace();  
					            return false;
					        }
					}*/
					p.waitFor();
					System.out.println("转换成功");
					return true;
				} catch (Exception e) {
					e.printStackTrace();
					try {
						throw e;
					} catch (Exception e1) {
						// TODO Auto-generatedcatch block
						e1.printStackTrace();
						return false;
					}
				}
			} else {
	
				System.out.println("PDF文件不存在，无法转换");
				return false;
			}
		} else {
			System.out.println("已经转为SWF文件，无需再次转换");
		}
	
		/*if (pdfFile.exists()) {
			pdfFile.delete();
		}*/
		System.out.println("转换成功!!");
		return true;
		//HttpSession session = request.getSession();
		//session.setAttribute("fileName", swfFile.getName());
		//response.sendRedirect(request.getContextPath()
			//	+ "/preview/flexpaper/readFile.jsp");
	}
	
}
