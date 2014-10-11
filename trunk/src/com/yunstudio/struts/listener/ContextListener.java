package com.yunstudio.struts.listener;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.ExternalOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;

import com.yunstudio.utils.MailUtil;
import com.yunstudio.utils.ViewOfficeTools;

public class ContextListener implements ServletContextListener{

	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		ViewOfficeTools.newInstance().getOfficeManager().stop();
	}

	public void contextInitialized(ServletContextEvent sce) {
		initViewOfficeTools(sce);
		
		initMailUtil();
	}
	
	private void initViewOfficeTools(ServletContextEvent sce){

		String officehome=sce.getServletContext().getInitParameter("officehome");
		int portnumbers=Integer.parseInt(sce.getServletContext().getInitParameter("portnumbers"));

		DefaultOfficeManagerConfiguration configuration = new DefaultOfficeManagerConfiguration();
		configuration.setOfficeHome(officehome);//设置OpenOffice.org安装目录
		configuration.setPortNumbers(portnumbers); //设置转换端口，默认为8100
		configuration.setTaskExecutionTimeout(1000 * 60 * 10L);//设置任务执行超时为5分钟
		configuration.setTaskQueueTimeout(1000 * 60 * 60 * 24L);//设置任务队列超时为24小时

		OfficeManager officeManager=configuration.buildOfficeManager();
		officeManager.start();
		ViewOfficeTools.newInstance().setOfficeManager(officeManager);
	}

	private void initMailUtil(){
		InputStream in=ContextListener.class.getResourceAsStream("/mailConfig.properties");
		Properties props=new Properties();
		try {
			props.load(in);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		MailUtil.setPort(Integer.parseInt(props.getProperty("port")));
		MailUtil.setServer(props.getProperty("server"));
		MailUtil.setFromName(props.getProperty("fromName"));
		MailUtil.setUser(props.getProperty("user"));
		MailUtil.setPassword(props.getProperty("password"));
		MailUtil.setTransportType(props.getProperty("transportType"));
	}
	
}
