package com.yunstudio.struts.action.admin.asks;

import java.lang.reflect.InvocationTargetException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.beanutils.BeanUtils;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepAdmin;
import com.yunstudio.entity.RepMessage;
import com.yunstudio.service.AdminService;
import com.yunstudio.service.MessageService;
import com.yunstudio.service.UserService;
import com.yunstudio.struts.action.BaseAction;

@SuppressWarnings("serial")
public class AsksAction extends BaseAction{
	
	 
	private UserService userService;
	private AdminService adminService;
	private MessageService messageService;
	private int id;
    private String title;
    private Date   addtime;
    private String content;
    private int ispassed;
    private int isreplied=1;
    private Date releasetime;
    private Date replytime;
    private String repcontent;
    private String asker;
	
    //留言列表
	public String list(){
		int pageNum = 1;
		int pageSize = 20;
		List<String> likenNames = Arrays.asList("title", "adduser");
		List<String> eqNames = Arrays.asList("ispassed","isreplied");
		Set<Criterion> criterions = new HashSet<Criterion>();
		Set<Order> orders = new HashSet<Order>();
		Order order = Order.desc("id");
		orders.add(order);
		for (Map.Entry<String, Object> param : getParameters().entrySet()) {
			String name = param.getKey();
			String value = ((String[]) param.getValue())[0];
			if (value != null && !value.isEmpty()) {
				if (eqNames.contains(name)) {
					criterions.add(Restrictions.eq(name, Integer.parseInt(value)));
				} else if (likenNames.contains(name)) {
					if (name.equals("adduser")) {
//						criterions.add(Restrictions.like("repUser.username", "%"+value+"%"));
						criterions.add(
								Restrictions.sqlRestriction(
										"(select u.username from rep_user u where u.id={alias}.userid) like '%"+value+"%'"));
					}else {
						criterions.add(Restrictions.like(name, "%"+value.trim()+"%"));
					}
				} else if (name.equals(Page.PAGENO)) {
					pageNum = Integer.parseInt(value);
				} else if (name.equals(Page.QUERYORDERBY)) {
					if (value.equals("asc")) {
						orders.remove(order);
						orders.add(Order.asc("id"));
					}else if (value.equals("addtime_desc")) {
						orders.remove(order);
						orders.add(Order.desc("addtime"));
					}else if (value.equals("addtime_asc")) {
						orders.remove(order);
						orders.add(Order.asc("addtime"));
					}
				} else if (name.equals(Page.PAGESIZE)) {
					pageSize = Integer.parseInt(value);
					if (pageSize <= 0) {
						pageSize = 20;
					}
				}
			}
		}
		Page page = messageService.pageCQuery(pageNum, pageSize, criterions,orders, "id");
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		return "list";
	}
	
	//添加留言
	public String add(){
		if(getRequest().getMethod().equals("GET")){
			return "add";
		}
		Date now=new Date();
		
		RepMessage message=new RepMessage();
		message.setAddtime(releasetime==null?now:releasetime);
		message.setRepAdmin((RepAdmin) getSessionMap().get(RepAdmin.ADMIN));
		
		try {
			BeanUtils.populate(message, getParameters());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		message.setIsreplied(0);
        
		/*获取留言用户，这段不能用，但是可以用sessionMap来获取当前登录的admin,
		而且留言表和用户表/管理员表双向关联。
		按道理也不能为空，所以现在操作会报错。*/
		/*String us=getRequest().getParameter("userid");
		int userid=Integer.parseInt(us);
		RepAdmin admin=adminService.get(userid);
		message.setRepAdmin(admin);*/
		messageService.add(message);
		return "listAction";
	}
	
	//回复留言
	public String reply(){
		RepMessage message=messageService.get(id);
		
		if(getRequest().getMethod().equals("POST")){
			
            try {
				BeanUtils.populate(message, getParameters());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

    		message.setRepAdmin((RepAdmin) getSessionMap().get(RepAdmin.ADMIN));
            message.setReptime(replytime==null?new Date():replytime);
            messageService.updateNotNullField(message);
			return "listAction";
		}else{
			getRoot().push(message);
			return "reply";
		}
	}

	/*//编辑回复
	public String replyEdit(){
		if(id==0){
			   return "replyEdit";
		}else{
			 if(getRequest().getMethod().equals("POST")){
				RepMessage message=messageService.get(id);
				
				message.setReptime(reptime==null?new Date():reptime);
	            message.setRepcontent(repcontent);
	            
	            message.setIsreplied(1);
	            
	            messageService.update(message);
	            
    			return "listAction";
			 }else{
				RepMessage message=messageService.get(id);
				getRoot().push(message);
			 return "replyEdit";
			 }
		}
	}*/
	
	//编辑留言
	public String edit(){
		if(id==0){
			   return "edit";
			}else{
				if(getRequest().getMethod().equals("POST")){
					RepMessage message=messageService.get(id);
					
					message.setId(id);
					message.setTitle(title);
					message.setAddtime(addtime==null?new Date():addtime);
	                message.setContent(content);
	                message.setIspassed(ispassed);
	                message.setIsreplied(message.getIsreplied());
	                message.setAsker(asker);
	        		message.setRepAdmin((RepAdmin) getSessionMap().get(RepAdmin.ADMIN));
	                messageService.update(message);
	                
	    			return "listAction";
				}else{
					RepMessage message=messageService.get(id);
					getRoot().push(message);
					return "edit";
				}
			}
	}
	

	//通过审核留言
	public String pass(){
		String[] ids=(String[]) getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idStr : ids) {
				int id=Integer.parseInt(idStr);
				RepMessage message=messageService.get(id);
				message.setIspassed(1);
				message.setPasstime(new Date());
				messageService.update(message);
			}
		}
		return "listAction";
	}
	
	//删除留言
	public String delete(){
		 if(id!=0){
			 	messageService.remove(id);
	        	getContextMap().put("message", "删除成功");
	    		return "listAction";
	        }else{
			String[] ids = (String[]) getParameters().get("ids");
			if (ids != null && ids.length > 0) {
				for (String idS : ids) {
					id = Integer.parseInt(idS);
					messageService.remove(id);
				}
			}
			getContextMap().put("message", "删除成功");
			return "listAction";
	        }
	}
	
	
	
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public AdminService getAdminService() {
		return adminService;
	}
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}
	public MessageService getMessageService() {
		return messageService;
	}
	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getIspassed() {
		return ispassed;
	}
	public void setIspassed(int ispassed) {
		this.ispassed = ispassed;
	}
	public String getRepcontent() {
		return repcontent;
	}
	public void setRepcontent(String repcontent) {
		this.repcontent = repcontent;
	}
	public Date getReplytime() {
		return replytime;
	}
	public void setReplytime(Date replytime) {
		this.replytime = replytime;
	}

	public int getIsreplied() {
		return isreplied;
	}

	public void setIsreplied(int isreplied) {
		this.isreplied = isreplied;
	}

	public Date getReleasetime() {
		return releasetime;
	}

	public void setReleasetime(Date releasetime) {
		this.releasetime = releasetime;
	}

	public String getAsker() {
		return asker;
	}

	public void setAsker(String asker) {
		this.asker = asker;
	}
}
