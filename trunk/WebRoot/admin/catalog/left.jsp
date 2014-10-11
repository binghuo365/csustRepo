<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<script type="text/javascript">
$(function(){
	Cms.lmenu('lmenu');
});
</script>
</head>
<body class="lbody">
<div class="left">

<%@ include file="/admin/date.jsp" %>
     <ul class="w-lful">
		<li><a href="gscatalog_list.do" target="rightFrame">资源类型类别</a></li>
		<li><a href="zycatalog_list.do" target="rightFrame">资源专业类别</a></li>
		<li><a href="tag_list.do" target="rightFrame">标签管理</a></li>
		<li><a href="topic_list.do" target="rightFrame">专题管理</a></li>
		
     </ul>
</div>
</body>
</html>