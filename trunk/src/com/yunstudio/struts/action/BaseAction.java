package com.yunstudio.struts.action;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.CompoundRoot;
/**
 * 通用Action类:存放通用的Action方法
 * @author tocean
 *
 */
public class BaseAction extends ActionSupport{

	private static final long serialVersionUID = 3457764558820779292L;

	public int page=1;//当前页码
	   
    public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public HttpServletRequest getRequest(){   
        return ServletActionContext.getRequest();   
    }   
       
    public HttpServletResponse getResponse(){   
        return ServletActionContext.getResponse();   
    }   
       
    public HttpSession getSession(){   
        return getRequest().getSession();   
    }   
       
    public ServletContext getServletContext(){   
        return ServletActionContext.getServletContext();   
    }   
    
    public ActionContext getActionContext() {
		return ActionContext.getContext();
	}
    
    public Map<String, Object> getParameters() {
		return ActionContext.getContext().getParameters();
	}
    
    public Map<String, Object> getSessionMap() {
		return ActionContext.getContext().getSession();
	}
    
    public Map<String, Object> getContextMap() {
		return ActionContext.getContext().getContextMap();
	}
    
    public CompoundRoot getRoot() {
    	return ActionContext.getContext().getValueStack().getRoot();
	}
       
    public String getRealyPath(String path){   
        return getServletContext().getRealPath(path);   
    }   
           
}
