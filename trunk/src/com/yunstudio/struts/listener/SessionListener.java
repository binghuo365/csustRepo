package com.yunstudio.struts.listener;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.yunstudio.service.AdminService;

public class SessionListener implements HttpSessionAttributeListener,HttpSessionListener{

	private AdminService adminService;

	
	public void attributeAdded(HttpSessionBindingEvent se) {
		// TODO Auto-generated method stub
		
	}

	public void attributeRemoved(HttpSessionBindingEvent se) {
		// TODO Auto-generated method stub

//		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(se.getSession().getServletContext());
//		adminService=(AdminService) wac.getBean("adminService");
		
		
	}

	public void attributeReplaced(HttpSessionBindingEvent se) {
		// TODO Auto-generated method stub
		
	}


	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
	}


	public void sessionDestroyed(HttpSessionEvent se) {
//		WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(se.getSession().getServletContext());
//		adminService=(AdminService) wac.getBean("adminService");
		
	}
}
