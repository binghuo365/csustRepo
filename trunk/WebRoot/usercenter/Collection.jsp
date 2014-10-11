<%@page import="com.yunstudio.entity.RepResource"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    
	<%@ include file="/Reference.jsp" %>
	
	<link href="${contextpath }/usercenter/usershow.css" rel="stylesheet" type="text/css"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
<script type="text/javascript">
$(function(){

});
function go(n){
	$("input[name='pageNum']").val(n);
	$("#folderForm").submit();
}
function confirmCancel(folderid,rid,isDelete){
	if(isDelete){
	     var b = confirm("您确定要删除吗?(该操作无法撤销)");
	     if(b){
	     	window.location.href="${contextpath }/userOpt_removeCollect.do?isdelete=1&folderid="+folderid+"&id="+rid;
	     }
	}else{
	     var b = confirm("您确定要取消收藏吗?");
	     if(b){
	     	window.location.href="${contextpath }/userOpt_removeCollect.do?isdelete=0&folderid="+folderid+"&id="+rid;
	     }
	}
}
function confirmDeleteFolder(folderid,isDelete){
	if(isDelete){
	     var b = confirm("您确定要删除您上传的该专题以及专题中的文件吗?(该操作无法撤销)");
	     if(b){
	     	window.location.href="${contextpath }/userOpt_removeFolder.do?isdelete=1&folderid="+folderid;
	     }
	}else{
	     var b = confirm("您确定要取消收藏该专题吗?");
	     if(b){
	     	window.location.href="${contextpath }/userOpt_removeFolder.do?isdelete=0&folderid="+folderid;
	     }
	}
}
</script>
<style type="text/css">
ul.folder li{
	position: relative;
}
ul.folder li a.deleteFolder{
	position: absolute;
	right: 0;
	top: 0;
	height: 37px;
	width: 120px;
	display: block;
	color: #F90;
}
.folderTitle{
	color: #666; 
	font-family: '微软雅黑'; 
	font-weight: bold; 
	font-size: 24px;
	margin:0 0 20px 30px;
}
</style>
  </head>
  
  <body>
  <c:choose>
  	<c:when test="${fatherfolder!=null }">
	  <div  class="folderTitle">
	  	<a href="${contextpath }/userOpt_listFolderInside.do?id=${fatherfolder.father.id}">..</a>
	  	/${fatherfolder.name }/</div>
  	</c:when>
  	<c:otherwise>
	  <div  class="folderTitle">
	  	我的收藏夹/</div>
  	</c:otherwise>
  </c:choose>
    <ul class="folder">
   	<c:forEach items="${folderlist }" var="f">
		<li><a href="${contextpath }/userOpt_listFolderInside.do?id=${f.id }">${f.name }</a>
		<c:if test="${fatherfolder!=null&&fatherfolder.name=='我的上传' }">
			<a class="deleteFolder" href="javascript:;" 
				onclick="confirmDeleteFolder(${f.id },true);">[删除]</a>
		</c:if>
		<c:if test="${fatherfolder!=null&&fatherfolder.name=='我的收藏' }">
			<a class="deleteFolder" href="javascript:;" 
				onclick="confirmDeleteFolder(${f.id },false);">[取消收藏]</a>
		</c:if>
		</li>
	</c:forEach>
	</ul>
		
	<ul class="resou"><!--6个li-->
          	<c:forEach items="${page.rows }" var="r">
  	        	<li>
                  <div class="resDetail">
                  	<div class="resTitle">
           		<a href="${contextpath }/view.do?id=${r.id}" target="_blank">
				${fn:substring(r.title,0,28) }
				<c:set value="${fn:length(r.title) }" var="textlength" ></c:set>
           		<c:if test="${textlength>28 }">..</c:if>
           		</a>
           		<span class="auditStatus">
           			${r.ispassed==0?'[审核中...]':'' }
           			<c:if test="${r.ispassed==-1}">
	           			<span style="color:#F99;">
	           			[已被退回,退回原因:${r.notpassreason }]</span>
           			</c:if>
           		</span>
           		<div class="resDownload">
	           		<a href="${contextpath }/download.do?id=${r.id}&folderid=${fatherfolder.id}"
	           			>[立即下载]</a>&nbsp;
	           		<c:if test="${fatherfolder.name=='我的上传'||fatherfolder.father.name=='我的上传' }">
						<a href="javascript:;" 
							onclick="confirmCancel(${folderid},${r.id },true);">[删除文件]</a>
					</c:if>
					<c:if test="${fatherfolder.name=='我的收藏'||fatherfolder.father.name=='我的收藏' }">
						<a href="javascript:;" 
							onclick="confirmCancel(${folderid},${r.id },false);">[取消收藏]</a>
					</c:if>
	           			
           		</div>
                   </div>
          			<div class="resInfo">
          				<%
          					RepResource r=(RepResource)pageContext.getAttribute("r");
          					String lengthMbStr=((Double)((long)r.getLength()/1024.0/1024.0)).toString();
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
 
 	
     <form action="userOpt_listFolderInside.do" id="folderForm" method="get">
     	<input type="hidden" name="id" value="${folderid }"/>
     	<input type="hidden" name="pageNum" value="1"/>
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
					" class="pageNum ${(i==page.page)?
                			'curPage':'' }">${i }</a>
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
         </form>
  </body>
</html>
