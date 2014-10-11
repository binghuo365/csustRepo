package com.yunstudio.struts.filter;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yunstudio.entity.RepAdmin;

public class AdminLoginFilter implements Filter{

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest) req;
		HttpServletResponse response=(HttpServletResponse) resp;
		String uri=request.getRequestURI();
		HttpSession session=request.getSession();
		
		if(uri.contains("login")
				||uri.contains("resetPassword")
				||uri.endsWith("js")
				||uri.endsWith("css")){
			chain.doFilter(request, response);
		}else if (request.getSession().getAttribute(RepAdmin.ADMIN)!=null) {
			chain.doFilter(request, response);
		}else {
			response.sendRedirect(request.getContextPath()+"/admin/login.jsp");
		}
		
		
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
