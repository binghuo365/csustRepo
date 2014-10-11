package com.yunstudio.struts.action.admin.systemsetup;

import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import com.yunstudio.entity.Page;
import com.yunstudio.entity.RepAdmin;
import com.yunstudio.service.AdminService;
import com.yunstudio.service.LogService;
import com.yunstudio.struts.action.BaseAction;

public class LogAction extends BaseAction{
	
	@Resource(name="logService")
	private LogService logService;
	
	@Resource(name="adminService")
	private AdminService adminService;
	
	public String list() {
		int pageNum=1;
		int pageSize=20;
		
		List<String> likenNames=Arrays.asList("operationtype","description","operationip");
//		List<String> eqNames=Arrays.asList("islock","ispassed","teacherorstu","roleid");
		
		Set<Criterion> criterions=new HashSet<Criterion>();
		Set<Order> orders=new HashSet<Order>();
		Order order=Order.desc("id");
		orders.add(order);

		for (Map.Entry<String, Object> param : getParameters().entrySet()) {
			String name=param.getKey();
			String value=((String[])param.getValue())[0];
			if(value!=null&&!value.isEmpty()){
				if(likenNames.contains(name)){
					criterions.add(Restrictions.like(name, "%"+value+"%"));

				}else if(name.equals("adminid")){
					criterions.add(Restrictions.eq("repAdmin.id", Integer.parseInt(value)));
				}else if(name.equals(Page.PAGENO)){
					pageNum=Integer.parseInt(value);
				
				}else if(name.equals(Page.QUERYORDERBY)){
					if(value.equals("asc")){
						orders.remove(order);
						orders.add(Order.asc("id"));
					}
				}else if (name.equals(Page.PAGESIZE)) {
					pageSize=Integer.parseInt(value);
					if(pageSize<=0){
						pageSize=20;
					}
				}
			}
		}
		
		String starttimeStr=getRequest().getParameter("starttime");
		String  endtimeStr=getRequest().getParameter("endtime");
		
		if(starttimeStr!=null&&!starttimeStr.isEmpty()&&endtimeStr!=null&&!endtimeStr.isEmpty()){
			try {
				SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date startTime = dateFormat.parse(starttimeStr);
				Date endTime = dateFormat.parse(endtimeStr);
				criterions.add(Restrictions.between("operationtime", startTime, endTime));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		
		Page page=logService.pageCQuery(pageNum, pageSize, criterions, orders,"id");
		getContextMap().put("page", page);
		getContextMap().put("params", getParameters());

		List<RepAdmin> admins=adminService.loadAll();
		getContextMap().put("admins", admins);
		
		return "list";
	}

	
}
