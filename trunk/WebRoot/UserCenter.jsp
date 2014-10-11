<%@page import="com.yunstudio.entity.RepResource"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>长沙理工大学教学资源库-用户中心</title>

<%@ include file="/Reference.jsp" %>
<link href="${contextpath }/css/usercenter.css" rel="stylesheet" type="text/css"/>

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
	
	navHover(10);
	
	
	usercenterColumnHover(0);
	$(".lbox1Li a").each(function(index, element) {
      	$(".lbox1Li a").eq(index).click(function(e) {
		/*二三级左侧栏目动画*/ 
			usercenterColumnHover(index);
	    }); 
    });
	/*注册表单样式以及行为的函数。*/
	formStyle();
	
	
	var folderJsonArray=${folderjsonarray==null?'[]':folderjsonarray };
	
	// 专业类别的treeview
	$("#collectFolder").treeview_addon({
			jsonArray:folderJsonArray,
			leavesTag:"a",/*just like the treeview support, you can use a or span, */
			aHref:"${contextpath}/userOpt_listFolderInside.do?id=", 
			target:"usershow"
	});
	
	/* $("#collectFolder li a").click(function(){
		$("#collectFolder li a").css("text-decoration","none");
		$(this).css("text-decoration","underline");
	}); */
	
});
	
</script>

<style type="text/css">
#collectFolder{
	margin-left: 20px;
	border: none;
}
#collectFolder ul{ 
	border: none;
}
</style>
</head>

<body style="position: relative;">
<%@ include file="/Header.jsp" %>
    <div class="leftPart">
    	<div class="lBox1">
        	<div class="lBoxTitle" style="
	text-align:center;">
            	${user.username }, 您好! 当前积分:${user.points }
            </div>
            <ul>
            	<li class="lbox1Li"><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            	<a href="${contextpath }/userOpt_listFolderInside.do" target="usershow">我的收藏夹</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
                <li>
                	<ul id="collectFolder">
                    </ul>
                </li>
            	<li class="lbox1Li"><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/userOpt_update.do" target="usershow">修改个人资料</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            	<li class="lbox1Li"><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/userOpt_updatePassword.do" target="usershow">修改密码</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            	<li class="lbox1Li"><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/resource_add.do" title="上传资源可以获取积分哦~~" target="usershow">上传资源</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            	<li class="lbox1Li"><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/resource_addMulti.do" title="上传资源可以获取积分哦~~" target="usershow">批量上传专题资源</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            </ul>
            
        </div>
    	
    	<div class="lBox2">
        	<div class="lBoxTitle">
            	最新资料
                <a href="${contextpath }/search.do?queryOrderBy=passtime desc">更多>></a>
            </div>
            <ul>
            	<c:forEach items="${newestresource }" begin="0" end="10" var="r">
            	<li><img src="images/liImg2.jpg" />&nbsp;
            		<a href="${contextpath }/view.do?id=${r.id}">
					${fn:substring(r.title,0,14) }
					<c:set value="${fn:length(r.title) }" var="textlength" ></c:set>
            		<c:if test="${textlength>14 }">..</c:if>
					</a>
				</li>
            	</c:forEach>
            </ul>
        </div>
    
    </div><!--leftPart-->    
    
    <div class="rightPart">
    	<div class="secondTitle">
        	<div class="sTitle">
            	<img src="images/secondTArrow.jpg" />
                个人中心
            </div>
            <div class="catalog">
            	<img src="images/secondHome.jpg" style="position:relative; top:3px; left:0;"  />
                首页 > 个人中心
            </div>
            
        </div>
        <iframe name="usershow" width="750" height="800" 
        	 frameborder="0" style="border:0px;" src="${contextpath }/userOpt_listFolderInside.do"></iframe>
           <!--  <div id="usershow" 
            	style="width: 750px;height: 800px; overflow: auto;">
            
            </div> -->
            
      
       
    </div><!-- rightPart -->
    
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
