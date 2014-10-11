<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>答疑帮助</title>
<%@include file="/admin/head.jsp" %>
<script type="text/javascript">
function getTableForm() {
	return document.getElementById('tableForm');
}
function optAdd(){
	var f = getTableForm();
	f.action="asks_add.do";
	f.method="get";
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
	f.action="asks_delete.do";
	f.submit();
}
function optPass() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	var f = getTableForm();
	f.action="asks_pass.do";
	f.submit();
}
function chgStatus() {
	var f = getTableForm();
	f.submit();
}

function _gotoPage(pageNo) {
	try{
		var tableForm = getTableForm();
		$("input[name=pageNo]").val(pageNo);
		tableForm.action="asks_list.do";
		tableForm.onsubmit=null;
		tableForm.submit();
	} catch(e) {
		alert('_gotoPage(pageNo)方法出错');
	}
	
}

$(function(){

	$("input[name=ispassed]").eq(0).attr("checked",true);	
	$("input[name=ispassed][value=<s:property value='#params.ispassed[0]'/>]").attr("checked",true);
	
	$("select[name=isreplied] option").eq(0).attr("checked",true);	
	$("select[name=isreplied] option[value=<s:property value='#params.isreplied[0]'/>]")
		.attr("selected",true);
	
	$("select[name=queryOrderBy] option").eq(0).attr("checked",true);	
	$("select[name=queryOrderBy] option[value=<s:property value='#params.queryOrderBy[0]'/>]")
		.attr("selected",true);

});
</script>
</head>
<body>

<div class="box-positon">
	<div class="rpos">当前位置: 内容管理 - 列表</div>
	<div class="clear"></div>
</div>

<div class="body-box">
<form id="tableForm" action="asks_list.do" method="post" style="padding-top:5px;">
<input type="hidden" name="pageNo" value=""/>
<div>
标题: <input type="text" name="title" value="<s:property value="#params.title[0]" />" style="width:100px"> 
留言者: <input type="text" name="adduser" value="<s:property value="#params.adduser[0]"/>" style="width:70px"/>
是否回复:<select name="isreplied">
<option value=""   >全部</option>
<option value="0" >未回复</option>
<option value="1" >已回复</option></select>
排序方法<select name="queryOrderBy">
	<option value="desc" >ID降序</option>
	<option value="asc" >ID升序</option>
	<option value="addtime_desc" >发布时间降</option>
	<option value="addtime_asc" >发布时间升</option>
	</select>
<input type="hidden" name="id" value=""/>
<input class="query" type="submit" value="查询"/>
</div>

<div style="padding-top:5px">
	<label><input type="radio" name="ispassed" value="" onclick="chgStatus();"  >全部</label>
	<label><input type="radio" name="ispassed" value="0" onclick="chgStatus();" >未发布</label>
	<label><input type="radio" name="ispassed" value="1" onclick="chgStatus();" >发布</label>
</div>

<table class="pn-ltable" style="" width="100%" cellspacing="1" cellpadding="0" border="0">
<thead class="pn-lthead"><tr>
	<th width="20"><input type='checkbox' onclick='Pn.checkbox("ids",this.checked)'/></th>
	<th>ID</th>
	<th>标题</th>
	<th>留言者</th>
	<th>留言时间</th>
	<th>回复的管理员</th>
	<th>回复者</th>
	<th>回复时间</th>
	<th>发布状态</th>
	<th>回复状态</th>
	<th>操作选项</th></tr>
</thead>

<tbody  class="pn-ltbody">
<s:iterator value="#page.rows">
<tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
	<td><input type='checkbox' name='ids' value='<s:property value="id" />'/></td>
	<td><s:property value="id" /></td>
	<td><s:property value="title" /></td>
	<td align="center">
	<s:if test="asker!=null">
	
		<s:if test="asker == '管理员'">
			<font color="red">管理员</font>
		</s:if>
		<s:else>
			<s:property value="asker"/>
		</s:else>
	</s:if>
	<s:else>
		<s:property value="user.username" /></td>
	</s:else>
	<td align="center"><s:if test="addtime!=null"><s:date name="addtime" format="yyyy-MM-dd HH:mm:ss" /></s:if></td>
	<td align="center"><s:property value="repAdmin.username" /></td>
	<td align="center"><s:property value="replyer" /></td>
	<td align="center"><s:if test="reptime!=null"><s:date name="reptime" format="yyyy-MM-dd HH:mm:ss" /></s:if></td>
	<td align="center"><s:property value="ispassed==1?'发布':'<font color=red>未发布</font>'" escapeHtml="false" /></td>
	<td align="center"><s:property value="repcontent!=null?'回复':'<font color=red>未回复</font>'" escapeHtml="false" /></td>
	<td align="center">
		<a href="asks_edit.do?id=<s:property value="id" />" class="pn-opt">修改</a> | 		
		<a href="asks_delete.do?id=<s:property value="id" />" class="pn-opt" onclick="if(!confirm('您确定删除吗？')) {return false;}">删除</a> |
		<a href="asks_reply.do?id=<s:property value="id" />" class="pn-opt">回复</a> |
		<%-- <a href="asks_replyEdit.do?id=<s:property value="id" />" class="pn-opt">修改回复</a> --%>
	</td>
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
	<input type="button"  value="添加" onclick="optAdd();" class="add"/>
	<input type="button" value="删除" onclick="optDelete();" class="del-button"/>
	<input type="button" value="发布" onclick="optPass();" class="submit"/>
</div>
</form>
</div>

</body>
</html>