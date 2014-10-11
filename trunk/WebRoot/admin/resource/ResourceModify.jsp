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
KindEditor
		.ready(function(K) {
			var editor1 = K
					.create(
							'textarea[name="content"]',
							{
								cssPath : '../../thirdparty/kindeditor/plugins/code/prettify.css',
								uploadJson : '../../thirdparty/kindeditor/jsp/upload_json.jsp',
								fileManagerJson : '../../thirdparty/kindeditor/jsp/file_manager_json.jsp',
								allowFileManager : true
							});
			prettyPrint();
			K('#add-picture')
					.click(
							function() {
								var topimg = $("#topimg");
								editor1
										.loadPlugin(
												'image',
												function() {
													editor1.plugin
															.imageDialog( {
																clickFn : function(
																		url,
																		title,
																		width,
																		height,
																		border,
																		align) {
																	var div = K('#topimgdiv');
																	div
																			.html("");
																	div
																			.append('<div style=\"float:left;width:60px;\"><div><img style=\"height:100px;width:100px;\" src="'
																					+ url
																					+ '" title="'
																					+ title
																					+ '" /></div><div><a href=\"javascript:delimg()\">删除</a></div></div>');
																	topimg
																			.val(url);
																	editor1
																			.hideDialog();
																	$(
																			'#add-picture')
																			.hide();
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
	if("<s:property value="topimg"/>"!=""){
		var div = $('#topimgdiv');
		url="<s:property value="topimg"/>";
		div.append('<div style=\"float:left;width:60px;\"><div><img style=\"height:100px;width:100px;\" src="<%=basePath%>'
																						+ url
																						+ '" title="'
																			+ url
																						+ '" /></div><div><a href=\"javascript:delimg()\">删除</a></div></div>');
		$("#topimg").val(url);
		$('#add-picture').hide();
	}
	
	$("select[name='topicid']").change(function(){
		var topicCatalogs=$("select[name='topicid'] option:selected").attr("catalogs");
		if(topicCatalogs!=null&&topicCatalogs!=""){
			var catalogs=topicCatalogs.split(",");
			$("select[name='gscatalogid'] option[value="+catalogs[0]+"]").attr("selected","selected");
			$("select[name='zycatalogid'] option[value="+catalogs[1]+"]").attr("selected","selected");
			$("select[name='gscatalogid']").attr("disabled",true);
			$("select[name='zycatalogid']").attr("disabled",true);
		}else{
			$("select[name='gscatalogid'] option").eq(0).attr("selected",true);
			$("select[name='zycatalogid'] option").eq(0).attr("selected",true);
			$("select[name='gscatalogid']").attr("disabled",false);
			$("select[name='zycatalogid']").attr("disabled",false);
		}
	
	});
	
	$("select[name='zycatalogid'] option[value=<s:property value='RepZycatalog.id' />]").attr("selected", true);
	$("select[name='gscatalogid'] option[value=<s:property value='RepGscatalog.id' />]").attr("selected", true);
	
	$("input[name=ispassed][value=<s:property value='ispassed' />]").attr("checked",true);
	
	if($("input[name=ispassed]:checked").val()=="-1"){
		$(".notpassreason").css("display","block");
	}
	$("label").click(function(){
		if($("input[name=ispassed]:checked").val()=="-1"){
			$(".notpassreason").css("display","block");
		}else{
			$(".notpassreason").css("display","none");
		}
	});
	
	
	
	/* $(".manhuaTip").manhuaTip({		
		loadimg:"${pageContext.request.contextPath}/thirdparty/jquerymsg/images/loading.gif"			       
	});
	 */
	 
	 
	var va=$("#form1").validate();
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
        inputField : "passtime",
        trigger    : "passtime",
        showTime   : true,
        dateFormat : "%Y-%m-%d %H:%M:%S",
        //align :"bottom",
    	onSelect   : function() {  },
    	
		onTimeChange  : function(cal) {	var h = cal.getHours(), m = cal.getMinutes(); if (h < 10) h = "0" + h; if (m < 10) m = "0" + m; cal.inputField.value=cal.date.getFullYear()+"-"+(cal.date.getMonth()+1)+"-"+(cal.date.getDate())+" "+h+":"+m+":00"; }
      });
	
      Calendar.setup({
        inputField : "updatetime",
        trigger    : "updatetime",
        showTime   : true,
        dateFormat : "%Y-%m-%d %H:%M:%S",
        //align :"bottom",
    	onSelect   : function() {  },onTimeChange  : function(cal) {	var h = cal.getHours(), m = cal.getMinutes(); if (h < 10) h = "0" + h; if (m < 10) m = "0" + m; cal.inputField.value=cal.date.getFullYear()+"-"+(cal.date.getMonth()+1)+"-"+(cal.date.getDate())+" "+h+":"+m+":00"; }
      });
      
});
</script>

	</head>
	<body>
		<form id="form1"
			action="resource_update.do?id=<s:property value="id"/>&method=save"
			method="post">
			<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1"
				border="0">
				<tr id="tr-typeId">
						<td width="10%" class="pn-flabel pn-flabel-h">
							<span class="pn-frequired">*</span>专题:
						</td>
						<td colspan="3" width="40%" class="pn-fcontent">
							<select name="topicid" id="topicid" class="{required:true}">
								<option value="">--空--</option>
								<s:iterator value="#tolist" id="item">
									<option value="${item.id}" catalogs="${item.repGscatalog.id },${item.repZycatalog.id }">
										${item.title}
									</option>
								</s:iterator>
							</select>
							(请先选择资源专题)
						</td>
					</tr>
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
						<span class="pn-frequired">*</span>标题:
					</td>
					<td colspan="3" width="90%" class="pn-fcontent">
						<input type="text" maxlength="150"
							value="<s:property value="title" />" name="title"
							class="required" size="70" maxlength="150" />
					</td>

				</tr>
				<tr id="tr-tagStr">


					<td width="10%" class="pn-flabel pn-flabel-h">
						Tag标签:
					</td>
					<td colspan="3" width="90%" class="pn-fcontent">
						<input type="text" maxlength="50" name="tagStr" size="35"
							maxlength="50" value='<s:iterator value="repTags" status="stat"><s:if test="#stat.count!=1">,</s:if><s:property value="name"/></s:iterator>' />
						<span class="pn-fhelp">用","分开</span>
					</td>

				</tr>
				<tr id="tr-description">


					<td width="10%" class="pn-flabel pn-flabel-h">
						摘要:
					</td>
					<td colspan="3" width="90%" class="pn-fcontent">
<textarea cols="70" rows="3"  name="description" maxlength="255"><s:property value="description" /></textarea>
					</td>

				</tr>
				<tr id="tr-author">


					<td width="10%" class="pn-flabel pn-flabel-h">
						作者:
					</td>
					<td colspan="3" width="40%" class="pn-fcontent">
							<s:property value="repUser==null?repAdmin.username:repUser.username"/>
					</td>
				</tr>



					<tr id="tr-topLevel">
						<td colspan="1" width="10%" class="pn-flabel pn-flabel-h">
							上传时间:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<input class="Wdate" type="text"
								style="width: 140px" name="addtime"
								value="<s:date name="addtime" format="yyyy-MM-dd HH:mm:ss" />" disabled="disabled" />
						</td>
					</tr>
					<tr id="tr-topLevel">
						<td colspan="1" width="10%" class="pn-flabel pn-flabel-h">
							发布时间(即通过审核的时间):
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<input class="Wdate" type="text"
								style="width: 140px" id="passtime" name="passtime"
								value="<s:date name="passtime" format="yyyy-MM-dd HH:mm:ss" />" />
						</td>
					</tr>


					<tr id="tr-topLevel">
						<td colspan="1" width="10%" class="pn-flabel pn-flabel-h">
							更新时间:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<input class="Wdate" type="text"
								style="width: 140px" id="updatetime" name="updatetime"
								value="<s:date name="updatetime" format="yyyy-MM-dd HH:mm:ss" />" />
							<span class="pn-fhelp">留空则为当前时间</span>
						</td>
					</tr>


					<tr id="tr-topLevel">
						<td colspan="1" width="10%" class="pn-flabel pn-flabel-h">
							审核:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<label><input type="radio" name="ispassed" value="0"/>未审核</label>
							<label><input type="radio" name="ispassed" value="1"/>已通过</label>
							<label><input type="radio" name="ispassed" value="-1"/>已退回</label>
							<div class="notpassreason" style="display: none;">未通过原因：<input name="notpassreason" type="text" value="<s:property value='notpassreason' />"/></div> 
						</td>
					</tr>

					<tr id="tr-typeId">
						<td width="10%" class="pn-flabel pn-flabel-h">
							资源类型:
						</td>
						<td colspan="3" width="40%" class="pn-fcontent">
							<s:property value='RepGscatalog.name' />
						</td>
					</tr>

					<tr>
						<td width="10%" class="pn-flabel">
							资源路径
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">

							<div id="result" style="color: red; height: 25px;">
								<s:property value="path" />
							</div>

						</td>
					</tr>
					
					<tr>
						<td width="10%" class="pn-flabel">
							预览文件路径
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">

							<div id="result" style="color: red; height: 25px;">
								<s:property value="translateurl" />
							</div>

						</td>
					</tr>
					<tr id="upload">
						<td width="10%" class="pn-flabel">
							更新资源:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<div id="fileQueue" style="height:auto;"></div>
							<input type="file" name="uploadify" id="uploadify" />
							<input type="hidden" id="resourcepath"  
								name="resourcepath"
								value="<s:property value='path'/>" 
								class="required" />
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
				'multi'          : false,
			    'removeCompleted': true,
				'buttonImg'      : '${pageContext.request.contextPath }/thirdparty/uploadify/images/update.gif',
				'height':30,
				'width':30,
			 	'fileDataName'   : 'uploadify', //和input的name属性值保持一致就好，Struts2就能处理了  
				 'onComplete'    : function (event, queueID, fileObj, response, data){
					                   	var uploadInfoArray=eval("("+response.toString()+")");
				 						if(uploadInfoArray!=null&&uploadInfoArray.length>0){
				 							$("#uploadifyoption").html("");
				 							for(var i=0;i < uploadInfoArray.length;i++){
				 								var info=uploadInfoArray[i];
					 							($("#resourcepath").val()==null||$("#resourcepath").val()=="")?
    	           									$("#resourcepath").val(info.path):
	    	            							$("#resourcepath").val($("#resourcepath").val()+"<path/>"+info.path);
	    	           							$("#uploadifyoption").append(info.path+"<font color=red>"+info.message+"</font><br/>");
				 							
				 							}
	                						
	                						$("#uploadify").remove();
    	           							$("#uploadifyUploader").remove();
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

					
					<tr id="tr-pictures">
						<td class="pn-flabel" width="10%">
							封面图片:
						</td>
						<td class="pn-fcontent" width="90%" colspan="3">
							<div style="float: left; width: 150px;">
								<input class="add-picture" id="add-picture" type="button"
									value="增加一张图片">
								<input type="hidden" id="topimg" name="topimg" />
							</div>
							<div id="topimgdiv"
								style="float: left; width: 100px; height: 100">
							</div>
						</td>
					</tr>
					<tr id="tr-txt">
						<td class="pn-flabel pn-flabel-h" width="10%">
							内容:
						</td>
						<td colspan="3" width="90%" class="pn-fcontent">
							<textarea class="ckeditor" cols="100" rows="20" id="content"
								name="content">
								<s:property value="content" />
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
						value="<s:property value="pointsneed"/>"
						class="{digits:true,range:[0,100]}" />
						
					</td>
				</tr>
				<tr>
					<td colspan="4" class="pn-fbutton">
						<input type="submit" value="提交"  class="manhuaTip submit" ty="loading" msg="正在等待后台生成预览文件......<br/>如响应时间过长可以先进行其他操作:<a href='resource_list.do'>返回</a><br/>如多次上传均无响应请到系统配置重启预览文件生成服务。" />

					</td>
				</tr>
			</table>
		</form>
		</div>
		<div class='msgbox_layer_wrap' style="display: none;">
			<span id='mode_tips_v2' style='z-index: 10000;' class='msgbox_layer'>
			<span class="loadimg"><img src="${pageContext.request.contextPath}/thirdparty/jquerymsg/images/loading.gif"/></span>
			</span>
		</div>
		<div id='blackCover' style="display: none;">
		</div>
	</body>
</html>