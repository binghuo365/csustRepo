<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>

<%@include file="/admin/head.jsp" %>

<script type="text/javascript">
$(function() {
	$("#jvForm").validate();
	
	
	
	$("select[name='roleid'] option").eq(0).attr("selected","selected");
	$("select[name='roleid'] option").each(function(){
		if(this.value=="<s:property value='RepRole.id' />"){
			$("select[name='roleid'] option").eq(0).removeAttr("selected");
			this.selected=true;
		}
	});
	
	$("select[name='school'] option").eq(0).attr("selected","selected");
	$("select[name='school'] option").each(function(){
		if(this.value=="<s:property value='school' />"){
			$("select[name='school'] option").eq(0).removeAttr("selected");
			this.selected=true;
		}
	});
});
</script>
</head>
<body>


<iframe name="hiddenIframe" frameborder="0" border="0" style="display:none;width:0px;height:0px;"></iframe><div class="box-positon">
	<div class="rpos">当前位置: 管理员管理 - 修改</div>
	<form class="ropt">
		<input type="submit" value="返回列表" onclick="this.form.action='admin_list.do';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>

<div class="body-box">
<form method="post" action="admin_update.do" id="jvForm">
<input type="hidden" name="id" value="<s:property value="id" />" />
<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
<tr>

<td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>用户名:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="100" name="username" value="<s:property value='username' />" class="required" maxlength="100"/>
<font color="red"><s:property value='#message' /></font></td>


<td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>密码(不能查看，只能重置):</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="30" name="password" value="" maxlength="30"/></td></tr>
<tr>



<td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>邮箱:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="255"  class="required email" value="<s:property value='email' />" name="email" size="35" maxlength="255"/></td>



<td width="10%" class="pn-flabel pn-flabel-h">锁定:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" value="0" <s:property value='#params==null?"checked=checked":""' /> <s:property value='islock=="0"?"checked=checked":""' /> name="islock"/>未锁定</label>
<label><input type="radio" <s:property value='islock==1?"checked=checked":""' /> value="1" name="islock"/>锁定</label></td></tr>
<tr>




<td width="10%" class="pn-flabel pn-flabel-h">角色:</td><td colspan="1" width="40%" class="pn-fcontent">
<select name="roleid">
<s:iterator value="#roles">
	<option value="<s:property value='id' />"><s:property value='name' /></option>
</s:iterator>
</select>
</td>

<td width="10%" class="pn-flabel pn-flabel-h">性别:</td><td  width="40%" class="pn-fcontent">
<label><input type="radio" value="1" <s:property value='gender==1?"checked=checked":""' /> name="gender"/>男</label> 
<label><input type="radio" value="2" <s:property value='gender==2?"checked=checked":""' /> name="gender"/>女</label> 
<label><input type="radio" value="0" <s:property value='gender==0?"checked=checked":""' /> name="gender"/>保密</label>
</td></tr>
<tr>





<td width="10%" class="pn-flabel pn-flabel-h">真实姓名:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="255" value="<s:property value='realname' />" name="realname" value="<s:property value='realname' />" size="10" maxlength="255"/></td>

<td width="10%" class="pn-flabel pn-flabel-h">学号/教师编号:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="30" name="snumber" value="<s:property value='snumber' />" class="digits" maxlength="30"/>
</td></tr>



<tr>


<td width="10%" class="pn-flabel pn-flabel-h">学院:</td><td colspan="1" width="40%" class="pn-fcontent">
<%-- <input type="text" maxlength="30" name="school" value="<s:property value='school' />" maxlength="30"/> --%>
<select name="school" style="width:150px;">
       <option value="经济与管理学院">经济与管理学院</option>
       <option value="交通运输工程学院">交通运输工程学院</option>
       <option value="土木与建筑学院">土木与建筑学院</option>
       <option value="汽车与机械工程学院">汽车与机械工程学院</option>
       <option value="电气与信息工程学院" >电气与信息工程学院</option>
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
</td>

<td width="10%" class="pn-flabel pn-flabel-h">专业:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="30" name="major" value="<s:property value='major' />" maxlength="30"/>
</td>

</tr>



<tr>



<td width="10%" class="pn-flabel pn-flabel-h">qq:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="30" class="digits" value="<s:property value='qq' />" name="qq" maxlength="30"/></td>

<td width="10%" class="pn-flabel pn-flabel-h">手机号码:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="30" class="digits" name="phone" value="<s:property value='phone' />" maxlength="30"/>
</td></tr>



<tr>



<td width="10%" class="pn-flabel pn-flabel-h">上次登录ip:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="30" class="digits" value="<s:property value='lastloginip' />" disabled="disabled" maxlength="30"/></td>

<td width="10%" class="pn-flabel pn-flabel-h">上次登录时间:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="30" class="digits" value="<s:if test="lastlogintime!=null"><s:date name="lastlogintime" format="yyyy-MM-dd HH:mm:ss" /></s:if>" disabled="disabled" maxlength="30"/>
</td></tr>



<tr>
<td colspan="4" class="pn-fbutton">
	<input type="submit" value="提交" class="submit" class="submit"/> &nbsp;
	 <input type="reset" value="重置" class="reset" onclick="javascript:window.location.href='admin_edit.do?id=<s:property value="id" />'" class="reset"/>
</td>

</tr></table>
</form>
</div>
</body>
</html>