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
	navHover(7);
	/*二三级左侧栏目动画*/
	columnTitleHover(6);
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
                联系我们
            </div>
            <div class="catalog">
            	<img src="images/secondHome.jpg" style="position:relative; top:3px; left:0;"  />
                首页 > 联系我们
            </div>
        </div>
            
          <div class="docTitle" style="text-align: left; margin-left: 20px;">
        	长沙理工大学教学资源网
        	</div>
        <div style="padding: 0 20px; height: 700px;">
       湖南省长沙市(雨花区)万家丽南路2段960号<br/>
		电话：0731-8881688 <br/>
		传真：0731-8881688 <br/>
		邮编:410004 <br/>
		域名备案信息：湘ICP备05003881号<br/> 
       	
       
        
       </div>
    </div><!-- rightPart -->
    
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
