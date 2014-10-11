<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>JEECMS Administrator's Control Panel - powered by jeecms</title>
<link href="res/jeecms/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="res/common/css/theme.css" rel="stylesheet" type="text/css"/>
<link href="res/common/css/jquery.validate.css" rel="stylesheet" type="text/css"/>
<link href="res/common/css/jquery.treeview.css" rel="stylesheet" type="text/css"/>
<link href="res/common/css/jquery.ui.css" rel="stylesheet" type="text/css"/>

<link href="${contextpath }/images/logo_icon.jpg" rel="shortcut icon">
<script src="/thirdparty/fckeditor/fckeditor.js" type="text/javascript"></script>
<!-- <script src="/thirdparty/My97DatePicker/WdatePicker.js" type="text/javascript"></script> -->
<script src="res/common/js/jquery.js" type="text/javascript"></script>
<script src="res/common/js/jquery.ext.js" type="text/javascript"></script>
<script src="res/common/js/pony.js" type="text/javascript"></script>
<script src="res/jeecms/js/admin.js" type="text/javascript"></script><style type="text/css">        
*{margin:0;padding:0}
a:focus {outline:none;}
html{height:100%;overflow:hidden;}
body{height:100%;}
#top{ background-color:#1d63c6; height:69px; width:100%;}
.logo{width:215px; height:69px;}
.topbg{background:url(res/jeecms/img/admin/top-tbg.png) no-repeat; height:38px;}
.login-welcome{padding-left:20px; color:#fff; font-size:12px;background:url(res/jeecms/img/admin/topbg.gif) no-repeat;}
.login-welcome a:link,.login-welcome a:visited{color:#fff; text-decoration:none;}

#welcome {color: #FFFFFF;padding: 0 30px 0 5px;}
#logout {color: #FFFFFF; padding-left: 5px;}

.nav{height:31px; overflow:hidden;}
.nav-menu{background:url(res/jeecms/img/admin/bg.png) repeat-x; height:31px; list-style:none; padding-left:20px; font-size:14px;}
.nav .current {background: url(res/jeecms/img/admin/navcurrbg.gif) no-repeat 0px 2px; color:#fff; width:72px; text-align:center;} 
.nav .current a{color:#fff;}
.nav-menu li {height:31px;text-align:center; line-height:31px; float:left; }
.nav-menu li a{color:#2b2b2b; font-weight:bold;display:block;line-height:31px;height:31px;}
.nav-menu li.sep{background: url(res/jeecms/img/admin/step.png) no-repeat; width:2px; height:31px; margin:0px 5px;}
.nav .normal{padding:0 5px; text-align:center; width:72px;}
.top-bottom{width:100%; background: url(res/jeecms/img/admin/bg.png) repeat-x 0px -34px; height:3px;}
.undis{display:none;}
.dis{display:block;}
</style>

<script type="text/javascript">
function g(o){
	return document.getElementById(o);
}
function HoverLi(m,n,counter){
	for(var i=1;i<=counter;i++){
		g('tb_'+m+i).className='normal';
	}
	g('tb_'+m+n).className='current';
}
</script>

</head>

<body>
<div id="top">
     <div class="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="215"><div class="logo"><img src="res/jeecms/img/admin/logo.png" width="215" height="69" /></div></td>
            <td valign="top">
                <div class="topbg">
                     <div class="login-welcome">
                             <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="420" height="38">
                                    <img src="res/jeecms/img/admin/welconlogin-icon.png"/><span id="welcome">您好, ${admin.username }</span>
                                    <img src="res/jeecms/img/admin/loginout-icon.png"/><a href="admin_logout.do" target="_top" id="logout" onclick="return confirm('您确定退出吗？');">退出</a>　　
                                    
                                    </td>
                                    <td align="right">

                                    </td>
                                    <td width="180">

                                    </td>
                                  </tr>
                                </table>
                       </div>  
                     <div class="nav">
                     	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td style="background-image:url('res/jeecms/img/admin/nav-left.png')" width="14" height="31"></td>
                                <td>
                                	<ul class="nav-menu">
                                    	<li class="current" id="tb_11" onclick="HoverLi(1,1,6);"><a href="main.jsp" target="mainFrame">首页</a></li>
										<li class="sep"></li><li class="normal" id="tb_12" onclick="HoverLi(1,2,6);"><a href="resource/main.jsp" target="mainFrame">资源管理</a></li>
										<li class="sep"></li><li class="normal" id="tb_13" onclick="HoverLi(1,3,6);"><a href="catalog/main.jsp" target="mainFrame">类别维护</a></li>
										<li class="sep"></li><li class="normal" id="tb_14" onclick="HoverLi(1,4,6);"><a href="user/main.jsp" target="mainFrame">用户管理</a></li>
										<li class="sep"></li><li class="normal" id="tb_15" onclick="HoverLi(1,5,6);"><a href="notice/main.jsp" target="mainFrame">公告管理</a></li>
										<%--<li class="sep"></li><li class="normal" id="tb_16" onclick="HoverLi(1,6,7);"><a href="asks/main.jsp" target="mainFrame">答疑帮助</a></li> --%>
										<li class="sep"></li><li class="normal" id="tb_16" onclick="HoverLi(1,6,6);"><a href="systemsetup/main.jsp" target="mainFrame">系统配置</a></li>
                                    </ul>
                                </td>
                              </tr>
                            </table>
                     </div>  
                </div>
          </tr>
        </table>
     </div>
</div>
<div class="top-bottom"></div>
</body>
</html>