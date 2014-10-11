<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
	   <%@include file="/admin/head.jsp"%>
       <%@include file="/admin/thirdpartinclude.jsp"%>

	<script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="content"]', {
				cssPath : '../../thirdparty/kindeditor/plugins/code/prettify.css',
				uploadJson : '../../thirdparty/kindeditor/jsp/upload_json.jsp',
				fileManagerJson : '../../thirdparty/kindeditor/jsp/file_manager_json.jsp',
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
	  	alert(data);
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
	var va=$("#form1").validate();

	$("select[name='gscatalogid'] option[value=<s:property value='gscatalogid' />]").attr("selected", true);
	
	
	 $(".manhuaTip").click(function(){
		if(va.form()){
		 	$("#blackCover").css({
		 		"display":"block",
		 		"width":$("body").width(),
		 		"height":$("body").height()
		 	});
		 	$(".msgbox_layer_wrap").css("display","block");
		 	$("#mode_tips_v2").append($(this).attr("msg"));
		}
	
	});
	
	
      Calendar.setup({
        inputField : "addtime",
        trigger    : "addtime",
        showTime   : true,
        dateFormat : "%Y-%m-%d %H:%M:%S",
        //align :"bottom",
    	onSelect   : function() {  },
    	
		onTimeChange  : function(cal) {	var h = cal.getHours(), m = cal.getMinutes(); if (h < 10) h = "0" + h; if (m < 10) m = "0" + m; cal.inputField.value=cal.date.getFullYear()+"-"+(cal.date.getMonth()+1)+"-"+(cal.date.getDate())+" "+h+":"+m+":00"; }
      });
});
function pathsParse(paths){
	return paths.substring(
				paths.lastIndexOf("\\")+1,
				paths.lastIndexOf("_"))+paths.substr(paths.lastIndexOf("."));
}

	</script>
	
	</head>
	<body>
		<div class="box-positon">
			<div class="rpos">
				当前位置: 资源管理 - 添加
			</div>
			<form class="ropt">
				<input type="submit" value="返回列表"
					onclick="this.form.action='resource_list.do';" class="return-button" />
			</form>
			<div class="clear"></div>
		</div>
		<form id="form1" action="resource_add.do" method="post">
			<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1"
				border="0">
				<tr id="tr-typeId">
						<td width="10%" class="pn-flabel pn-flabel-h">
							<span class="pn-frequired">*</span>资源类型:
						</td>
						<td colspan="3" width="40%" class="pn-fcontent">
							<select name="gscatalogid" id="gscatalogid">
								<s:iterator value="#gslist" id="item">
									<option value="${item.id}">
										${item.name}
									</option>
								</s:iterator>
							</select>
							(请先选择资源类型)
						</td>
					</tr>
				
				<tr>
					<td width="10%" class="pn-flabel pn-flabel-h">
						<span class="pn-frequired">*</span>专业类别:
					</td>
					<td colspan="3" width="90%" class="pn-fcontent">
						<div style="float: left">
							<div>
								<select name="zycatalogid" id="zycatalogid">
									<s:iterator value="#zylist" id="item">
										<option value="${item.id}">
											${item.name}
										</option>
									</s:iterator>
								</select>
							</div>
							<div id="channelsContainer"></div>
						</div>

						<div style="clear: both"></div>
					</td>
				</tr>
				<tr id="tr-title">


					<td width="10%" class="pn-flabel pn-flabel-h">
						标题:
					</td>
					<td colspan="3" width="90%" class="pn-fcontent">
						<input type="text" maxlength="150" name="title"  size="70" maxlength="150" />(如果为空则标题为文件名)
					</td>

				</tr>
				<tr id="tr-tagStr">


					<td width="10%" class="pn-flabel pn-flabel-h">
						关键字:
					</td>
					<td colspan="3" width="90%" class="pn-fcontent">
						<input type="text" maxlength="50" name="tagStr" size="35" maxlength="50" />
						<span class="pn-fhelp">用","分开</span>
					</td>

				</tr>
				<tr id="tr-description">


					<td width="10%" class="pn-flabel pn-flabel-h">
						摘要:
					</td>
					<td colspan="3" width="90%" class="pn-fcontent">
						<textarea cols="70" rows="3" name="description" maxlength="255"></textarea>
					</td>

				</tr>
				<tr id="tr-author">


					<td width="10%" class="pn-flabel pn-flabel-h">
						上传者:
					</td>
					<td colspan="3" width="40%" class="pn-fcontent">
						${admin.username }<input type="hidden" maxlength="100" readonly="readonly" maxlength="100" value="${admin.id }" />
					</td>

					</tr>

					<tr id="tr-topLevel">
						<td colspan="1" width="10%" class="pn-flabel pn-flabel-h">
							发布时间:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<input class="Wdate" type="text"
								id="addtime"
								style="width: 140px" name="addtime" value="">
							<span class="pn-fhelp">留空则为当前时间</span>
						</td>
					</tr>

					
					<tr id="upload">
						<td width="10%" class="pn-flabel">
							上传资源:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<div id="fileQueue" style="height:auto;"></div>
							<input type="file" name="uploadify" id="uploadify" />
							<input type="hidden" id="resourcepath"  name="resourcepath" class="required" />
							<p id="uploadifyoption">
								<a href="javascript:jQuery('#uploadify').uploadifyUpload();">开始上传</a>&nbsp;
								<a href="javascript:jQuery('#uploadify').uploadifyClearQueue()">取消上传</a>
							</p>
							<div id="result" style="color:red;"></div>
							<script type="text/javascript">
$(document).ready(function() {
			$("#uploadify").uploadify({
				'uploader'       : '${pageContext.request.contextPath }/thirdparty/uploadify/uploadify.swf',//是组件自带的flash，用于打开选取本地文件的按钮 
				'script'         : '${pageContext.request.contextPath }/resource_uploadFile.do',
				'cancelImg'      : '${pageContext.request.contextPath}/thirdparty/uploadify/images/cancel.png',
				'queueID'        : 'fileQueue',
				'auto'           : false,
				'multi'          : false,
			    'removeCompleted': true,
				'buttonImg'      : '${pageContext.request.contextPath }/thirdparty/uploadify/images/add.png',
				'height':30,
				'width':30,
			 	'fileDataName'   : 'uploadify', //和input的name属性值保持一致就好，Struts2就能处理了  
				 'onComplete'    : function (event, queueID, fileObj, response, data){
					                   	var uploadInfoArray=eval("("+response.toString()+")");
				 						if(uploadInfoArray!=null&&uploadInfoArray.length>0){
				 							$("#uploadifyoption").html("");
				 							for(var i=0;i < uploadInfoArray.length;i++){
				 								var info=uploadInfoArray[i];
				 								
	
												if(info.path!=undefined){
					 								($("#resourcepath").val()==null||$("#resourcepath").val()=="")?
    	           										$("#resourcepath").val(info.path+"_"+info.title):
	    	            								$("#resourcepath").val($("#resourcepath").val()+"<path/>"+info.path+"_"+info.title);
												}
	    	           							$("#uploadifyoption").append(info.title+"<font color=red>"+info.message+"</font><br/>");
				 							
				 							}
	                						
	                						$("#uploadify").remove();
    	           							$("#uploadifyUploader").remove();
				 							$("label[for=resourcepath]").remove();
				 						}
               						} ,    
                'fileDesc'       : '支持格式:<s:property value="#fileExt" />',
                'fileExt'        : '<s:property value="#fileExt" />',
                'onError'     :function(event,queueId,fileObj,errorObj){
                	alert(errorObj.type+"_"+errorObj.info+"_"+errorObj);
                } 
			  
			});
		});
		</script>
						</td>
					</tr>

					<tr id="tr-txt">
						<!--上传附件框架-->
					</tr>
					<tr id="tr-pictures">
						<td class="pn-flabel" width="10%">
							封面图片:
						</td>
						<td class="pn-fcontent" width="90%" colspan="3">
						  <div style="float:left; width:150px;">
								<input class="add-picture" id="add-picture" type="button" value="增加一张图片">
							    <input type="hidden" id="topimg" name="topimg" />
							</div>
				       <div id="topimgdiv" style="float:left; width:100px; height:100">
                         </div>
						</td>
					</tr>
					<tr id="tr-txt">
						<td class="pn-flabel pn-flabel-h" width="10%">
							内容:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<textarea class="ckeditor" cols="100"  rows="20" id="content" name="content">
</textarea>
						</td>
					</tr>
					
					
					<tr id="tr-txt">
						<td class="pn-flabel pn-flabel-h" width="10%">
							下载所需积分:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<input type="text" 
							name="pointsneed" 
							value="0"
							class="{required:true,digits:true,range:[0,100]}" />
						</td>
					</tr>
					<tr>
					<td colspan="4" class="pn-fbutton">
						<input type="hidden" name="cid" value="11" />
						<input type="submit" value="提交"  class="manhuaTip submit" ty="loading" msg="正在等待后台生成预览文件......<br/>如响应时间过长可以先进行其他操作:<a href='resource_list.do'>返回</a><br/>如多次上传均无响应请到系统配置重启预览文件生成服务。" />
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