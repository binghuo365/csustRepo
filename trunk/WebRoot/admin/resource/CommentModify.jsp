<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title></title>

<%@include file="/admin/head.jsp" %>
<%@include file="/admin/thirdpartinclude.jsp"%>
<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="content"]', {
				cssPath : '${pageContext.request.contextPath}/thirdparty/kindeditor/plugins/code/prettify.css',
				uploadJson : '${pageContext.request.contextPath}/thirdparty/kindeditor/jsp/upload_json.jsp',
				fileManagerJson : '${pageContext.request.contextPath}/thirdparty/kindeditor/jsp/file_manager_json.jsp',
				allowFileManager : true
			});
			prettyPrint();
		K('#add-picture').click(function () {
	            var topimg = $("#topimg");
	            editor1.loadPlugin('image', function () {
	                editor1.plugin.imageDialog({
	                    clickFn: function (url, title, width, height, border, align) {
	                        var div = K('#topimgdiv');
	                        div.html("");
	                        div.append('<div style=\"float:left;width:60px;\"><div><img style=\"height:100px;width:100px;\" src="' + url + '" title="' + title + '" /></div><div><a href=\"javascript:delimg()\">删除</a></div></div>');
							topimg.val(url);
	                        editor1.hideDialog();
	                    }
	                });
	            });
	        });
		});
		$(function() {
			$("#jvForm").validate();
			$("input[name=ispassed][value=<s:property value='ispassed' />]").attr("checked",true);
			if($("input[name=ispassed]:checked").val()=='-1'){
				$("span.notpassreason").css("display","inline");
			}else{
				$("span.notpassreason").css("display","none");
			}
			
			$("input[name=ispassed]").click(function(){
				if($("input[name=ispassed]:checked").val()=='-1'){
					$("span.notpassreason").css("display","inline");
				}else{
					$("span.notpassreason").css("display","none");
				}
			});
			
					
		      Calendar.setup({
		        inputField : "passtimeStr",
		        trigger    : "passtimeStr",
		        showTime   : true,
		        dateFormat : "%Y-%m-%d %H:%M:%S",
		        //align :"bottom",
		    	onSelect   : function() {  },onTimeChange  : function(cal) {	var h = cal.getHours(), m = cal.getMinutes(); if (h < 10) h = "0" + h; if (m < 10) m = "0" + m; cal.inputField.value=cal.date.getFullYear()+"-"+(cal.date.getMonth()+1)+"-"+(cal.date.getDate())+" "+h+":"+m+":00"; }
		      });
			
		});
		
		
</script>
</head>

<body>
<iframe name="hiddenIframe" frameborder="0" border="0" style="display:none;width:0px;height:0px;"></iframe>
<div class="box-positon">
	<div class="rpos">当前位置: 资源评论管理 - 修改</div>
	<form class="ropt">
		<input type="submit" value="返回列表"
			onclick="this.form.action='comment_list.do';" class="return-button" />
	</form>
	<div class="clear"></div>
</div>

<div class="body-box">
<form method="post" action="comment_update.do" id="jvForm">
<input type="hidden" name="id" value="<s:property value="id"/>"/>
<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
	
	<tr id="tr-title">
		<td width="10%" class="pn-flabel pn-flabel-h"><span class="pn-frequired">*</span>资源标题:</td>
		<td colspan="3" width="90%" class="pn-fcontent">
			<input type="text" maxlength="150" value="<s:property value='repResource.title'/>" class="required" disabled="disabled"/>
		</td>
	</tr>
	
	<tr id="tr-author">
		<td width="10%" class="pn-flabel pn-flabel-h">评论者:</td>
		<td colspan="3" width="40%" class="pn-fcontent">
			<input type="text" maxlength="100" value="<s:property value='repUser.username'/>" maxlength="100" disabled="disabled"/>
		</td>
	</tr>
	
	<tr id="tr-author">
		<td width="10%" class="pn-flabel pn-flabel-h">评论时间:</td>
		<td colspan="3" width="40%" class="pn-fcontent">
			<input type="text" maxlength="100" value="<s:if test="addtime!=null"><s:date name="addtime" format="yyyy-MM-dd HH:mm:ss" /></s:if>" maxlength="100" disabled="disabled"/>
		</td>
	</tr>
	<tr id="tr-author">
		<td width="10%" class="pn-flabel pn-flabel-h">通过审核时间:</td>
		<td colspan="3" width="40%" class="pn-fcontent">
			<input class="Wdate" type="text" maxlength="100" id="passtimeStr" name="passtimeStr" value="<s:if test="passtime!=null"><s:date name="passtime" format="yyyy-MM-dd HH:mm:ss" /></s:if>" maxlength="100" />
		</td>
	</tr>
	
	<tr id="tr-ispassed">	
	<td width="10%" class="pn-flabel pn-flabel-h">是否通过审核:</td>
	<td width="40%" class="pn-fcontent">
		<label><input type="radio" name="ispassed" value="0" onclick="chgStatus();"/>未审核</label>
		<label><input type="radio" name="ispassed" value="1" onclick="chgStatus();"/>已通过</label>
		<label><input type="radio" name="ispassed" value="-1" onclick="chgStatus();"/>已退回</label>
		&nbsp;&nbsp;&nbsp;<span class="notpassreason" style="display: none;">未通过审核的原因: <input type="text" name="notpassreason" value="<s:property value="notpassreason"/>"/></span>
	</td>
	</tr>	


	<tr id="tr-txt">
		<td class="pn-flabel pn-flabel-h" width="10%">内容:</td>
		<td colspan="3" width="90%" class="pn-fcontent">
			<textarea class="ckeditor" cols="100" rows="20" id="content" name="content"><s:property value="content"/></textarea>
		</td>
	</tr>

	<tr-operation>
		<td colspan="4" class="pn-fbutton">
		<input type="hidden" name="cid" value="11" /> 
		<input type="submit" value="提交" class="submit" class="submit" />&nbsp; 
		<input type="reset" value="重置" class="reset" class="reset" />
		</td>
	</tr>
	
	<div style="color:red">
    <s:fielderror />
</div>
</table>
</form>
</div>
</body>
</html>