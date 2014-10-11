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
	$(".checkboxLabel").each(function(index){
		if((index+1)%6==0){
			$(this).after("<br/>");
		}
	});
	
	
});
</script>
<style type="text/css">
.checkboxLabel{
white-space: nowrap;
}
</style>
</head>
<body>


<iframe name="hiddenIframe" frameborder="0" border="0" style="display:none;width:0px;height:0px;"></iframe><div class="box-positon">
	<div class="rpos">当前位置: 角色管理 - 添加</div>
	<form class="ropt">
		<input type="submit" value="返回列表" onclick="this.form.action='role_list.do';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>

<div class="body-box">
<form method="post" action="role_add.do" id="jvForm">
<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
<tr>

<td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>角色名称:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="100" name="name" value="<s:property value='name' />" class="required"/>
<font color="red"><s:property value='#message' /></font></td>
</tr>

<tr>

<td width="10%" class="pn-flabel pn-flabel-h">角色权限:</td><td colspan="1" width="40%" class="pn-fcontent">
<%-- <s:iterator value="#permissions">

<label><input type="checkbox" value="0" <s:property value='repPermissions.countains()?"checked=checked":""' /> name="islock"/><</label>

</s:iterator> --%>
<s:checkboxlist list="#permissionlist" name="permissionids" listKey="id" listValue="name" value="#selectpermissionlist" theme="simple"></s:checkboxlist>
<font color="red"><s:property value="#permissionsmessage"/></font>
</td>
</tr>
<tr>

<td width="10%" class="pn-flabel pn-flabel-h">角色描述:</td><td colspan="1" width="40%" class="pn-fcontent">
<!-- <input type="text" maxlength="200" name="name" value="" class="required" maxlength="100"/> -->
<textarea rows="10" cols="60" name="description" class="{maxlength:200}"><s:property value='description' /></textarea>
</td>
</tr>


<tr>

<td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>排序权值:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="5" name="sort" value="<s:property value='sort==null?0:sort' />"/>
</td>
</tr>

<tr>
<td colspan="4" class="pn-fbutton">
	<input type="submit" value="提交" class="submit" class="submit"/> &nbsp;
	 <input type="reset" value="重置" class="reset" onclick="javascript:window.location.href='add.jsp'" class="reset"/>
</td>

</tr></table>
</form>
</div>
</body>
</html>