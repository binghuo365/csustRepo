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

function optDelete() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	if(!confirm("您确定删除吗？")) {
		return;
	}
	var f = getTableForm();
	f.action="log_delete.do";
	f.submit();
}


function _gotoPage(pageNo) {
	try{
		var tableForm = getTableForm();
		$("input[name=pageNo]").val(pageNo);
		tableForm.action="log_list.do";
		tableForm.onsubmit=null;
		tableForm.submit();
	} catch(e) {
		alert('_gotoPage(pageNo)方法出错');
	}
	
}
$(function(){

	
	$("select[name='adminid'] option").eq(0).attr("selected","selected");
	$("select[name='adminid'] option").each(function(){
		if(this.value=="<s:property value="#params.adminid[0]" />"){
			$("select[name='adminid'] option").eq(0).removeAttr("selected");
			this.selected=true;
		}
	});
	
	$("select[name='operationtype'] option").eq(0).attr("selected","selected");
	$("select[name='operationtype'] option").each(function(){
		if(this.value=="<s:property value="#params.operationtype[0]" />"){
			$("select[name='operationtype'] option").eq(0).removeAttr("selected");
			this.selected=true;
		}
	});
	
      Calendar.setup({
        inputField : "starttime",
        trigger    : "starttime",
        showTime   : true,
        dateFormat : "%Y-%m-%d %H:%M:%S",
        //align :"bottom",
    	onSelect   : function() {  },onTimeChange  : function(cal) {	var h = cal.getHours(), m = cal.getMinutes(); if (h < 10) h = "0" + h; if (m < 10) m = "0" + m; cal.inputField.value=cal.date.getFullYear()+"-"+(cal.date.getMonth()+1)+"-"+(cal.date.getDate())+" "+h+":"+m+":00"; }
      });
	
      Calendar.setup({
        inputField : "endtime",
        trigger    : "endtime",
        showTime   : true,
        dateFormat : "%Y-%m-%d %H:%M:%S",
        //align :"bottom",
    	onSelect   : function() {  },onTimeChange  : function(cal) {	var h = cal.getHours(), m = cal.getMinutes(); if (h < 10) h = "0" + h; if (m < 10) m = "0" + m; cal.inputField.value=cal.date.getFullYear()+"-"+(cal.date.getMonth()+1)+"-"+(cal.date.getDate())+" "+h+":"+m+":00"; }
      });
});

</script>
</head>
<body>
<div class="box-positon">
	<div class="rpos">当前位置: 系统配置 - 操作日志 - 列表</div>
	<div class="clear"></div>
</div>
<div class="body-box">
<form id="tableForm" action="log_list.do" method="post" style="padding-top:5px;">
<input type="hidden" name="pageNo" value=""/>
<div>

操作人: 
<select name="adminid" style="width:80px;">
<option value="">全部</option>
<s:iterator value="#admins">
<option value="<s:property value="id" />" ><s:property value="username" /></option>
</s:iterator>
</select>
操作类型: 
<select name="operationtype" style="width:70px;">
       <option value="">全部</option>
       <option value="登录">登录</option>
       <option value="新增">新增</option>
       <option value="删除">删除</option>
       <option value="修改">修改</option>
       <option value="其他">其他</option>
</select>
操作内容: <input type="text" name="description" value="<s:property value="#params.description[0]" />" style="width:100px">

操作ip: <input type="text" name="operationip" value="<s:property value="#params.operationip[0]" />" style="width:70px">

操作时间:从:<input type="text" id="starttime" name="starttime" value="<s:property value="#params.starttime[0]" />" style="width:120px"> 
到:<input type="text" id="endtime" name="endtime" value="<s:property value="#params.endtime[0]" />"  style="width:120px"> 

<select name="queryOrderBy">
<option value="desc" <s:property value="#params.size()==0?'selected=selected':''" /> <s:property value="#params.queryOrderBy[0]=='desc'?'selected=selected':''" />>ID降序</option>
<option value="asc" <s:property value="#params.queryOrderBy[0]=='asc'?'selected=selected':''" />>ID升序</option></select>
<input type="hidden" name="id" value="">
<input class="query" type="submit" value="查询">
</div>
<table class="pn-ltable" style="" width="100%" cellspacing="1" cellpadding="0" border="0">
<thead class="pn-lthead"><tr>
	<th width="20"><input type='checkbox' onclick='Pn.checkbox("ids",this.checked)'/></th>
	<th>ID</th>
	<th>操作人</th>
	<th>操作类型</th>
	<th>操作内容</th>
	<th>操作ip</th>
	<th>操作时间</th></tr></thead>
<tbody  class="pn-ltbody">
<s:iterator value="#page.rows">
<tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
	<td><input type='checkbox' name='ids' value='<s:property value="id" />'/></td>
	<td><s:property value="id" /></td>
	<td><s:property value="operator"/><s:property value="repAdmin==null&&operator!='System'?<font color=red>(该管理员已被删除)</font>':''" escapeHtml="false"/></td>
	<td><s:property value="operationtype" /></td>
	<td><s:property value="description" /></td>
	<td><s:property value="operationip" /></td>
	<td>
	<s:if test="operationtime!=null"><s:date name="operationtime" format="yyyy-MM-dd HH:mm:ss" /></s:if>
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
</div>
</form>
</div>
</body>
</html>