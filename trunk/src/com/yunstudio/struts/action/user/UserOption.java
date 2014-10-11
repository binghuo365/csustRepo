package com.yunstudio.struts.action.user;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;

import org.json.simple.JSONArray;

import com.sun.org.apache.commons.beanutils.BeanUtils;
import com.yunstudio.entity.RepFolder;
import com.yunstudio.entity.RepGscatalog;
import com.yunstudio.entity.RepResource;
import com.yunstudio.entity.RepUser;
import com.yunstudio.entity.RepZycatalog;
import com.yunstudio.entity.WebConstant;
import com.yunstudio.service.CommentService;
import com.yunstudio.service.FolderService;
import com.yunstudio.service.NoticeService;
import com.yunstudio.service.ParamService;
import com.yunstudio.service.ResourceService;
import com.yunstudio.service.UserService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.MD5Util;
import com.yunstudio.utils.MailUtil;
import com.yunstudio.utils.StringUtil;
import com.yunstudio.utils.UUIDUtils;
import com.yunstudio.utils.UploadUtils;
import com.yunstudio.utils.WebUtil;

public class UserOption extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6700096750907640735L;

	/*service
	 */
	//_start
	private ResourceService resourceService;
	
	private NoticeService noticeService;
	
	private UserService userService;
	
	private CommentService commentService;
	
	private ParamService paramService;
	
	private FolderService folderService;
	
	//_end
	
	/*静态常量
	 */
	//_start
	private static final String SIGNIN="signin";
	private static final String SIGNIN_FAILED="signinfailed";
	
	private static final String LOGIN="login";
	private static final String LOGIN_FAILED="loginfailed";
	
	private static final String FAILED="failed";
	
	private static final String emailTitle="您的密码已经重置----长沙理工大学教学资源库";
	
	private static final String INDEX="index";
	
	private static final String USER_CENTER="usercenter";
	
	private static final String LIST_FOLDER_INSIDE="listFolderInside";

	private static final String UPDATE = "update";

	private static final String UPDATE_PASSWORD = "updatePassword";

	private static final String REDIRECT_USER_CENTER = "redirect_user_center";
	
	//_end
	
	/*request传的参数
	 */
	//_start
	public String confirm_password;
	
	public String validateCode;
	
	public Integer id;
	
	public Integer folderid;
	
	private Integer pageNum;
	
	private Integer pageSize;
	
	private String oldpassword;
	
	private String newpassword;
	
	private String realname;
	
	private String school;
	
	private String major;
	
	private String qq;
	
	private String phone;
	
	private Integer gender;
	
	private int isdelete;
	

	//_end
	
	

	
	private List<Map<String, Map<String, Object>>> folderJsonList;
	
	private List<RepFolder> folders;
	
	/*
	 *注册
	 */
	public String signin(){
		initData();
		echoInput();
		
		if (getRequest().getMethod().equals("GET")) {
			return SIGNIN;
		}
		RepUser user=WebUtil.params2Bean(getParameters(), RepUser.class);
		List sameUsernameList=userService.findByhql(
				"select u.id from RepUser u where u.username=?",
				1, user.getUsername());
		List sameEmailList=userService.findByhql(
				"select u.id from RepUser u where u.email=?",
				1, user.getEmail());
		if(sameUsernameList.size()>0){
			getRequest().setAttribute("username_message",
					"登录名已存在,请换个用户名！");
			return SIGNIN_FAILED;
			
		}else if (sameEmailList.size()>0) {
			getRequest().setAttribute("email_message",
					"该邮箱已经被用于注册,请换个邮箱！");
			return SIGNIN_FAILED;
			
		}else if (!confirm_password.equals(user.getPassword())) {
			getRequest().setAttribute("confirm_password_message",
					"两次密码不一致！");
			return SIGNIN_FAILED;
			
		}else if (StringUtil.isNullOrEmpty(validateCode)||
				!validateCode.toLowerCase().equals(getSession().getAttribute(
				WebConstant.SessionAttrKey.VALIDATE_CODE).toString())) {
			getRequest().setAttribute("validateCode_message", 
					"验证码错误！");
			return SIGNIN_FAILED;
		}
		
		//MD5加密密码
		user.setPassword(MD5Util.MD5(user.getPassword()));
		user.setRegtime(new Date());
		user.setPasstime(new Date());
		
		if(user.getTeacherorstu().equals(1)){
			if(paramService.getParams().getSisneedpass().equals(1)){
				//如果用户是学生并且配置为学生需要审核
				user.setIspassed(0);
				user.setPasstime(null);
			}
			user.setPoints(1000);
		}
		if (user.getTeacherorstu().equals(2)){
			if(paramService.getParams().getTisneedpass().equals(1)) {
				//如果用户是老师并且配置为老师需要审核
				user.setIspassed(0);
				user.setPasstime(null);
			}
			user.setPoints(5000);
		}
		
		//插入一条用户数据
		userService.add(user);

		//存入session表示已经登录
		getSession().setAttribute(WebConstant.SessionAttrKey.USER, 
				userService.get(user.getId()));
		
		//添加两个收藏夹，一个是我的上传，一个是我的收藏
		RepFolder myUpload=new RepFolder();
		myUpload.setName("我的上传");
		myUpload.setRepUser(user);
		folderService.add(myUpload);
		
		RepFolder myCollect=new RepFolder();
		myCollect.setName("我的收藏");
		myCollect.setRepUser(user);
		folderService.add(myCollect);
		
		getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, 
				"注册成功!!");
		getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
				"/index.do");
		
		return SUCCESS;
	}
	
	
	public String login(){
		
		initData();
		echoInput();
		
		if (getRequest().getMethod().equals("GET")) {
			return LOGIN;
		}
		
		String email=getRequest().getParameter("email");
		if(!StringUtil.isNullOrEmpty(email)){
			List list=userService.findByhql(
					"select u from RepUser u where u.email = ?", 1, email);
			if (list.size()==0) {

				getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
						"该邮箱未注册!!");
				getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
						"/userOpt_login.do");
				return FAILED;
			}else {
				String basePath = new StringBuilder(getRequest().getScheme())
						.append("://").append(getRequest().getServerName())
						.append(":").append(getRequest().getServerPort())
						.append(getRequest().getContextPath()).toString();
				
				RepUser u=(RepUser) list.get(0);
				String newPassword=UUIDUtils.uuid().substring(0, 6);
				u.setPassword(MD5Util.MD5(newPassword));
				userService.update(u);
				
				StringBuilder emailBody=new StringBuilder("您的登录名为:")
					.append(u.getUsername())
					.append("<br/>您的密码已经重置为:<font color='red'>")
					.append(newPassword)
					.append("</font><br/>请及时修改密码，如有问题，请<a href='")
					.append(basePath).append("/contact.do'>联系我们</a>");
				MailUtil.sendEmail(email, emailTitle, emailBody.toString());

				
				getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
						"密码重置成功!!");
				getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
						"/userOpt_login.do");
				return SUCCESS;
			}
		}

		String username=getRequest().getParameter("username");
		String password=getRequest().getParameter("password");

		if(StringUtil.isNullOrEmpty(username)||
				StringUtil.isNullOrEmpty(password)){
			getRequest().setAttribute("username_message", 
					"用户名或者密码不能为空!!");
			return LOGIN_FAILED;
		}
		
		RepUser user=userService.findUserByName(username);
		if(user==null){
			getRequest().setAttribute("username_message", 
					"用户名不存在!!");
			return LOGIN_FAILED;
		}
		
		if(!MD5Util.MD5(password).equals(user.getPassword())){
			getRequest().setAttribute("password_message", 
					"密码错误!!");
			return LOGIN_FAILED;
		}
		
		getSession().setAttribute(WebConstant.SessionAttrKey.USER_LAST_LOGIN_IP,
				user.getLastloginip());
		getSession().setAttribute(WebConstant.SessionAttrKey.USER_LAST_LOGIN_TIME, 
				user.getLastlogintime());
		
		user.setLastloginip(getRequest().getRemoteAddr());
		user.setLastlogintime(new Date());
		userService.update(user);
		
		getSession().setAttribute(WebConstant.SessionAttrKey.USER, user);
		
		initFolder();
		return INDEX;
	}
	
	public String logout(){
		getSession().setAttribute("user", null);
		return INDEX;
	}
	
	public String showcenter(){
		initData();
		initFolder();

		return USER_CENTER;
	}
	
	@SuppressWarnings("unchecked")
	public String listFolderInside(){
		
		if(pageNum==null||pageNum==0){
			pageNum=1;
		}
		if(pageSize==null||pageSize==0){
			pageSize=10;
		}
		
		Object o=getSession().getAttribute(WebConstant.SessionAttrKey.USER);
		if(o==null){
			return null;
		}

		RepUser user=(RepUser) o;
		List<RepFolder> list=null;
		if(id==null){
			list=folderService.findByhql(
					"select new RepFolder(f.id,f.name) from RepFolder f " +
					"where f.repUser.id=? and f.father.id=null", 0, user.getId());
			getRequest().setAttribute(WebConstant.RequestAttrKey.FATHER_FOLDER,
					null);
		}else {
			list=folderService.findByhql(
					"select new RepFolder(f.id,f.name) from RepFolder f " +
					"where f.father.id=? and f.repUser.id=?", 
					0, id,user.getId());
			getRequest().setAttribute(WebConstant.RequestAttrKey.FATHER_FOLDER,
					folderService.get(id));
		}
		getRequest().setAttribute(WebConstant.RequestAttrKey.FOLDER_ID, id);
		getRequest().setAttribute(WebConstant.RequestAttrKey.FOLDERLIST, list);
		getRequest().setAttribute(WebConstant.RequestAttrKey.PAGE,
				resourceService.pageQuery(WebConstant.Hql.queryResource+
						" left join r.repFolders fs where fs.id=?", pageNum,pageSize, id));
		
		return LIST_FOLDER_INSIDE;
	}
	
	
	@SuppressWarnings("unchecked")
	public String removeCollect() {
		if(id!=null&&folderid!=null){
			RepFolder f= folderService.get(folderid);
			RepUser user=(RepUser) getSession().getAttribute(WebConstant.SessionAttrKey.USER);
			if(!f.getRepUser().getId().equals(user.getId())){
				getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
						"取消收藏失败!!");
				getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
						"/userOpt_listFolderInside.do?id="+folderid);
				return SUCCESS;
			}
			
			RepResource r=new RepResource();
			r.setId(id);
			
			if(isdelete==1){
				RepResource resource=resourceService.get(id);
				if(resource.getRepUser()!=null&&
						resource.getRepUser().getId().equals(user.getId())){
					
					deleteResourceAndFile(resource);
					
					getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
							"删除上传文件成功!!");
					getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
							"/userOpt_listFolderInside.do?id="+folderid);
					return SUCCESS;
				}
			}
				
			
			List<RepResource> rList=resourceService.findByhql(
					"select new RepResource(r.id,r.title) from RepResource r " +
					"left join r.repFolders f where f.id=?", 0, f.getId());
			
			Set<RepResource> set=new HashSet<RepResource>(rList);
			set.remove(r);
			f.setRepResources(set);
			
			folderService.update(f);
			

			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
					"取消收藏成功!!");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/userOpt_listFolderInside.do?id="+folderid);
			return SUCCESS;
		}else {
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
					"取消收藏失败!!");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/userOpt_listFolderInside.do?id="+folderid);
			return SUCCESS;
			
		}
	}

	@SuppressWarnings("unchecked")
	public String removeFolder() {
		RepUser user=(RepUser) getSession().getAttribute(WebConstant.SessionAttrKey.USER);
		if(folderid==null){
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
					"删除收藏夹失败!!");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/userOpt_listFolderInside.do");
			return FAILED;
		}
		
		List<RepResource> list=resourceService.findByhql(
				"select new RepResource(r.id,u.id) from RepResource r " +
				"left join r.repFolders f left join r.repUser u where f.id=?", 
				0, folderid);
		
		if(isdelete==1){
			for (RepResource r : list) {
				if(r.getRepUser().getId().equals(user.getId())){
					deleteResourceAndFile(r);
				}
			}
			
			folderService.remove(folderid);
			
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
					"删除上传专题成功!!");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/userOpt_listFolderInside.do");
		}else {
			folderService.remove(folderid);
			
			getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE,
					"删除收藏专题成功!!");
			getRequest().setAttribute(WebConstant.RequestAttrKey.RETURN_URL, 
					"/userOpt_listFolderInside.do");
			
		}
		
		return SUCCESS;
	}
	
	private void deleteResourceAndFile(RepResource r) {
		String rootPath=getServletContext().getRealPath("").replace("\\", "/");
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
		resourceService.remove(r.getId());
	}
	
	public String update(){
		if(getRequest().getMethod().equals("GET")){
			return UPDATE;
		}
		RepUser user=(RepUser) getSession().getAttribute(WebConstant.SessionAttrKey.USER);
		
		user.setRealname(realname);
		user.setGender(gender);
		user.setSchool(school);
		user.setMajor(major);
		user.setQq(qq);
		user.setPhone(phone);
		
		userService.update(user);
		
		getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, "修改已保存 &radic;");
		return UPDATE;
	}
	
	public  String updatePassword() {
		if(getRequest().getMethod().equals("GET")){
			return UPDATE_PASSWORD;
		}
		
		RepUser user=(RepUser) getSession().getAttribute(WebConstant.SessionAttrKey.USER);
		if(!user.getPassword().equals(MD5Util.MD5(oldpassword))){
			getRequest().setAttribute("oldpassword_message", "原密码错误!!");
			return UPDATE_PASSWORD;
		}
		
		if(!newpassword.equals(confirm_password)){
			getRequest().setAttribute("confirm_password_message", "两次密码不一致!!");
			return UPDATE_PASSWORD;
		}
		
		user.setPassword(MD5Util.MD5(newpassword));
		userService.update(user);

		getRequest().setAttribute(WebConstant.RequestAttrKey.MESSAGE, "密码修改成功 &radic;");
		return UPDATE_PASSWORD;
	}
	

	/**
	 * 递归算法太消耗资源，不过现在暂时没有时间，等下次有时间再用非递归的实现算了，，
	 */
	@SuppressWarnings("unchecked")
	private void initFolder(){
		RepUser user=(RepUser) getSession().getAttribute(WebConstant.SessionAttrKey.USER);
		
		if(user==null){
			return;
		}
		
		
		//获取所有的专业类别
		folders=folderService.findByhql(
				"select f from RepFolder f where f.repUser.id=?", 0, user.getId());
		//初始化用来构造json数据的list
		folderJsonList=new ArrayList<Map<String,Map<String,Object>>>(10);
		//List<RepFolder> stack=new ArrayList<RepFolder>();
		//通过递归构造jsonArray形式的类别
		for (RepFolder f : folders) {
			if(f.getFather()==null){
				Map<String, Map<String, Object>> map=new HashMap<String, Map<String, Object>>(1);
				Map<String, Object> childMap=new HashMap<String, Object>(2);
				childMap.put("children", recurseFolder(f));
				childMap.put("text", f.getName());
				map.put(f.getId().toString(), childMap);
				folderJsonList.add(map);
			}
		}
		String folderJsonArray=JSONArray.toJSONString(folderJsonList);
		
		//输出用于构造树状类别列表的json数据
		getRequest().setAttribute(WebConstant.RequestAttrKey
				.FOLDER_JSON_ARRAY, folderJsonArray);
	}
	
	//用递归把所有的收藏夹和收藏的资源封装成可以转换成json的结构。
	public List<Map<String, Map<String, Object>>> 
				recurseFolder(RepFolder folder){
		List<Map<String, Map<String, Object>>> list=
				new ArrayList<Map<String, Map<String, Object>>>(10);
		
		for (RepFolder f : folders) {
			if(f.getFather()!=null&&
					(f.getFather().getId()==folder.getId())){
				Map<String, Map<String, Object>> map=
						new HashMap<String, Map<String, Object>>(1);
				Map<String, Object> childMap=
						new HashMap<String, Object>(2);
				
				childMap.put("children", recurseFolder(f));
				childMap.put("text", f.getName());
				map.put(f.getId().toString(), childMap);
				list.add(map);
			}
		}
		
		return list;
	}
	
	
	/**
	 * 初始化一些页面会显示出来的数据。
	 * 主要是最热的公告和最新的资源
	 */
	private void initData(){

		//最新资源
		getRequest().setAttribute(WebConstant.RequestAttrKey.NEWEST_RESOURCE,
				resourceService.findByhql(WebConstant.Hql.queryResourceOrderByNew,
						10, (Object[])null));
		//最热公告
		getRequest().setAttribute(WebConstant.RequestAttrKey.HOTEST_NOTICE,
				noticeService.findByhql(
						WebConstant.Hql.queryNoticeByViewtimes, 5, (Object[])null));
	}
	/**
	 * 回显用户输入的数据
	 */
	private void echoInput(){
		getRequest().setAttribute(WebConstant.RequestAttrKey.PARAMS, 
				getParameters());
	}

	@Resource(name="resourceService")
	public void setResourceService(ResourceService resourceService) {
		this.resourceService = resourceService;
	}

	@Resource(name="noticeService")
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}

	@Resource(name="userService")
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Resource(name="commentService")
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}

	@Resource(name="paramService")
	public void setParamService(ParamService paramService) {
		this.paramService = paramService;
	}


	@Resource(name="folderService")
	public void setFolderService(FolderService folderService) {
		this.folderService = folderService;
	}


	public void setConfirm_password(String confirm_password) {
		this.confirm_password = confirm_password;
	}

	public String getConfirm_password() {
		return confirm_password;
	}


	public String getValidateCode() {
		return validateCode;
	}


	public void setValidateCode(String validateCode) {
		this.validateCode = validateCode;
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public Integer getPageNum() {
		return pageNum;
	}


	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}


	public Integer getFolderid() {
		return folderid;
	}


	public void setFolderid(Integer folderid) {
		this.folderid = folderid;
	}


	public Integer getPageSize() {
		return pageSize;
	}


	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}


	public String getOldpassword() {
		return oldpassword;
	}


	public void setOldpassword(String oldpassword) {
		this.oldpassword = oldpassword;
	}


	public String getNewpassword() {
		return newpassword;
	}


	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}


	public String getRealname() {
		return realname;
	}


	public void setRealname(String realname) {
		this.realname = realname;
	}


	public String getSchool() {
		return school;
	}


	public void setSchool(String school) {
		this.school = school;
	}


	public String getMajor() {
		return major;
	}


	public void setMajor(String major) {
		this.major = major;
	}


	public String getQq() {
		return qq;
	}


	public void setQq(String qq) {
		this.qq = qq;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public Integer getGender() {
		return gender;
	}


	public void setGender(Integer gender) {
		this.gender = gender;
	}


	public int getIsdelete() {
		return isdelete;
	}


	public void setIsdelete(int isdelete) {
		this.isdelete = isdelete;
	}

}
