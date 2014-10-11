<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<body>
  	    <div class="box-positon">
        	 <h1>当前位置: 首页 - 欢迎页</h1>
        </div>
<div class="body-box">
        <div class="welcom-con">
        	 <div class="we-txt">
             	  <p>
                  欢迎使用Repository资源管理系统！<br />
                  Repository程序版本： Repository【<a href="http://www.yunstudio.net" target="_blank">查看最新版本</a>】<br />
                  您上次登录的时间是：<c:if test="${lastlogintime!=null }">
${fn:substring(lastlogintime,0,19) }
</c:if><br />
                  您上次登录的IP是：${lastloginip }<br />
                  已用内存：<span style="color:#0078ff;">${sysInfo.usingMemory }G</span>&nbsp;&nbsp;&nbsp;&nbsp;
                  剩余内存：<span style="color:#ff8400;">${sysInfo.leftMemory }G </span>&nbsp;&nbsp;&nbsp;&nbsp;
                  最大内存：<span style="color:#00ac41;">${sysInfo.totalMemory }G</span>
                  </p>
             </div>
             <ul class="ms">
             	<li class="wxx">访问量</li><li class="attribute">　　　系统属性</li>
             </ul>
             <div class="ms-xx">
                 <div class="xx-xx">
             	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
             	       <tr>
                        <td width="20%" height="30" align="right"></td>
                        <td width="25%"><b>资源上传量</b></td>
                    </tr>
                      <tr>
                        <td height="30" align="right">今日：</td>
                     	<td>${rCount.todayUpload }</td>
                    </tr>
                      <tr>
                        <td height="30" align="right">昨日：</td>
                     	<td>${rCount.yesterdayUpload }</td>
                    </tr>
                      <tr>
                        <td height="30" align="right">本周：</td>
                     	<td>${rCount.weekUpload }</td>
                    </tr>
                      <tr>
                        <td height="30" align="right">本月：</td>
                     	<td>${rCount.monthUpload }</td>
                     </tr>
                     <tr>
                        <td height="30" align="right">累计：</td>
                     	<td>${rCount.totalUpload }</td>
                     </tr>
               </table>
                 </div>
                 <div class="attribute-xx" style="float:left">
                 	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="30%" height="30" align="right">操作系统版本：</td>
                            <td height="30"><span class="black">${sysInfo.osinfo } </span></td>
                        </tr>
                          <tr>
                            <td width="30%" height="30" align="right">操作系统类型：</td>
                            <td height="30"><span class="black">${sysInfo.cpuType }</span> </td>
                        </tr>
                          <tr>
                            <td width="30%" height="30" align="right">用户、目录、临时目录：</td>
                            <td height="30"><span class="black">${sysInfo.sysUser }, ${sysInfo.tomCatDir }, ${sysInfo.tomCatTempDir }</span></td>
                        </tr><tr>
                            <td width="30%" height="30" align="right">JAVA运行环境：</td>
                            <td height="30"><span>${sysInfo.javaRuntimeNameInfo }</span></td>
                          </tr>
                          <tr>
                            <td width="30%" height="30" align="right">JAVA虚拟机：</td>
                            <td height="30"> <span>${sysInfo.javaVmInfo }</span></td>
                        </tr>
                          <tr>
                            <td width="30%" height="30" align="right">资源所在硬盘信息：</td>
                            <td height="30"> <span>
                            	${sysInfo.diskInfo }
                            </span></td>
                        </tr>
                   </table>  
               </div>

             </div>
             
  </div>
</body>
</html>