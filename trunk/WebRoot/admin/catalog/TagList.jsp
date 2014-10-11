<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>经管资源库系统</title>

<%@include file="/admin/head.jsp" %>

<script type="text/javascript">
function getTableForm() {
	return document.getElementById('tableForm');
}


function optAdd(){
	var f = getTableForm();
	f.action="tag_addui.do";
	f.submit();
}
function optDelete() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	if(!confirm("您确定删除吗？")) {
		return;
	}
	var f = getTableForm();
	f.action="tag_delete.do";
	f.submit();
}

function _gotoPage(pageNo) {
	try{
		var tableForm = getTableForm();
		$("input[name=pageNo]").val(pageNo);
		tableForm.action="tag_list.do";
		tableForm.onsubmit=null;
		tableForm.submit();
	} catch(e) {
		alert('_gotoPage(pageNo)方法出错');
	}
	
}



</script>
</head>
<body>
<div class="box-positon">
	<div class="rpos">当前位置: 资源标签 - 列表</div>
	<div class="clear"></div>
</div>
<div class="body-box">
<form id="tableForm" action="tag_list.do" method="post" style="padding-top:5px;">
<input type="hidden" name="pageNo" value=""/>
<div>

标签名称: 
<input type="text" name="name" value="<s:property value="#params.name[0]" />" style="width:70px">

<select name="queryOrderBy">
<option value="desc" <s:property value="#params.size()==0?'selected=selected':''" /> <s:property value="#params.queryOrderBy[0]=='desc'?'selected=selected':''" />>ID降序</option>
<option value="asc" <s:property value="#params.queryOrderBy[0]=='asc'?'selected=selected':''" />>ID升序</option>
</select>
<input type="hidden" name="id" value="">
<input class="query" type="submit" value="查询">
</div>
<table class="pn-ltable" style="" width="100%" cellspacing="1" cellpadding="0" border="0">
<thead class="pn-lthead"><tr>
	<th width="20"><input type='checkbox' onclick='Pn.checkbox("ids",this.checked)'/></th>
	<th>ID</th>
	<th>标签名称</th>
	<th width="100">操作选项</th></tr></thead>
<tbody  class="pn-ltbody">
<s:iterator value="#page.rows">
<tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
	<td><input type='checkbox' name='ids' value='<s:property value="id" />'/></td>
	<td><s:property value="id" /></td>
	<td><s:property value="name" /></td>
	<td align="center">		<a href="tag_edit.do?id=<s:property value="id" />" class="pn-opt">修改</a> | <a href="tag_delete.do?id=<s:property value="id" />" class="pn-opt" onclick="if(!confirm('您确定删除吗？')) {return false;}">删除</a></td>
</tr>
</s:iterator>

</tbody>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0"><tbody><tr><td align="center" class="pn-sp">
	共 <s:property value="#page.records" /> 条&nbsp;
	每页<input type="text" name="pageSize" value="<s:property value="#page.pageSize" />" style="width:30px" onfocus="this.select();" onkeypress="if(event.keyCode==13){$(this).blur();return false;}">条&nbsp;
	<input class="first-page" type="button" value="首 页" onclick="_gotoPage('1');">
	<input class="pre-page" type="button" value="上一页" onclick="_gotoPage('<s:property value="#page.page-1<1?#page.page:#page.page-1" />');">
	<input class="next-page" type="button" value="下一页" onclick="_gotoPage('<s:property value="#page.page+1>#page.total?#page.page:#page.page+1" />');">
	<input class="last-page" type="button" value="尾 页" onclick="_gotoPage(<s:property value="#page.total" />);">&nbsp;
	当前 <s:property value="#page.page" />/<s:property value="#page.total" /> 页 &nbsp;转到第<input type="text" id="_goPs" style="width:50px" onfocus="this.select();" onkeypress="if(event.keyCode==13){$('#_goPage').click();return false;}">页
	<input class="go" id="_goPage" type="button" value="转" onclick="_gotoPage($('#_goPs').val());">
</td></tr></tbody></table>
<div style="margin-top:15px;">
<input type="button" value="新增" onclick="optAdd();" class="add"/>
&nbsp; <input type="button" value="删除" onclick="optDelete();" class="del-button"/>
</div>
</form>
</div>
</body>
</html>