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
<link href="${contextpath }/css/listTextSecondStyle.css" rel="stylesheet" type="text/css"/>

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
	
	var catalogid=${catalogid};
	switch(catalogid)
	{
		case 1:
				$(".sTitle").append("在线文库");
				$(".catalog").append("在线文库");
				/* 导航动画 */
				navHover(1);
				/*二三级左侧栏目动画*/
				columnTitleHover(0);
				break;
		case 3:
			$(".sTitle").append("教学软件");
			$(".catalog").append("教学软件");
			/* 导航动画 */
			navHover(4);
			/*二三级左侧栏目动画*/
			columnTitleHover(3);
			break;
		default:
			break;
			
	}
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
                
            </div>
            <div class="catalog">
            	<img src="images/secondHome.jpg" style="position:relative; top:3px; left:0;"  />
                首页 > 
            </div>
        </div>
            
            <ul><!--6个li-->
            	<c:forEach items="${page.rows }" var="r">
    	        	<li>
                    <div class="resDetail">
                    	<div class="resTitle">
	            		<a href="${contextpath }/view.do?id=${r.id}">
						${fn:substring(r.title,0,28) }
						<c:set value="${fn:length(r.title) }" var="textlength" ></c:set>
	            		<c:if test="${textlength>28 }">..</c:if>
	            		</a>
	            		<a href="#" class="resDownload">[立即下载]</a>
	                    </div>
            			<div class="resInfo">
            				<%
            					RepResource r=(RepResource)pageContext.getAttribute("r");
            					String lengthMbStr=((Double)(r.getLength()/1024.0/1024.0)).toString();
            					String[] lenMbStr=lengthMbStr.split("\\.");
            					if(lenMbStr.length>1){
            						lengthMbStr=lenMbStr[0]+"."+((lenMbStr[1].length()<4)?lenMbStr[1]:lenMbStr[1].substring(0, 3));
            					}
            				 %>
                        	更新日期 ${fn:substring(r.updatetime,0,10) } 软件大小:<%=lengthMbStr %>MB 下载量:${r.downloadnum }
                        </div>
                        <div class="resDescri">
	                	<c:choose>
	                		<c:when test="${r.description==null
	                					||r.description==''}">   
								<%
	               				String content=((RepResource)pageContext.getAttribute("r"))
	               					.getContent();
	               				if(content!=null){
	               					content=content.replaceAll("<[\\w|\\W|\\n]+?>|\\s|&nbsp;", "");
	                				content=content.length()>112?content.substring(0, 112)+"..":content;
	               				}
                				pageContext.setAttribute("content", content);
                			 	%>
								${content }
			            		   			
	                		</c:when>
	                		<c:otherwise>
								${fn:substring(r.description,0,112) }
								<c:set value="${fn:length(r.description) }" var="textlength" ></c:set>
			            		<c:if test="${textlength>112 }">..</c:if>  
	                		</c:otherwise>
	                	</c:choose>
                        </div>
                      </div>
	            	</li>
            	</c:forEach>
            	
            </ul>
            
            
         <%@ include file="/SecondPageNav.jsp" %>  
    </div><!-- rightPart -->
    
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
