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
	
	
	$("select[name='fatherid'] option").eq(0).attr("selected","selected");
	$("select[name='fatherid'] option").each(function(){
		if(this.value=="<s:property value='father.id' />"){
			$("select[name='fatherid'] option").eq(0).removeAttr("selected");
			this.selected=true;
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
	<div class="rpos">当前位置: 类型类别管理 - 添加</div>
	<form class="ropt">
		<input type="submit" value="返回列表" onclick="this.form.action='gscatalog_list.do';" class="return-button"/>
	</form>
	<div class="clear"></div>
</div>

<div class="body-box">
<form method="post" action="gscatalog_update.do" id="jvForm">
<input type="hidden" name="id" value="<s:property value='id' />"/>
<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
<tr>

<td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>类型类别名称:</td><td colspan="1" width="40%" class="pn-fcontent">
<input type="text" maxlength="100" name="name" value="<s:property value='name' />" class="required"/>
<font color="red"><s:property value='#message' /></font></td>
</tr>

<tr>

<td width="10%" class="pn-flabel pn-flabel-h">父级分类的名称:</td><td colspan="1" width="40%" class="pn-fcontent">
<select name="fatherid">
	<option value="">无</option>
<s:iterator value="#gscatalogs">
	<option value="<s:property value='id' />"><s:property value='name' /></option>
</s:iterator>
</select>

</td>
</tr>
<tr>

<td width="10%" class="pn-flabel pn-flabel-h">类型类别描述:</td><td colspan="1" width="40%" class="pn-fcontent">
<!-- <input type="text" maxlength="200" name="name" value="" class="required" maxlength="100"/> -->
<textarea rows="10" cols="60" name="description" class="{maxlength:200}"><s:property value='description' /></textarea>
</td>
</tr>



<tr>
<td colspan="4" class="pn-fbutton">
	<input type="submit" value="提交" class="submit" class="submit"/> &nbsp;
	 <input type="reset" value="重置" class="reset" onclick="javascript:window.location.href='gscatalog_addui.do'" class="reset"/>
</td>

</tr></table>
</form>
</div>
</body>
</html>