package com.yunstudio.struts.action.admin.systemsetup;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.artofsolving.jodconverter.office.DefaultOfficeManagerConfiguration;
import org.artofsolving.jodconverter.office.OfficeManager;

import com.yunstudio.entity.RepParam;
import com.yunstudio.service.ParamService;
import com.yunstudio.struts.action.BaseAction;
import com.yunstudio.utils.TaskmgrUtil;
import com.yunstudio.utils.ViewOfficeTools;

public class ParamAction extends BaseAction{
	
	@Resource(name="paramService")
	private ParamService paramService;
	

	public String edit() {
		RepParam param=paramService.loadAll().get(0);
		
		getRoot().push(param);
		return "edit";
	}
	
	public String update() {
		
		RepParam param=new RepParam();
		
		try {
			BeanUtils.populate(param, getParameters());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		param.setFormat(param.getFormat().trim().replace(" ", "").replace("，", ",").replace("：", ":"));
		paramService.update(param);
		paramService.updateStaticParams();

		getContextMap().put("message", "修改成功");
		getContextMap().put("returnUrl", "param_edit.do");
		
		return SUCCESS;
	}
	

	public String restart() {
		
		try {
			//杀死已经发生死锁的pdf2swf.exe进程
			TaskmgrUtil.killProcess("pdf2swf.exe");
			
			/*
			 * 获取单例的ViewOfficeTools
			 */
			ViewOfficeTools viewOfficeTools=ViewOfficeTools.newInstance();
			
			/*
			 * 停止officeManager的服务
			 */
			try {
				viewOfficeTools.getOfficeManager().stop();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			/*
			 * 重新配置officeManager
			 */
			viewOfficeTools.setOfficeManager(
					viewOfficeTools.newOfficeManager());
			/*
			 * 启动officeManager的服务
			 */
			viewOfficeTools.getOfficeManager().start();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		  
        getContextMap().put("message", "重启预览文件生成服务成功!!");
		getContextMap().put("returnUrl", "param_edit.do");
		return SUCCESS;
	}		

	
}
