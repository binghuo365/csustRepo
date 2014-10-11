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
		   phone: {
		   	digits:true
		   },
		   qq: {
		   	digits:true
		   }
		  }
	}); 
	/*注册表单样式以及行为的函数。*/
	formStyle();
	
	$("input[name='gender'][value='${user.gender}']").attr("checked",true);
	$("input[name='tos'][value='${user.teacherorstu}']").attr("checked",true);
	$("select[name='school'] option[value='${user.school}']").attr("selected",true);
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
    <form action="userOpt_update.do" method="post" id="signinForm" class="userForm">
         <table border="0" width="100%">
			<tbody>	
          
		
			<tr>
				<td width="150" class="right" valign="top">真实姓名：</td>
				<td><input type="text" name="realname" class="inputBox" value="${user.realname }" maxlength="50">
					<div style="height:5px;width:2px;"></div></td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">性别：</td>
				<td>
					<label><input type="radio" value="1" name="gender">男</label> 
					<label><input type="radio" value="2" name="gender">女</label> 
					<label><input type="radio" value="0" checked="checked" name="gender">保密</label>
					<div style="height:5px;width:2px;"></div>
				</td>
				
			</tr>
			<tr>
				<td width="150" class="right" valign="top">类别：</td>
				<td>
					<label><input type="radio" value="1" name="tos" disabled="disabled">学生</label>
					<label><input type="radio" value="2" name="tos" disabled="disabled">老师</label>
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
				<td><input type="text" maxlength="30" name="major" class="inputBox"
						 value="${user.major }">
					<div style="height:5px;width:2px;"></div></td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">qq：</td>
				<td><input type="text" maxlength="30" class="inputBox" 
						value="${user.qq }" name="qq">
					<div style="height:5px;width:2px;"></div></td>
			</tr>
			<tr>
				<td width="150" class="right" valign="top">手机号码：</td>
				<td><input type="text" maxlength="30" name="phone" class="inputBox"
						 value="${user.phone }">
					<div style="height:5px;width:2px;"></div></td>
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
