package com.yunstudio.struts.action.admin.notice;

import java.text.ParseException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.sun.org.apache.commons.beanutils.BeanUtils;
import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepAdmin;
import com.yunstudio.entity.RepNotice;
import com.yunstudio.service.AdminService;
import com.yunstudio.service.NoticeService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.struts.form.NoticeForm;
import com.yunstudio.utils.WebUtil;

/**
 * 公告管理
 * @author 彭倩
 * 
 */
@SuppressWarnings("serial")
public class NoticeAction extends BaseAction {
	
	private Integer id;
	private String title;
	private String content;
	private NoticeService noticeService;
	private AdminService adminService;
	private Date addtime;
	private String author;
	private Date atime;

	/**
	 * 显示公告列表，加上分页
	 * 
	 * @return
	 */
	public String list() {
		int pageNum = 1;
		int pageSize = 20;

		List<String> likenNames = Arrays.asList("title", "adduser");
		List<String> eqNames = Arrays.asList("ispassed");

		Set<Criterion> criterions = new HashSet<Criterion>();
		Set<Order> orders = new HashSet<Order>();
		Order order = Order.desc("id");
		orders.add(order);

		for (Map.Entry<String, Object> param : getParameters().entrySet()) {
			String name = param.getKey();
			String value = ((String[]) param.getValue())[0];

			if (value != null && !value.isEmpty()) {
				if (eqNames.contains(name)) {
					if(!value.equals("-1")){
						criterions.add(Restrictions.eq(name, Integer.parseInt(value)));
					}
				} else if (likenNames.contains(name)) {
					if (name.equals("adduser")) {
						criterions.add(
//								Restrictions.sqlRestriction("(select u.username from rep_admin u where u.id={alias}.adminid) like '%"+value+"%'"));
								Restrictions.like("author", "%"+value.trim()+"%"));
					} else {
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

		Page page = noticeService.pageCQuery(pageNum, pageSize, criterions,orders, "id");
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		return "list";
	}


	/**
	 * 添加公告，给添加公告加一个成功转向页面
	 * @return
	 */
	public String add() {
		if(getRequest().getMethod().equals("GET")){
			return "add";
		}
		RepNotice notice=new RepNotice();
		
		try {
			BeanUtils.populate(notice, getParameters());
		} catch (Exception e) {
			e.printStackTrace();
		}
		notice.setAddtime(atime == null ? new Date() : atime);
		notice.setRepAdmin((RepAdmin)getSessionMap().get(RepAdmin.ADMIN));
		
		noticeService.add(notice);
		
		getContextMap().put("message", "添加成功");
		getContextMap().put("returnUrl", "notice_list.do");
		return SUCCESS;
//		return "listAction";
	}

	/**
	 * 编辑公告
	 * @return
	 */
	public String edit() {
		RepNotice notice=noticeService.get(id);
		getRoot().push(notice);
		return "edit";
	}
	
	/**
	 * 更新公告，存在时间转换的问题，编辑功能好像无法实现了！！震惊！！！
	 * @return
	 * @throws ParseException 
	 */
	public String update(){
		RepNotice notice=new RepNotice();
		
		try {
			BeanUtils.populate(notice, getParameters());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(atime!=null){
			notice.setAddtime(atime);
		}

		notice.setRepAdmin((RepAdmin)getSessionMap().get(RepAdmin.ADMIN));
		noticeService.updateNotNullField(notice);
		return "listAction";
	}
	
	public String delete() {
		String idStr = getRequest().getParameter("id");
		int id = 0;
		if (idStr != null &&!idStr.isEmpty()) {
			id = Integer.parseInt(idStr);
			noticeService.remove(id);
		}
		String[] ids = (String[]) getParameters().get("ids");
		if (ids != null && ids.length > 0) {
			for (String idS : ids) {
				id = Integer.parseInt(idS);
				noticeService.remove(id);
			}
		}
		return "listAction";
	}

	public String pass() {
		String[] ids=(String[]) getParameters().get("ids");
		if(ids!=null&&ids.length>0){
			for (String idStr : ids) {
				int id=Integer.parseInt(idStr);
				RepNotice notice=noticeService.get(id);
				notice.setIspassed(1);
				noticeService.update(notice);
			}
		}
		return "listAction";
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public NoticeService getNoticeService() {
		return noticeService;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public AdminService getAdminService() {
		return adminService;
	}
	@Resource(name="adminService")
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	@Resource(name="noticeService")
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public Date getAtime() {
		return atime;
	}


	public void setAtime(Date atime) {
		this.atime = atime;
	}
}