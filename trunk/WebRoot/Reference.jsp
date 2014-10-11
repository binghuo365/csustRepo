<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<% String contextpath = request.getContextPath();
request.setAttribute("contextpath", contextpath);
 %>
<link href="${contextpath }/css/commons.css" rel="stylesheet" type="text/css"/>
<link href="${contextpath }/images/logo_icon.jpg" rel="shortcut icon">
<script type="text/javascript" src="${contextpath }/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${contextpath }/js/stylePlus.js"></script> 

<!--  图片轮播插件-->
<link href="${contextpath }/pulgins/sliderPlay/sliderPlay.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${contextpath }/pulgins/sliderPlay/jquery-SliderPlay-1.0.min.js"></script>

<!--treeview 插件-->
<link href="${contextpath }/pulgins/jquerytreeview/jquery.treeview.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${contextpath }/pulgins/jquerytreeview/jquery.treeview.js"></script>
<script type="text/javascript" src="${contextpath }/pulgins/jquerytreeview/jquery.cookie.js"></script>

<!-- 自己对jquery.treeview的二次开发的支持checkbox，radio的jquery.treeview.addon插件 -->
<script type="text/javascript" src="${contextpath }/pulgins/jquery_treeview_addon/treeview.addon.js"></script>

<!-- jquery.validate 插件 -->
<script type="text/javascript" src="${contextpath }/pulgins/jqueryvalidate/jquery.validate.min.js"></script>
<script type="text/javascript" src="${contextpath }/pulgins/jqueryvalidate/jquery.metadata.js"></script>
<script type="text/javascript" src="${contextpath }/pulgins/jqueryvalidate/messages_cn.js"></script>
<link href="${contextpath }/pulgins/jqueryvalidate/formvalidate.css" rel="stylesheet" type="text/css"/>

<!-- 日期选择插件 -->
<script src="${contextpath }/thirdparty/jscal/js/jscal2.js"></script>
<script src="${contextpath }/thirdparty/jscal/js/lang/cn.js"></script>
<link rel="stylesheet" type="text/css" href="${contextpath }/thirdparty/jscal/css/jscal2.css" />
<link rel="stylesheet" type="text/css" href="${contextpath }/thirdparty/jscal/css/border-radius.css" />

