<%@page import="com.yunstudio.entity.RepResource"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>长沙理工大学教学资源库</title>
<meta http-equiv="refresh" content="5;URL=/repository/index.do" />

<%@ include file="/Reference.jsp" %>
<link href="${contextpath }/css/thirdStyle.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
$(function(){
	/*表单提示*/
	formHint();

	/*图片轮播*/
	mySliderPlay();
	
	/*获取时间信息的方法*/
	getTimeInfo();
	
	
	/*hotnews 的滚动动画*/
	hotNewsRoll();
	
	/* 导航动画 */
	navHover(6);
	/*二三级左侧栏目动画*/
	columnTitleHover(5);
});
</script>

</head>

<body>

<%@ include file="/Header.jsp" %>
   
   
   <div style="font-size: 24px; text-indent: 2em; 
   		color: #000; line-height: 30px; 
   		padding: 20px; 20px; 100px; 20px;
   		font-family: '微软雅黑','黑体','新宋体';
   			">
   	对不起，服务器出现错误，5s后将跳转主页。
   	如果反复出现这种情况,请反馈给网站管理员。
   </div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
