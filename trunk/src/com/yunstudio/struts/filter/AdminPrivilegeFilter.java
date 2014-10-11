package com.yunstudio.struts.filter;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.yunstudio.entity.RepAdmin;
import com.yunstudio.entity.RepPermission;
import com.yunstudio.service.PermissionService;
import com.yunstudio.struts.interceptor.LogInterceptor;

public class AdminPrivilegeFilter implements Filter{

	private Set<String> actionNames=new HashSet<String>(); 
	
	public void init(FilterConfig filterConfig) throws ServletException {
		List<RepPermission> list=LogInterceptor.list;
		if(list!=null){
			for (RepPermission repPermission : list) {
				actionNames.add(repPermission.getActionname());
			}
		}
		list=null;
	}

	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request=(HttpServletRequest) req;
		HttpServletResponse response=(HttpServletResponse) resp;
		
		String uri=request.getRequestURI();
		boolean isAdmin=false;
		String[] uriStrs=uri.split("/");
		if(uriStrs!=null){
			for (String s : uriStrs) {
				if(s.equals("admin")){
					isAdmin=true;
				}
			}
		}
		String actionname=uri.substring(uri.lastIndexOf("/")+1,uri.lastIndexOf("."));
		
		RepAdmin admin=(RepAdmin) request.getSession().getAttribute(RepAdmin.ADMIN);
		boolean hasPermission=false;
		if(isAdmin&&actionNames.contains(actionname)){
			//判断是否是空避免空指针错误
			if(admin!=null&&admin.getRepRole()!=null){
				for (RepPermission permission : admin.getRepRole().getRepPermissions()) {
					//如果此管理员具有访问的action对应的权限，则把hasPermission标记设置成true
					if(permission.getActionname().equals(actionname)){
						hasPermission=true;
					}
				}
			}
			
			//有权限则访问
			if(hasPermission){
				if(admin.getIslock()==1){
					request.setAttribute("message", "对不起，您已经被管理员锁定，请联系管理员");
					request.getRequestDispatcher("/admin/NoPermissionMessage.jsp").forward(request, response);
				}else {
					chain.doFilter(request, response);
				}
			//没有权限则跳转
			}else {
				request.setAttribute("message", "对不起，您没有权限访问此页面");
				request.getRequestDispatcher("/admin/NoPermissionMessage.jsp").forward(request, response);
			}
		//不限制权限的访问内容则直接访问
		}else {
			chain.doFilter(request, response);
		}
		
		
	}

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}
