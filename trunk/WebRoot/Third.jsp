<%@page import="com.yunstudio.entity.RepParam"%>
<%@page import="com.yunstudio.service.impl.ParamServiceImpl"%>
<%@page import="com.yunstudio.service.ParamService"%>
<%@page import="com.yunstudio.struts.action.user.ThirdAction"%>
<%@page import="com.yunstudio.utils.StringUtil"%>
<%@page import="com.yunstudio.utils.ViewOfficeTools"%>
<%@page import="com.yunstudio.entity.RepResource"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>长沙理工大学教学资源库</title>

<%@ include file="/Reference.jsp" %>
<link href="${contextpath }/css/thirdStyle.css" rel="stylesheet" type="text/css"/>

<script charset="utf-8"	src="${pageContext.request.contextPath}/thirdparty/officetranslate/js/flexpaper_flash_debug.js"></script>
<script charset="utf-8"	src="${pageContext.request.contextPath}/thirdparty/officetranslate/js/flexpaper_flash.js"></script>
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
	
	var catalogid=${m.repGscatalog!=null?m.repGscatalog.id:'0'};
	switch(catalogid)
	{ 
		case 1:
				$(".sTitle").append("在线文库");
				$(".catalog").append("在线文库 > 在线预览");
				/* 导航动画 */
				navHover(1);
				/*二三级左侧栏目动画*/
				columnTitleHover(0);
				break;
		case 2:
				$(".sTitle").append("视频教程");
				$(".catalog").append("视频教程 > 在线播放");
				/* 导航动画 */
				navHover(2);
				/*二三级左侧栏目动画*/
				columnTitleHover(1);
				break;
		case 3:
			$(".sTitle").append("教学软件");
			$(".catalog").append("教学软件 > 软件详情");
			/* 导航动画 */
			navHover(4);
			/*二三级左侧栏目动画*/
			columnTitleHover(3);
			break;
		case 4:
			$(".sTitle").append("图文教材");
			$(".catalog").append("图文教材 > 教程详情");
				/* 导航动画 */
				navHover(5);
				/*二三级左侧栏目动画*/
				columnTitleHover(4);
				break;
		default:
			break;
			
	}
	
	if(catalogid==0||catalogid>4){
			$(".sTitle").append("综合搜索");
			$(".catalog").append("综合搜索 > 资源详情");
			/* 导航动画 */
			navHover(3);
			/*二三级左侧栏目动画*/
			columnTitleHover(2);
	}
	<%
		RepParam configParam=ParamServiceImpl.params;
		request.setAttribute("configParam", configParam);
		configParam.getDloadneedpoints();
	%>
		$("#downloadFile").click(function(){
			var b=true;
			<c:if test="${configParam.dloadneedpoints==1&&admin==null}">
		 		b=warnPoints(${m.pointsneed });
		 	</c:if>
		 	if(b){
				window.location.href="download.do?id="+${m.id };
		 	}
		});
	
	
<%
	Set<Integer> set=(Set<Integer>) session.getAttribute("liked");
	RepResource resource1=(RepResource)request.getAttribute("m");
	
	if(set!=null&&set.contains(resource1.getId())){
		resource1.setLikenum(resource1.getLikenum()-1);
		%>$("#zanBtn").html("已赞(${m.likenum+1 })");<%
	}
%>
	
});

$(window).load(function(){
	if($("#topimg").width()>700){
		$("#topimg").css("width","700");
	}else{
		$("#topimg").css("margin-top","20px")
					.css("margin-bottom","50px");
	}
});
function zan(i){
	$.get("zan.do",{id:i},function(data){
		var zanBtn=$("#zanBtn");
		if(data=="notlogin"){
			zanBtn.html("未登录");
		}else if(data=="add"){
			zanBtn.html("已赞(${m.likenum+1 })");
		}else if(data=="remove"){
			zanBtn.html("赞(${m.likenum })");
		}
	});
}
</script>

</head>

<body style="position: relative;">
<%@ include file="/Header.jsp" %>
   <%@ include file="/SecondLeft.jsp" %>
    
    <div class="rightPart">
    	<div class="secondTitle">
        	<div class="sTitle">
            	<img src="images/secondTArrow.jpg" />
                
            </div>
            <div class="catalog">
            	<img src="images/secondHome.jpg" style="position:relative; top:3px; left:0;"  />
                首页 > 
            </div>
        </div>
            
          <div class="docTitle">
        	${m.title }
        </div>
        <div class="docInfo">
    
			<%
				RepResource m=(RepResource)request.getAttribute("m");
				String lengthMbStr=null;
				if(m!=null){
					lengthMbStr=((Double)(m.getLength()/1024.0/1024.0)).toString();
					String[] lenMbStr=lengthMbStr.split("\\.");
					if(lenMbStr.length>1){
						lengthMbStr=lenMbStr[0]+"."+((lenMbStr[1].length()<4)?lenMbStr[1]:lenMbStr[1].substring(0, 3));
					}
				}
			 %>
        
        	时间：${fn:substring(m.addtime,0,19) } 上传者：${m.repUser==null?m.repAdmin.realname:m.repUser.username } 文件大小：<%=lengthMbStr %>MB 下载量：${m.downloadnum } 
        	
			<c:if test="${configParam.dloadneedpoints==1}">
        	下载所需积分:${m.pointsneed }分
        	</c:if>
			<c:if test="${configParam.dloadneedpoints==0}">
        	下载所需积分:0分
        	</c:if>
        	<a href="javascript:;" onclick="zan(${m.id});" 
        	style="background: url('<%=contextpath%>/images/zan.png') no-repeat left center ; padding-left: 20px; ">
        	
        	<span id="zanBtn" style="color: orange;">赞(${m.likenum })</span></a>
            <div style="clear:both;"></div>
        </div>
        
        <div style="padding: 0 20px;">
	        	<!-- <img src="images/docView.jpg" /> --> 
	        	<% if(!ViewOfficeTools.newInstance().isOffice(m.getPath())&&!m.getPath().endsWith("pdf")){ %> 
	        			<%if(ThirdAction.isImg(m.getPath())){ %>
	        				<img src="<%=contextpath %>${m.path }" style="margin: 10 auto;" alt="" id="topimg"/>
	        			<%}else if(m.getPath().endsWith("swf")||m.getPath().endsWith("swfl")){%>
	        			
	        			<script src="Scripts/swfobject_modified.js" type="text/javascript"></script>
	        				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="644" height="500" style="margin: 10 auto;"  id="FlashID" title="xxx">
							  <param name="movie" value="<%=contextpath %>${m.path }" />
							  <param name="quality" value="high" />
							  <param name="wmode" value="opaque" />
							  <param name="swfversion" value="8.0.35.0" />
							  <!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->
							  <param name="expressinstall" value="Scripts/expressInstall.swf" />
							  <!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->
							  <!--[if !IE]>-->
							  <object type="application/x-shockwave-flash" data="<%=contextpath %>${m.path }" width="644" height="500" style="margin: 10 auto;" >
							    <!--<![endif]-->
							    <param name="quality" value="high" />
							    <param name="wmode" value="opaque" />
							    <param name="swfversion" value="8.0.35.0" />
							    <param name="expressinstall" value="Scripts/expressInstall.swf" />
							    <!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->
							    <div>
							      <h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
							      <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="获取 Adobe Flash Player" width="112" height="33" /></a></p>
							    </div>
							    <!--[if !IE]>-->
							  </object>
							  <!--<![endif]-->
							</object>
							<script type="text/javascript">
							swfobject.registerObject("FlashID");
							</script>
	        			<%}else if(m.getPath().endsWith("wmv")){%>
	        				<object id="mediaplayer" width="644" height="500" classid="clsid:22d6f312-b0f6-11d0-94ab-0080c74c7e95" standby="loading windows media player components..." type="application/x-oleobject">
								<param name="filename" value="${contextpath }${m.path}"/>
								<param name="showcontrols" value="true"/>
								<param name="showstatusbar" value="false"/>
								<param name="showdisplay" value="false"/>
								<param name="autostart" value="false"/>
								<embed type="application/x-mplayer2" src="${contextpath }${m.path}" name="mediaplayer" width="644" height="500" showcontrols="1" showstatusbar="0" showdisplay="0" autostart="0"> </embed>
							</object>
	        			
	        			<%}else if(ThirdAction.isVideo(m.getPath())){ %>
					<script type="text/javascript" src="js/offlights.js"></script>
	        		
					<div id="video" style="position:relative;z-index: 100;width:644px;height:500px; margin: 10px auto;"><div id="a1"></div></div>
						<script type="text/javascript" src="ckplayer/ckplayer.js" charset="utf-8"></script>
						<script type="text/javascript">
							var flashvars={
								f:'<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +contextpath%>${m.path}',
								c:0,
								b:1
								};
							var params={bgcolor:'#FFF',allowFullScreen:true,allowScriptAccess:'always'};
							CKobject.embedSWF('ckplayer/ckplayer.swf','a1','ckplayer_a1','600','400',flashvars,params);
							/*
							CKobject.embedSWF(播放器路径,容器id,播放器id/name,播放器宽,播放器高,flashvars的值,其它定义也可省略);
							下面三行是调用html5播放器用到的
							*/
							//var video=['<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextpath%>${m.path}->video/mp4'];
							//var support=['iPad','iPhone','ios','android+false','msie10+false','webKit'];
							//CKobject.embedHTML5('video','ckplayer_a1',600,400,video,flashvars,support);
						  </script>
											
	        			<% }else{ %>
	        				<img src="<%=contextpath %>${m.topimg }" alt="" style="margin: 10px auto;" id="topimg"/>
	        			<%} %>
	        	<%	}else if(!m.isTranslated()){ %>
	        	
	        	<div class="docView" id="docView">对不起，此资源暂时没有预览。</div>
	        	<style>
	        		#docView{
	        			height:100px;
	        		}
	        	</style>
	        	<%}else{ %>
	        <div style="margin-left: 40px;">预览前20页:</div>
	        <div class="docView" id="docView"></div>
	        	<script type="text/javascript">
	      var fp = new FlexPaperViewer(
				 '${contextpath}/thirdparty/officetranslate/FlexPaperViewer',
				 'docView', { config : {
				 SwfFile : escape('${contextpath}${m.translateurl}'),
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
	        <% } %>
	        	 
	        
	        <div class="downloadDoc">
	        <a href="javascript:;" id="downloadFile"><img src="images/download.jpg" width="93" height="48" /></a>&nbsp;&nbsp;&nbsp;&nbsp;
	        <a href="collect.do?id=${m.id }"><img src="images/collect.jpg" width="93" height="48" /></a>
	        </div>
	        
	        <div style="text-indent: 2em; color: #999; font-size: 12px; font-style: oblique;margin: 10px 20px; font-family: '黑体'">
	        	${m.description }
	        </div>
	        <div class="docDescri">
	        	<span>[资源详情]</span>
	           ${m.content }
	        </div>
	       	
	        <div style="height:50px;"></div>
	        	<!-- Baidu Button BEGIN -->
	            <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
	            <a class="bds_qzone"></a>
	            <a class="bds_tsina"></a>
	            <a class="bds_tqq"></a>
	            <a class="bds_renren"></a>
	            <a class="bds_t163"></a>
	            <span class="bds_more"></span>
	            <a class="shareCount"></a>
	            </div>
	            <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=1510536" ></script>
	            <script type="text/javascript" id="bdshell_js"></script>
	            <script type="text/javascript">
	          	  document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
	            </script>
	            <!-- Baidu Button END -->
	        <div class="docPage">
	        	<b>上一资源：</b>
	            <c:choose>
	            	<c:when test="${mprev==null }">
	            	<span>没有了。</span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	            	</c:when>
	            	<c:otherwise>
		            <a href="${contextpath }/view.do?id=${mprev.id}">
					${fn:substring(mprev.title,0,23) }
					<c:set value="${fn:length(mprev.title) }" var="textlength" ></c:set>
		         	<c:if test="${textlength>23 }">...</c:if>
					</a>
					</c:otherwise>
				</c:choose>
	        	<b>下一资源：</b>
	            <c:choose>
	            	<c:when test="${mnext==null }">
	            	<span>没有了。</span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	            	</c:when>
	            	<c:otherwise>
		            <a href="${contextpath }/view.do?id=${mnext.id}">
					${fn:substring(mnext.title,0,23) }
					<c:set value="${fn:length(mnext.title) }" var="textlength" ></c:set>
		         	<c:if test="${textlength>23 }">...</c:if>
					</a>
				</c:otherwise>
				</c:choose>
	        </div>
          </div>  
    </div><!-- rightPart -->
    
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
