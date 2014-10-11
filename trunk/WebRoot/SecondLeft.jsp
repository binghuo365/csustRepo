<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 	<div class="leftPart">
    	<div class="lBox1">
        	<div class="lBoxTitle">
            	栏目导航
            </div>
            <ul>
            	<li><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/gscatalog.do?catalogid=1">在线文库</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            	<li><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/gscatalog.do?catalogid=2">视频教程</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            	<li><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/search.do">综合下载</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            	<li><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/gscatalog.do?catalogid=3">教学软件</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            	<li><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/gscatalog.do?catalogid=4">图文教材</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
            	<li><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
            		<a href="${contextpath }/notice.do">公告中心</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
    			<li><img src="images/columnArrow1.jpg" class="columnLeftArrow" />&nbsp;
    				<a href="${contextpath }/contact.do">联系我们</a><img src="images/columnArrow2.jpg" class="columnRightArrow" /></li>
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
