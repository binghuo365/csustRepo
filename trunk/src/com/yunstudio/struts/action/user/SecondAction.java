package com.yunstudio.struts.action.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.simple.JSONArray;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepGscatalog;
import com.yunstudio.entity.RepZycatalog;
import com.yunstudio.entity.WebConstant;
import com.yunstudio.service.GsCatalogService;
import com.yunstudio.service.NoticeService;
import com.yunstudio.service.ResourceService;
import com.yunstudio.service.TagService;
import com.yunstudio.service.ZyCatalogService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.HqlUtils;
import com.yunstudio.utils.StringUtil;

public class SecondAction extends BaseAction{
	
	private static String LIST_TEXT="listtext";
	
	private static String LIST_IMG="listimg";
	
	private ResourceService resourceService;
	
	private NoticeService noticeService;
	
	private ZyCatalogService zyCatalogService;
	
	private GsCatalogService gsCatalogService;
	
	private TagService tagService;
	
	private List<Map<String, Map<String, Object>>> zycatalogJsonList;
	
	private List<Map<String, Map<String, Object>>> gscatalogJsonList;
	
	private List<RepZycatalog> zycatalogs;
	
	private List<RepGscatalog> gscatalogs;
	
	public String second(){
		String catalogidStr=getRequest().getParameter(WebConstant.RequestParamKey.CATALOGID);
		String pageNumStr=getRequest().getParameter(WebConstant.RequestParamKey.PAGE_NUM);
		String pageSizeStr=getRequest().getParameter(WebConstant.RequestParamKey.PAGE_SIZE);
		
		Integer pageNum=1;
		Integer pageSize=6;
		
		if(!StringUtil.isNullOrEmpty(pageNumStr)){
			pageNum=Integer.parseInt(pageNumStr);
		}

		if(!StringUtil.isNullOrEmpty(pageSizeStr)){
			pageSize=Integer.parseInt(pageSizeStr);
		}
		
		if(!StringUtil.isNullOrEmpty(catalogidStr)&&pageNum>0){
			Integer catalogid=Integer.parseInt(catalogidStr);
			getRequest().setAttribute(WebConstant.RequestAttrKey.CATALOGID, catalogid);
			//最新资源
			getRequest().setAttribute(WebConstant.RequestAttrKey.NEWEST_RESOURCE,
					resourceService.findByhql(WebConstant.Hql.queryResourceOrderByNew,
							10, (Object[])null));
			//最热公告
			getRequest().setAttribute(WebConstant.RequestAttrKey.HOTEST_NOTICE,
					noticeService.findByhql(
							WebConstant.Hql.queryNoticeByViewtimes, 5, (Object[])null));
			
			if(catalogid==1||catalogid==3){
				
				pageSize=6;
				
				Page page=noticeService.pageQuery(
						WebConstant.Hql.queryResourceByGsOrderByNew, pageNum, pageSize, catalogid);
				getRequest().setAttribute(WebConstant.RequestAttrKey.PAGE, page);
				return LIST_TEXT;
			}else if(catalogid==2||catalogid==4){
				
				pageSize=4;
				Page page=noticeService.pageQuery(
						WebConstant.Hql.queryResourceByGsOrderByNew, pageNum, pageSize, catalogid);
				getRequest().setAttribute(WebConstant.RequestAttrKey.PAGE, page);
				return LIST_IMG;
			}
		}
		
		return SUCCESS;
	}
	
	public String notice(){
		String pageNumStr=getRequest().getParameter(WebConstant.RequestParamKey.PAGE_NUM);
		String pageSizeStr=getRequest().getParameter(WebConstant.RequestParamKey.PAGE_SIZE);
		
		Integer pageNum=1;
		Integer pageSize=15;
		
		if(!StringUtil.isNullOrEmpty(pageNumStr)){
			pageNum=Integer.parseInt(pageNumStr);
		}

		if(!StringUtil.isNullOrEmpty(pageSizeStr)){
			pageSize=Integer.parseInt(pageSizeStr);
		}
		
		if(pageNum>0){
			
			Page page=noticeService.pageQuery(
					WebConstant.Hql.queryNoticeOrderByNew, pageNum, pageSize, (Object[])null);
			getRequest().setAttribute(WebConstant.RequestAttrKey.PAGE, page);
		}

		//最新资源
		getRequest().setAttribute(WebConstant.RequestAttrKey.NEWEST_RESOURCE,
				resourceService.findByhql(WebConstant.Hql.queryResourceOrderByNew,
						10, (Object[])null));
		//最热公告
		getRequest().setAttribute(WebConstant.RequestAttrKey.HOTEST_NOTICE,
				noticeService.findByhql(
						WebConstant.Hql.queryNoticeByViewtimes, 5, (Object[])null));
		return SUCCESS;
	}

	public String search(){
		
		int pageNum = 1;
		int pageSize = 10;
		List<Integer> checkedGscatalogIds=new ArrayList<Integer>();
		List<Integer> checkedZycatalogIds=new ArrayList<Integer>();
		Map<String, Object> condistionsMap=new HashMap<String, Object>();
		String orderBy="order by r.id desc";
		

		HqlUtils hqlUtils=new HqlUtils();
		String hql=null;
		for (Map.Entry<String, Object> param : getParameters().entrySet()) {

			String name = param.getKey();
			String[] values = (String[]) param.getValue();
			if (!StringUtil.isNullOrEmpty(values[0])) {
				String value=values[0].trim();
				if (name.equals("zycatalogid")) {
					StringBuilder hqlString=new StringBuilder(
							"r.repZycatalog.id in (?");
					for (String v : values) {
						hqlString.append(","+v);
						checkedZycatalogIds.add(Integer.parseInt(v));
					}
					hqlString.append(")");
					condistionsMap.put(hqlString.toString(), Integer.parseInt(value));
					
					
				}else if (name.equals("gscatalogid")) {
					StringBuilder hqlString=new StringBuilder(
							"r.repGscatalog.id in (?");
					for (String v : values) {
						hqlString.append(","+v);
						checkedGscatalogIds.add(Integer.parseInt(v));
					}
					hqlString.append(")");
					condistionsMap.put(hqlString.toString(), Integer.parseInt(value));
					//condistionsMap.put("r.repGscatalog.id = ?", Integer.parseInt(value));
					
				}else if(name.equals("adduser")) {
						if(!value.equals("管理员")){
							condistionsMap.put("u.username like ?", "%"+value+"%");
						}else {
							condistionsMap.put("r.repAdmin.id > ?", 0);
						}
						
						
				}else if(name.equals("title")){
						condistionsMap.put("r.title like ?", "%"+value+"%");
						
				} else if (name.equals("tagname")) {
					condistionsMap.put("(select t from r.repTags t where t.name like ?) is not null", "%"+value+"%");
					
				}else if(name.equals("topicid")){
					condistionsMap.put("r.repTopic.id = ?", Integer.parseInt(value));
					
				}else if (name.equals("topicname")) {
					condistionsMap.put("r.repTopic.title like ?", "%"+value+"%");

				}else if (name.equals(WebConstant.RequestParamKey.PAGE_NUM)) {
					pageNum = Integer.parseInt(value);
					
				} else if (name.equals(WebConstant.RequestParamKey.QUERY_ORDER_BY)) {
					orderBy="order by r."+value;
					
				} else if (name.equals(WebConstant.RequestParamKey.PAGE_SIZE)) {
					pageSize = Integer.parseInt(value);
					if (pageSize <= 0) {
						pageSize = 10;
					}
					
				}
			}
			
		}
		condistionsMap.put("r.ispassed=?", 1);
		hql=hqlUtils.condition2hql(WebConstant.Hql
				.queryResource, condistionsMap, orderBy);
		Page page=resourceService.pageQuery(hql, pageNum,
				pageSize, hqlUtils.getObjects());
		
		//初始化树状类别
		initTreeCatalog();
		
		//查询出来的分页数据
		getRequest().setAttribute(WebConstant.RequestAttrKey.PAGE, page);
		//最新资源
		getRequest().setAttribute(WebConstant.RequestAttrKey.NEWEST_RESOURCE,
				resourceService.findByhql(WebConstant.Hql.queryResourceOrderByNew,
						10, (Object[])null));
		//已经选择的类别，用于数据回显
		getRequest().setAttribute(WebConstant.RequestAttrKey
				.CHECKED_GSCATALOG_IDS, JSONArray.toJSONString(
						checkedGscatalogIds));
		getRequest().setAttribute(WebConstant.RequestAttrKey
				.CHECKED_ZYCATALOG_IDS, JSONArray.toJSONString(
						checkedZycatalogIds));
		//已经输入的参数，用于数据回显
		getRequest().setAttribute(WebConstant.RequestAttrKey
				.PARAMS, getParameters());
		
		
		//加载十条最热的标签
		List<String> tags=tagService.findHotesTags(10);
		getRequest().setAttribute("hotestTags", tags);
		return SUCCESS;
	}
	
	private void initTreeCatalog(){

		//获取所有的专业类别
		zycatalogs=zyCatalogService.loadAll();
		gscatalogs=gsCatalogService.loadAll();
		//初始化用来构造json数据的list
		zycatalogJsonList=new ArrayList<Map<String,Map<String,Object>>>(10);
		gscatalogJsonList=new ArrayList<Map<String,Map<String,Object>>>(10);
		//通过递归构造jsonArray形式的类别
		for (RepZycatalog z : zycatalogs) {
			if(z.getFather()==null){
				Map<String, Map<String, Object>> map=new HashMap<String, Map<String, Object>>(1);
				Map<String, Object> childMap=new HashMap<String, Object>(2);
				childMap.put("children", recurseZycatalog(z));
				childMap.put("text", z.getName());
				map.put(z.getId().toString(), childMap);
				zycatalogJsonList.add(map);
			}
		}
		for (RepGscatalog g : gscatalogs) {
			if(g.getFather()==null){
				Map<String, Map<String, Object>> map=new HashMap<String, Map<String, Object>>(1);
				Map<String, Object> childMap=new HashMap<String, Object>(2);
				childMap.put("children", recurseGscatalog(g));
				childMap.put("text", g.getName());
				map.put(g.getId().toString(), childMap);
				gscatalogJsonList.add(map);
			}
		}
		
		String zyJsonArray=JSONArray.toJSONString(zycatalogJsonList);
		String gsJsonArray=JSONArray.toJSONString(gscatalogJsonList);
		
		//输出用于构造树状类别列表的json数据
		getRequest().setAttribute(WebConstant.RequestAttrKey
				.ZY_JSON_ARRAY, zyJsonArray);
		getRequest().setAttribute(WebConstant.RequestAttrKey
				.GS_JSON_ARRAY, gsJsonArray);
	}

	//用递归把所有的专业类别封装成可以转换成json的结构。
	public List<Map<String, Map<String, Object>>> 
				recurseZycatalog(RepZycatalog zycatalog){
		List<Map<String, Map<String, Object>>> list=
				new ArrayList<Map<String, Map<String, Object>>>(10);
		
		for (RepZycatalog z : zycatalogs) {
			if(z.getFather()!=null&&
					(z.getFather().getId()==zycatalog.getId())){
				Map<String, Map<String, Object>> map=
						new HashMap<String, Map<String, Object>>(1);
				Map<String, Object> childMap=
						new HashMap<String, Object>(2);
				childMap.put("children", recurseZycatalog(z));
				childMap.put("text", z.getName());
				map.put(z.getId().toString(), childMap);
				list.add(map);
			}
		}
		
		return list;
	}
	
	//用递归把所有的类型类别封装成可以转换成json的结构。
	public List<Map<String, Map<String, Object>>> 
					recurseGscatalog(RepGscatalog gscatalog){
		List<Map<String, Map<String, Object>>> list=
				new ArrayList<Map<String, Map<String, Object>>>(10);
		
		for (RepGscatalog g : gscatalogs) {
			if(g.getFather()!=null&&
					(g.getFather().getId()==gscatalog.getId())){
				Map<String, Map<String, Object>> map=
						new HashMap<String, Map<String, Object>>(1);
				Map<String, Object> childMap=
						new HashMap<String, Object>(2);
				childMap.put("children", recurseGscatalog(g));
				childMap.put("text", g.getName());
				map.put(g.getId().toString(), childMap);
				list.add(map);
			}
		}
		
		return list;
	}
	
	@Resource(name="resourceService")
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	@Resource(name="noticeService")
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}

	@Resource(name="zyCatalogService")
	public void setZyCatalogService(ZyCatalogService zyCatalogService) {
		this.zyCatalogService = zyCatalogService;
	}

	@Resource(name="gsCatalogService")
	public void setGsCatalogService(GsCatalogService gsCatalogService) {
		this.gsCatalogService = gsCatalogService;
	}
	@Resource(name="tagService")
	public void setTagService(TagService tagService) {
		this.tagService = tagService;
	}

}
