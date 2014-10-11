<%@page import="com.yunstudio.entity.RepResource"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="长沙理工大学,经济与管理学院,教学资源库系统,云作坊"/>
<title>长沙理工大学教学资源库</title>
<%@ include file="/Reference.jsp" %>
<link href="${contextpath }/css/indexStyle.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
$(function(){
	/*表单提示*/
	formHint();

	/* 导航动画 */
	navHover(0);
	
	/*图片轮播*/
	mySliderPlay();
	
	/*hotnews 的滚动动画*/
	hotNewsRoll();
	
	/*获取时间信息的方法*/
	getTimeInfo();
	
	/*热门视频的左右滚动动画，支持变化的视频个数*/
	videoRoll();
});
</script>

</head>

<body>

<%@ include file="/Header.jsp" %>
    
    <div class="leftPart">
    	<div class="mainTitle">
        	最热资源下载
        </div>
        
        <div class="lBox1">
        	<div class="hotImg">
        		<a href="${contextpath }/view.do?id=${hotestresource[0].id }">
            	<img src="<%=contextpath %>${hotestresource[0].topimg }" width="322" height="193" />
            	</a>
                <img src="images/hotTriangle.gif" class="hotTri" />
            </div>
            
            <div class="hotList">
            	<div class="hotTitle">
					<a href="${contextpath }/view.do?id=${hotestresource[0].id }" style="color:#4392da">
					${fn:substring(hotestresource[0].title,0,50) }
            		<c:set value="${fn:length(hotestresource[0].title) }" var="textlength" ></c:set><c:if test="${textlength>50 }">..</c:if>
            		</a>
                </div>
                <div class="hotDetail">
                	<c:choose>
                		<c:when test="${hotestresource[0].description==null
                					||hotestresource[0].description==''}">   
							${fn:substring(hotestresource[0].content,0,120) }
							<c:set value="${fn:length(hotestresource[0].content) }" var="textlength" ></c:set>
		            		<c:if test="${textlength>120 }">..</c:if>   			
                		</c:when>
                		<c:otherwise>
							${fn:substring(hotestresource[0].description,0,120) }
							<c:set value="${fn:length(hotestresource[0].description) }" var="textlength" ></c:set>
		            		<c:if test="${textlength>120 }">..</c:if>  
                		</c:otherwise>
                	</c:choose>
               		<a href="${contextpath }/view.do?id=${hotestresource[0].id }">[详情]</a>
                </div>
                
                <ul>
                	<c:forEach items="${hotestresource }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,25) }
            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>25 }">..</c:if>
                		</a><span>[${fn:substring(r.passtime,0,10) }]</span></li>
                	</c:forEach>
                	
                </ul>
            
            </div>
            
            <div style="clear:both;"></div>
        </div><!--lBox1 end-->
    
        <div class="lBox2">
        	<div class="lBox2_cell lBox2_cell_left">
            	<div class="cellTitle">
                	会计学专业>>
                    <a href="${contextpath }/search.do?zycatalogid=1">更多>></a>
                </div>
                <ul>
                	<c:forEach items="${zycatalog1 }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,19) }
		            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>19 }">..</c:if>
                		</a><span>[下载${r.downloadnum }次]</span></li>
                	</c:forEach>
                </ul>
            </div>
        	<div class="lBox2_cell">
            	<div class="cellTitle">
                	财务管理学专业>>
                    <a href="${contextpath }/search.do?zycatalogid=2">更多>></a>
                </div>
                <ul>
                	<c:forEach items="${zycatalog2 }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,19) }
		            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>19 }">..</c:if>
                		</a><span>[下载${r.downloadnum }次]</span></li>
                	</c:forEach>
                </ul>
            </div>
        	
        	<div class="lBox2_cell lBox2_cell_left">
            	<div class="cellTitle">
                	企业管理专业>>
                    <a href="${contextpath }/search.do?zycatalogid=3">更多>></a>
                </div>
                <ul>
                	<c:forEach items="${zycatalog3 }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,19) }
		            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>19 }">..</c:if>
                		</a><span>[下载${r.downloadnum }次]</span></li>
                	</c:forEach>
                </ul>
            </div>
        	<div class="lBox2_cell">
            	<div class="cellTitle">
                	市场营销专业>>
                    <a href="${contextpath }/search.do?zycatalogid=4">更多>></a>
                </div>
                <ul>
                	<c:forEach items="${zycatalog4 }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,19) }
		            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>19 }">..</c:if>
                		</a><span>[下载${r.downloadnum }次]</span></li>
                	</c:forEach>
                </ul>
            </div>
        	
        	<div class="lBox2_cell lBox2_cell_left">
            	<div class="cellTitle">
                	信息管理与信息系统专业>>
                    <a href="${contextpath }/search.do?zycatalogid=5">更多>></a>
                </div>
                <ul>
                	<c:forEach items="${zycatalog5 }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,19) }
		            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>19 }">..</c:if>
                		</a><span>[下载${r.downloadnum }次]</span></li>
                	</c:forEach>
                </ul>
            </div>
        	<div class="lBox2_cell">
            	<div class="cellTitle">
                	金融学专业>>
                    <a href="${contextpath }/search.do?zycatalogid=6">更多>></a>
                </div>
                <ul>
                	<c:forEach items="${zycatalog6 }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,19) }
		            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>19 }">..</c:if>
                		</a><span>[下载${r.downloadnum }次]</span></li>
                	</c:forEach>
                </ul>
            </div>
        	
        	<div class="lBox2_cell lBox2_cell_left">
            	<div class="cellTitle">
                	国际经济与贸易专业>>
                    <a href="${contextpath }/search.do?zycatalogid=7">更多>></a>
                </div>
                <ul>
                	<c:forEach items="${zycatalog7 }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,19) }
		            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>19 }">..</c:if>
                		</a><span>[下载${r.downloadnum }次]</span></li>
                	</c:forEach>
                </ul>
            </div>
        	<div class="lBox2_cell">
            	<div class="cellTitle">
                	其他>>
                    <a href="${contextpath }/search.do?zycatalogid=8">更多>></a>
                </div>
                <ul>
                	<c:forEach items="${zycatalog8 }"  var="r">
                		<li><a href="${contextpath }/view.do?id=${r.id }">
							${fn:substring(r.title,0,19) }
		            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>19 }">..</c:if>
                		</a><span>[下载${r.downloadnum }次]</span></li>
                	</c:forEach>
                </ul>
            </div>
        	
        	
            
            <div style="clear:both"></div>
        </div><!--lBox2 end-->
        
        <div class="lBox3">
            <div class="lBox3_title">
               热门视频>>
                <a href="${contextpath }/gscatalog.do?catalogid=2">更多>></a>
            </div>
            
            <ul>
            	<c:forEach items="${hotestvideo }" var="r" >
            	<li>
                	<a href="${contextpath }/view.do?id=${r.id }">
                		<img src="<%=contextpath %>${r.topimg }" width="134" height="97" />
                    </a>
                    <div>
                    	<img src="images/camera.jpg" />
                        <a href="${contextpath }/view.do?id=${r.id }">
						${fn:substring(r.title,0,6) }
	            		<c:if test="${fn:length(r.title) }>6">..</c:if>
	            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set><c:if test="${textlength>6 }">..</c:if>
						</a>
                    </div>
                </li>
                </c:forEach>
                <div style="clear:both"></div>
            </ul>
        	
        </div><!-- lBox3 end -->
        
        
        
    </div><!-- leftPart end -->
    
    <div class="rightPart">
    	<div class="rBox1">
        	<div class="rBoxTitle">
            	最新公告
                <a href="notice.do">更多>></a>
            </div>
            <ul>
            	<c:forEach items="${newestnotice }" var="n" >
            		<li><img src="images/liImg2.jpg" />
            			<a href="${contextpath }/viewnotice.do?id=${n.id }">
						${fn:substring(n.title,0,14) }
	            		<c:set value="${fn:length(n.title) }" var="textlength" ></c:set><c:if test="${textlength>14 }">..</c:if>
						</a></li>
            	</c:forEach>
            </ul>
            
        </div>
        
        
    	<div class="rBox2">
        	<div class="rBoxTitle">
            	最新资料
                <a href="<%=contextpath %>/search.do?queryOrderBy=passtime desc">更多>></a>
            </div>
            <ul>
            	<c:forEach items="${newestresource }" var="r" begin="0" end="10">
            	<li>
                	<a href="${contextpath }/view.do?id=${r.id }" class="resourceImg"><img src="<%=contextpath %>${r.topimg }" width="46" height="33" /></a>
                    <div class="resourceDetail">
                    	<a class="resourceTitle" href="${contextpath }/view.do?id=${r.id }">
                        	[
								${fn:substring(r.title,0,6) }
			            		<c:set value="${fn:length(r.title) }" var="textlength" ></c:set>
			            		<c:if test="${textlength>6 }">..</c:if>
			            		
                        	] 
                        </a>
                         上传时间:${fn:substring(r.passtime,0,10) }
                        <div class="resourceDesc">
	    	        		
	            		<c:choose>
                		<c:when test="${r.description==null
                					||r.description==''}">   
                			<%
                				String content=((RepResource)pageContext.getAttribute("r"))
                					.getContent();
                				if(content!=null){
                					content=content.replaceAll("<[\\w|\\W|\\n]+?>|\\s|&nbsp;", "");
                					content=content.length()>10?content.substring(0, 10)+"..":content;
                				}
                				pageContext.setAttribute("content", content);
                			 %>
							${content }
                		</c:when>
                		<c:otherwise>
							${fn:substring(r.description,0,10) }
		            		<c:set value="${fn:length(r.description) }" var="textlength" ></c:set><c:if test="${textlength>10 }">..</c:if>
                		</c:otherwise>
                	</c:choose>
	            		
						</div>
                    </div>
                    <div style="clear:both;"></div>
                </li>
                </c:forEach>
            	
            </ul>
        </div>
    
    </div><!--rightPart-->
    
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
