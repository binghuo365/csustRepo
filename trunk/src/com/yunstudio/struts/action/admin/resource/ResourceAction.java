package com.yunstudio.struts.action.admin.resource;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepAdmin;
import com.yunstudio.entity.RepGscatalog;
import com.yunstudio.entity.RepResource;
import com.yunstudio.entity.RepTag;
import com.yunstudio.entity.RepTopic;
import com.yunstudio.entity.RepUser;
import com.yunstudio.entity.RepZycatalog;
import com.yunstudio.entity.WebConstant;
import com.yunstudio.service.GsCatalogService;
import com.yunstudio.service.ParamService;
import com.yunstudio.service.ResourceService;
import com.yunstudio.service.TagService;
import com.yunstudio.service.TopicService;
import com.yunstudio.service.ZyCatalogService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.struts.action.user.ThirdAction;
import com.yunstudio.utils.HqlUtils;
import com.yunstudio.utils.StringUtil;
import com.yunstudio.utils.UploadUtils;
import com.yunstudio.utils.ViewOfficeTools;

public class ResourceAction extends BaseAction {

	//_start
	//获取网站根目录，结尾没有\
	public String rootPath=getServletContext().getRealPath("").replace("\\", "/");
		
	private ResourceService resourceService;
	private ZyCatalogService zyCatalogService;
	private GsCatalogService gsCatalogService;
	private TopicService topicService;
	private TagService tagService;
	private ParamService paramService;
	
	private List<File> uploadify;// uploadify上传的文件
	private List<String> uploadifyFileName;// 上传的文件名称
	private List<String> uploadifyContentType;// 文件的内容类型
    private int id;
    private String title;
    private int gscatalogid;
    private int zycatalogid;
    private int topicid;
    private String description;
    private String content;
    //上传时间(只显示在后台)
    private Date   addtime;
    //发布时间(即通过审核的时间，显示在前台)
    private Date passtime;
    //最后更新时间(显示在前台)
    private Date updatetime;
    private String topimg;
    private String resourcepath;
    private String tagStr;
    private Integer ispassed;
    private Integer pointsneed;

	private String notpassreason;

	public List<File> getUploadify() {
		return uploadify;
	}

	public void setUploadify(List<File> uploadify) {
		this.uploadify = uploadify;
	}

	public List<String> getUploadifyFileName() {
		return uploadifyFileName;
	}

	public void setUploadifyFileName(List<String> uploadifyFileName) {
		this.uploadifyFileName = uploadifyFileName;
	}

	public ResourceService getResourceService() {
		return resourceService;
	}

	@Resource
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public ZyCatalogService getZyCatalogService() {
		return zyCatalogService;
	}
	@Resource
	public void setZyCatalogService(ZyCatalogService zyCatalogService) {
		this.zyCatalogService = zyCatalogService;
	}

	public GsCatalogService getGsCatalogService() {
		return gsCatalogService;
	}
	@Resource
	public void setGsCatalogService(GsCatalogService gsCatalogService) {
		this.gsCatalogService = gsCatalogService;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getGscatalogid() {
		return gscatalogid;
	}
	public void setGscatalogid(int gscatalogid) {
		this.gscatalogid = gscatalogid;
	}
	public int getZycatalogid() {
		return zycatalogid;
	}
	public void setZycatalogid(int zycatalogid) {
		this.zycatalogid = zycatalogid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public String getTopimg() {
		return topimg;
	}
	public void setTopimg(String topimg) {
		this.topimg = topimg;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getResourcepath() {
		return resourcepath;
	}
	public void setResourcepath(String resourcepath) {
		this.resourcepath = resourcepath;
	}

	public String getTagStr() {
		return tagStr;
	}

	public void setTagStr(String tagStr) {
		this.tagStr = tagStr;
	}

	public TagService getTagService() {
		return tagService;
	}
	@Resource(name="tagService")
	public void setTagService(TagService tagService) {
		this.tagService = tagService;
	}

	public ParamService getParamService() {
		return paramService;
	}

	@Resource(name="paramService")
	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}

	public List<String> getUploadifyContentType() {
		return uploadifyContentType;
	}

	public void setUploadifyContentType(List<String> uploadifyContentType) {
		this.uploadifyContentType = uploadifyContentType;
	}

	public TopicService getTopicService() {
		return topicService;
	}

	public void setTopicService(TopicService topicService) {
		this.topicService = topicService;
	}

	public int getTopicid() {
		return topicid;
	}

	public void setTopicid(int topicid) {
		this.topicid = topicid;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Date getPasstime() {
		return passtime;
	}

	public void setPasstime(Date passtime) {
		this.passtime = passtime;
	}

	public Integer getIspassed() {
		return ispassed;
	}

	public void setIspassed(Integer ispassed) {
		this.ispassed = ispassed;
	}
	public String getNotpassreason() {
		return notpassreason;
	}

	public void setNotpassreason(String notpassreason) {
		this.notpassreason = notpassreason;
	}

	public Integer getPointsneed() {
		return pointsneed;
	}

	public void setPointsneed(Integer pointsneed) {
		this.pointsneed = pointsneed;
	}
	//_end
	
	
	

	/*
	 * 通过hql语句实现的list方法，通过hql语句还是可以增强对生成的sql的控制的，
	 * 配合hqlutils省去了拼接字符串的一些判断语句，变得更加简洁了。
	 * 这样写的主要目的是按需生成sql语句，避免查询不必要的字段以及级联查询出现的问题
	 */
	public String list() {
		
		int pageNo = 1;
		int pageSize = 20;
		
		Map<String, Object> condistionsMap=new HashMap<String, Object>();
		String hql="select new RepResource("
						+"r.id,r.title,r.likenum,r.downloadnum,r.ispassed,r.passtime,"
						+"u.username,a.username,g.name,z.name,t.title,r.uploader,"
						+"r.translateurl,r.commentSize,a.realname) "
						+"from RepResource r left join r.repUser u left join r.repAdmin a left join r.repGscatalog g left join r.repZycatalog z "
						+"left join r.repTopic t";
		String orderBy="order by r.id desc";
		
		for (Map.Entry<String, Object> param : getParameters().entrySet()) {
			String name = param.getKey();
			String value = ((String[]) param.getValue())[0];
			if (!StringUtil.isNullOrEmpty(value)) {
				value=value.trim();
				if (name.equals("gscatalogid")) {
						condistionsMap.put("r.repGscatalog.id=?", Integer.parseInt(value));
						
				}else if (name.equals("zycatalogid")) {
					condistionsMap.put("r.repZycatalog.id=?", Integer.parseInt(value));
					
				}else if(name.equals("ispassed")){
						condistionsMap.put("r.ispassed=?", Integer.parseInt(value));
						
				}else if(name.equals("adduser")) {
						condistionsMap.put("r.uploader like ?", "%"+value+"%");
						
				}else if(name.equals("title")){
						condistionsMap.put("r.title like ?", "%"+value+"%");
						
				} else if (name.equals("tagname")) {
					condistionsMap.put("(select t from r.repTags t where t.name like ?) is not null", "%"+value+"%");
					
				}else if (name.equals(Page.PAGENO)) {
					pageNo = Integer.parseInt(value);
					
				} else if (name.equals(Page.QUERYORDERBY)) {
					orderBy="order by r."+value;
					
				} else if (name.equals(Page.PAGESIZE)) {
					pageSize = Integer.parseInt(value);
					if (pageSize <= 0) {
						pageSize = 20;
					}
					
				}
			}
		}
		HqlUtils hqlUtils=new HqlUtils();
		hql=hqlUtils.condition2hql(hql, condistionsMap, orderBy);
		Page page=resourceService.pageQuery(hql, pageNo, pageSize, hqlUtils.getObjects());
		
		//加载类型下拉框
		GscatalogList();
		ZycatalogList();
		listHotestTags();
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		
		return "list";
	}
	
	@SuppressWarnings("unchecked")
	public void listHotestTags(){
		List<String> tags=tagService.findHotesTags(10);
//		getContextMap().put("hotestTags",tags);
		getRequest().setAttribute("hotestTags", tags);
	}
	
	public void GscatalogList(){
		List<RepGscatalog> gslist=gsCatalogService.loadAll();
		getContextMap().put("gslist", gslist);
	}
	public void ZycatalogList(){
		List<RepZycatalog> zylist=zyCatalogService.loadAll();
		getContextMap().put("zylist", zylist);
	}
	public void TopicList() {
		List<RepTopic> toList=topicService.loadAll();
		getContextMap().put("tolist", toList);
	}
	
	
	@SuppressWarnings("unchecked")
	public String add() {
		Date now=new Date();
		if(getRequest().getMethod().equals("POST")){
			RepResource source=new RepResource();
			RepGscatalog gscatalog=new RepGscatalog();
			gscatalog.setId(gscatalogid);
			RepZycatalog zycatalog=new RepZycatalog();
			zycatalog.setId(zycatalogid);

			String[] tags=tagStr.replace(" ", "").replace("，", ",").split(",");
			
			for (String t : tags) {
				if(!StringUtil.isNullOrEmpty(t)){
					RepTag tag=null;
					List<RepTag> list=tagService.pageQuery("from RepTag tag where tag.name=?", 1, 1, t).getRows();
					if(list.size()>0){
						tag=list.get(0);
					}else {
						tag=new RepTag();
						tag.setName(t);
					}
					source.getRepTags().add(tag);
				}
				
			}
			fillProperties(now, source, gscatalog, zycatalog,resourcepath);
            

			ViewOfficeTools.newInstance().office2swf(source);
            
            resourceService.add(source);
            
            
            getContextMap().put("message", "添加成功");
			getContextMap().put("returnUrl", "resource_list.do");
			return "success";
		}else{
			ZycatalogList();
			GscatalogList();
			
			String supportFormat="*."+paramService.loadAll().get(0).getFormat();
			getContextMap().put("fileExt", supportFormat.replace(",", ";*.")
											.replaceAll("\\:\\d*", ""));
			return "add";
		}
	}

	private void fillProperties(Date now, RepResource source,
			RepGscatalog gscatalog, RepZycatalog zycatalog,String path) {
		int indexOf_=path.indexOf('_', path.lastIndexOf('/'));
		String path_title=path.substring(indexOf_+1);
		String path_path=path.substring(0, indexOf_);
		source.setTitle(
				StringUtil.isNullOrEmpty(title)?
						path_title
						:title.trim());
		source.setPath(path_path);
		source.setDescription(description);
		source.setRepGscatalog(gscatalog);
		source.setRepZycatalog(zycatalog);
		
		
		if(StringUtil.isNullOrEmpty(topimg)){
			
			if(ThirdAction.isImg(path_path)){
				source.setTopimg(path_path);
			}else {

				String defaultIconsPath=rootPath+
						"/attached/image/default_icons";
				File defaultIconsFolder=new File(defaultIconsPath);
				File[] defaultIcons=defaultIconsFolder.listFiles();
				String lowerPath=path_path.toLowerCase();
				for (File icon : defaultIcons) {
					String iconName=icon.getName();
					if(lowerPath.endsWith(
							iconName.substring(
									0, iconName.indexOf('.')))){
						source.setTopimg(
								"/attached/image/default_icons/"
								+iconName);
					}
				}
				if(StringUtil.isNullOrEmpty(source.getTopimg())){
					source.setTopimg(
							"/attached/image/default_icons/file.png");
				}
			}
			
			
		}else {
			source.setTopimg(topimg);
		}
		source.setContent(content);
		
		source.setIspassed(1);
		source.setPasstime(now);
		
		source.setAddtime(addtime==null?now:addtime);
		source.setUpdatetime(source.getAddtime());
		RepAdmin admin=(RepAdmin) getSessionMap().get("admin");
		source.setRepAdmin(admin);
		source.setUploader(admin.getRealname());
		source.setLength(new File(rootPath+path_path).length());
		source.setPointsneed(pointsneed);
		
	}
	
	public String deleteTopImgAjax(){
		String imgPath=getRequest().getParameter("imgPath");
		HttpServletResponse response=getResponse();
		
		File img=new File(rootPath+imgPath.substring(imgPath.indexOf("/",1)));
		if(img.exists()){
			if(img.delete())
				writeStr(response, "success");
		}else {
			writeStr(response, "failed");
		}
		
		return null;
		
	}
	
	/**
	 * 通过response输出字符串
	 * @param response
	 * @param content
	 */
	private void writeStr(HttpServletResponse response,String content) {
		response.setCharacterEncoding("utf-8");
		try {
			response.getWriter().write(content);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 批量上传一个主题的资源
	 * @return
	 */
	public String addMulti() {
		if(getRequest().getMethod().equals("POST")){
			String[] paths=resourcepath.split("<path/>");
			RepTopic topic=topicService.get(topicid);
			RepAdmin admin=(RepAdmin) getSessionMap().get("admin");
			Date now=new Date();
			
			if(paths==null){
	            getContextMap().put("message", "添加成功");
				getContextMap().put("returnUrl", "resource_add.do");
				return "failed";
			}

			String[] tags=tagStr.replace(" ", "").replace("，", ",").split(",");
			Set<RepTag> set=new HashSet<RepTag>(10);
			for (String t : tags) {
            	if(!StringUtil.isNullOrEmpty(t)){
            		RepTag tag=null;
            		@SuppressWarnings("unchecked")
					List<RepTag> list=tagService.pageQuery(
							"from RepTag tag where tag.name=?", 1, 1, t)
							.getRows();
            		if(list.size()>0){
            			tag=list.get(0);
            		}else {
            			tag=new RepTag();
            			tag.setName(t);
            		}
            		set.add(tag);
            	}
			}
			for (String path : paths) {
				final RepResource source=new RepResource();
				
				source.setRepTopic(topic);
				source.setRepTags(set);
				
				 fillProperties(
						 now,source,
						 topic.getRepGscatalog(), 
						 topic.getRepZycatalog(),path);
				

				ViewOfficeTools.newInstance().office2swf(source);
				resourceService.add(source);
				
				
			}

			
            getContextMap().put("message", "添加成功");
			getContextMap().put("returnUrl", "resource_list.do");
			return "success";
		}else{
			ZycatalogList();
			GscatalogList();
			TopicList();
			
			
			String supportFormat="*."+paramService.loadAll().get(0).getFormat();
			getContextMap().put("fileExt", supportFormat.replace(",", ";*.")
											.replaceAll("\\:\\d*", ""));
			return "addmulti";
		}
	}
	
	

	public String update() {
		if(id==0){
		   return "update";
		}else{
			Date now=new Date();
			if(getRequest().getMethod().equals("POST")){
				RepResource source=resourceService.get(id);

				if(topicid!=0){
					RepTopic topic=topicService.get(topicid);
					source.setRepTopic(topic);
					source.setRepGscatalog(topic.getRepGscatalog());
					source.setRepZycatalog(topic.getRepZycatalog());
				}else {
					source.setRepGscatalog(new RepGscatalog(gscatalogid));
					source.setRepZycatalog(new RepZycatalog(zycatalogid));
				}
				
					
				
				source.setId(id);
				source.setTitle(title);
				source.setDescription(description);
				if(addtime==null){
					addtime=(Date) resourceService.findByhql("select r.addtime from RepResource r where r.id=?", 1, id).get(0);
				}
                source.setAddtime(addtime);


	            source.setIspassed(1);
	            source.setPasstime(now);
                
				source.setNotpassreason(notpassreason);
                source.setUpdatetime(updatetime==null?now:updatetime);
                source.setTopimg(topimg);
                source.setContent(content);
                source.setPointsneed(pointsneed);
                
                String oldFilePath=rootPath+resourceService.findByhql("select r.path from RepResource r where r.id=?", 1, id).get(0);
                File oldFile=new File(oldFilePath);
                File newFile=new File(rootPath+resourcepath);
                
                if(newFile.exists()){
                	if(oldFile.exists()){
                		oldFile.delete();
                	}
                	
                	newFile.renameTo(oldFile);
    				ViewOfficeTools.newInstance().office2swf(source);
                }
                
                resourceService.update(source);
                
                //正在等待后台生成可预览文件..<br>如果无响应，请到系统资源管理页面重启预览转换服务再重新上传。
    			getContextMap().put("message", "操作成功!!");
    			getContextMap().put("returnUrl", "resource_list.do");
				return "success";
				
			}else{
				RepResource resource = resourceService.get(id);
				getRoot().push(resource);
				ZycatalogList();
				GscatalogList();
				TopicList();
				
				String supportFormat="*."+paramService.loadAll().get(0).getFormat();
				getContextMap().put("fileExt", supportFormat.replace(",", ";*.")
												.replaceAll("\\:\\d*", ""));
				return "update";
			}
		}

		
	}
	
	public String delete() {
        if(id!=0){
        	deleteResourceAndFile(id);
        	
        	
        	getContextMap().put("message", "删除成功");
    		getContextMap().put("returnUrl", "resource_list.do");
    		return "success";
        }else{
			String[] ids = (String[]) getParameters().get("ids");
			if (ids != null && ids.length > 0) {
				for (String idS : ids) {
					id = Integer.parseInt(idS);
					deleteResourceAndFile(id);
				}
			}
			getContextMap().put("message", "删除成功");
			getContextMap().put("returnUrl", "resource_list.do");
			return "success";
        }
	}

	private void deleteResourceAndFile(Integer id) {
		RepResource r=(RepResource) resourceService.findByhql(
				"select new RepResource(r.path,r.translateurl) from RepResource r where r.id=?", 1,id).get(0);
		//删除资源源文件
		if(!StringUtil.isNullOrEmpty(r.getPath())){
			File file=new File(rootPath+r.getPath());
			if(file.exists()){
				file.delete();
			}
		}
		//删除资源转换成的swf文件
		if(!StringUtil.isNullOrEmpty(r.getTranslateurl())){
			File file=new File(rootPath+r.getTranslateurl());
			if(file.exists()){
				file.delete();
			}
		}
		//删除资源转换的pdf文件
		File file=new File(rootPath+UploadUtils.relativePath+"/pdf/"+id+".pdf");
		if(file.exists()){
			file.delete();
		}
		resourceService.remove(id);
	}

	/**
	 * 已经弃用，只用user包内的ResourceAction内的uploadFile
	 * @return
	 * @throws Exception
	 */
	public String uploadFile() throws Exception {
		
		List<Map<String, String>> uploadReturnInfoList=new ArrayList<Map<String,String>>();

		String format=paramService.getParams().getFormat().toLowerCase();
		Map<String, Long> formatItemMap=StringUtil.paramsFormatParseMap(format);
		
		
		for (int i=0;i<uploadify.size();i++) {
			File file=uploadify.get(i);
			String fileName=uploadifyFileName.get(i);
			
			String filenameExt=fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
			
			//对文件名进行转码再生成路径
			String encodedFileName=StringUtil.encodeFilename(fileName);
			String filePath=UploadUtils.makeDirs(rootPath, encodedFileName);
			
			Long limitSize=formatItemMap.get(filenameExt);
			Long limitSizeByte=null;
			
			if(limitSize==null){
				Map<String,String> map=new HashMap<String, String>(2);
				map.put("message", "不支持的文件格式类型!!");
				map.put("title", fileName.substring(0,
						fileName.lastIndexOf('.')));
				uploadReturnInfoList.add(map);
				continue;
			}else {
				limitSizeByte=limitSize*1024*1024;//将mb转换成byte
			}
			if(limitSizeByte<file.length()){
				Map<String, String> map=new HashMap<String, String>(2);
				map.put("message", "该格式的文件上传支持的最大大小为"+limitSize.toString()+"MB!!");
				map.put("title", fileName.substring(0,
						fileName.lastIndexOf('.')));
				uploadReturnInfoList.add(map);
				continue;
			}
			
			file.renameTo(new File(rootPath+filePath));
			
			
			Map<String, String> map=new HashMap<String, String>(2);
			map.put("path", filePath);
			map.put("title", fileName.substring(0,
					fileName.lastIndexOf('.')));
			map.put("message", "上传成功!!");
			uploadReturnInfoList.add(map);
			
			
		}
		
		writeStr(getResponse(), JSONArray.toJSONString(uploadReturnInfoList));
		return null; // 这里不需要页面转向，所以返回空就可以了

	}

	
	public String reject() {
		if(id!=0){
			
			RepResource source=new RepResource();
			source.setId(id);
			source.setIspassed(-1);
			source.setNotpassreason(notpassreason);
			resourceService.updateNotNullField(source);
        	
        	getContextMap().put("message", "退回成功!!");
    		getContextMap().put("returnUrl", "resource_list.do");
    		return "success";
        }else{
			String[] ids = (String[]) getParameters().get("ids");
			if (ids != null && ids.length > 0) {
				for (String idS : ids) {
					id = Integer.parseInt(idS);
					RepResource source=new RepResource();
					source.setId(id);
					source.setIspassed(-1);
					source.setNotpassreason(notpassreason);
					resourceService.updateNotNullField(source);
				}
			}
	        getContextMap().put("message", "退回成功!!");
			getContextMap().put("returnUrl", "resource_list.do");
			return "success";
        }
		
	}
	
	public String testView(){
		String idStr=getRequest().getParameter("id");
		if(!StringUtil.isNullOrEmpty(idStr)){
			int id=Integer.parseInt(idStr);
			String swfPath=(String) resourceService.findByhql("select r.translateurl from RepResource r where r.id=?", 1, id).get(0);
			getRequest().setAttribute("swfpath", getRequest().getContextPath()+swfPath);
		}
		return "testview";
	}

	public String pass() {

		if(id!=0){
			
			RepResource source=resourceService.get(id);
			source.setIspassed(1);
			source.setPasstime(new Date());
			resourceService.update(source);
        	
        	getContextMap().put("message", "通过成功!!");
    		getContextMap().put("returnUrl", "resource_list.do");
    		return "success";
        }else{
			String[] ids = (String[]) getParameters().get("ids");
			if (ids != null && ids.length > 0) {
				for (String idS : ids) {
					id = Integer.parseInt(idS);
					RepResource source=resourceService.get(id);
					source.setIspassed(1);
					source.setPasstime(new Date());
					resourceService.update(source);
				}
			}
	        getContextMap().put("message", "通过成功!!");
			getContextMap().put("returnUrl", "resource_list.do");
			return "success";
        }
	}
}

