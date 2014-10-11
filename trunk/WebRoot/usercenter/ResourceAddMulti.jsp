<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<%@ include file="/Reference.jsp" %>
       <%@include file="/admin/thirdpartinclude.jsp"%>
	<link href="${contextpath }/usercenter/usershow.css" rel="stylesheet" type="text/css"/>
	<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="content"]', {
				cssPath : '${contextpath}/thirdparty/kindeditor/plugins/code/prettify.css',
				uploadJson : '${contextpath}/thirdparty/kindeditor/jsp/upload_json.jsp',
				fileManagerJson : '${contextpath}/thirdparty/kindeditor/jsp/file_manager_json.jsp',
				allowFileManager : true
			});
			prettyPrint();
		K('#add-picture').click(function () {
	            var topimg = $("#topimg");
	            editor1.loadPlugin('image', function () {
	                editor1.plugin.imageDialog({
	                    clickFn: function (url, title, width, height, border, align) {
	                        var div = K('#topimgdiv');
	                        div.html("");
	                        div.append('<div style=\"float:left;width:60px;\"><div><img style=\"height:100px;width:100px;\" src="' + url + '" title="' + title + '" /></div><div><a href=\"javascript:delimg()\">删除</a></div></div>');
							topimg.val(url);
	                        editor1.hideDialog();
	                    }
	                });
	            });
	        });
		});
		

function delimg()//用于删除img里面的东西
{
	  $.get("resource_deleteTopImgAjax.do", { imgPath: $("#topimgdiv img").attr("src") },
	  	function(data){
	  		if(data=="success"){
		      $('#topimgdiv').html("");
			  $('#topimg').val("");
		  	}else{
		  		$('#topimgdiv').append("<font color=\"red\">删除失败!!</font>");
		  	}
	  	}	
	  );
}
$(function() {

	$("select[name='topicid'] option").eq(0).attr("selected", "selected");
	
	var catalogsStr=$("select[name='topicid'] option:selected").attr("catalogs");
	var catalogs;
	if(catalogsStr){
		try{
			catalogs=catalogsStr.split(",");
			if(catalogs.length=2){
				$(".zyCatalog").html(catalogs[0]);
				$(".gsCatalog").html(catalogs[1]);
			}else{
				$(".zyCatalog").html("");
				$(".gsCatalog").html("");
			}
		}catch(e){
				console.log('错误' + e.message + '发生在' +   e.lineNumber + '行');
		}
	}
	
	$("select[name='topicid']").click(function(){
		var catalogsStr=$("select[name='topicid'] option:selected").attr("catalogs");
		var catalogs;
		if(catalogsStr){
			try{
				catalogs=catalogsStr.split(",");
				$(".zyCatalog").html(catalogs[0]);
				$(".gsCatalog").html(catalogs[1]);
				
			}catch(e){
				console.log('错误' + e.message + '发生在' +   e.lineNumber + '行');
			}
		}else{
			$(".zyCatalog").html("");
			$(".gsCatalog").html("");
		}
	});

	
     /*  Calendar.setup({
        inputField : "addtime",
        trigger    : "addtime",
        showTime   : true,
        dateFormat : "%Y-%m-%d %H:%M:%S",
        //align :"bottom",
    	onSelect   : function() {  },
    	
		onTimeChange  : function(cal) {	var h = cal.getHours(), m = cal.getMinutes(); if (h < 10) h = "0" + h; if (m < 10) m = "0" + m; cal.inputField.value=cal.date.getFullYear()+"-"+(cal.date.getMonth()+1)+"-"+(cal.date.getDate())+" "+h+":"+m+":00"; }
      });
      	 */
	/*初始化热门标签*/
	initHotTags();
	
	initResourceFormStyle();

	$("select[name=zycatalogid] option").eq(1).attr("selected",true);	
	$("select[name=gscatalogid] option").eq(1).attr("selected",true);
	$("select[name=zycatalogid] option[value=${params.zycatalogid[0]}]").attr("selected",true);
	$("select[name=gscatalogid] option[value=${params.gscatalogid[0]}]").attr("selected",true);
	$("select[name=topicid] option[value=${params.topicid[0]}]").attr("selected",true);
	
	showTopcSelect();
});
	</script>
	
<style type="text/css">
${message==null?'.createtopic':'.selecttopic'}{
	display: none;
}
.createtopic td,.selectTopic td{
	height:30px;
	vertical-align: middle;
}
#topicid,#topicname,#zycatalogid,#gscatalogid{
	width: 150px;
}
</style>
	</head>
	<body>
		<form id="form1" class="resourceForm"  action="resource_addMulti.do" method="post">
			<input type="hidden" name="iscreate" value="${params.iscreate[0] }"/>
			<font color=red>${message }</font>
			<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1"
				border="0">
				
				<tr class="selectTopic">
						<td>
							<dfn>*</dfn>专题:
						</td>
						<td>
							<select name="topicid" id="topicid">
								<option value="" catalogs="">--空--</option>
								<s:iterator value="#tolist" id="item">
									<option value="${item.id}" catalogs="${item.repGscatalog.name },${item.repZycatalog.name }">
										${item.title}
									</option>
								</s:iterator>
							</select>
							(请先选择资源专题，或者<a href="javascript:;" onclick="showTopcInput();" style="color:#F90;">创建专题</a>.)
						</td>
					</tr>
					
				
				<tr class="createtopic">
						<td>
							<dfn>*</dfn>专题:
						</td>
						<td>
							<input type="text" name="topicname" id="topicname" maxlength="20"/>
							(请先输入专题名称，或者<a href="javascript:;" onclick="showTopcSelect();" style="color:#F90;">选择已有专题</a>.)
						</td>
					</tr>
					
				<tr class="selectTopic">
						<td>
							<dfn>&nbsp;</dfn>专业类别:
						</td>
						<td class="zyCatalog">
						</td>
					</tr>
					
					
			
				<tr class="createtopic">
					<td>
						<dfn>*</dfn>专业类别:
					</td>
					<td>
						<select name="zycatalogid" id="zycatalogid">
							<option value="" catalogs="">--空--</option>
							<s:iterator value="#zylist" id="item">
								<option value="${item.id}">
									${item.name}
								</option>
							</s:iterator>
						</select>
					(请输入专题包括的专业类别)

					</td>
				</tr>
					
				<tr class="selectTopic">
						<td>
							<dfn>&nbsp;</dfn>类型类别:
						</td>
						<td class="gsCatalog">
						</td>
					</tr>
				
				
					<tr class="createtopic">
						<td>
							<dfn>*</dfn>类型类别:
						</td>
						<td>
							<select name="gscatalogid" id="gscatalogid">
								<option value="" catalogs="">--空--</option>
								<s:iterator value="#gslist" id="item">
									<option value="${item.id}">
										${item.name}
									</option>
								</s:iterator>
							</select>
							(请输入专题包括的类型类别)
						</td>
					</tr>
				
				
				
				<tr>


					<td>
						关键字:
					</td>
					<td>
						<input type="text" maxlength="50" 
							name="tagStr" value="${params.tagStr[0] }" size="35" maxlength="50" />
						<span class="pn-fhelp">用","分开</span>
						
						<c:forEach items="${hotestTags }" var="tname" begin="0" end="4">
							<span class="hotestTags">${tname }</span>
						</c:forEach>
					</td>

				</tr>
				<tr>


					<td>
						摘要:
					</td>
					<td>
						<textarea cols="30" rows="3" 
						name="description" maxlength="255">${params.description[0] }</textarea>
					</td>

				</tr>
				<tr>


					<td>
						作者:
					</td>
					<td>
						${user.username }
					</td>
				</tr>
					<tr>
						<td>
							上传资源:
						</td>
						<td>
							<div id="fileQueue" style="height:auto;"></div>
							<input type="file" name="uploadify" id="uploadify" />
							<input type="hidden" id="resourcepath"  name="resourcepath"
								value="" class="required" />
							<p id="uploadifyoption">
								<a href="javascript:jQuery('#uploadify').uploadifyUpload();">开始上传</a>&nbsp;
								<a href="javascript:jQuery('#uploadify').uploadifyClearQueue()">取消上传</a>
							</p>
							<div id="result" style="color:red;"></div>
							<script type="text/javascript">
$(document).ready(function() {
			$("#uploadify").uploadify({
				'uploader'       : '${pageContext.request.contextPath }/thirdparty/uploadify/uploadify.swf',//是组件自带的flash，用于打开选取本地文件的按钮 
				'script'         : 'resource_uploadFile.do',
				'cancelImg'      : '${pageContext.request.contextPath}/thirdparty/uploadify/images/cancel.png',
				'queueID'        : 'fileQueue',
				'auto'           : false,
				'multi'          : true,
			    'removeCompleted': true,
			    'simUploadLimit' : 5,	
				'buttonImg'      : '${pageContext.request.contextPath }/thirdparty/uploadify/images/add.png',
				'height':30,
				'width':30,
			 	'fileDataName'   : 'uploadify', //和input的name属性值保持一致就好，Struts2就能处理了  
				 'onComplete'    : function (event, queueID, fileObj, response, data){
					                   	var uploadInfoArray=eval("("+response.toString()+")");

				 						if(uploadInfoArray!=null&&uploadInfoArray.length>0){
				 							for(var i=0;i<uploadInfoArray.length;i++){
				 								var info=uploadInfoArray[i];
					 							if(info.path!=undefined){
					 								($("#resourcepath").val()==null||$("#resourcepath").val()=="")?
    	           										$("#resourcepath").val(info.path+"_"+info.title):
	    	            								$("#resourcepath").val($("#resourcepath").val()+"<path/>"+info.path+"_"+info.title);
												}
		                						$("#result").append("<font color=black>"+info.title+"</font>"+info.message+"<br/>");
				 							
				 							}
	                							
				 							$("label[for=resourcepath]").remove();
				 						}
               						} ,    
                'fileDesc'       : '支持格式:<s:property value="#fileExt" />',
                'fileExt'        : '<s:property value="#fileExt" />'
			  
			});
		});
		</script>
						</td>
					</tr>
					<tr>
						<td>
							封面图片:
						</td>
						<td>
						  <div style="float:left; width:150px;">
								<input class="add-picture" id="add-picture" type="button" value="增加一张图片" />
							    <input type="hidden" id="topimg" name="topimg" value="${params.topimg[0] }" />
							</div>
				       <div id="topimgdiv" style="float:left; width:100px; height:100">
                         </div>
						</td>
					</tr>
					<tr>
						<td>
						内容:
						</td>
					
						<td>
							<textarea class="ckeditor" cols="80"   rows="20" id="content" 
							name="content">${params.content[0] }</textarea>
						</td>
					</tr>
					
					<tr>
						<td>
							下载所需积分:
						</td>
						<td>
							<input type="text" name="pointsneed" value="0"/>
						</td>
					</tr>
					<tr>
					<td colspan="2" align="center">
						<input type="hidden" name="cid" value="11" />
						<input type="submit" value="提交" class="manhuaTip submit" ty="loading" msg="
						正在等待后台生成预览文件......<br/>
						如响应时间过长可以先进行其他操作:<a href='${contextpath }/resource_addMulti.do'>返回</a>
						<br/>如多次上传均无响应请反应给管理员"/>
						&nbsp;
						<input type="reset" value="重置" class="reset" class="reset" />
					</td>
				</tr>
			</table>
		</form>
		
		
		<div class='msgbox_layer_wrap' style="display: none;">
			<span id='mode_tips_v2' style='z-index: 10000;' class='msgbox_layer'>
			<span class="loadimg"><img src="${pageContext.request.contextPath}/thirdparty/jquerymsg/images/loading.gif"/></span>
			</span>
		</div>
		<div id='blackCover' style="display: none;">
		</div>
	</body>
</html>