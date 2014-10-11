/***
 * 漫画Jquery时间插件
 * 编写时间：2012年7月14号
 * 修改:z
 * version:manhuaTip.1.0.js
***/
$(function() {
	$.fn.manhuaTip = function(options) {
		var defaults = {
			Event : "click",
			timeOut : 2000,
			loadimg:"../../thirdparty/jquerymsg/images/loading.gif"
		};
		var options = $.extend(defaults,options);
		var $tip = $(this);
		$tip.live(options.Event,function(e){	
			var pathValue=$("input[name=resourcepath]").val();
			if(pathValue==null||pathValue==""){
				return ;
			}
			
			
			var type = $(this).attr('ty');		
			var msg = $(this).attr('msg');
		  	var tipHtml = '';
			if (type =='loading'){
				tipHtml = '<span class="loadimg"></span>'+(msg ? msg : '正在提交您的请求，请稍候...');
			} else if (type =='notice'){
				tipHtml = '<span class="gtl_ico_hits"></span>'+msg
			} else if (type =='error'){
				tipHtml = '<span class="gtl_ico_fail"></span>'+msg
			} else if (type =='succ'){
				tipHtml = '<span class="gtl_ico_succ"></span>'+msg
			}
			if ($('.msgbox_layer_wrap')) {
				$('.msgbox_layer_wrap').remove();
			}
			$("body").prepend("<div class='msgbox_layer_wrap'><span id='mode_tips_v2' style='z-index: 10000;' class='msgbox_layer'>"
				+tipHtml+"</span></div><div id='blackCover'></div>");
			$(".msgbox_layer_wrap").show();
			
			$("#blackCover").css({
				"width":$("body").width(),
				"height":$("body").height()
			});
			
		});	
	}
});