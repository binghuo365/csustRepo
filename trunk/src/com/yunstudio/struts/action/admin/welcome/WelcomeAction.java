package com.yunstudio.struts.action.admin.welcome;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;

import com.yunstudio.entity.RepAdmin;
import com.yunstudio.entity.RepRole;
import com.yunstudio.entity.ResourceCount;
import com.yunstudio.entity.SysInfo;
import com.yunstudio.service.AdminService;
import com.yunstudio.service.ResourceService;
import com.yunstudio.service.RoleService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.GetSystemInfo;
import com.yunstudio.utils.MD5Util;
import com.yunstudio.utils.WebUtil;

public class WelcomeAction extends BaseAction{
	
	@Resource(name="adminService")
	private AdminService adminService;
	
	@Resource(name="roleService")
	private RoleService roleService;
	
	@Resource(name="resourceService")
	private ResourceService resourceService;
	
	public String edit() {
		RepAdmin admin=(RepAdmin) getSessionMap().get(RepAdmin.ADMIN);
		List<RepRole> roles=roleService.loadAll();
		
		getContextMap().put("roles", roles);
		getRoot().push(admin);
		return "edit";
	}
	
	public String update() {
		
		RepAdmin admin=WebUtil.params2FormBean(getParameters(), RepAdmin.class);
		
		RepAdmin adminLogin=(RepAdmin) getSessionMap().get(RepAdmin.ADMIN);
		
		admin.setId(adminLogin.getId());
		admin.setUsername(admin.getUsername().trim());
		
		RepAdmin a=adminService.findAdminByName(admin.getUsername());
		if(a!=null&&!a.getId().equals(admin.getId())){
			getContextMap().put("message", "已经存在同名用户，请换个用户名!");
			getContextMap().put("params", getParameters());
			return "edit";
		}
		
		if(admin.getPassword()!=null&&!admin.getPassword().isEmpty()){
			admin.setPassword(MD5Util.MD5(admin.getPassword()));
		}else {
			admin.setPassword(null);
		}
		
		admin.setId(adminLogin.getId());
		adminService.updateNotNullField(admin);
		getSessionMap().put(RepAdmin.ADMIN,adminService.get(adminLogin.getId()));
		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "welcome_welcome.do");
		
		return SUCCESS;
	}

	public String welcome() {
		
		SysInfo sysInfo=new SysInfo();
		String rootPath=ServletActionContext.getServletContext().getRealPath("");
		Date endTime=new Date();
		Date startTime=null;
		ResourceCount rCount=new ResourceCount();
		Calendar calendar=Calendar.getInstance();
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		
		sysInfo.setOsinfo(GetSystemInfo.getProperty(GetSystemInfo.OS_NAME)
				+" "+GetSystemInfo.getProperty(GetSystemInfo.OS_VERSION));
		sysInfo.setCpuType(GetSystemInfo.getProperty(GetSystemInfo.OS_ARCH));
		sysInfo.setSysUser(GetSystemInfo.getProperty(GetSystemInfo.USER_NAME));
		sysInfo.setTomCatDir(rootPath+"\\bin");
		sysInfo.setTomCatTempDir(rootPath+"\\temp");
		sysInfo.setJavaRuntimeNameInfo(GetSystemInfo.getProperty(GetSystemInfo.JAVA_RUNTIME_NAME)+" "
				+GetSystemInfo.getProperty(GetSystemInfo.JAVA_RUNTIME_VERSION));
		sysInfo.setJavaVmInfo(GetSystemInfo.getProperty(GetSystemInfo.JAVA_VM_NAME)+" "
				+GetSystemInfo.getProperty(GetSystemInfo.JAVA_VM_VERSION));
		
		double totalMemory=GetSystemInfo.getTotalMemery()/(1024*1024*1024.0);
		double leftMemory=GetSystemInfo.getLeftMemory()/(1024*1024*1024.0);
		double usingMemory=totalMemory-leftMemory;
		sysInfo.setTotalMemory(GetSystemInfo.nf.format(totalMemory));
		sysInfo.setLeftMemory(GetSystemInfo.nf.format(leftMemory));
		sysInfo.setUsingMemory(GetSystemInfo.nf.format(usingMemory));
		sysInfo.setDiskInfo(GetSystemInfo.getDisk(rootPath.charAt(0)));
		
		
		try {
			startTime = df.parse(df.format(endTime));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int todayUpload=(Integer) resourceService
				.countResourceByTime(startTime, endTime);
		rCount.setTodayUpload(todayUpload);
		
		
		calendar.setTime(startTime);
		calendar.add(Calendar.DATE, -1);
		endTime=startTime;
		startTime=calendar.getTime();
		int yesterdayUpload=(Integer) resourceService
				.countResourceByTime(startTime, endTime);
		rCount.setYesterdayUpload(yesterdayUpload);
		
		endTime=new Date();
		
		calendar.setTime(endTime);
		calendar.add(Calendar.WEEK_OF_MONTH, -1);
		startTime=calendar.getTime();
		int weekUpload=(Integer) resourceService
				.countResourceByTime(startTime, endTime); 
		rCount.setWeekUpload(weekUpload);
		
		calendar.setTime(endTime);
		calendar.add(Calendar.MONTH, -1);
		startTime=calendar.getTime();
		int monthUpload=(Integer) resourceService
				.countResourceByTime(startTime, endTime); 
		rCount.setMonthUpload(monthUpload);

		int totalUpload=(Integer) resourceService
				.countResourceByTime(null, null);
		rCount.setTotalUpload(totalUpload);
		
		getRequest().setAttribute("rCount", rCount);
		getRequest().setAttribute("sysInfo", sysInfo);
		
		
		
		
		return "welcome";
	}
}
