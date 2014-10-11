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

<%@include file="/admin/head.jsp" %>
<script type="text/javascript">
$(function(){
	Cms.lmenu('lmenu');
});
</script>
</head>
<body class="lbody">
<div class="left">
<div class="date">
 <span>现在时间： 
 	<script language="javascript">
       var day="";
       var month="";
       var ampm="";
       var ampmhour="";
       var myweekday="";
       var year="";
       mydate=new Date();
       myweekday=mydate.getDay();
       mymonth=mydate.getMonth()+1;
       myday= mydate.getDate();
       year= mydate.getFullYear();
       if(myweekday == 0)
       weekday=" 星期日 ";
       else if(myweekday == 1)
       weekday=" 星期一 ";
       else if(myweekday == 2)
       weekday=" 星期二 ";
       else if(myweekday == 3)
       weekday=" 星期三 ";
       else if(myweekday == 4)
       weekday=" 星期四 ";
       else if(myweekday == 5)
       weekday=" 星期五 ";
       else if(myweekday == 6)
       weekday=" 星期六 ";
       document.write(year+"年"+mymonth+"月"+myday+"日 "+weekday);
      </script>
 </span>
</div>      <ul class="w-lful">
		<li><a href="welcome_edit.do" target="rightFrame">个人资料</a></li>
		
     </ul>
</div>
</body>
</html>