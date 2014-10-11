<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
  <head>
    
    <title>在线阅读</title>
        <style type="text/css" media="screen"> 
html, body { height:100%; }
body { margin:0; padding:0; overflow:auto; }   
#flashContent { display:none; }
        </style> 
 
	   <%@include file="/admin/head.jsp"%>
      
<script charset="utf-8"	src="${pageContext.request.contextPath}/thirdparty/officetranslate/js/flexpaper_flash_debug.js"></script>
<script charset="utf-8"	src="${pageContext.request.contextPath}/thirdparty/officetranslate/js/flexpaper_flash.js"></script>
  </head>
  
  <body>
    <div style="position:absolute;left:200px;top:10px;">
        <a id="viewerPlaceHolder" style="width:1000px;height:800px;display:block"></a>
        
        <script type="text/javascript">
      var fp = new FlexPaperViewer(
			 '../../thirdparty/officetranslate/FlexPaperViewer',
			 'viewerPlaceHolder', { config : {
			 SwfFile : escape('${requestScope.swfpath}'),
			 Scale : 0.6, 
			 ZoomTransition : 'easeOut',
			 ZoomTime : 0.5,
			 ZoomInterval : 0.2,
			 FitPageOnLoad : true,
			 FitWidthOnLoad : false,
			 PrintEnabled : false,
			 FullScreenAsMaxWindow : false,
			 ProgressiveLoading : true,
			 MinZoomSize : 0.2,
			 MaxZoomSize : 5,
			 SearchMatchAll : false,
			 InitViewMode : 'Portrait',
			 
			 ViewModeToolsVisible : true,
			 ZoomToolsVisible : true,
			 NavToolsVisible : true,
			 CursorToolsVisible : true,
			 SearchToolsVisible : true,
			  
			    localeChain: 'zh_CN'
			 }});
        </script>
        
        
        </div>
   </body>
</html>
