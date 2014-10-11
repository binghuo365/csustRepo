<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>长沙理工大学经济与管理学院资源管理后台</title>
<% String contextpath = request.getContextPath();
request.setAttribute("contextpath", contextpath);
 %>
<link href="${contextpath }/images/logo_icon.jpg" rel="shortcut icon">
<%@include file="/admin/head.jsp" %>

<script type="text/javascript">
if(top!=this) {
	top.location=this.location;
}
$(function() {
	$("#jvForm").validate();
	$("#resetPasswordForm").fadeOut(0);
	$("#submitResetPasswordForm").click(function(){
		$("form#resetPasswordForm").submit();
	});
});
function showJvForm(){
	$("#resetPasswordForm").fadeOut(600,function(){
		$("#resetPasswordForm").css("display","none");
		$("#jvForm").fadeIn(600);
	});
}
function showResetPasswordForm(){
	$("#jvForm").fadeOut(600,function(){
		$("#jvForm").css("display","none");
		$("#resetPasswordForm").fadeIn(600);
	});
}
</script>
<style type="text/css">
body{margin:0;padding:0;font-size:12px;background:url(res/jeecms/img/login/bg.jpg) top repeat-x;}
.input{width:150px;height:17px;border-top:1px solid #404040;border-left:1px solid #404040;border-right:1px solid #D4D0C8;border-bottom:1px solid #D4D0C8;}
</style>
</head>
<body>

<table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="200">&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="423" height="280" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="res/jeecms/img/login/ltop.jpg" /></td>
              </tr>
              <tr>
                <td><img src="res/jeecms/img/login/llogo.jpg" /></td>
              </tr>
            </table></td>
          <td width="40" align="center" valign="bottom"><img src="res/jeecms/img/login/line.jpg" width="23" height="232" /></td>
          <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="90" align="center" valign="bottom"><img src="res/jeecms/img/login/ltitle.jpg" /></td>
              </tr>
              <tr>
                <td>
				<form id="jvForm" action="admin_login.do" method="post">
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="5">
                   <tr>
                   	<td colspan="2" align="center">
                      <font color="red">${message }</font>
                      </td>
                   </tr>
                   <tr>
                      <td width="91" height="40" align="right"><strong> 用户名：</strong></td>
                      <td width="211"><input name="username" value="<s:property value="#params.username[0]"/>" type="input" id="username" class="{required:true}" maxlength="100" class="input"/>
                      <font color="red"><s:property value="#usernameWrong"/></font>
                      </td>
                      
                    </tr>
                    <tr>
                      <td height="40" align="right"><strong>密码：</strong></td>
                      <td><input name="password" value="<s:property value="#params.username[0]"/>" type="password" id="password" maxlength="32" class="{required:true}" class="input"/>
                      <font color="red"><s:property value="#passwordWrong"/></font>
                      <a href="javascript:;" onclick="showResetPasswordForm();" style="color: #F90;">取回密码</a>
                      </td>
                    </tr>
                    <s:if test="#showValidateCode">
                    	<tr><td></td>
                    	<td><img src="${pageContext.request.contextPath }/validatecode.png" onclick="this.src='${pageContext.request.contextPath }/validatecode.png?'"/></td>
                    	</tr>
	                    <tr>
	                      <td height="40" align="right"><strong>验证码：</strong></td>
	                      <td>
	                      <input name="validatecode" value="<s:property value="#params.validatecode[0]"/>" type="text" id="password" maxlength="32" class="{required:true}" class="input"/>
	                      <font color="red"><s:property value="#validateCodeWrong"/></font>
	                      </td>
	                    </tr>
                    </s:if>
                    <tr>
                      <td height="40" colspan="2" align="center">
					    <input type="image" src="res/jeecms/img/login/login.jpg" name="submit" />
                        &nbsp; &nbsp; <img name="reg" style="cursor: pointer" src="res/jeecms/img/login/reset.jpg" onclick="document.forms[0].reset()" /> </td>
                    </tr>
                  </table>
				</form>
				<form id="resetPasswordForm" action="admin_resetPassword.do" method="post">
				
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="5">
                   <tr>
                      <td width="91" height="40" align="right"><strong> 邮箱：</strong></td>
                      <td width="211"><input name="email" value="<s:property value="#params.email[0]"/>" type="input" id="username" class="{required:true}" maxlength="100" class="input"/>
                      <a href="javascript:;" onclick="showJvForm();" style="color: #F90;">我要登录</a>
                      </td>
                      
                    </tr>
                    <tr>
                      <td height="40" colspan="2" align="center">
					    <img style="cursor: pointer" src="res/jeecms/img/login/resetPassword.gif" onclick="document.forms[1].submit()" />
                        &nbsp; &nbsp; <img name="reg" style="cursor: pointer" src="res/jeecms/img/login/reset.jpg" onclick="document.forms[1].reset()" /> </td>
                    </tr>
                  </table>
				</form>
				
                  </td>
              </tr>
            </table>
           
           </td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
