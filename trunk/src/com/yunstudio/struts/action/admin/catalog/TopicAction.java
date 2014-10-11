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
import com.yunstudio.entity.RepTopic;
import com.yunstudio.entity.RepZycatalog;
import com.yunstudio.service.GsCatalogService;
import com.yunstudio.service.TopicService;
import com.yunstudio.service.ZyCatalogService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.StringUtil;

public class TopicAction extends BaseAction{
	
	@Resource(name="topicService")
	private TopicService topicService;
	
	@Resource(name="gsCatalogService")
	private GsCatalogService gsCatalogService;
	
	@Resource(name="zyCatalogService")
	private ZyCatalogService zyCatalogService;

	@SuppressWarnings("unchecked")
	public String list() {
		int pageNum=1;
		int pageSize=20;
		String title=getRequest().getParameter("title");
		String gscatalogidStr=getRequest().getParameter("gscatalogid");
		String zycatalogidStr=getRequest().getParameter("zycatalogid");
		String queryOrderBy=getRequest().getParameter("queryOrderBy");
		String pageSizeStr=getRequest().getParameter("pageSize");
		String pageNumStr=getRequest().getParameter("pageNo");
		
		Set<Criterion> criterions=new HashSet<Criterion>(2);
		Set<Order> orders=new HashSet<Order>(1);
		Order orderByIdDesc=Order.desc("id");
		orders.add(orderByIdDesc);
		
		if(!StringUtil.isNullOrEmpty(title)){
			criterions.add(Restrictions.like("title", "%"+title.trim()+"%"));
		}
		if(!StringUtil.isNullOrEmpty(gscatalogidStr)){
			criterions.add(Restrictions.eq("repGscatalog.id", Integer.parseInt(gscatalogidStr)));
		}
		if(!StringUtil.isNullOrEmpty(zycatalogidStr)){
			criterions.add(Restrictions.eq("repZycatalog.id", Integer.parseInt(zycatalogidStr)));
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
		
		List<RepGscatalog> gscatalogs=gsCatalogService.loadAll();
		List<RepZycatalog> zycatalogs=zyCatalogService.loadAll();
		Page page=topicService.pageCQuery(pageNum, pageSize, criterions,orders,"id");
		
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		getContextMap().put("gscatalogs", gscatalogs);
		getContextMap().put("zycatalogs", zycatalogs);
		return "list";
	}
	
	
	public String addui() {

		List<RepGscatalog> gscatalogs=gsCatalogService.loadAll();
		List<RepZycatalog> zycatalogs=zyCatalogService.loadAll();
		getContextMap().put("gscatalogs", gscatalogs);
		getContextMap().put("zycatalogs", zycatalogs);
		
		return "add";
	}
	
	public String add() {
		String title=getRequest().getParameter("title").trim();
		String gscatalogidStr=getRequest().getParameter("gscatalogid");
		String zycatalogidStr=getRequest().getParameter("zycatalogid");
		String description=getRequest().getParameter("description");
		
		RepTopic topic=new RepTopic();
		topic.setTitle(title);
		topic.setDescription(description);
		
		if(!StringUtil.isNullOrEmpty(gscatalogidStr)){
			RepGscatalog gscatalog=new RepGscatalog();
			gscatalog.setId(Integer.parseInt(gscatalogidStr));
			topic.setRepGscatalog(gscatalog);
		}
		
		if(!StringUtil.isNullOrEmpty(zycatalogidStr)){
			RepZycatalog zycatalog=new RepZycatalog();
			zycatalog.setId(Integer.parseInt(zycatalogidStr));
			topic.setRepZycatalog(zycatalog);
		}
		

		//查找是否存在同名学科分类名称
		if(!StringUtil.isNullOrEmpty(title)){
			List<RepTopic> list=topicService.findTopicByTitle(title);
			if(list.size()>0){
				List<RepGscatalog> gscatalogs=gsCatalogService.loadAll();
				List<RepZycatalog> zycatalogs=zyCatalogService.loadAll();
				getContextMap().put("gscatalogs", gscatalogs);
				getContextMap().put("zycatalogs", zycatalogs);
				
				getContextMap().put("message", "对不起，已经存在同名的专题名称");
				getRoot().push(topic);
				return "add";
			}
		}else {
			List<RepGscatalog> gscatalogs=gsCatalogService.loadAll();
			List<RepZycatalog> zycatalogs=zyCatalogService.loadAll();
			getContextMap().put("gscatalogs", gscatalogs);
			getContextMap().put("zycatalogs", zycatalogs);
			
			getContextMap().put("message", "对不起，专题名称不能为空");
			getRoot().push(topic);
			return "add";
		}
		
		topicService.add(topic);


		getContextMap().put("message", "新增成功");
		getContextMap().put("returnUrl", "topic_list.do");
		
		return SUCCESS;
	}
	
	public String edit() {
		String idStr=getRequest().getParameter("id");
		RepTopic topic=null;
		if(!StringUtil.isNullOrEmpty(idStr)){
			topic=topicService.get(Integer.parseInt(idStr));
		}

		List<RepGscatalog> gscatalogs=gsCatalogService.loadAll();
		List<RepZycatalog> zycatalogs=zyCatalogService.loadAll();
		getContextMap().put("gscatalogs", gscatalogs);
		getContextMap().put("zycatalogs", zycatalogs);
		
		getRoot().push(topic);
		return "edit"; 
	}
	
	public String update() {
		String idStr=getRequest().getParameter("id");
		String title=getRequest().getParameter("title").trim();
		String gscatalogidStr=getRequest().getParameter("gscatalogid");
		String zycatalogidStr=getRequest().getParameter("zycatalogid");
		String description=getRequest().getParameter("description");
		
		RepTopic topic=new RepTopic();
		topic.setId(Integer.parseInt(idStr));
		topic.setTitle(title);
		topic.setDescription(description);
		
		if(StringUtil.isNullOrEmpty(title)){
			List<RepGscatalog> gscatalogs=gsCatalogService.loadAll();
			List<RepZycatalog> zycatalogs=zyCatalogService.loadAll();
			getContextMap().put("gscatalogs", gscatalogs);
			getContextMap().put("zycatalogs", zycatalogs);
			
			getContextMap().put("message", "对不起学科分类名称不能为空");
			return "edit";
		}

		if(!StringUtil.isNullOrEmpty(gscatalogidStr)){
			RepGscatalog gscatalog=new RepGscatalog();
			gscatalog.setId(Integer.parseInt(gscatalogidStr));
			topic.setRepGscatalog(gscatalog);
		}else {
			topic.setRepGscatalog(null);
		}
		
		if(!StringUtil.isNullOrEmpty(zycatalogidStr)){
			RepZycatalog zycatalog=new RepZycatalog();
			zycatalog.setId(Integer.parseInt(zycatalogidStr));
			topic.setRepZycatalog(zycatalog);
		}
		
		List<RepTopic> list=topicService.findTopicByTitle(title);
		if(list.size()>0&&!list.get(0).getId().equals(topic.getId())){
			List<RepGscatalog> gscatalogs=gsCatalogService.loadAll();
			List<RepZycatalog> zycatalogs=zyCatalogService.loadAll();
			getContextMap().put("gscatalogs", gscatalogs);
			getContextMap().put("zycatalogs", zycatalogs);
			
			getContextMap().put("message", "对不起,已经存在同名的学科分类");
			getRoot().push(topic);
			return "edit";
		}
		topicService.update(topic);
		
		
		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "topic_list.do");
		
		return SUCCESS;
	}
	
	public String delete() {
		String idStr=getRequest().getParameter("id");
		if(!StringUtil.isNullOrEmpty(idStr)){
			topicService.remove(Integer.parseInt(idStr));
		}
		
		String[] idsStr=(String[]) getParameters().get("ids");
		if(idsStr!=null&&idsStr.length>0){
			for (String id : idsStr) {
				topicService.remove(Integer.parseInt(id));
			}
		}
		

		getContextMap().put("message", "删除成功");
		getContextMap().put("returnUrl", "topic_list.do");
		
		return SUCCESS;
	}
}
