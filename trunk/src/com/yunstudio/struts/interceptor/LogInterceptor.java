package com.yunstudio.struts.interceptor;

import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.util.StringUtils;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.yunstudio.entity.RepAdmin;
import com.yunstudio.entity.RepLog;
import com.yunstudio.entity.RepPermission;
import com.yunstudio.service.AdminService;
import com.yunstudio.service.LogService;
import com.yunstudio.service.PermissionService;

public class LogInterceptor implements Interceptor{

	@Resource(name="logService")
	private LogService logService;
	
	@Resource(name="permissionService") 
	private PermissionService permissionService;

	public static List<RepPermission> list;
	
	public void destroy() {
		// TODO Auto-generated method stub
		list=null;
	}
	
	public void init() {
		if(list==null){
			list=permissionService.loadAll();
		}
	}

	@SuppressWarnings("unchecked")
	public String intercept(ActionInvocation invocation) throws Exception {
		ActionContext actionContext=invocation.getInvocationContext();
		HttpServletRequest request=(HttpServletRequest) actionContext.get(ServletActionContext.HTTP_REQUEST);
		String actionName=actionContext.getName();
		
		String description=null;
		String type=null;
		
		//取出并遍历所有的permission对象，如果有含有actionName一样的则把对应的操作保存到description
		for (RepPermission permission : list) {
			if(permission.getActionname().equals(actionName)){
				description=permission.getName();
			}
		}
		//根据actionName里面包含的关键字判断操作的类型
		String actionNameLowerCase=actionName.toLowerCase();
		if(actionNameLowerCase.contains("add")){
			type="新增";
		}else if (actionNameLowerCase.contains("delete")) {
			type="删除";
		}else if (actionNameLowerCase.contains("update")
					||actionNameLowerCase.contains("lock")
					||actionNameLowerCase.contains("pass")
					||actionNameLowerCase.contains("modify")) {
			type="修改";
		}else if(actionNameLowerCase.contains("login")){
			type="登录";
			description="登录后台";
		}else if (actionNameLowerCase.contains("logout")) {
			type="登出";
			description="登出后台";
		}
		
		//创建RepLog对象来报错日志信息
		RepLog log=new RepLog();
		log.setOperationtime(new Date());
		log.setOperationip(request.getRemoteAddr());
		
		//执行action并获取执行完成的结果
		String result=invocation.invoke();
		
		String resultLowerCase=null;
		if(result!=null){
			resultLowerCase=result.toLowerCase();
		}
		//根据resultCode判断是否执行成功,不成功的话则什么也 不做
		if(resultLowerCase==null
				||resultLowerCase.equals("faild")
				||resultLowerCase.equals("add")
				||resultLowerCase.equals("edit")
				||resultLowerCase.equals("modify")
				||resultLowerCase.equals("login")
				){
			
		/*
		 * 成功的话根据
		 * description是否为空(即是否是有对应permission的action)
		 * type是否为空（既是否是含有增删改登陆登出的关键字）判断访问的action是否有必要记录。
		 */
		}else if(description!=null&&type!=null){
			RepAdmin admin=(RepAdmin) actionContext.getSession().get(RepAdmin.ADMIN);
			log.setRepAdmin(admin);
			log.setDescription(description);
			log.setOperationtype(type);
			log.setOperator(admin.getUsername());
			logService.add(log);
			
			Integer id=log.getId();
			List<Integer> ids=logService.findByhql(
					"select l.id from RepLog l where l.id<?", 0, id-800000);
			logService.deleteAll(ids);
			
		}
		
//		logService.remove();
		
		
		return result;
			
	}

}
