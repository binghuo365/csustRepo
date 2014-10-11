<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>答疑帮助</title>
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
		<li><a href="asks_list.do" target="rightFrame">留言列表</a></li>
     </ul>
</div>
</body>
</html>