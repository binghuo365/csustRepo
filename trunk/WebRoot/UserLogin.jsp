<%@page import="com.yunstudio.entity.RepResource"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>长沙理工大学教学资源库</title>

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
	
	
	$("#loginBox").validate({
		rules: {
		   username: {
		   	required:true,
		   	maxlength:20,
		   	minlength:4
		   },
		   password: {
		    required: true,
		    minlength: 6,
		   	maxlength:50
		   }
		  }
	}); 
	$("#emailBox").validate({
		email: {
			    required: true,
			    email: true
			   }
	});
	$(".rightPart").height($(".leftPart").height());
	
});

</script>

<style type="text/css">
.rightPart{
	overflow: hidden;
	position: relative;
}
.formBox{
	width: 1510px;
	position: absolute;
	top: 40px;
	left: 0;
}
#loginBox{
	float: left;
}
#emailBox{
	float: right;
}
</style>
</head>

<body>

<%@ include file="/Header.jsp" %>
   <%@ include file="/SecondLeft.jsp" %>
    
    <div class="rightPart">
    	<div class="secondTitle">
        	<div class="sTitle">
            	<img src="images/secondTArrow.jpg" />
                用户登录
            </div>
            <div class="catalog">
            	<img src="images/secondHome.jpg" style="position:relative; top:3px; left:0;"  />
                首页 > 用户登录
            </div>
        </div>
         <div class="formBox"> 
          <form action="userOpt_login.do" method="post" id="loginBox" name="loginBox" class="userForm">
         <table border="0" width="100%">
			<tbody>			<tr>
				<td class="right" valign="top"><dfn>*</dfn>登录名：</td>
				<td>
					<input type="text" name="username" 
						class="inputBox" value="${params.username[0] }" maxlength="20"  />
						<span style="color: red;">${username_message}</span>
				</td>
			</tr>
			<tr>
				<td class="right" valign="top"><dfn>*</dfn>密码：</td>
				<td>
					<input type="password" id="password" name="password" 
					class="inputBox" maxlength="50" value="${params.password[0] }"  />
						<span style="color: red;">${password_message}</span>
					<a href="javascript:;" onclick="showEmail();" style="color: red;">不记得密码了?</a>
				</td>
			</tr>
			
			
			<tr>
				<td colspan="2">
				<button class="submitBtn" onclick="submitSigninForm($('#loginForm'))">登录</button>
				</td>
			</tr>
		</tbody></table>
		</form>
		
		
         <form action="userOpt_login.do" method="post" id="emailBox" class="userForm" name="findEmailForm">
			<table>
				<tr>
					<td width="150" class="right" valign="top">E-mail：</td>
					<td>
						<input type="text" name="email" 
							class="inputBox" value="${params.email[0] }"  maxlength="50"/>
						<span style="color: red;">${email_message}</span>
					<a href="javascript:;" onclick="showLogin();" 
						style="color: red;">想起密码了，我要登录</a>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
					<button class="submitBtn" 
						onclick="submitForm($('#resetPassswordForm'))">重置密码</button>
					</td>
				</tr>
				
			</table>
		</form>
		<div style="clear: both;"></div>
		</div>
    </div><!-- rightPart -->
    
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
