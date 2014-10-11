package com.yunstudio.struts.action.admin.catalog;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepGscatalog;
import com.yunstudio.service.GsCatalogService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.StringUtil;

public class GsCatalogAction extends BaseAction{
	@Resource(name="gsCatalogService")
	private GsCatalogService gsCatalogService;
	

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
		
		List<RepGscatalog> list=gsCatalogService.loadAll();
		Page page=gsCatalogService.pageCQuery(pageNum, pageSize, criterions,orders,"id");
		
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		getContextMap().put("gscatalogs", list);
		return "list";
	}
	
	
	public String addui() {
		
		List<RepGscatalog> list=gsCatalogService.loadAll();
		getContextMap().put("gscatalogs", list);
		
		return "add";
	}
	
	public String add() {
		String name=getRequest().getParameter("name").trim();
		String fatheridStr=getRequest().getParameter("fatherid");
		String description=getRequest().getParameter("description");
		
		RepGscatalog gscatalog=new RepGscatalog();
		gscatalog.setName(name);
		gscatalog.setDescription(description);
		
		if(!StringUtil.isNullOrEmpty(fatheridStr)){
			RepGscatalog father=new RepGscatalog();
			father.setId(Integer.parseInt(fatheridStr));
			gscatalog.setFather(father);
		}
		

		//查找是否存在同名学科分类名称
		if(!StringUtil.isNullOrEmpty(name)){
			List<RepGscatalog> list=gsCatalogService.findGscatalogByName(name);
			if(list.size()>0){
				List<RepGscatalog> listAll=gsCatalogService.loadAll();
				getContextMap().put("gscatalogs", listAll);
				getContextMap().put("message", "对不起，已经存在同名的学科分类名称");
				getRoot().push(gscatalog);
				return "add";
			}
		}else {
			List<RepGscatalog> listAll=gsCatalogService.loadAll();
			getContextMap().put("gscatalogs", listAll);
			getContextMap().put("message", "对不起，学科分类名称不能为空");
			getRoot().push(gscatalog);
			return "add";
		}
		
		gsCatalogService.add(gscatalog);

		getContextMap().put("message", "新增成功");
		getContextMap().put("returnUrl", "gscatalog_list.do");
		
		return SUCCESS;
	}
	
	public String edit() {
		String idStr=getRequest().getParameter("id");
		RepGscatalog gscatalog=null;
		if(!StringUtil.isNullOrEmpty(idStr)){
			gscatalog=gsCatalogService.get(Integer.parseInt(idStr));
		}
		
		List<RepGscatalog> list=gsCatalogService.loadAll();
		getContextMap().put("gscatalogs", list);
		getRoot().push(gscatalog);
		return "edit"; 
	}
	
	public String update() {
		String idStr=getRequest().getParameter("id");
		String name=getRequest().getParameter("name").trim();
		String description=getRequest().getParameter("description");
		String fatheridStr=getRequest().getParameter("fatherid");
		
		RepGscatalog gscatalog=new RepGscatalog();
		gscatalog.setId(Integer.parseInt(idStr));
		gscatalog.setName(name);
		gscatalog.setDescription(description);
		
		if(StringUtil.isNullOrEmpty(name)){
			List<RepGscatalog> listAll=gsCatalogService.loadAll();
			getContextMap().put("gscatalogs", listAll);
			getContextMap().put("message", "对不起学科分类名称不能为空");
			return "edit";
		}
		if(!StringUtil.isNullOrEmpty(fatheridStr)){
			RepGscatalog father=new RepGscatalog();
			father.setId(Integer.parseInt(fatheridStr));
			gscatalog.setFather(father);
		}else {
			gscatalog.setFather(null);
		}
		
		List<RepGscatalog> list=gsCatalogService.findGscatalogByName(name);
		if(list.size()>0&&!list.get(0).getId().equals(gscatalog.getId())){
			List<RepGscatalog> listAll=gsCatalogService.loadAll();
			getContextMap().put("gscatalogs", listAll);
			getContextMap().put("message", "对不起,已经存在同名的学科分类");
			getRoot().push(gscatalog);
			return "edit";
		}
		if(gscatalog.getId()>5)
			gsCatalogService.updateNotNullField(gscatalog);

		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "gscatalog_list.do");
		
		return SUCCESS;
	}
	
	public String delete() {
		String idStr=getRequest().getParameter("id");
		if(!StringUtil.isNullOrEmpty(idStr)){
			Integer id=Integer.parseInt(idStr);
			if (id>5) {
				gsCatalogService.remove(id);
			}
		}
		
		String[] idsStr=(String[]) getParameters().get("ids");
		if(idsStr!=null&&idsStr.length>0){
			for (String id : idsStr) {
				Integer idi=Integer.parseInt(id);
				if (idi>5) {
					gsCatalogService.remove(idi);
				}
			}
		}
		

		getContextMap().put("message", "删除成功");
		getContextMap().put("returnUrl", "gscatalog_list.do");
		
		return SUCCESS;
	}
}
