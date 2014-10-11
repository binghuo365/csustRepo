<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath}/admin/res/jeecms/css/admin.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/admin/res/common/css/theme.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/admin/res/common/css/jquery.validate.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/admin/res/common/css/jquery.treeview.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/admin/res/common/css/jquery.ui.css" rel="stylesheet" type="text/css"/>


<script src="${pageContext.request.contextPath}/admin/res/common/js/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/admin/res/common/js/jquery.metadata.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/admin/res/common/js/jquery.ext.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/admin/res/common/js/pony.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/admin/res/jeecms/js/admin.js" type="text/javascript"></script>


<!-- 日期选择插件 -->
<script src="${pageContext.request.contextPath}/thirdparty/jscal/js/jscal2.js"></script>
<script src="${pageContext.request.contextPath}/thirdparty/jscal/js/lang/cn.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/thirdparty/jscal/css/jscal2.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/thirdparty/jscal/css/border-radius.css" />
<script type="text/javascript">
$(function(){
	$("input[name='pointsneed']").after("<span>请输入0-100分作为其他用户下载所需积分</span>");
});
</script>

