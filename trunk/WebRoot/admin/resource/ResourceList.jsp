<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>
<%@include file="/admin/head.jsp" %>
<script>
$(function() {
	$("#rejectDialog").dialog({
		autoOpen: false,
		modal: true,
		width: 380,
		height: 200,
		position: ["center",50],
		buttons: {
			"OK": function() {
				rejectSubmit();
			}
		}
	});
});
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
	f.action="resource_delete.do";
	f.submit();
}
function optRejectAddComment() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	var f = getTableForm();
	f.action="resource_addComment.do";
	f.submit();
}
function optReject() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	$("#rejectDialog").dialog("open");
}


function _gotoPage(pageNo) {
	try{
		var tableForm = getTableForm();
		$("input[name=pageNo]").val(pageNo);
		tableForm.action="resource_list.do";
		tableForm.onsubmit=null;
		tableForm.submit();
	} catch(e) {
		alert('_gotoPage(pageNo)方法出错');
	}
	
}

function optPass() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	var f = getTableForm();
	f.action="resource_pass.do";
	f.submit();
}
function rejectSubmit() {
	$("input[name=notpassreason]").val($("#rejectOpinion").val());
	$("#rejectDialog").dialog("close");
	var f = getTableForm();
	f.action="resource_reject.do";
	f.submit();
}
function chgStatus() {
	var f = getTableForm();
	f.submit();
}
$(function(){
	
	$("select[name=gscatalogid] option[value=<s:property value='#params.gscatalogid[0]' />]").attr("selected",true);
	$("select[name=zycatalogid] option[value=<s:property value='#params.zycatalogid[0]' />]").attr("selected",true);
	$("select[name=queryOrderBy] option[value=<s:property value='#params.queryOrderBy[0]' />]").attr("selected",true);
	$("input[name=ispassed][value=<s:property value='#params.ispassed[0]' />]").attr("checked",true);
	
	$(".hotestTags").click(function(){
		$("input[name=tagname]").val($(this).html());
	}).hover(function(){
		$(this).css({"font-weight":"bolder"});
	},function(){
		$(this).css({"font-weight":"normal"});
	});
});
</script>
<style type="text/css">
.hotestTags{
	padding:0 2px;
	cursor: pointer;
}
table td{
	text-align: center;
}
</style>
</head>
<body>
<div class="box-positon">
	<div class="rpos">当前位置: 资源管理 - 列表</div>
	<form class="ropt"  method="get">
		<input class="add" type="submit" value="添加" onclick="this.form.action='resource_add.do';"/>
		
	</form>
	<div class="clear"></div>
</div>

<div class="body-box">
<form action="resource_list.do" method="post" id="tableForm" style="padding-top:5px;">
<div>
标题: <input type="text" name="title" value="<s:property value="#params.title[0]"/>" style="width:200px"/>
发布者: <input type="text" name="adduser" value="<s:property value="#params.adduser[0]"/>" style="width:150px"/>
资源类型类别:
<select name="gscatalogid"><option value="" selected="selected">--所有类型--</option>
<s:iterator value="#gslist">
<option value="<s:property value="id"/>"><s:property value="name"/></option>
</s:iterator>
</select>
资源专业类别:
<select name="zycatalogid"><option value="" selected="selected">--所有类型--</option>
<s:iterator value="#zylist">
<option value="<s:property value="id"/>"><s:property value="name"/></option>
</s:iterator>
</select>
<select name="queryOrderBy">
<option value="passtime desc">发布时间降</option>
<option value="passtime asc">发布时间升</option>
<option value="downloadnum desc">下载降</option>
<option value="downloadnum asc">下载升</option>
<option value="likenum desc">赞降</option>
<option value="likenum asc">赞升</option>
</select><br/>
关键字: <input type="text" name="tagname" value="<s:property value="#params.tagname[0]"/>" style="width:150px"/>
热门关键字:
<c:forEach items="${requestScope.hotestTags }" var="tname">
	<span class="hotestTags">${tname }</span>
</c:forEach>

<input class="query" type="submit" value="查询"/>
</div>
<div style="padding-top:5px">
<label><input type="radio" name="ispassed" value="" onclick="chgStatus();" checked="checked"/>所有资源</label>
<label><input type="radio" name="ispassed" value="0" onclick="chgStatus();"/>未审核</label>
<label><input type="radio" name="ispassed" value="1" onclick="chgStatus();"/>已通过</label>
<label><input type="radio" name="ispassed" value="-1" onclick="chgStatus();"/>已退回</label>
</div>
<input type="hidden" name="pageNo" value=""/>

<table class="pn-ltable" style="" width="100%" cellspacing="1" cellpadding="0" border="0">
<thead class="pn-lthead"><tr>
	<th width="20"><input type='checkbox' onclick='Pn.checkbox("ids",this.checked)'/></th>
	<th>ID</th>
	<th>标题</th>
	<th>专业类别</th>
	<th>发布者</th>
	<th>赞数</th>
	<th>下载数</th>
	<%-- <th>评论数</th> --%>
	<th>发布时间</th>
	<th>审核</th>
	<th>生成预览</th>
	<th>操作选项</th></tr></thead>
<tbody  class="pn-ltbody">
 <s:iterator id="res" value="#page.rows">
<tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
	<td><input type='checkbox' name='ids' value="${res.id}" /></td>
	<td>${res.id}</td>
	<td style="text-align: left;">		
		<strong>[<s:property value="repGscatalog.name"/>]</strong>
		${res.title}
</td>
	<td><s:property value="repZycatalog.name"/></td>
	<td><s:property value="repAdmin!=null?repAdmin.username:repUser.username"/>
		(<s:property value="uploader"/>)</td>
	<td>${res.likenum}</td>
	<td>${res.downloadnum}</td>
	<%-- <td><s:property value="repComments.size()"/></td> --%>
	<td>	<s:if test="passtime!=null"><s:date name="passtime" format="yyyy-MM-dd HH:mm:ss" /></s:if></td>
	<td>
		<s:property value="ispassed==0?'<font color=red>未审核</font>':''" escapeHtml="false" />
		<s:property value="ispassed==1?'已审核':''" />
		<s:property value="ispassed==-1?'已退回':''" />	
	</td>
	<td>
	<s:property value="translated?'成功':'无'" escapeHtml="false" />
			
	</td>	
	<td>
		<a href="${pageContext.request.contextPath }/view.do?id=${res.id}" target="_blank" class="pn-opt">查看</a> | 		
		<a href="resource_update.do?id=${res.id}" class="pn-opt">修改</a> | 		
		<a href="resource_delete.do?id=<s:property value="id" />" onclick="if(!confirm('您确定删除吗？')) {return false;}" class="pn-opt">删除</a>
	</td>
</tr>
</s:iterator>

</tbody>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"><tr><td align="center" class="pn-sp">
共 <s:property value="#page.records" /> 条&nbsp;
	每页<input type="text" name="pageSize" value="<s:property value="#page.pageSize" />" style="width:30px" onfocus="this.select();" onkeypress="if(event.keyCode==13){$(this).blur();return false;}">条&nbsp;
	<input class="first-page" type="button" value="首 页" onclick="_gotoPage('1');">
	<input class="pre-page" type="button" value="上一页" onclick="_gotoPage('<s:property value="#page.page-1<1?#page.page:#page.page-1" />');">
	<input class="next-page" type="button" value="下一页" onclick="_gotoPage('<s:property value="#page.page+1>#page.total?#page.page:#page.page+1" />');">
	<input class="last-page" type="button" value="尾 页" onclick="_gotoPage(<s:property value="#page.total" />);">&nbsp;
	当前 <s:property value="#page.page" />/<s:property value="#page.total" /> 页 &nbsp;转到第<input type="text" id="_goPs" style="width:50px" onfocus="this.select();" onkeypress="if(event.keyCode==13){$('#_goPage').click();return false;}">页
	<input class="go" id="_goPage" type="button" value="转" onclick="_gotoPage($('#_goPs').val());">
</td></tr></table>
<script type="text/javascript">
function _gotoPage(pageNo) {
	try{
		var tableForm = getTableForm();
		$("input[name=pageNo]").val(pageNo);
		tableForm.action="resource_list.do";
		tableForm.onsubmit=null;
		tableForm.submit();
	} catch(e) {
		alert('_gotoPage(pageNo)方法出错');
	}; 
</script>
<div style="margin-top:15px;">
	<input type="button" value="删除" onclick="optDelete();" class="del-button"/>
	<input type="button" value="通过" onclick="optPass();" class="check"/>
	<input id="rejectButton" type="button" value="退回" onclick="optReject();" class="reject"/>
</div>
<input type="hidden" name="notpassreason" value=""/>
</form>
</div>
<div id="rejectDialog" style="display:none" title="退回原因">
<p>退回原因: <input type="text" id="rejectOpinion" style="width:260px " onkeypress="if(event.keyCode==13){rejectSubmit();return false;}"/></p>
</div>
</body>
</html>