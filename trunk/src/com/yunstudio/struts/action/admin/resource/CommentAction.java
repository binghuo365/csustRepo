package com.yunstudio.struts.action.admin.resource;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepComment;
import com.yunstudio.service.CommentService;
import com.yunstudio.service.ResourceService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.HqlUtils;
import com.yunstudio.utils.StringUtil;

public class CommentAction extends BaseAction {

	@Resource(name = "commentService")
	private CommentService commentService;

	@Resource(name = "resourceService")
	private ResourceService resourceService;

	public String list() {
		int pageNum = 1;
		int pageSize = 20;

		String orderBy = "order by c.id desc";
		Map<String, Object> condistionMap = new HashMap<String, Object>(3);
		StringBuilder hqlBuilder = new StringBuilder(
				"select new RepComment(c.id, c.addtime,")
				.append("c.content,c.ispassed,c.notpassreason, c.passtime,")
				.append("u.username,r.title) from RepComment c ")
				.append("left join c.repUser u left join c.repResource r");

		for (Map.Entry<String, Object> entry : getParameters().entrySet()) {
			String name = entry.getKey();
			String value = ((String[]) entry.getValue())[0];
			if(value!=null){
				value=value.trim();
			}
			if(StringUtil.isNullOrEmpty(value)){
				continue;
				
			}else if (name.equals("ispassed")) {
				condistionMap.put("c.ispassed =?", Integer.parseInt(value));
				
			} else if (name.equals("title")) {
				condistionMap.put("r.title like ?", "%" + value + "%");
				
			}else if (name.equals("commentator")) {
				condistionMap.put("u.username like ?", "%" + value + "%");
				
			} else if (name.equals("queryOrderBy")) {
				orderBy = "order by c." + value;
				
			} else if (name.equals("pageNo")) {
				pageNum = Integer.parseInt(value);
				
			} else if (name.equals("pageSize")) {
				pageSize = Integer.parseInt(value);
				
			}
		}
		HqlUtils hqlUtils = new HqlUtils();
		String hql = hqlUtils.condition2hql(hqlBuilder, condistionMap, orderBy);

		Page page = commentService.pageQuery(hql, pageNum, pageSize,
				hqlUtils.getObjects());

		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());
		return "list";
	}

	public String pass() {

		String idStr = getRequest().getParameter("id");

		if (!StringUtil.isNullOrEmpty(idStr)) {
			int id = Integer.parseInt(idStr);

			RepComment comment = new RepComment();
			comment.setId(id);
			comment.setIspassed(1);

			commentService.updateNotNullField(comment);

			getContextMap().put("message", "通过成功!!");
			getContextMap().put("returnUrl", "comment_list.do");
			return SUCCESS;
		} else {
			String[] ids = (String[]) getParameters().get("ids");
			if (ids != null && ids.length > 0) {
				for (String idS : ids) {
					int id = Integer.parseInt(idS);
					RepComment comment = new RepComment();
					comment.setId(id);
					comment.setIspassed(1);

					commentService.updateNotNullField(comment);
				}
			}
			getContextMap().put("message", "通过成功!!");
			getContextMap().put("returnUrl", "comment_list.do");
			return "success";
		}
	}

	public String reject() {

		String idStr = getRequest().getParameter("id");
		String notpassreason=getRequest().getParameter("notpassreason");

		if (!StringUtil.isNullOrEmpty(idStr)) {
			int id = Integer.parseInt(idStr);

			RepComment comment = new RepComment();
			comment.setId(id);
			comment.setIspassed(-1);
			comment.setNotpassreason(notpassreason);

			commentService.updateNotNullField(comment);

			getContextMap().put("message", "通过成功!!");
			getContextMap().put("returnUrl", "comment_list.do");
			return SUCCESS;
		} else {
			String[] ids = (String[]) getParameters().get("ids");
			if (ids != null && ids.length > 0) {
				for (String idS : ids) {
					int id = Integer.parseInt(idS);
					RepComment comment = new RepComment();
					comment.setId(id);
					comment.setIspassed(-1);
					comment.setNotpassreason(notpassreason);

					commentService.updateNotNullField(comment);
				}
			}
			getContextMap().put("message", "通过成功!!");
			getContextMap().put("returnUrl", "comment_list.do");
			return "success";
		}
	}

	public String delete() {

		String idStr = getRequest().getParameter("id");

		if (!StringUtil.isNullOrEmpty(idStr)) {
			int id = Integer.parseInt(idStr);

			commentService.remove(id);

			getContextMap().put("message", "通过成功!!");
			getContextMap().put("returnUrl", "comment_list.do");
			return SUCCESS;
		} else {
			String[] ids = (String[]) getParameters().get("ids");
			if (ids != null && ids.length > 0) {
				for (String idS : ids) {
					int id = Integer.parseInt(idS);
					commentService.remove(id);
				}
			}
			getContextMap().put("message", "通过成功!!");
			getContextMap().put("returnUrl", "comment_list.do");
			return SUCCESS;
		}
	}
	
	public String update() {
		if(getRequest().getMethod().equals("GET")){
			
			String idStr=getRequest().getParameter("id");
			if(!StringUtil.isNullOrEmpty(idStr)){
				int id=Integer.parseInt(idStr);
				RepComment comment=commentService.get(id);
				getRoot().add(comment);
			}
			
			return "edit";
		}else {
			RepComment comment=new RepComment();
			
			try {
				String passtimeStr=getRequest().getParameter("passtimeStr");
				DateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date passtime=sdf.parse(passtimeStr);
				BeanUtils.populate(comment, getParameters());
				
				comment.setPasstime(passtime);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			commentService.updateNotNullField(comment);
			getContextMap().put("message", "更新成功!!");
			getContextMap().put("returnUrl", "comment_list.do");
			return SUCCESS;
		}
		
	}
	
}