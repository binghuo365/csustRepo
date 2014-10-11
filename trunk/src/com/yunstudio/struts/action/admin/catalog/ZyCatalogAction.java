package com.yunstudio.struts.action.admin.catalog;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepZycatalog;
import com.yunstudio.service.ZyCatalogService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.StringUtil;

public class ZyCatalogAction extends BaseAction{
	@Resource(name="zyCatalogService")
	private ZyCatalogService zyCatalogService;
	

	@SuppressWarnings("unchecked")
	public String list() {
		int pageNum=1;
		int pageSize=20;
		String name=getRequest().getParameter("name");
		String fatheridStr=getRequest().getParameter("fatherid");
		String queryOrderBy=getRequest().getParameter("queryOrderBy");
		String pageSizeStr=getRequest().getParameter("pageSize");
		String pageNumStr=getRequest().getParameter("pageNo");
		
		Set<Criterion> criterions=new HashSet<Criterion>(2);
		Set<Order> orders=new HashSet<Order>(1);
		Order orderByIdDesc=Order.desc("id");
		orders.add(orderByIdDesc);
		
		if(!StringUtil.isNullOrEmpty(name)){
			criterions.add(Restrictions.like("name", "%"+name.trim()+"%"));
		}
		if(!StringUtil.isNullOrEmpty(fatheridStr)){
			criterions.add(Restrictions.eq("father.id", Integer.parseInt(fatheridStr)));
		}
		if(!StringUtil.isNullOrEmpty(queryOrderBy)&&queryOrderBy.equals("asc")){
			orders.remove(orderByIdDesc);
			orders.add(Order.asc("id"));
		}
		if(!StringUtil.isNullOrEmpty(pageSizeStr)){
			pageSize=Integer.parseInt(pageSizeStr);
		}
		if (!StringUtil.isNullOrEmpty(pageNumStr)) {
			pageNum=Integer.parseInt(pageNumStr);
		}
		
		List<RepZycatalog> list=zyCatalogService.loadAll();
		Page page=zyCatalogService.pageCQuery(pageNum, pageSize, criterions,orders,"id");
		
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		getContextMap().put("zycatalogs", list);
		return "list";
	}
	
	
	public String addui() {
		
		List<RepZycatalog> list=zyCatalogService.loadAll();
		getContextMap().put("zycatalogs", list);
		
		return "add";
	}
	
	public String add() {
		String name=getRequest().getParameter("name");
		String fatheridStr=getRequest().getParameter("fatherid");
		String description=getRequest().getParameter("description");
		
		RepZycatalog zycatalog=new RepZycatalog();
		zycatalog.setName(name);
		zycatalog.setDescription(description);
		
		if(!StringUtil.isNullOrEmpty(fatheridStr)){
			RepZycatalog father=new RepZycatalog();
			father.setId(Integer.parseInt(fatheridStr));
			zycatalog.setFather(father);
		}
		

		//查找是否存在同名学科分类名称
		if(!StringUtil.isNullOrEmpty(name)){
			List<RepZycatalog> list=zyCatalogService.findZycatalogByName(name);
			if(list.size()>0){
				List<RepZycatalog> listAll=zyCatalogService.loadAll();
				getContextMap().put("zycatalogs", listAll);
				getContextMap().put("message", "对不起，已经存在同名的学科分类名称");
				getRoot().push(zycatalog);
				return "add";
			}
		}else {
			List<RepZycatalog> listAll=zyCatalogService.loadAll();
			getContextMap().put("zycatalogs", listAll);
			getContextMap().put("message", "对不起，学科分类名称不能为空");
			getRoot().push(zycatalog);
			return "add";
		}
		
		zyCatalogService.add(zycatalog);

		getContextMap().put("message", "新增成功");
		getContextMap().put("returnUrl", "zycatalog_list.do");
		
		return SUCCESS;
	}
	
	public String edit() {
		String idStr=getRequest().getParameter("id");
		RepZycatalog zycatalog=null;
		if(!StringUtil.isNullOrEmpty(idStr)){
			zycatalog=zyCatalogService.get(Integer.parseInt(idStr));
		}
		
		List<RepZycatalog> list=zyCatalogService.loadAll();
		getContextMap().put("zycatalogs", list);
		getRoot().push(zycatalog);
		return "edit"; 
	}
	
	public String update() {
		String idStr=getRequest().getParameter("id");
		String name=getRequest().getParameter("name");
		String description=getRequest().getParameter("description");
		String fatheridStr=getRequest().getParameter("fatherid");
		
		RepZycatalog zycatalog=new RepZycatalog();
		zycatalog.setId(Integer.parseInt(idStr));
		zycatalog.setName(name);
		zycatalog.setDescription(description);
		
		if(StringUtil.isNullOrEmpty(name)){
			List<RepZycatalog> listAll=zyCatalogService.loadAll();
			getContextMap().put("zycatalogs", listAll);
			getContextMap().put("message", "对不起学科分类名称不能为空");
			return "edit";
		}
		if(!StringUtil.isNullOrEmpty(fatheridStr)){
			RepZycatalog father=new RepZycatalog();
			father.setId(Integer.parseInt(fatheridStr));
			zycatalog.setFather(father);
		}else {
			zycatalog.setFather(null);
		}
		
		List<RepZycatalog> list=zyCatalogService.findZycatalogByName(name);
		if(list.size()>0&&!list.get(0).getId().equals(zycatalog.getId())){
			List<RepZycatalog> listAll=zyCatalogService.loadAll();
			getContextMap().put("zycatalogs", listAll);
			getContextMap().put("message", "对不起,已经存在同名的学科分类");
			getRoot().push(zycatalog);
			return "edit";
		}
		if(zycatalog.getId()>8)
			zyCatalogService.update(zycatalog);

		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "zycatalog_list.do");
		
		return SUCCESS;
	}
	
	public String delete() {
		String idStr=getRequest().getParameter("id");
		if(!StringUtil.isNullOrEmpty(idStr)){
			Integer id=Integer.parseInt(idStr);
			if (id>8) {
				zyCatalogService.remove(Integer.parseInt(idStr));
			}
		}
		
		String[] idsStr=(String[]) getParameters().get("ids");
		if(idsStr!=null&&idsStr.length>0){
			for (String id : idsStr) {
				Integer idi=Integer.parseInt(id);
				if (idi>8) {
					zyCatalogService.remove(Integer.parseInt(id));
				}
			}
		}
		


		getContextMap().put("message", "删除成功");
		getContextMap().put("returnUrl", "zycatalog_list.do");
		
		return SUCCESS;
	}
}
