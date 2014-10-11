<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 <div class="pagNav">
            
            	<a href="
					<c:choose>
		            	<c:when test="${page.page==1 }">javascript:;</c:when>
		            	<c:otherwise>${contextpath }/${catalogid!=null?
		            		'gscatalog':'notice' }.do?<c:if test="${catalogid!=null}">catalogid=${catalogid }&</c:if>pageNum=1</c:otherwise>
		            </c:choose> 
				">首页</a>
                <a href="
					<c:choose>
		            	<c:when test="${page.page-1<1 }">javascript:;</c:when>
		            	<c:otherwise>${contextpath }/${catalogid!=null?
		            		'gscatalog':'notice' }.do?<c:if test="${catalogid!=null}">catalogid=${catalogid }&</c:if>pageNum=${page.page-1 }</c:otherwise>
		            </c:choose> 
				">上一页</a>
                
                <c:forEach var="i" begin="1" end="${page.total }" step="1" >
                	<a href="
						<c:choose>
			            	<c:when test="${i==page.page }">javascript:;</c:when>
			            	<c:otherwise>${contextpath }/${catalogid!=null?
		            		'gscatalog':'notice' }.do?<c:if test="${catalogid!=null}">catalogid=${catalogid }&</c:if>pageNum=${i }</c:otherwise>
			            </c:choose> 
					" class="${(i==page.page)?
                			'pageNum curPage':'pageNum' }">${i }</a>
                </c:forEach>
                <a href="
					<c:choose>
		            	<c:when test="${page.page+1>page.total }">javascript:;</c:when>
		            	<c:otherwise>${contextpath }/${catalogid!=null?
		            		'gscatalog':'notice' }.do?<c:if test="${catalogid!=null}">catalogid=${catalogid }&</c:if>pageNum=${page.page+1 }</c:otherwise>
		            </c:choose>
                ">下一页</a>
            	<a href="
					<c:choose>
		            	<c:when test="${page.page==page.total }">javascript:;</c:when>
		            	<c:otherwise>${contextpath }/${catalogid!=null?
		            		'gscatalog':'notice' }.do?<c:if test="${catalogid!=null}">catalogid=${catalogid }&</c:if>pageNum=${page.total }</c:otherwise>
		            </c:choose>
            	">末页</a>
            	
            	共${page.total }页 / ${page.records }条记录
            </div><!-- pageNav end -->
<script type="text/javascript">
	pageHide();
</script>
