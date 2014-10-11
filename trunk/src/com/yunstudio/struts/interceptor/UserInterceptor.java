package com.yunstudio.struts.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.yunstudio.entity.RepUser;
import com.yunstudio.entity.WebConstant;
import com.yunstudio.service.ParamService;

public class UserInterceptor  implements Interceptor{

	@Resource(name="paramService")
	private ParamService paramService;

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void init() {
		// TODO Auto-generated method stub
		
	}
	//未用。。
	public String intercept(ActionInvocation invo) throws Exception {
		// TODO Auto-generated method stub
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		HttpSession session=request.getSession();
		String uri=request.getRequestURI();
		String[] filterActionNames=new String[]{
				"showcenter",
				"listFolderInside",
				"removeCollect",
				"removeFolder",
				"update",
				"updatePassword",
				"collect",
				"resource_add",
				"resource_addMulti",
				"resource_update"
		};
		Object o=session.getAttribute(WebConstant.SessionAttrKey.USER);
		for (String n : filterActionNames) {
			if(uri.contains(n)){
				if(o==null){
					request.setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
							"您未登录或者登录已过期，请重新登录!!");
					request.setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							"/userOpt_login.do");
					
					request.getRequestDispatcher("/message.jsp").forward(request, response);
				}else {
					RepUser user=(RepUser) o;

					if(user.getIspassed().equals(0)){
						request.setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
								"您未通过审核，暂不能使用此功能!!");
						request.setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
								"/index.do");
						request.getRequestDispatcher("/message.jsp").forward(request, response);
					}

					if(user.getIspassed().equals(-1)){
						request.setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
								"您的注册已被退回，<br/>退回原因:"+
								(user.getNotpassreason()==null?
										"无"
										:user.getNotpassreason()));
						
						request.setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
								"/index.do");
						request.getRequestDispatcher("/message.jsp").forward(request, response);
					}


					if(user.getIslock().equals(1)){
						request.setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
								"您已经被管理员锁定，暂不能使用此功能!!");
						request.setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
								"/index.do");
						request.getRequestDispatcher("/message.jsp").forward(request, response);
					}
				}
			}
		}
		
		
		
		invo.invoke();
		
		return null;
	}


}
