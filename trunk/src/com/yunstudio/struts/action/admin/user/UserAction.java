package com.yunstudio.struts.action.admin.user;

import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.locale.converters.DateLocaleConverter;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepUser;
import com.yunstudio.service.UserService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.struts.form.UserAddForm;
import com.yunstudio.struts.form.UserForm;
import com.yunstudio.utils.MD5Util;
import com.yunstudio.utils.WebUtil;

/**
 * 前台用户管理的action
 * 
 * @author 杨真
 * 	
 * 2013-6-16 9:42
 *
 */
public class UserAction extends BaseAction{
	
	@Resource(name="userService")
	private UserService userService;

	
	public String left() {
		return "left";
	}

	public String list() {
		
		
		int pageNum=1;
		int pageSize=20;
		/*Cookie[] cookies=request.getCookies();
		boolean cookieExistFlag=false;
		for (Cookie cookie : cookies) {
			if(cookie.getName().equals(Page._COOKIE_PAGE_SIZE)){
				pageSize=Integer.parseInt(cookie.getValue());
				cookieExistFlag=true;
			}
		}
		if(!cookieExistFlag){
			Cookie cookie=new Cookie(Page._COOKIE_PAGE_SIZE, "20");
			response.addCookie(cookie);
		}
		*/
		
		List<String> likenNames=Arrays.asList("username","school","major");
		List<String> eqNames=Arrays.asList("islock","ispassed","teacherorstu");
		
		Set<Criterion> criterions=new HashSet<Criterion>();
		Set<Order> orders=new HashSet<Order>();
		Order order=Order.desc("id");
		orders.add(order);
/*
 * 注：此方法下方的注释部分是pageQuery方法拼接hql语句的分页实现方案
 * 
 * @author 杨真 8-16 9:41
 */
//		StringBuilder hql=new StringBuilder("from RepUser u ");
//		String orderBy="desc";
//		ArrayList<Object> hqlParams=new ArrayList<Object>();
		
//		int paramIndex=0;
		for (Map.Entry<String, Object> param : getParameters().entrySet()) {
			String name=param.getKey();
			String value=((String[])param.getValue())[0];
			if(value!=null&&!value.isEmpty()){
//				if(eqNames.contains(name)&&!value.equals("-1")){
				if(eqNames.contains(name)){
					criterions.add(Restrictions.eq(name, Integer.parseInt(value)));
						/*if(paramIndex==0){
							hql.append("where ");
							hql.append("u."+name+" =? ");
						}else {
							hql.append("and u."+name+" =? ");
						}

						hqlParams.add(paramIndex,Integer.parseInt(value));
						paramIndex++;*/
					
				}else if(likenNames.contains(name)){
					criterions.add(Restrictions.like(name, "%"+value.trim()+"%"));
					/*if(paramIndex==0){
						hql.append("where ");
						hql.append("u."+name+" like ? ");
					}else{
						hql.append("and u."+name+" like ? ");
					}
					
					hqlParams.add(paramIndex,"%"+value+"%");
					paramIndex++;*/
					
				}else if(name.equals(Page.PAGENO)){
					pageNum=Integer.parseInt(value);
				}else if(name.equals(Page.QUERYORDERBY)){
					if(value.equals("asc")){
//						orderBy="asc";
						orders.remove(order);
						orders.add(Order.asc("id"));
					}
				}else if (name.equals(Page.PAGESIZE)) {
					pageSize=Integer.parseInt(value);
					if(pageSize<=0){
						pageSize=20;
					}
				}
			}
		}
		
//		hql.append("order by u.id "+orderBy);
//		
//		System.out.println(hql);
//		
//		Page page=userService.pageQuery(hql.toString(), pageNum, pageSize, hqlParams.toArray());
		Page page=userService.pageCQuery(pageNum, pageSize, criterions, orders,"id");
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		
		return "list";
	}
	
	public String add(){

		//判断是否是get方法获取的，
		//如果是get方法获取的则说明是访问新建管理员的表单而不是提交表单。
		if(getRequest().getMethod().equals("GET")){
			return "add";
		}
		
		UserAddForm userAddForm=WebUtil.params2FormBean(getParameters(), UserAddForm.class);
		RepUser user=new RepUser();
		try {
			BeanUtils.copyProperties(user, userAddForm);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		user.setUsername(user.getUsername().trim());
		

		//判断是否存在同名用户
		RepUser u=userService.findUserByName(user.getUsername());
		if(u!=null){
			getContextMap().put("message", "已经存在同名用户，请换个用户名!");
			getContextMap().put("params", getParameters());
			return "add";
		}
		
		user.setPassword(MD5Util.MD5(user.getPassword()));
		user.setRegtime(new Date());
		if(user.getIspassed()==null||user.getIspassed().equals(1)){
			user.setPasstime(new Date());
		}else {
			user.setPasstime(null);
		}
		
		userService.add(user);

		getContextMap().put("message", "新增成功");
		getContextMap().put("returnUrl", "user_list.do");
		
		return SUCCESS;
	}
	
	public String edit() {
		String idStr=getRequest().getParameter("id");
		int id=0;
		if(idStr!=null&&!idStr.isEmpty()){
			id=Integer.parseInt(idStr);
		}
		RepUser user=userService.get(id);
		
		getRoot().push(user);
		return "edit";
	}
	
	public String update() {
		
		RepUser user=WebUtil.params2FormBean(getParameters(), RepUser.class);

		RepUser u=userService.findUserByName(getRequest().getParameter("username").trim());
		if(u!=null&&!u.getId().equals(user.getId())){
			getContextMap().put("message", "已经存在同名用户，请换个用户名!");
			getRoot().push(user);
			return "edit";
		}
		
		user.setUsername(user.getUsername().trim());
		if(user.getPassword()!=null&&!user.getPassword().isEmpty()){
			user.setPassword(MD5Util.MD5(user.getPassword()));
		}else {
			user.setPassword(null);
		}
		
		userService.updateNotNullField(user);

		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "user_list.do");
		
		return SUCCESS;
	}
	
	public String delete() {
		String idStr=getRequest().getParameter("id");
		int id = -1;
		if(idStr!=null&&!idStr.isEmpty()){
			id=Integer.parseInt(idStr);
			userService.remove(id);
		}

		String[] ids=(String[])getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idS : ids) {
				id=Integer.parseInt(idS);
				userService.remove(id);
			}
		}


		getContextMap().put("message", "删除成功");
		getContextMap().put("returnUrl", "user_list.do");
		
		return SUCCESS;
	}
	
	public String lock() {
		String[] ids=(String[]) getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idStr : ids) {
				int id=Integer.parseInt(idStr);
				RepUser user=userService.get(id);
				user.setIslock(1);
				userService.update(user);
			}
		}
		


		getContextMap().put("message", "锁定成功");
		getContextMap().put("returnUrl", "user_list.do");
		
		return SUCCESS;
	}
	
	public String unlock() {
		String[] ids=(String[]) getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idStr : ids) {
				int id=Integer.parseInt(idStr);
				RepUser user=userService.get(id);
				user.setIslock(0);
				userService.update(user);
			}
		}
		


		getContextMap().put("message", "解锁成功");
		getContextMap().put("returnUrl", "user_list.do");
		
		return SUCCESS;
	}
	
	public String pass() {
		String[] ids=(String[]) getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idStr : ids) {
				int id=Integer.parseInt(idStr);
				RepUser user=userService.get(id);
				user.setIspassed(1);
				user.setPasstime(new Date());
				userService.update(user);
			}
		}


		getContextMap().put("message", "审核成功");
		getContextMap().put("returnUrl", "user_list.do");
		
		return SUCCESS;
	}
	
	public String reject() {
		String[] ids=(String[]) getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idStr : ids) {
				int id=Integer.parseInt(idStr);
				RepUser user=userService.get(id);
				user.setIspassed(-1);
				user.setPasstime(new Date());
				user.setNotpassreason(getRequest().getParameter("notpassreason"));
				userService.update(user);
			}
		}


		getContextMap().put("message", "审核成功");
		getContextMap().put("returnUrl", "user_list.do");
		
		return SUCCESS;
	}
}
