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
<link href="${contextpath }/css/searchPageStyle.css" rel="stylesheet" type="text/css"/>

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
	navHover(3);
	/*二三级左侧栏目动画*/
	/*columnTitleHover(2);*/
	
	
	//[{"1":{"checked":true,"text":"Item1","children":[{"2":{"checked":true,"text":"Item2","children":[]}}]}}]
	//var jsonArray="[{\"1\":{\"checked\":true,\"text\":\"Item1\",\"children\":[{\"2\":{\"checked\":true,\"text\":\"Item2\",\"children\":[]}},{\"3\":{\"checked\":false,\"text\":\"Item3\",\"children\":[]}}]}}]";
	var zyJsonArray=${zyjsonarray };
	var gsJsonArray=${gsjsonarray};
	
	
	var checkedzycatalogids=${checkedzycatalogids==null?0:checkedzycatalogids};
	var checkedgscatalogids=${checkedgscatalogids==null?0:checkedgscatalogids};
	
	// 专业类别的treeview
	$("#zyCatalogTree").treeview_addon({
			jsonArray:zyJsonArray,
			inputType:"checkbox",/*you can choose checkbox,radio. if you don't want input support, you can write false*/
			inputName:"zycatalogid",
			leavesTag:"span",/*just like the treeview support, you can use a or span, */
			checkedArray:checkedzycatalogids,
			partCheckedImageSrc:"./images/partChecked.jpg"
	});
	// 格式类别的treeview
	$("#gsCatalogTree").treeview_addon({
			jsonArray:gsJsonArray,
			inputType:"checkbox",/*you can choose checkbox,radio. if you don't want input support, you can write false*/
			inputName:"gscatalogid",
			checkedArray:checkedgscatalogids,
			leavesTag:"span",/*just like the treeview support, you can use a or span, */
			partCheckedImageSrc:"./images/partChecked.jpg"
	});
	
	
	$("select[name='queryOrderBy'] option[value='${params.queryOrderBy[0]}']").attr("selected",true);
	
	/*初始化热门标签*/
	initHotTags();
	
	pageHide();
});
function go(n){
	$("input[name='pageNum']").val(n);
	$("#search").submit();
}
</script>
<style type="text/css">
.hotestTags{
	cursor: pointer;
}


.catalogLi{
	font-weight: bold;
	color: #5097d9;
}
</style>
</head>

<body>

<%@ include file="/Header.jsp" %>
    
    <form id="search" action="search.do" method="post">
    <div class="leftPart">
    	<div class="lBox1">
        	<div class="lBoxTitle">
            	类别
            </div>
            <ul class="catalog">
            	<li class="catalogLi"><img src="images/columnArrow1Blue.jpg" class="columnLeftArrow" />&nbsp;<a href="#">专业类别</a>
                </li>
                <li>
                    <ul id="zyCatalogTree" class="treeview">
                    </ul>
                </li>
                
                <!--专业类别 end-->
            	<li class="catalogLi"><img src="images/columnArrow1Blue.jpg" class="columnLeftArrow" />&nbsp;<a href="#">类型类别</a></li>
                <li>
                    <ul id="gsCatalogTree" class="treeview">
                    </ul>
                </li> <!--类型类别 end-->
            </ul> 
            
        </div>
        
        
    	<div class="lBox2">
        	<div class="lBoxTitle">
            	最新资料
                <a href="<%=contextpath %>/search.do?queryOrderBy=passtime desc">更多>></a>
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
    <div class="rightPart" style="position: relative;">
    	<div class="secondTitle">
        	<div class="sTitle">
            	<img src="images/secondTArrow.jpg" />
                综合搜索
            </div>
            <div class="catalog">
            	<img src="images/secondHome.jpg" style="position:relative; top:3px; left:0;"  />
                首页 > 综合搜索
            </div>
        </div>
        	<div style="margin: 5px 10px;">
				标&nbsp;&nbsp;题: <input type="text" name="title" value="${params.title[0] }" style="width:200px ;" />
				发布者: <input type="text" name="adduser" value="${params.adduser[0] }" style="width:50px" />
				排序: <select name="queryOrderBy">
				<option value="passtime desc">按发布时间降序</option>
				<option value="passtime asc">按发布时间升序</option>
				<option value="downloadnum desc">按下载量降序</option>
				<option value="downloadnum asc">按下载量升序</option>
				<option value="likenum desc">按赞数降序</option>
				<option value="likenum asc">按赞数升序</option>
				</select>
				专题:<input type="text" name="topicname" value="${params.topicname[0] }" style="width:150px"/>
				<br />
				关键字: <input type="text" name="tagname" value="${params.tagname[0] }" style="width:150px" />
				热门搜索:
					<c:forEach items="${hotestTags }" var="tname" begin="0" end="4">
						<span class="hotestTags">${tname }</span>
					</c:forEach>
				
				<button class="searchBtn" style="position: absolute; right: 20px; top: 70px;" onclick="$('#search').submit();">搜 索</button>
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
            		<a href="${contextpath }/download.do?id=${r.id}" class="resDownload">[立即下载]</a>
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
            
            
        <div class="pagNav">
            	<input type="hidden" name="pageNum" value=""  />
            	<a href="
					<c:choose>
		            	<c:when test="${page.page==1 }">javascript:;</c:when>
		            	<c:otherwise>javascript:go(1);</c:otherwise>
		            </c:choose> 
				">首页</a>
                <a href="
					<c:choose>
		            	<c:when test="${page.page-1<1 }">javascript:;</c:when>
		            	<c:otherwise>javascript:go(${page.page-1 });</c:otherwise>
		            </c:choose> 
				">上一页</a>
                
                <c:forEach var="i" begin="1" end="${page.total }" step="1" >
                	<a href="
						<c:choose>
			            	<c:when test="${i==page.page }">javascript:;</c:when>
			            	<c:otherwise>javascript:go(${i });</c:otherwise>
			            </c:choose> 
					" class="${(i==page.page)?
                			'pageNum curPage':'pageNum' }">${i }</a>
                </c:forEach>
                <a href="
					<c:choose>
		            	<c:when test="${page.page+1>page.total }">javascript:;</c:when>
		            	<c:otherwise>javascript:go(${page.page+1 });</c:otherwise>
		            </c:choose>
                ">下一页</a>
            	<a href="
					<c:choose>
		            	<c:when test="${page.page==page.total }">javascript:;</c:when>
		            	<c:otherwise>javascript:go(${page.total });</c:otherwise>
		            </c:choose>
            	">末页</a>
            	
            	共${page.total }页 / ${page.records }条记录
            </div>
    </div><!-- rightPart -->
    
    </form>
    <div style="clear:both;"></div>
   <%@ include file="/Footer.jsp" %>

</body>
</html>
