package com.yunstudio.struts.action.user;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.yunstudio.entity.RepFolder;
import com.yunstudio.entity.RepLog;
import com.yunstudio.entity.RepNotice;
import com.yunstudio.entity.RepResource;
import com.yunstudio.entity.RepUser;
import com.yunstudio.entity.WebConstant;
import com.yunstudio.service.FolderService;
import com.yunstudio.service.LogService;
import com.yunstudio.service.NoticeService;
import com.yunstudio.service.ParamService;
import com.yunstudio.service.ResourceService;
import com.yunstudio.service.UserService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.MailUtil;
import com.yunstudio.utils.StringUtil;
import com.yunstudio.utils.ViewOfficeTools;

public class ThirdAction extends BaseAction{
	
	private static String M="m";
	
	private static String M_PREV="mprev";
	
	private static String M_NEXT="mnext";
	
	private ResourceService resourceService;
	
	private NoticeService noticeService;
	
	private ParamService paramService;
	
	@Resource(name="userService")
	private UserService userService;
	
	private InputStream inputStream;
	
	private FolderService folderService;
	
	@Resource(name="logService")
	private LogService logService;
	
	private String fileName;
	
	public static String FAILED = "failed";
	
	@SuppressWarnings("unchecked")
	public String viewnotice(){

		initData();
		
		String idStr=getRequest().getParameter(WebConstant.RequestParamKey.ID);
		if(!StringUtil.isNullOrEmpty(idStr)){
			Integer id=Integer.parseInt(idStr);
			RepNotice notice=noticeService.get(id);

			//更新该公告的浏览次数
			notice.setViewtimes(notice.getViewtimes()+1);
			noticeService.update(notice);
			
			RepNotice notice_prev = null;
			RepNotice notice_next = null;
			getRequest().setAttribute(M, notice);
			
			
			List<RepNotice> list=noticeService.findByhql(
					WebConstant.Hql.queryNoticeIdAndTitleById, 1, id+1);
			if (list.size()>0) {
				notice_prev=list.get(0);
			}
			
			list=noticeService.findByhql(
					WebConstant.Hql.queryNoticeIdAndTitleById, 1, id-1);
			if(list.size()>0){
				notice_next=list.get(0);
			}
			
			getRequest().setAttribute(M_PREV, notice_prev);
			getRequest().setAttribute(M_NEXT, notice_next);
			
			
		}
			
		return SUCCESS;
	}
	
	public String view(){

		initData();
		
		String idStr=getRequest().getParameter(WebConstant.RequestParamKey.ID);
		if(!StringUtil.isNullOrEmpty(idStr)){
			Integer id=Integer.parseInt(idStr);
			
			RepResource resource=resourceService.get(id);
			RepResource resource_prev=null;
			RepResource resource_next=null;
			
			List list=resourceService.findByhql(
					WebConstant.Hql.queryResourceIdAndTitleById, 1, id+1);
			if(list.size()>0){
				resource_prev=(RepResource) list.get(0);
			}
			list= resourceService.findByhql(
					WebConstant.Hql.queryResourceIdAndTitleById, 1, id-1);
			if(list.size()>0){
				resource_next=(RepResource) list.get(0);
			}
			
			
			//查出是否已经收藏
			
			
			getRequest().setAttribute(M, resource);
			getRequest().setAttribute(M_PREV, resource_prev);
			getRequest().setAttribute(M_NEXT, resource_next);
			
			
		}
		
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public String collect(){
		String idStr=getRequest().getParameter(WebConstant
				.RequestParamKey.ID);
		if(StringUtil.isNullOrEmpty(idStr)){
			return null;
		}
		Integer id=Integer.parseInt(idStr);
		
		RepUser user=(RepUser) getSession().getAttribute(WebConstant.SessionAttrKey.USER);
		if(user==null){
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
					"对不起，游客没有权限下载，请先注册或登录再下载。 ");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/userOpt_signin.do");
			return FAILED;
		}else if (user.getIspassed()==0) {
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
					"对不起，您尚未通过审核，如长时间未通过审核可以联系我们。");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/view.do?id="+id);
			return FAILED;
		}else if (user.getIspassed()==-1) {
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
					"对不起，您的注册已被退回，如有异议可以联系我们。");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/view.do?id="+id);
			return FAILED;
		}
		
		//"select f from RepFolder f left join f.repResources rs where f.repUser.id=?"
		List<RepFolder> list=folderService.findByhql(
				"select f from RepFolder f where f.repUser.id=?", 
				0, user.getId());
		if(list.size()>1){
			RepResource r=new RepResource(id, "");
			RepFolder f=list.get(1);

			for (int i=1;i<list.size();i++) {
				
				RepFolder ff=list.get(i);
				List<RepResource> rList=resourceService.findByhql(
						"select new RepResource(r.id,r.title) from RepResource r " +
						"left join r.repFolders f where f.id=?", 0, ff.getId());
				ff.setRepResources(new HashSet<RepResource>(rList));
				if(ff.getRepResources().contains(r)){
					getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
							"该资源您已收藏，无需重复收藏。");
					getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							"/view.do?id="+id);
					return FAILED;
					
				}
			}
			
			f.getRepResources().add(r);
			folderService.update(f);
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
					"收藏成功.");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/view.do?id="+id);
			
			return SUCCESS;
		}else {
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
					"您居然没有收藏夹，请先新建一个.");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/view.do?id="+id);
			
			return FAILED;
		}
		

	}
	
	public String download(){
		
		String idStr=getRequest().getParameter(WebConstant
				.RequestParamKey.ID);
		String type=getRequest().getParameter("type");
		RepUser user=null;
		if(!StringUtil.isNullOrEmpty(idStr)){
			Integer id=Integer.parseInt(idStr);
			
			/*
			 * 下载权限判断
			 */
			Object o=getSession().getAttribute(WebConstant.SessionAttrKey.USER);
			
			Object a=getSession().getAttribute(WebConstant.SessionAttrKey.ADMIN);
			if(a!=null){

				RepResource r=resourceService.get(id);
				String realPath=getServletContext().getRealPath(r.getPath());
				
				File file=new File(realPath);
				if(!file.exists()){
					getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
							"对不起，此文件不存在。");
					String returnUrl="/view.do?id="+id;
					getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							returnUrl);
					RepLog log=new RepLog();
					log.setOperator("System");
					log.setOperationtype("其他");
					log.setDescription("发现id为"+id+"的资源文件丢失");
					logService.add(log);
					
					return FAILED;
				}
				
				String suffix=ViewOfficeTools.newInstance().getSuffix(r.getPath());//带"."
				this.fileName=r.getTitle()+"."+suffix;
				try {
					this.fileName=URLEncoder.encode(fileName, "UTF-8");
					this.inputStream=new FileInputStream(file);
				}catch (Exception e) {
					e.printStackTrace();
				}
				
				return SUCCESS;
			}
			
			if(paramService.getParams().getVisitordownload().equals(1)){
				//读取配置如果游客可以下载，则继续往下执行
			}else{
				if (o==null){
					getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
							"对不起，游客没有权限下载，请先注册或登录再下载。 ");
					getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							"/userOpt_signin.do");
					return FAILED;
				}
				user=(RepUser) o;
				if (user.getIspassed().equals(0)) {
					getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
							"对不起，您尚未通过审核，如长时间未通过审核可以联系我们。");
					getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							"/view.do?id="+id);
					return FAILED;
				}
				if (user.getIspassed().equals(-1)) {
					getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
							"对不起，您的注册已被退回，如有异议可以联系我们。");
					getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							"/view.do?id="+id);
					return FAILED;
				}
			}
			
			RepResource r=resourceService.get(id);
			String realPath=getServletContext().getRealPath(r.getPath());
			
			File file=new File(realPath);
			if(!file.exists()){
				getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
						"对不起，此文件不存在。");
				String returnUrl="/view.do?id="+id;
				getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
						returnUrl);
				RepLog log=new RepLog();
				log.setOperator("System");
				log.setOperationtype("其他");
				log.setDescription("id为"+id+"的资源文件丢失");
				logService.add(log);
				
				return FAILED;
			}
			
			
			String suffix=ViewOfficeTools.newInstance().getSuffix(r.getPath());//不带"."
			this.fileName=r.getTitle()+"."+suffix;
			try {
				this.fileName=URLEncoder.encode(fileName, "UTF-8");
				this.inputStream=new FileInputStream(file);
				
				if (paramService.getParams().getDloadneedpoints().equals(1)) {
					int pointsneed = r.getPointsneed();
					int points = user.getPoints();
					if (points < pointsneed) {

						getRequest().setAttribute(
								WebConstant.RequestAttrKey.MESSAGE,
								"对不起，您的积分不足，请上传资源获取积分。");
						getRequest().setAttribute(
								WebConstant.RequestAttrKey.RETURN_URL,
								"/view.do?id=" + id);
						return FAILED;
					} else {
						RepUser uploader=r.getRepUser();
						if(uploader!=null){
							uploader.setPoints(uploader.getPoints()+pointsneed);
							userService.update(uploader);
						}
						user.setPoints(points - pointsneed);
						userService.update(user);
					}
				}
				//更新资源的下载次数
				r.setDownloadnum(r.getDownloadnum()+1);
				resourceService.update(r);
				
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
						"对不起，该资源不存在。");
				String folderid=getRequest().getParameter("folderid");
				if(!StringUtil.isNullOrEmpty(folderid)){
					getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							"/userOpt_listFolderInside.do?id="+folderid);
				}else {
					getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							"/view.do?id="+id);
				}
				return FAILED;
			}
				
				
				
		}

		return SUCCESS;
		
	}

	
	public void zan() {
		
		Object o=getSession().getAttribute(WebConstant.SessionAttrKey.USER);
		if(o==null){
			write("notlogin");
			return ;
		}
		
		String idStr=getRequest().getParameter("id");
		if(!StringUtil.isNullOrEmpty(idStr)){
			Integer id=Integer.parseInt(idStr);
			Set<Integer> set=null;
			set=(Set<Integer>) getSession().getAttribute("liked");
			//如果这是该session第一次赞
			if(set==null){
				set=new HashSet<Integer>();
				getSession().setAttribute("liked", set);
			}
			
			//判断是否赞过该资源
			if (set.contains(id)) {
				set.remove(id);
				reduceALikeNum(id);
				write("remove");
			}else {
				set.add(id);
				addALikeNum(id);
				write("add");
			}
			
			
		}
	}
	
	private void write(String content) {
		try {
			HttpServletResponse response=getResponse();
			response.setCharacterEncoding("utf-8");
			PrintWriter writer=response.getWriter();
			writer.write(content);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private void addALikeNum(Integer id){
		RepResource r=resourceService.get(id);
		r.setLikenum(r.getLikenum()+1);
		resourceService.update(r);
	}
	
	private void reduceALikeNum(Integer id){
		RepResource r=resourceService.get(id);
		r.setLikenum(r.getLikenum()-1);
		resourceService.update(r);
	}
	
	public String contact(){
		initData();
		return SUCCESS;
	}
	
	public void initData(){
		//最新资源
		getRequest().setAttribute(WebConstant.RequestAttrKey.NEWEST_RESOURCE,
				resourceService.findByhql(WebConstant.Hql.queryResourceOrderByNew,
						10, (Object[])null));
		//最热公告
		getRequest().setAttribute(WebConstant.RequestAttrKey.HOTEST_NOTICE,
				noticeService.findByhql(
						WebConstant.Hql.queryNoticeByViewtimes, 5, (Object[])null));

	}
	
	public static boolean isImg(String path){
		String suffix=ViewOfficeTools.newInstance().getSuffix(path).toLowerCase();
		if(suffix.startsWith("jp")||
				suffix.equals("gif")||
				suffix.equals("bmp")||
				suffix.equals("png")){
			return true;
		}
		return false;
	}
	
	public static boolean isVideo(String path){
		String suffix=ViewOfficeTools.newInstance().getSuffix(path).toLowerCase();
		if(suffix.startsWith("mp")||
				suffix.equals("flv")||
				suffix.equals("f4v")||
				suffix.equals("swf")||
				suffix.equals("avi")){
			return true;
		}
		return false;
	}
	
	@Resource(name="resourceService")
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}
	
	@Resource(name="noticeService")
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}


	public String getFileName() {
		return fileName;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	@Resource(name="paramService")
	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}

	@Resource(name="folderService")
	public void setFolderService(FolderService folderService) {
		this.folderService = folderService;
	}
}
