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
});
</script>
</head>
<body>


<iframe name="hiddenIframe" frameborder="0" border="0" style="display:none;width:0px;height:0px;"></iframe><div class="box-positon">
	<div class="rpos">当前位置: 系统配置 - 参数设置</div>
	<div class="clear"></div>
</div>

<div class="body-box">
<form method="post" action="param_update.do" id="jvForm">
<input type="hidden" name="id" value="<s:property value='id' />"/>
<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
<tr>


<td width="10%" class="pn-flabel pn-flabel-h">老师注册是否需要审核:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="tisneedpass" value="0" <s:property value='tisneedpass==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="tisneedpass" value="1" <s:property value='tisneedpass==1?"checked=checked":""' />/>需要</label></td>
</tr>


<tr>


<td width="10%" class="pn-flabel pn-flabel-h">学生注册是否需要审核:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="sisneedpass" value="0" <s:property value='sisneedpass==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="sisneedpass" value="1" <s:property value='sisneedpass==1?"checked=checked":""' />/>需要</label></td>
</tr>


<tr>


<td width="10%" class="pn-flabel pn-flabel-h">老师上传是否需要审核:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="tuploadneedpass" value="0" <s:property value='tuploadneedpass==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="tuploadneedpass" value="1" <s:property value='tuploadneedpass==1?"checked=checked":""' />/>需要</label></td>
</tr>


<tr>


<td width="10%" class="pn-flabel pn-flabel-h">学生上传是否需要审核:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="suploadneedpass" value="0" <s:property value='suploadneedpass==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="suploadneedpass" value="1" <s:property value='suploadneedpass==1?"checked=checked":""' />/>需要</label></td>
</tr>


<%-- <tr>


<td width="10%" class="pn-flabel pn-flabel-h">老师评论是否需要审核:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="tctneedpass" value="0" <s:property value='tctneedpass==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="tctneedpass" value="1" <s:property value='tctneedpass==1?"checked=checked":""' />/>需要</label></td>
</tr>


<tr>


<td width="10%" class="pn-flabel pn-flabel-h">学生评论是否需要审核:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="sctneedpass" value="0" <s:property value='sctneedpass==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="sctneedpass" value="1" <s:property value='sctneedpass==1?"checked=checked":""' />/>需要</label></td>
</tr>

<tr>


<td width="10%" class="pn-flabel pn-flabel-h">请求帮助是否需要审核:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="askneedpass" value="0" <s:property value='askneedpass==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="askneedpass" value="1" <s:property value='askneedpass==1?"checked=checked":""' />/>需要</label></td>
</tr>
 --%>


<tr>


<td width="10%" class="pn-flabel pn-flabel-h">游客是否可以下载:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="visitordownload" value="0" <s:property value='visitordownload==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="visitordownload" value="1" <s:property value='visitordownload==1?"checked=checked":""' />/>需要</label></td>
</tr>

<tr>


<td width="10%" class="pn-flabel pn-flabel-h">下载是否需要积分:</td><td colspan="1" width="40%" class="pn-fcontent">
<label><input type="radio" name="dloadneedpoints" value="0" <s:property value='dloadneedpoints==0?"checked=checked":""' />/>不需要</label>
<label><input type="radio" name="dloadneedpoints" value="1" <s:property value='dloadneedpoints==1?"checked=checked":""' />/>需要</label></td>
</tr>


<tr>


<td width="10%" class="pn-flabel pn-flabel-h">上传所支持的文件后缀名格式类型以及对应的最大上传大小
（文件大小的单位为MB,用逗号和分号分隔,如:<font color=red>doc:10,xls:5</font>）:</td><td colspan="1" width="40%" class="pn-fcontent">
<textarea rows="4" cols="80" name="format"><s:property value='format' /></textarea>
</td>
</tr>






<tr>
<td colspan="4" class="pn-fbutton">
	<input type="submit" value="提交" class="submit" class="submit"/> &nbsp;
	 <input type="reset" value="重置" class="reset" onclick="javascript:window.location.href='param_edit.do?id=<s:property value="id" />'" class="reset"/>
</td>

</tr></table>
</form>
</div>
</body>
</html>