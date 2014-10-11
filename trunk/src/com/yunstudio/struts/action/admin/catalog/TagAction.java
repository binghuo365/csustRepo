package com.yunstudio.struts.action.admin.catalog;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepTag;
import com.yunstudio.service.GsCatalogService;
import com.yunstudio.service.TagService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.StringUtil;

public class TagAction extends BaseAction{
	@Resource(name="tagService")
	private TagService tagService;
	

	@SuppressWarnings("unchecked")
	public String list() {
		int pageNum=1;
		int pageSize=20;
		String name=getRequest().getParameter("name");
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
		
		Page page=tagService.pageCQuery(pageNum, pageSize, criterions,orders,"id");
		
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		return "list";
	}
	
	
	public String addui() {
		return "add";
	}
	
	public String add() {
		String name=getRequest().getParameter("name").trim();
		
		RepTag tag=new RepTag();
		tag.setName(name);
		

		//查找是否存在同名学科分类名称
		if(!StringUtil.isNullOrEmpty(name)){
			List<RepTag> list=tagService.findTagByName(name);
			if(list.size()>0){
				getContextMap().put("message", "对不起，已经存在同名的学科分类名称");
				getRoot().push(tag);
				return "add";
			}
		}else {
			getContextMap().put("message", "对不起，学科分类名称不能为空");
			getRoot().push(tag);
			return "add";
		}
		
		tagService.add(tag);

		getContextMap().put("message", "新增成功");
		getContextMap().put("returnUrl", "tag_list.do");
		
		return SUCCESS;
	}
	
	public String edit() {
		String idStr=getRequest().getParameter("id");
		RepTag tag=null;
		if(!StringUtil.isNullOrEmpty(idStr)){
			tag=tagService.get(Integer.parseInt(idStr));
		}
		
		getRoot().push(tag);
		return "edit"; 
	}
	
	public String update() {
		String idStr=getRequest().getParameter("id");
		String name=getRequest().getParameter("name").trim();
		
		RepTag tag=new RepTag();
		tag.setId(Integer.parseInt(idStr));
		tag.setName(name);
		
		if(StringUtil.isNullOrEmpty(name)){
			getContextMap().put("message", "对不起标签名称不能为空");
			return "edit";
		}
		
		List<RepTag> list=tagService.findTagByName(name);
		if(list.size()>0&&!list.get(0).getId().equals(tag.getId())){
			getContextMap().put("message", "对不起,已经存在同名的学科分类");
			getRoot().push(tag);
			return "edit";
		}
		tagService.update(tag);

		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "tag_list.do");
		
		return SUCCESS;
	}
	
	public String delete() {
		String idStr=getRequest().getParameter("id");
		if(!StringUtil.isNullOrEmpty(idStr)){
			tagService.remove(Integer.parseInt(idStr));
		}
		
		String[] idsStr=(String[]) getParameters().get("ids");
		if(idsStr!=null&&idsStr.length>0){
			for (String id : idsStr) {
				tagService.remove(Integer.parseInt(id));
			}
		}
		


		getContextMap().put("message", "删除成功");
		getContextMap().put("returnUrl", "tag_list.do");
		
		return SUCCESS;
	}
}
