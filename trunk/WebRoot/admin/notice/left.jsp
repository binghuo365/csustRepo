<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>资源管理系统--公告管理jeecms-left</title>
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
			<li><a href="notice_list.do" target="rightFrame">公告列表</a></li>
			<li><a href="notice_add.do" target="rightFrame">添加公告</a></li>
 	    </ul>
	</div>
</body>
</html>