package com.yunstudio.struts.action.user;

import javax.annotation.Resource;

import com.yunstudio.entity.WebConstant;
import com.yunstudio.service.NoticeService;
import com.yunstudio.service.ResourceService;
import com.yunstudio.struts.action.BaseAction;

public class IndexAction extends BaseAction{
	
	private ResourceService resourceService;
	
	private NoticeService noticeService;
	
	
	public String index(){
		//最热公告
		getRequest().setAttribute(WebConstant.RequestAttrKey.HOTEST_NOTICE,
				noticeService.findByhql(
						WebConstant.Hql.queryNoticeByViewtimes, 5, (Object[])null));
		//最新公告
		getRequest().setAttribute(WebConstant.RequestAttrKey.NEWEST_NOTICE,
				noticeService.findByhql(
						WebConstant.Hql.queryNoticeOrderByNew, 9, (Object[])null));
		//最热资源
		getRequest().setAttribute(WebConstant.RequestAttrKey.HOTEST_RESOURCE,
				resourceService.findByhql(
						WebConstant.Hql.queryResourceOrderByDownload, 5, (Object[])null));
		
		//分专业的类别列表
		for(int i=1;i<9;i++){
			getRequest().setAttribute(WebConstant.RequestAttrKey.ZYCATALOG+i,
					resourceService.findByhql(
							WebConstant.Hql.queryResourceByZyOrderByDowload, 5, i));
		}
		//最新视频资源
		getRequest().setAttribute(WebConstant.RequestAttrKey.HOTEST_VIDEO,
				resourceService.findByhql(
						WebConstant.Hql.queryResourceByGsOrderByDownload, 10, 2));
		//最新资源
		getRequest().setAttribute(WebConstant.RequestAttrKey.NEWEST_RESOURCE,
				resourceService.findByhql(
						WebConstant.Hql.queryResourceOrderByNew, 11, (Object[])null));
		
		
		return SUCCESS;
	}

	@Resource(name="resourceService")
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}

	@Resource(name="noticeService")
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}
}
