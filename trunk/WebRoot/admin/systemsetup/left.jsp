<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>jeecms-left</title>

<%@ include file="/admin/head.jsp" %>
<script type="text/javascript">
$(function(){
	Cms.lmenu('lmenu');
});
function confirmRestart(){
	var b=confirm("重启预览文件生成服务可能导致正在转换的文件转换失败，\n您确定要重启?");
	if(b){
		window.parent.document.getElementsByName("rightFrame").item(0).src="param_restart.do";
	}
}
</script>
</head>
<body class="lbody">
<div class="left">

<%@ include file="/admin/date.jsp" %>
     <ul class="w-lful">
		<li><a href="param_edit.do" target="rightFrame">参数配置</a></li>
		<li><a href="role_list.do" target="rightFrame">角色管理</a></li>
		<li><a href="log_list.do" target="rightFrame">操作日誌</a></li>
		<li><a href="../druid/index.html" target="rightFrame">连接池监控</a></li>
		<li><a href="javascript:;" onclick="confirmRestart()">重启预览文件生成服务</a></li>
     </ul>
</div>
</body>
</html>