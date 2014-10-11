<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>经管资源库系统</title>
<% String contextpath = request.getContextPath();
request.setAttribute("contextpath", contextpath);
 %>
<link href="${contextpath }/images/logo_icon.jpg" rel="shortcut icon">
</head>
<frameset rows="72,*" frameborder="0" border="0" framespacing="0">
	<frame src="top.jsp" name="topFrame" noresize="noresize" id="leftFrame" />
	<frame src="main.jsp" name="mainFrame" id="mainFrame" />
</frameset>
<noframes><body></body></noframes>
</html>
