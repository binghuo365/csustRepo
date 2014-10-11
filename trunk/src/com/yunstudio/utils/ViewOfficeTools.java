package com.yunstudio.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.struts2.ServletActionContext;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;
import com.yunstudio.entity.RepResource;

/**
 * 未测试的代码
 * @author Z
 *
 */
public class ViewOfficeTools{
	
	
	public String swfRelativeDir="/thirdparty/officetranslate/swfs";
	public String pdfRelativeDir=UploadUtils.relativePath+"/pdf";
	public String toolRelativeDir="/WEB-INF";
	
	private String rootPath;
	
	private OfficeManager officeManager;
	
	public synchronized OfficeManager newOfficeManager() {
		String officehome=ServletActionContext.getServletContext().getInitParameter("officehome");
		int portnumbers=Integer.parseInt(ServletActionContext.getServletContext().getInitParameter("portnumbers"));

		DefaultOfficeManagerConfiguration configuration = new DefaultOfficeManagerConfiguration();
		configuration.setOfficeHome(officehome);//设置OpenOffice.org安装目录
		configuration.setPortNumbers(portnumbers); //设置转换端口，默认为8100
		configuration.setTaskExecutionTimeout(1000 * 60 * 10L);//设置任务执行超时为5分钟
		configuration.setTaskQueueTimeout(1000 * 60 * 60 * 24L);//设置任务队列超时为24小时
		
		return configuration.buildOfficeManager();
	}
	
	public OfficeManager getOfficeManager() {
		if(officeManager==null){
			officeManager=newOfficeManager();
		    getOfficeManager().start();
		}
		
		return officeManager;
	}

	public void setOfficeManager(OfficeManager officeManager) {
		this.officeManager = officeManager;
	}

	private static ViewOfficeTools viewOfficeTools=new ViewOfficeTools();
	
	private ViewOfficeTools(){}
	
	public static ViewOfficeTools newInstance() {
		return viewOfficeTools;
	}
	

	public  boolean office2Pdf(String spath,String dpath){
		// 转换源文件
		File sourceFile = new File(spath);
		// PDF目标文件
		File pdfFile = new File(dpath);

		// swf文件名不能有中文或者特殊字符，否则会出现找不到文件路径的问题，并且文件名不能存在特殊字符（如%），否则转换会失败
		//	System.out.println("第一步：生成文件对象，准备转换");
		// 转换成pdf文件
		if (sourceFile.exists()) {
	        OfficeDocumentConverter converter = 
	        		new OfficeDocumentConverter(getOfficeManager());
	        converter.convert(sourceFile,pdfFile);
		} else {
			//System.out.println("要转换的文件不存在");
			return false;
		}
		return true;		
	}
	
	public synchronized boolean pdf2Swf(String rootPath,
			String spath,String dpath,Integer pageSize){
		//System.out.println("pdf2Swf start------------------------------------->>>>>>");
		File pdfFile = new File(spath);
		File swfFile = new File(dpath);
		Runtime r = Runtime.getRuntime();
		
		if(pageSize==null){
			pageSize=20;
		}
		
		if (pdfFile.exists()) {
			try {
				StringBuilder commandBuilder=new StringBuilder(rootPath)
					.append(toolRelativeDir)
					.append("/tools/pdf2swf.exe \"")
					.append(pdfFile.getPath())
					.append("\" -o \"")
					.append(swfFile.getPath())
					.append("\" -T9 -s poly2bitmap -S ")
					.append(" -p 1-")
					.append(pageSize);
				
				System.out.println(commandBuilder.toString());
				Process p=r.exec(commandBuilder.toString().replace("/", "\\"));
				InputStream is=p.getInputStream();
				InputStream es=p.getErrorStream();
				
				BufferedReader br=new BufferedReader(new InputStreamReader(is));
				BufferedReader ebr=new BufferedReader(new InputStreamReader(es));
				String s=null;
				while((s=br.readLine())!=null){
					System.out.println(s);
				}
				while((s=ebr.readLine())!=null){
					System.out.println(s);
				}
				
				
				//p.waitFor();
				//System.out.println("转换成功");
				//System.out.println("pdf2Swf end------------------------------------->>>>>>");
				return true;
			} catch (Exception e) {
				//System.out.println("pdf2Swf 失败------------------------------------->>>>>>");
				e.printStackTrace();
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
					return false;
				}
			}
		} else {

			//System.out.println("PDF文件不存在，无法转换");
			return false;
		}
	
	}

	public String getSuffix(String path) {
		return path.substring(path.lastIndexOf(".")+1);
	}
	
	
	public boolean isOffice(String path) {
		String suffix=getSuffix(path);
		if(suffix.contains("doc")
				||suffix.contains("xls")
				||suffix.contains("ppt")
				||suffix.contains("txt")){
			return true;
		}else {
			return false;
		}
	}
	
	
	
	public void office2swf(RepResource resource){
		
		rootPath=ServletActionContext.getServletContext().getRealPath("").replace("\\", "/");

		String officepath=rootPath+resource.getPath();
		
		StringBuilder swfRelativePathBuilder=new StringBuilder()
			.append(swfRelativeDir)
			.append("/")
			.append(UUIDUtils.uuid())
			.append(".swf");
		String swfpath=rootPath+swfRelativePathBuilder.toString();
		
		if(getSuffix(officepath).equals("pdf")){
			 if(pdf2Swf(rootPath,officepath, swfpath, 20)){
				 resource.setTranslateurl(swfRelativePathBuilder.toString());
			 }
			 return ;
		}
		
		if(!isOffice(officepath)){
			return ;
		}
		
		StringBuilder pdfRelativePathBuilder=new StringBuilder()
			.append(pdfRelativeDir)
			.append("/")
			.append(UUIDUtils.uuid())
			.append(".pdf");
		String pdfPath=rootPath+pdfRelativePathBuilder;
		
		try {
			
			NewThread  newThread=new NewThread(rootPath,officepath,pdfPath,swfpath);
			Thread t1=new Thread(newThread);
			t1.setName("office转换线程_"+resource.getTitle());
			t1.setPriority(10);
			t1.start();
			resource.setTranslateurl(swfRelativePathBuilder.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @author Z
	 *
	 */
	class NewThread implements Runnable{

		private String rootPath;
		private String officepath;
		private String pdfPath;
		private String swfpath;
		
		public String getOfficepath() {
			return officepath;
		}

		public NewThread(String rootPath,String officepath, String pdfPath, String swfpath) {
			super();
			this.rootPath=rootPath;
			this.officepath = officepath;
			this.pdfPath = pdfPath;
			this.swfpath = swfpath;
		}

		public void setOfficepath(String officepath) {
			this.officepath = officepath;
		}

		public String getPdfPath() {
			return pdfPath;
		}

		public void setPdfPath(String pdfPath) {
			this.pdfPath = pdfPath;
		}

		public String getSwfpath() {
			return swfpath;
		}

		public void setSwfpath(String swfpath) {
			this.swfpath = swfpath;
		}

		public  void run() {
			// TODO Auto-generated method stub
			office2Pdf(officepath, pdfPath);
			synchronized(ViewOfficeTools.newInstance()){
				Timer killPdf2swfTimer=new Timer(true);
				killPdf2swfTimer.schedule(new KillPdf2Task(), 1000*60*10);
				
				pdf2Swf(rootPath,pdfPath,swfpath, 20);
				System.out.println(Thread.currentThread().getName());	

				File pdfFile=new File(pdfPath);
				if(pdfFile.exists()){
					pdfFile.delete();
				}
			}
		}
	}

	class KillPdf2Task extends TimerTask{

		@Override
		public void run() {
			// TODO Auto-generated method stub
			System.err.println("开始超时结束pdf2swf进程任务......");
			TaskmgrUtil.killProcess("pdf2swf.exe");
		}
		
	}
}
