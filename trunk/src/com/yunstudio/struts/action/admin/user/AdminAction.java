package com.yunstudio.struts.action.admin.user;

import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.locale.converters.DateLocaleConverter;
import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepAdmin;
import com.yunstudio.entity.RepRole;
import com.yunstudio.entity.RepUser;
import com.yunstudio.entity.WebConstant;
import com.yunstudio.service.AdminService;
import com.yunstudio.service.RoleService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.struts.form.AdminAddForm;
import com.yunstudio.struts.form.UserForm;
import com.yunstudio.utils.MD5Util;
import com.yunstudio.utils.MailUtil;
import com.yunstudio.utils.StringUtil;
import com.yunstudio.utils.UUIDUtils;
import com.yunstudio.utils.WebUtil;

/**
 * 前台用户管理的action
 * 
 * @author 杨真
 * 	
 * 2013-8-16 15:22
 *
 */
public class AdminAction extends BaseAction{

	@Resource(name="adminService")
	private AdminService adminService;
	
	@Resource(name="roleService")
	private RoleService roleService;

	public String left() {
		return "left";
	}

	private static final String emailTitle="您的密码已经重置----长沙理工大学教学资源库";
	
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
		List<String> eqNames=Arrays.asList("islock","ispassed","teacherorstu","roleid");
		
		Set<Criterion> criterions=new HashSet<Criterion>();
		Set<Order> orders=new HashSet<Order>();
		Order order=Order.desc("id");
		orders.add(order);

		for (Map.Entry<String, Object> param : getParameters().entrySet()) {
			String name=param.getKey();
			String value=((String[])param.getValue())[0];
			if(value!=null&&!value.isEmpty()){
				if(eqNames.contains(name)){
					if(!value.equals("-1")){
						if(name.equals("roleid")){
							criterions.add(Restrictions.eq("repRole.id", Integer.parseInt(value)));
						}else {
							criterions.add(Restrictions.eq(name, Integer.parseInt(value)));
						}
					}
					
				}else if(likenNames.contains(name)){
					criterions.add(Restrictions.like(name, "%"+value.trim()+"%"));

				}else if(name.equals(Page.PAGENO)){
					pageNum=Integer.parseInt(value);
				
				}else if(name.equals(Page.QUERYORDERBY)){
					if(value.equals("asc")){
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
		
		Page page=adminService.pageCQuery(pageNum, pageSize, criterions, orders,"id");
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		

		List<RepRole> roles=roleService.loadAll();
		getContextMap().put("roles", roles);
		
		return "list";
	}
	
	public String add(){
		
		List<RepRole> roles=roleService.loadAll();
		getContextMap().put("roles", roles);
		
		//判断是否是get方法获取的，
		//如果是get方法获取的则说明是访问新建管理员的表单而不是提交表单。
		if(getRequest().getMethod().equals("GET")){
			return "add";
		}
		
		RepAdmin a=adminService.findAdminByName(getRequest().getParameter("username").trim());
		if(a!=null){
			getContextMap().put("message", "已经存在同名用户，请换个用户名!");
			getContextMap().put("params", getParameters());
			return "add";
		}
		
		
		AdminAddForm adminAddForm=WebUtil.params2FormBean(getParameters(), AdminAddForm.class);
		RepAdmin admin=new RepAdmin();
		
		
		try {
			BeanUtils.copyProperties(admin, adminAddForm);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		admin.setUsername(admin.getUsername().trim());
		admin.setPassword(MD5Util.MD5(admin.getPassword()));
		admin.setAddtime(new Date());
		
		int roleid=Integer.parseInt(((String[])getParameters().get("roleid"))[0]);
//		admin.setRepRole(roleService.get(roleid));
		RepRole role=new RepRole();
		role.setId(roleid);
		admin.setRepRole(role);

		adminService.add(admin);


		getContextMap().put("message", "新增成功");
		getContextMap().put("returnUrl", "admin_list.do");
		
		return SUCCESS;
	}

	public String addui() {
		return "addui";
	}
	
	public String edit() {
		int id=Integer.parseInt(getRequest().getParameter("id"));
		RepAdmin admin=adminService.get(id);
		List<RepRole> roles=roleService.loadAll();
		
		getContextMap().put("roles", roles);
		getRoot().push(admin);
		return "edit";
	}
	
	public String update() {
		
		UserForm userForm=WebUtil.params2FormBean(getParameters(), UserForm.class);
		RepAdmin admin=new RepAdmin();
		
		ConvertUtils.register(new DateLocaleConverter(), Date.class);
		try {
			BeanUtils.copyProperties(admin, userForm);
		} catch (Exception e) {
			e.printStackTrace();
		}

		admin.setUsername(admin.getUsername().trim());
		RepAdmin a=adminService.findAdminByName(admin.getUsername());
		if(a!=null&&!a.getId().equals(admin.getId())){
			getContextMap().put("message", "已经存在同名用户，请换个用户名!");
			getContextMap().put("params", getParameters());
			return "edit";
		}
		
		if(admin.getPassword()!=null&&!admin.getPassword().isEmpty()){
			admin.setPassword(MD5Util.MD5(admin.getPassword()));
		}else {
			admin.setPassword(null);
		}

		int roleid=Integer.parseInt(((String[])getParameters().get("roleid"))[0]);
		
		//判断更新的管理员是否是最后的一个未锁定的超级管理员，如果是的话则不能删除
		RepRole role=roleService.get(roleid);
		RepRole originalRole=adminService.get(admin.getId()).getRepRole();
		//判断是否符合最后一个超级管理员的条件
		if(originalRole!=null&&originalRole.getName().equals("超级管理员")
				//如果是最后一个超级管理员，则判断是否进行了修改角色或锁定操作
				&&(!role.getName().equals("超级管理员")||admin.getIslock()==1)){

			int size=adminService.countUnLockSuperAdmins();
			if(size<=1){
				getContextMap().put("message", "不能对最后一个超级管理员进行锁定或者修改角色的操作!");
				getContextMap().put("returnUrl", getRequest().getContextPath()+"/admin/user/admin_list.do");
				return "faild";
			}
		}
		
		admin.setRepRole(role);
		
		adminService.updateNotNullField(admin);
		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "admin_list.do");
		
		return SUCCESS;
	}
	
	public String delete() {
		String idStr=getRequest().getParameter("id");
		String[] ids=(String[]) getParameters().get("ids");
		int id = -1;
		
		int size=adminService.countUnLockSuperAdmins();
		
		if(idStr!=null&&!idStr.isEmpty()){
			id=Integer.parseInt(idStr);
			//如果管理员只剩下一条记录则拒绝删除。
			if(size<=1&&adminService.get(id).getRepRole().getName().equals("超级管理员")){
				getContextMap().put("message", "不能删除所有超级管理员!");
				getContextMap().put("returnUrl", getRequest().getContextPath()+"/admin/user/admin_list.do");
				return "faild";
			}
			
			adminService.remove(id);
		}

		if(ids!=null&&ids.length>0){
			
			for (String idS : ids) {
				id=Integer.parseInt(idS);
				
				if(size<=ids.length&&adminService.get(id).getRepRole().getName().equals("超级管理员")){
					getContextMap().put("message", "不能删除所有超级管理员!");
					getContextMap().put("returnUrl", getRequest().getContextPath()+"/admin/user/admin_list.do");
					return "faild";
				}
				
				adminService.remove(id);
			}
		}

		getContextMap().put("message", "删除成功");
		getContextMap().put("returnUrl", "admin_list.do");
		
		return SUCCESS;
	}
	
	public String lock() {
		String[] ids=(String[]) getParameters().get("ids");
		
		//判断锁定的管理员是否是最后的一个未锁定的超级管理员，如果是的话则不能删除
		int size=adminService.countUnLockSuperAdmins();
		
		if(ids!=null&&ids.length>0){
			for (String idStr : ids) {
				int id=Integer.parseInt(idStr);
				
				if(size<=ids.length&&adminService.get(id).getRepRole().getName().equals("超级管理员")){
					getContextMap().put("message", "不能锁定所有超级管理员!");
					getContextMap().put("returnUrl", getRequest().getContextPath()+"/admin/user/admin_list.do");
					return "faild";
				}
				
				/*
				 * 这段代码同样的在别的地方以及单元测试都会报懒加载 session关闭错误。
				 * 这里却不会，真是奇怪
				 */
				RepAdmin admin=adminService.get(id);
				admin.setIslock(1);
				adminService.update(admin);
			}
		}
		

		getContextMap().put("message", "锁定成功");
		getContextMap().put("returnUrl", "admin_list.do");
		
		return SUCCESS;
	}
	
	public String unlock() {
		String[] ids=(String[]) getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idStr : ids) {
				int id=Integer.parseInt(idStr);
				RepAdmin admin=adminService.get(id);
				admin.setIslock(0);
				adminService.update(admin);
			}
		}
		

		getContextMap().put("message", "解锁成功");
		getContextMap().put("returnUrl", "admin_list.do");
		
		return SUCCESS;
	}
	
	public String login() {
		Map<String, Object> application=getActionContext().getApplication();
		String username=getRequest().getParameter("username");
		String password=getRequest().getParameter("password");
		String validateCodeInput=getRequest().getParameter("validatecode");
		String wrongTimes=(application.get(username)==null)?
								null:application.get(username).toString();
		
		String validateCodeInService= getSessionMap().get("validateCode")==null?
								null:getSessionMap().get("validateCode").toString();
		//如果需要验证码则需要判断验证码是否正确。
		if(wrongTimes!=null&&wrongTimes.length()>3){
			if(validateCodeInService==null||
					validateCodeInput==null||
					!validateCodeInService.toLowerCase()
						.equals( validateCodeInput.toLowerCase())){
				
				getContextMap().put("validateCodeWrong", "验证码错误!");
				getContextMap().put("showValidateCode", true);
				getContextMap().put("params", getParameters());
				return LOGIN;
			}
		}
		//防止用户名为空时的空指针错误.
		if(username!=null){
			RepAdmin admin=adminService.findAdminByName(username);
			if(admin!=null&&admin.getPassword().equals(MD5Util.MD5(password))){
				//登录成功
				
				/*
				 * 先通过hql语句（findAdminByName）查出admin对象
				 * 再用get(int id)方法，利用配置的查询策略把相关的role表和Permission表给抓取出来。
				 */
				admin=adminService.get(admin.getId());
				getSessionMap().put("admin", admin);
				
				//更新最后登陆时间与最后登陆ip
				getSessionMap().put(RepAdmin.LAST_LOGIN_IP, admin.getLastloginip());
				getSessionMap().put(RepAdmin.LAST_LOGIN_TIME, admin.getLastlogintime());
				admin.setLastloginip(getRequest().getRemoteAddr());
				admin.setLastlogintime(new Date());
				adminService.update(admin);
				application.remove(username);
				return SUCCESS;
			}
			//用户名不存在
			if(admin==null){
				getContextMap().put("usernameWrong", "用户名不存在!");
				getContextMap().put("params", getParameters());
				application.remove(username);
				return LOGIN;
			//密码错误
			}else if (!admin.getPassword().equals(MD5Util.MD5(password))) {
				getContextMap().put("passwordWrong", "密码错误!");
			}
		}else {
			getContextMap().put("usernameWrong", "用户名不能为空!");
		}
		
		
		//登录失败时在服务器计算登录失败的次数，如果大于三次便需要输入验证码
		if(wrongTimes==null){
			application.put(username, "0");
		}else if (wrongTimes.length()>=3) {
			getContextMap().put("showValidateCode", true);
			application.put(username, application.get(username)+"0");
		}else {
			application.put(username, application.get(username)+"0");
		}
		
		getContextMap().put("params", getParameters());
		return LOGIN;
	}
	
	public String resetPassword() {
		
		String email=getRequest().getParameter("email");
		if(!StringUtil.isNullOrEmpty(email)){
			List list=adminService.findByhql(
					"select u from RepAdmin u where u.email = ?", 1, email);
			if (list.size()==0) {

				getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
						"该邮箱未注册!!");
				return LOGIN;
			}else {
				
				RepAdmin u=(RepAdmin) list.get(0);
				String newPassword=UUIDUtils.uuid().substring(0, 6);
				u.setPassword(MD5Util.MD5(newPassword));
				adminService.update(u);
				
				StringBuilder emailBody=new StringBuilder("管理员您好! 您的登录名为:")
					.append(u.getUsername())
					.append("<br/>您的密码已经重置为:<font color='red'>")
					.append(newPassword)
					.append(
		"</font><br/>请及时修改密码，如有问题，请联系开发者:<a href=\"mailto:yangzhen3@foxmail.com\">yangzhen3@foxmail.com</a>");
				MailUtil.sendEmail(email, emailTitle, emailBody.toString());

				
				getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
						"密码重置成功!!");
				return LOGIN;
			}
		}

		getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
				"请输入邮箱!!");
		return LOGIN;
	}
	
	public String logout() {

		getSession().invalidate();
		return LOGIN;
	}
}
