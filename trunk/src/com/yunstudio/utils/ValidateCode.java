package com.yunstudio.utils;

import java.io.IOException;  
import java.awt.Color;  
import java.io.OutputStream;  
import java.util.Random;  
  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  
  
import org.patchca.color.ColorFactory;  
import org.patchca.color.SingleColorFactory;  
import org.patchca.filter.predefined.CurvesRippleFilterFactory;
import org.patchca.filter.predefined.DiffuseRippleFilterFactory;
import org.patchca.filter.predefined.DoubleRippleFilterFactory;
import org.patchca.filter.predefined.MarbleRippleFilterFactory;
import org.patchca.filter.predefined.WobbleRippleFilterFactory;  
import org.patchca.service.ConfigurableCaptchaService;  
import org.patchca.utils.encoder.EncoderHelper;  
import org.patchca.word.RandomWordFactory;  
/** 
 * 验证码生成类 
 * 
 * 本类的简要描述： 
 * 使用开源验证码项目patchca生成 
 * jar包：patchca-0.5.0.jar 
 * 项目网址：https://code.google.com/p/patchca/ 
 * 项目中文介绍：http://baike.baidu.com/view/6925997.htm?fromTaglist 
 * 
 */  
  
public class ValidateCode extends HttpServlet {  
	private static ConfigurableCaptchaService cs;
	private static ColorFactory cf ;
	private static RandomWordFactory wf;
	private static CurvesRippleFilterFactory crff;
	private static MarbleRippleFilterFactory mrff;
	private static DoubleRippleFilterFactory drff;
	private static WobbleRippleFilterFactory wrff;
	private static DiffuseRippleFilterFactory dirff;

	@Override
	public void init() throws ServletException {
		super.init();
		cs = new ConfigurableCaptchaService();
		cf = new SingleColorFactory(new Color(25, 60, 170));
		wf = new RandomWordFactory();
		crff = new CurvesRippleFilterFactory(cs.getColorFactory());
		drff = new DoubleRippleFilterFactory();
		wrff = new WobbleRippleFilterFactory();
		dirff = new DiffuseRippleFilterFactory();
		mrff = new MarbleRippleFilterFactory();
		cs.setWordFactory(wf);
		cs.setColorFactory(cf);
		cs.setWidth(120);
		cs.setHeight(50);
	}

	@Override
	public void destroy() {
		wf = null;
		cf = null;
		cs = null;
		super.destroy();
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("image/png");
		response.setHeader("cache", "no-cache");
		wf.setMaxLength(4);
		wf.setMinLength(4);
		HttpSession session = request.getSession();
		OutputStream os = response.getOutputStream();
		Random r = new Random();
		switch (r.nextInt(5)) {
		case 0:
			cs.setFilterFactory(crff);
			break;
		case 1:
			cs.setFilterFactory(mrff);
			break;
		case 2:
			cs.setFilterFactory(drff);
			break;
		case 3:
			cs.setFilterFactory(wrff);
			break;
		case 4:
			cs.setFilterFactory(dirff);
			break;
		}
		String ValidateCode = EncoderHelper.getChallangeAndWriteImage(cs, "png", os);
		session.setAttribute("validateCode", ValidateCode);
		os.flush();
		os.close();
	}
}