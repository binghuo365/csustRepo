<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>长沙理工大学教学资源库</title>

<%@ include file="/Reference.jsp" %>
<link href="${contextpath }/css/noticeSecondStyle.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
$(function(){
	/*表单提示*/
	formHint();

	/* 导航动画 */
	navHover(6);
	
	/*图片轮播*/
	mySliderPlay();
	
	/*hotnews 的滚动动画*/
	hotNewsRoll();
	
	/*获取时间信息的方法*/
	getTimeInfo();
	
	/*二三级左侧栏目动画*/
	columnTitleHover(5);
	
	//隐藏太长的分页选择
	pageHide();
	
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
                首页 > 公告中心
            </div>
        </div>
            
            <ul><!--15个li-->
            	<c:forEach items="${page.rows }" var="n">
            	<li>&nbsp;<img src="images/secondLiImg.jpg" />&nbsp;
            		<a href="${contextpath }/viewnotice.do?id=${n.id}">
					${fn:substring(n.title,0,28) }
					<c:set value="${fn:length(n.title) }" var="textlength" ></c:set>
            		<c:if test="${textlength>28 }">..</c:if>
            		</a><span>${fn:substring(n.addtime,0,10) }</span></li>
            	</c:forEach>
            	
            	
            </ul>
         
         <%@ include file="/SecondPageNav.jsp" %>   
         
    </div><!-- rightPart -->
    
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
