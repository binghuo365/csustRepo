package com.yunstudio.struts.action.admin.systemsetup;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.locale.converters.DateLocaleConverter;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepPermission;
import com.yunstudio.entity.RepRole;
import com.yunstudio.entity.RepUser;
import com.yunstudio.service.PermissionService;
import com.yunstudio.service.RoleService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.struts.filter.AdminPrivilegeFilter;
import com.yunstudio.struts.form.UserForm;
import com.yunstudio.struts.interceptor.LogInterceptor;
import com.yunstudio.utils.MD5Util;
import com.yunstudio.utils.WebUtil;

public class RoleAction extends BaseAction{

	@Resource(name="roleService")
	private RoleService roleService;
	
	@Resource(name="permissionService")
	private PermissionService permissionService;
	
	@SuppressWarnings("unchecked")
	public String list() {
		int pageNum=1;
		int pageSize=20;
		
		String id=getRequest().getParameter("id");
		String sort=getRequest().getParameter("sort");
		if(id!=null&&!id.isEmpty()&&sort!=null&&!sort.isEmpty()){
			RepRole role=new RepRole();
			role.setId(Integer.parseInt(id));
			role.setSort(Integer.parseInt(sort));
			roleService.updateNotNullField(role);
		}
		
		Page page=roleService.pageCQuery(pageNum, pageSize, null,null,"id");
		
		Collections.sort(page.getRows(), new Comparator<RepRole>() {

			public int compare(RepRole o1, RepRole o2) {
				// TODO Auto-generated method stub
				return o2.getSort()-o1.getSort();
			}
		});
		
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		
		return "list";
	}
	
	public String addui() {
		List<RepPermission> permissions=LogInterceptor.list;
		getContextMap().put("permissionlist", permissions);
		return "add";
	}
	
	public String add() {
		//查询可选的权限
		List<RepPermission> permissions=LogInterceptor.list;
		getContextMap().put("permissionlist", permissions);
		
		//根据参数对角色bean赋值
		RepRole role=new RepRole();
		try {
			BeanUtils.populate(role, getParameters());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		role.setName(role.getName().trim());
		String[] permissionIdStrs=(String[])getParameters().get("permissionids");
		//判断是否存在同名角色
		RepRole r=roleService.findRoleByName(getRequest().getParameter("name").trim());
		if(r!=null){
			//将取出的权限id数组转换成list
			List<String> permissionids=Arrays.asList(permissionIdStrs);
			getContextMap().put("message", "已经存在同名用户，请换个用户名!");
			getContextMap().put("selectpermissionlist", permissionids);
			getRoot().push(role);
			return "add";
		}
		//对角色bean的权限set赋值
		if(permissionIdStrs!=null&&permissionIdStrs.length>0){
			for (String id : permissionIdStrs) {
				RepPermission p=new RepPermission();
				p.setId(Integer.parseInt(id));
				role.getRepPermissions().add(p);
			}
		}else {
			getContextMap().put("permissionsmessage", "请至少选择一个权限!");
			getRoot().push(role);
			return "add";
		}
		
		roleService.add(role);
		getContextMap().put("message", "新增成功");
		getContextMap().put("returnUrl", "role_list.do");
		
		return SUCCESS;
	}
	
	public String delete() {
		
		String idStr=getRequest().getParameter("id");
		int id = -1;
		if(idStr!=null&&!idStr.isEmpty()){
			id=Integer.parseInt(idStr);
			
			//查询删除的是否
			RepRole role=roleService.get(id);
			if(role.getName().equals("超级管理员")){
				getContextMap().put("message", "不能删除预定义的超级管理员角色!");
				getContextMap().put("returnUrl", getRequest().getContextPath()+"/admin/systemsetup/role_list.do");
				return "faild";
			}else {
				roleService.remove(role);
			}
		}

		String[] ids=(String[])getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idS : ids) {
				id=Integer.parseInt(idS);

				RepRole role=roleService.get(id);
				if(role.getName().equals("超级管理员")){
					getContextMap().put("message", "不能删除预定义的超级管理员角色!");
					getContextMap().put("returnUrl", getRequest().getContextPath()+"/admin/systemsetup/role_list.do");
					return "faild";
				}else {
					roleService.remove(role);
				}
			}
		}
		getContextMap().put("message", "删除成功");
		getContextMap().put("returnUrl", "role_list.do");
		
		return SUCCESS;
	}
	
	public String edit() {
		List<RepPermission> permissions=LogInterceptor.list;
		getContextMap().put("permissionlist", permissions);
		
		String idStr=getRequest().getParameter("id");
		int id=0;
		if(idStr!=null&&!idStr.isEmpty()){
			id=Integer.parseInt(idStr);
		}
		RepRole role=roleService.get(id);
		

		List<String> permissionids=new ArrayList<String>();
		for (RepPermission permission : role.getRepPermissions()) {
			permissionids.add(permission.getId().toString());
		}
		
		getContextMap().put("selectpermissionlist", permissionids);
		
		getRoot().push(role);
		return "edit";
	}
	
	/**
	 * @return
	 */
	public String update() {
		List<RepPermission> permissions=LogInterceptor.list;
		getContextMap().put("permissionlist", permissions);

		RepRole role=new RepRole();
		
		try {
			BeanUtils.populate(role, getParameters());
		} catch (Exception e) {
			e.printStackTrace();
		}
		role.setName(role.getName().trim());
		/*
		 * 判断要更新的角色是否是预定义的角色，如果是的话便不能更新
		 * **暂时注释，方便调试。
		 */
		RepRole rr=roleService.get(role.getId());
		if(rr.getName().equals("超级管理员")){
			getContextMap().put("message", "不能修改预定义的超级管理员角色!");
			getContextMap().put("returnUrl", getRequest().getContextPath()+"/admin/systemsetup/role_list.do");
			return "faild";
		}
		
		String[] permissionIdStrs=(String[])getParameters().get("permissionids");

		//判断是否存在同名角色
		RepRole r=roleService.findRoleByName(getRequest().getParameter("name").trim());
		if(r!=null&&!r.getId().equals(role.getId())){
			//将取出的权限id数组转换成list
			List<String> permissionids=Arrays.asList(permissionIdStrs);
			getContextMap().put("message", "已经存在同名角色，请换个角色名称!");
			getContextMap().put("selectpermissionlist", permissionids);
			getRoot().push(role);
			return "edit";
		}
		
		//对角色bean的权限set赋值
		if(permissionIdStrs!=null&&permissionIdStrs.length>0){
			for (String id : permissionIdStrs) {
				RepPermission p=new RepPermission();
				p.setId(Integer.parseInt(id));
				role.getRepPermissions().add(p);
			}
		}else {
			//查询可选的权限
			getContextMap().put("permissionsmessage", "请至少选择一个权限!");
			getRoot().push(role);
			return "edit";
		}
		
		
		roleService.updateNotNullField(role);

		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "role_list.do");
		
		return SUCCESS;
	}
	
}
