<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    
	<%@ include file="/Reference.jsp" %>

	<link href="${contextpath }/usercenter/usershow.css" rel="stylesheet" type="text/css"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
<script type="text/javascript">
$(function(){
	$("#signinForm").validate({
		rules: {
		   newpassword: {
		    required: true,
		    minlength: 6,
		   	maxlength:50
		   },
		   confirm_password: {
		    required: true,
		    minlength: 6,
		   	maxlength:50,
		    equalTo: "#newpassword"
		   }
		}
	}); 
	/*注册表单样式以及行为的函数。*/
	formStyle();
	
});
</script>

<style type="text/css">
.inputBox{
	height: auto;
}
</style>
  </head>
  
  <body>
  <div style="color: red; margin-left: 240px;">${message }</div>
    <form action="userOpt_updatePassword.do" method="post" id="signinForm" class="userForm">
         <table border="0" width="100%">
			<tbody>	
            <tr>
				<td class="right" valign="top"><dfn>*</dfn>原来的密码：</td>
				<td>
					<div class="oneline">
						<input type="password" id="oldpassword" name="oldpassword" class="inputBox" maxlength="50" value="">
						<span style="color: red;">${oldpassword_message}</span>
					</div>
								
				</td>
			</tr>	
  			<tr>
				<td class="right" valign="top"><dfn>*</dfn>新密码：</td>
				<td>
					<div class="oneline">
						<input type="password" id="newpassword" name="newpassword" class="inputBox" maxlength="50" value="">
						<span style="color: red;">${newpassword_message}</span>
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
						<input type="password" id="confirm_password" name="confirm_password" class="inputBox" value="" maxlength="50">
						<span style="color: red;">${confirm_password_message}</span>
					</div>
					<div class="twoline">
                        （确保您记住密码。）
					</div>
								
				</td>
			</tr>
		
			<tr>
				<td colspan="2">
				<button class="submitBtn" onclick="submitForm($('#signinForm'))">保存</button>
				</td>
			</tr>
		</tbody></table>
		</form>
  </body>
</html>
