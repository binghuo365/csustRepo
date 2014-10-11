<%@ page language="java" import="java.util.*" isErrorPage="true" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="header">
	<div class="headerContent">
    	<img src="images/logo.jpg" width="343" height="105" />
        
        <div class="headRight">
        	<div class="headInfo">	
            	欢迎您的访问! 
        		<c:choose>
        		<c:when test="${user!=null }">
        			[<a href="${contextpath }/userOpt_showcenter.do" class="red">${user.username}(${user.points})<c:if 
        				test="${user.ispassed==0 }">（未审核）</c:if><c:if test="${user.ispassed==-1 }">(审核被退回)</c:if></a>]
        			[<a href="${contextpath }/userOpt_logout.do" class="red">退出登录</a>]
        		</c:when>
        		<c:otherwise>
	                [<a href="${contextpath }/userOpt_login.do" class="red">请登录</a>] 
	                [<a href="${contextpath }/userOpt_signin.do" class="red">立即注册</a>]
                </c:otherwise>
                </c:choose> 
                | <a href="javascript:;" onclick="addfavor(document.URL,document.title);">加入收藏</a>
                | <a href="admin/login.jsp">后台管理</a>
            </div>
            <form action="${contextpath }/search.do?title=" method="post" id="searchForm">
                <input type="text" name="searchkey" value="${params.title[0]==null?'请输入您要查询的关键字':params.title[0] }" class="searchBox"/>
                <button class="searchBtn" onclick="submitSearchForm();">搜 索</button>
            </form>
        </div>
    </div>
</div><!--  header end -->
<div class="main">
    <ul class="nav">
    	<li><a href="${contextpath }/index.do">网站首页</a></li>
    	<li><a href="${contextpath }/gscatalog.do?catalogid=1">在线文库</a></li>
    	<li><a href="${contextpath }/gscatalog.do?catalogid=2">视频教程</a></li>
    	<li><a href="${contextpath }/search.do">综合搜索</a></li>
    	<li><a href="${contextpath }/gscatalog.do?catalogid=3">教学软件</a></li>
    	<li><a href="${contextpath }/gscatalog.do?catalogid=4">图文教材</a></li>
    	<li><a href="${contextpath }/notice.do">公告中心</a></li>
    	<li><a href="${contextpath }/contact.do">联系我们</a></li>
        <div style="clear:both;"></div>
    </ul><!-- nav end -->
    
    
    <div class="sliderPlay" id="sliderPlay">
      <ul class="slider" style="left: 0px; width: 2532px;">
            <li style="position: static; left: 0px;"><a href="javascript:;">
            <img src="images/banner1.jpg" width="1003" height="236"></a></li>
            <li><a href="javascript:;"><img src="images/banner2.jpg"></a></li>
            <li><a href="javascript:;"><img src="images/banner3.jpg"></a></li>
            <!-- <li><a href="javascript:;"><img src="images/image01.gif"></a></li> -->
      </ul>
      <div id="btnBox" class="btnBox">
          <span class="btn cur"></span>
          <span class="btn"></span>
          <span class="btn"></span>
          <!-- <span class="btn"></span> -->
      </div>
    </div><!-- sliderPlay end-->
        
     
    <div class="hotNews">
    	<img src="images/home.gif" />
        <b>热门公告：</b>
        <ul>
        	<c:forEach items="${hotestnotice }" begin="0" end="2" var="b">
        	<li><a href="${contextpath }/viewnotice.do?id=${b.id }">${b.title }</a></li>
        	</c:forEach>
        </ul>
        <div class="timeInfo">
        	<%
        		Date today=new Date();
				request.setAttribute("today", today);
				int week=today.getDay();
				String day=null;
				switch(week)
				{
					case 0:
						day="日";
					case 1:
						day="一";
					case 2:
						day="二";
					case 3:
						day="三";
					case 4:
						day="四";
					case 5:
						day="五";
					case 6:
						day="六";
					default:
						break;
				}
        	 %>
        	 <fmt:formatDate value="${today }" pattern="今天是:yyyy年M月d日 星期"/>
        	 <%=day %>
        </div>
        <div style="clear:both"></div>
    </div><!-- hotNews -->