<%@page import="com.yunstudio.entity.RepResource"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>长沙理工大学教学资源库-注册页面</title>

<%@ include file="/Reference.jsp" %>
<link href="${contextpath }/css/listTextSecondStyle.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
$(function(){
	/*表单提示*/
	formHint();

	/*图片轮播*/
	mySliderPlay();
	
	/*获取时间信息的方法*/
	getTimeInfo();
	
	
	/*hotnews 的滚动动画*/
	hotNewsRoll();
	
	navHover(0);
	/*二三级左侧栏目动画*/
	columnTitleHover(10);
	
	/*注册表单样式以及行为的函数。*/
	formStyle();
	
	
	$("#signinForm").validate({
		rules: {
		   username: {
		   	required:true,
		   	maxlength:20,
		   	minlength:4
		   },
		   email: {
		    required: true,
		    email: true
		   },
		   password: {
		    required: true,
		    minlength: 6,
		   	maxlength:50
		   },
		   confirm_password: {
		    required: true,
		    minlength: 6,
		   	maxlength:50,
		    equalTo: "#password"
		   },
		   validateCode: {
		    required: true,
		   	maxlength:10
		   },
		   phone: {
		   	digits:true
		   },
		   qq: {
		   	digits:true
		   }
		  }
	}); 
	
	$("#validateCode").focus(function(){
		if($("#validateCodeImg").attr("src")==""
			||$("#validateCodeImg").attr("src")==null){
			$("#validateCodeImg").attr("src","<%=contextpath%>/validatecode.png");
		}
	});
	
	$("#validateCodeImg").click(function(){
		$(this).attr("src","<%=contextpath%>/validatecode.png");
	});
	
	$("input[name='gender'][value='${params.gender[0]}']").attr("checked",true);
	$("input[name='teacherorstu'][value='${params.teacherorstu[0]}']").attr("checked",true);
	$("select[name='school'] option[value='${params.school[0]}']").attr("selected",true);
});
</script>
</head>

<body>

<%@ include file="/Header.jsp" %>
   <%@ include file="/SecondLeft.jsp" %>
    
    <div class="rightPart">
    	<div class="secondTitle">
        	<div class="sTitle">
            	<img src="images/secondTArrow.jpg" />
                用户注册
            </div>
            <div class="catalog">
            	<img src="images/secondHome.jpg" style="position:relative; top:3px; left:0;"  />
                首页 > 用户注册
            </div>
        </div>
            
          <form action="userOpt_signin.do" method="post" id="signinForm" name="signinForm" class="userForm">
         <table border="0" width="100%">
			<tbody>			<tr>
				<td class="right" valign="top"><dfn>*</dfn>登录名：</td>
				<td>
					<div class="oneline">
					<input type="text" name="username" 
						class="inputBox" value="${params.username[0] }" maxlength="20"  />
						<span style="color: red;">${username_message}</span>
					</div>
					<div class="twoline">
						（4～20个字符，支持中文、英文、数字、"_"、"-"）
					</div>							
				</td>
			</tr>
			<tr>
				<td class="right" valign="top"><dfn>*</dfn>密码：</td>
				<td>
					<div class="oneline">
						<input type="password" id="password" name="password" 
							class="inputBox" maxlength="50" value="${params.password[0] }"  />
					</div><div class="clear"></div>
					<div class="twoline">
						（为了您帐户的安全，建议使用字符+数字等多种不同类型的组合，且长度大于6位。）
					</div>
								
				</td>
			</tr>
			
			<tr>
				<td class="right" valign="top"><dfn>*</dfn>再次输入密码：</td>
				<td>
					<div class="oneline">
						<input type="password" name="confirm_password" 
							class="inputBox" value="${params.confirm_password[0] }" maxlength="50"  />
						<span style="color: red;">${confirm_password_message}</span>
					</div>
					<div class="twoline">
                        （确保您记住密码。）
					</div>
								
				</td>
			</tr>
			
			<tr>
				<td width="150" class="right" valign="top"><dfn>*</dfn>E-mail：</td>
				<td>
					<div class="oneline">
						<input type="text" name="email" 
							class="inputBox" value="${params.email[0] }"  maxlength="50"/>
						<span style="color: red;">${email_message}</span>
					</div>
					<div class="twoline">
						（有效的E-mail地址才能取回密码。）
					</div>
								
				</td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">真实姓名：</td>
				<td><input type="text" name="realname" 
					class="inputBox" value="${params.realname[0] }" maxlength="50"/>
					<div style="height:5px;width:2px;"></div></td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">性别：</td>
				<td>
					<label><input type="radio" 
						value="1" name="gender" />男</label> 
					<label><input type="radio" 
						value="2" name="gender" />女</label> 
					<label><input type="radio" 
						value="0" checked="checked" name="gender" />保密</label>
					<div style="height:5px;width:2px;"></div>
				</td>
				
			</tr>
			<tr>
				<td width="150" class="right" valign="top">类别：</td>
				<td>
					<label><input type="radio" value="1" checked="checked" name="teacherorstu" />学生</label>
					<label><input type="radio" value="2" name="teacherorstu" />老师</label>
					<div style="height:5px;width:2px;"></div>
				</td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">学院：</td>
				<td>
					<select name="school" class="loginSelect">
					       <option value="经济与管理学院">经济与管理学院</option>
					       <option value="交通运输工程学院">交通运输工程学院</option>
					       <option value="土木与建筑学院">土木与建筑学院</option>
					       <option value="汽车与机械工程学院">汽车与机械工程学院</option>
					       <option value="电气与信息工程学院">电气与信息工程学院</option>
					       <option value="计算机与通信工程学院">计算机与通信工程学院</option>
					       <option value="能源与动力工程学院">能源与动力工程学院</option>
					       <option value="马克思主义学院">马克思主义学院</option>
					       <option value="文法学院">文法学院</option>
					       <option value="数学与计算科学学院">数学与计算科学学院</option>
					       <option value="设计艺术学院">设计艺术学院</option>
					       <option value="物理与电子科学学院">物理与电子科学学院</option>
					       <option value="化学与生物工程学院">化学与生物工程学院</option>
					       <option value="水利工程学院">水利工程学院</option>
					       <option value="外国语学院">外国语学院</option>
					       <option value="体育教学部">体育教学部</option>
					       <option value="城南学院">城南学院</option>
					       <option value=" 继续教育学院">继续教育学院</option>
					</select>
					<div style="height:5px;width:2px;"></div>
				</td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">专业：</td>
				<td><input type="text" maxlength="30" name="major" 
					class="inputBox" value="${params.major[0] }"   />
					<div style="height:5px;width:2px;"></div></td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">qq：</td>
				<td><input type="text" maxlength="30" 
					class="inputBox" value="${params.qq[0] }"   name="qq"/>
					<div style="height:5px;width:2px;"></div></td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">手机号码：</td>
				<td><input type="text" maxlength="30" name="phone"	 
					class="inputBox" value="${params.phone[0] }"   />
					<div style="height:5px;width:2px;"></div></td>
			</tr>
			
			<tr>
				<td class="right" valign="top"><dfn>*</dfn>校验码：</td>
				<td>
					<div class="oneline">
						<input type="text" id="validateCode" 
							name="validateCode" class="inputBox"  maxlength="10" />
						<span style="color: red;">${validateCode_message}</span>
					</div><div style="clear:both;"></div>
					<div style="font-size:12px;">
						（如果您连续输入不对验证码，请检查您的浏览器是否禁用了Cookie。）
					</div>
				</td>
			</tr>
			<tr id="tr_vc" style="">
				<td class="right" valign="top"></td>
				<td><img id="validateCodeImg" 
					src="" style="display:inline; vertical-align:middle" /> 
				<a id="aRecode" href="javascript:$('#validateCodeImg').attr('src','<%=contextpath %>/validatecode.png?');" class="font_gray">看不清，换一张</a></td>
			</tr>
			<tr>
				<td colspan="2">
				<button class="submitBtn" onclick="submitForm($('#signinForm'))">注册</button>
				</td>
			</tr>
		</tbody></table>
		</form>
    </div><!-- rightPart -->
    
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
