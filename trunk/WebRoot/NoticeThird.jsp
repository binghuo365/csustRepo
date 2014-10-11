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
   <%@ include file="/SecondLeft.jsp" %>
    
    <div class="rightPart">
    	<div class="secondTitle">
        	<div class="sTitle">
            	<img src="images/secondTArrow.jpg" />
                公告中心
            </div>
            <div class="catalog">
            	<img src="images/secondHome.jpg" style="position:relative; top:3px; left:0;"  />
                首页 > 公告中心 > 新闻查看
            </div>
        </div>
            
          <div class="docTitle">
        	${m.title }
        </div>
        <div class="docInfo">
        	时间：${fn:substring(m.addtime,0,19) }  发布人：${m.author } 浏览次数：${m.viewtimes }
            <div style="clear:both;"></div>
        </div>
        <div style="padding: 0 20px;">
        ${m.content }
       	
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
        	<b>上一篇：</b>
            <c:choose>
            	<c:when test="${mprev==null }">
            	<span>没有了。</span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            	</c:when>
            	<c:otherwise>
            	 <a href="${contextpath }/viewnotice.do?id=${mprev.id}">
            	 ${fn:substring(mprev.title,0,23) }
				<c:set value="${fn:length(mprev.title) }" var="textlength" ></c:set>
         		<c:if test="${textlength>23 }">...</c:if>
            	 </a>
            	</c:otherwise>
            </c:choose>
        	<b>下一篇：</b>
            <c:choose>
            	<c:when test="${mnext==null }">
            	<span>没有了。</span>
            	</c:when>
            	<c:otherwise>
            	 <a href="${contextpath }/viewnotice.do?id=${mnext.id}">
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
