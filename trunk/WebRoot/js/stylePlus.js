// JavaScript Document
function homePage(obj) {
    var url = window.location.href;
    try {
        obj.style.behavior = 'url(#default#homepage)';
        obj.setHomePage(url);
    }
    catch(e) {
        if (window.netscape) {
            try {
                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            }
            catch(e) {
                alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
            }
            var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
            prefs.setCharPref('browser.startup.homepage', url);
        }
    }
}

function addfavor(url,title) {
    if(confirm("网站名称："+title+"\n网址："+url+"\n确定添加收藏?")){
        var ua = navigator.userAgent.toLowerCase();
        if(ua.indexOf("msie 8")>-1){
            external.AddToFavoritesBar(url,title,'');//IE8
        }else{
            try {
                window.external.addFavorite(url, title);
            } catch(e) {
                try {
                    window.sidebar.addPanel(title, url, "");//firefox
                } catch(e) {
                    alert("加入收藏失败，请使用Ctrl+D进行添加");
                }
            }
        }
    }
    return false;
}
/*提交表单*/
function submitForm(f)
{
	var inputs=f.find("input");
	inputs.each(function(index,element){
		var input=inputs.eq(index);
		if(input.attr("name").indexOf("password")==-1)
			input.val($.trim(input.val()));
	});
	
	f.submit();
}

function submitSearchForm()
{
	var searchInput=$("#searchForm input[name=searchkey]");
	if(searchInput.val()=="请输入您要查询的关键字"){
		searchInput.val("");
	}
	$("#searchForm").attr("action",$("#searchForm").attr("action")+searchInput.val())
		
	$("#searchForm").submit();
}

/*表单提示*/
function formHint()
{
	var searchInput=$("#searchForm input[name=searchkey]");

	if(searchInput.val()=="请输入您要查询的关键字")
		searchInput.css("color","#ccc");
	
	searchInput.blur(function(e) {
        if(searchInput.val()=="")
			searchInput.val("请输入您要查询的关键字").css("color","#ccc");
			
    }).focus(function(e) {
        if(searchInput.val()=="请输入您要查询的关键字")
			searchInput.val("").css("color","#333");
    });;
}

/*图片轮播*/
function mySliderPlay()
{
	$('#sliderPlay').sliderPlay();
	$('#sliderPlay2').sliderPlay({
		speed:500, //动画效果持续时间
		timeout:3000,//幻灯间隔时间
		btnBox:'btnBox2', //按钮的容器id
		btnCurClassName:'cur', //当前按钮的className,
		direction:'up', //left , up 
		mouseEvent:'hover' //事件类型，默认是click ,hover
	});
}

/* 导航动画 */
function navHover(i){
	var navLis=$(".main .nav li");
	navLis.eq(i).css("background-color","#1c6ab2");
	
	navLis.hover(function(e) {
        $(this).css("background-color","#1c6ab2");
		
    },function(e){
        $(this).css("background-color","#4392da");
		navLis.eq(i).css("background-color","#1c6ab2");	
	});	
}

/*hotnews 的滚动动画*/
function hotNewsRoll()
{
	var hotNewsUl=$(".main .hotNews ul");
	var i=0;
	var liHeight=$(".main .hotNews ul li").height();
	var liLength=$(".main .hotNews ul li").length;
	setInterval(function(){
		
		hotNewsUl.animate({
			"top":liHeight*(i<=1-liLength?i=0:--i)
			},1000);
	},3000);
	
}
/*获取时间信息的方法*/
function getTimeInfo()
{
	var today=new Date();
	var day;
	switch(today.getDay())
	{
		case 0:
			day="一";
		case 1:
			day="二";
		case 2:
			day="三";
		case 3:
			day="四";
		case 4:
			day="五";
		case 5:
			day="六";
		case 6:
			day="日";
		default:
			break;
	}
	
	var timeInfo="今天是:"+today.getFullYear()+"年"+
				(today.getMonth()+1)+"月"+
				today.getDate()+"日 &nbsp;星期"+day+"&nbsp;";
				
	$(".hotNews .timeInfo").html(timeInfo);
}
/*热门视频的左右滚动动画，支持变化的视频个数*/
function videoRoll() 
{
	var videoLi=$(".main .leftPart .lBox3 ul li");
	var videoUl=$(".main .leftPart .lBox3 ul");
	var videoLiWidth=videoLi.width()+12;
	var videoLiLength=videoLi.length;
	
	videoUl.width(
			videoLiLength*videoLiWidth);
	
	var i=0;
	setInterval(function(){
		videoUl.animate({
			"left":videoLiWidth*(i<=5-videoLiLength?i=0:--i)
			},1000);
	},5000);
}

/*二三级左侧栏目动画*/
function columnTitleHover(i)
{
	var columnAs=$(".main .leftPart .lBox1 ul li a")
	
	
	columnAs.css({
				"font-weight":"normal",
				"color":"#666"
			}).parent().children(".columnLeftArrow").attr("src","images/columnArrow1.jpg");
	
	columnAs.eq(i).css({
				"font-weight":"bold",
				"color":"#1f69b0"
			}).parent().children(".columnLeftArrow").attr("src","images/columnArrow1Blue.jpg");
	
	columnAs.each(function(index, element) {
        columnAs.eq(index).hover(function(e) {
            $(this).css({
				"font-weight":"bold",
				"color":"#1f69b0"
			}).parent().children(".columnLeftArrow").attr("src","images/columnArrow1Blue.jpg");
        },function(){
			if(index===i){
				return ;
			}
			
            $(this).css({
				"font-weight":"normal",
				"color":"#666"
			}).parent().children(".columnLeftArrow").attr("src","images/columnArrow1.jpg");
		});
    });
}

function usercenterColumnHover(i){
	var columnAs=$(".main .leftPart .lBox1 ul li.lbox1Li a")
	
	columnAs.css({
				"font-weight":"normal",
				"color":"#666"
			}).parent().children(".columnLeftArrow").attr("src","images/columnArrow1.jpg");
	columnAs.eq(i).css({
				"font-weight":"bold",
				"color":"#1f69b0"
			}).parent().children(".columnLeftArrow").attr("src","images/columnArrow1Blue.jpg");
	
	columnAs.each(function(index, element) {
        columnAs.eq(index).unbind("hover").hover(function(e) {
            $(this).css({
				"font-weight":"bold",
				"color":"#1f69b0"
			}).parent().children(".columnLeftArrow").attr("src","images/columnArrow1Blue.jpg");
        },function(){
			if(index==i){
				return ;
			}
			
            $(this).css({
				"font-weight":"normal",
				"color":"#666"
			}).parent().children(".columnLeftArrow").attr("src","images/columnArrow1.jpg");
		});
    });
}


function formStyle(){
	$(".inputBox").hover(function(){
		$(this).css("border-color","#4392da");
	},function(){
		$(this).css("border-color","#ccc");
	});
	
}
function showEmail(){
	$(".formBox").animate({
		left:"-750px"
	},500);
}

function showLogin(){
	$(".formBox").animate({
		left:"0px"
	},500);
}

function initHotTags(){
	$(".hotestTags").click(function(){
		$("input[name=tagname]").val($(this).html());
		var tagStr=$("input[name=tagStr]");
		try{
			if(tagStr.length>0&&tagStr.val().indexOf($(this).html())==-1){
				if(tagStr.val()!=""&&tagStr.val()!=null){
					tagStr.val(tagStr.val()+","+$(this).html());
				}else{
					tagStr.val($(this).html());
				}
				
				
			}
		}catch(e){
			console.log('错误' + e.message + '发生在' +   e.lineNumber + '行');
		}
		
		
		
	}).hover(function(){
		$(this).css({"text-decoration":"underline"});
	},function(){
		$(this).css({"text-decoration":"none"});
	});
	$(".hotestTags").each(function(index,element){
		switch(index%9){
			case 1:
				$(".hotestTags").eq(index).css("color","#F00");
				break;	
			case 2:
				$(".hotestTags").eq(index).css("color","#0F0");
				break;	
			case 3:
				$(".hotestTags").eq(index).css("color","#00F");
				break;	
			case 4:
				$(".hotestTags").eq(index).css("color","#F90");
				break;	
			case 0:
				$(".hotestTags").eq(index).css("color","#09F");
				break;		
		}
		
	});	
}
function initResourceFormStyle(){
	var trs=$(".resourceForm table tr");
	trs.each(function(){
		$(this).find("td").eq(0).css("text-align","right");
	});
	$(".resourceForm table tr:last").find("td").css("text-align","center");
	
	var va=$("#form1").validate({
		rules: {
		   gscatalogid: {
				required:true
		   },
		   zycatalogid: {
			   required:true
		   },
		   topicid: {
			   required:true
		   },
		   resourcepath:{
			   required:true
		   },
		   topicname:{
			   required:true
		   },
		   pointsneed:{
			   required:true,
			   digits:true,
			   range:[0,100]
		   }
		}
	}); 
	
	$("input[name='pointsneed']").after("<span>请输入0-100分作为其他用户下载所需积分</span>");
	
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
}




function showTopcInput(){
	$(".selectTopic").each(function(index,element){
		$(".selectTopic").eq(index).hide(500,function(){
			$(".createtopic").eq(index).show(500);
		});
	});
	$("select[name='topicid']").append("<option value='0'>none</option>");
	$("select[name='topicid'] option").eq(1).attr("selected",true);

	$("input[name=topicname]").val("");
	$("select[name='gscatalogid'] option").eq(0).attr("selected",true);
	$("select[name='zycatalogid'] option").eq(0).attr("selected",true);
	
	$("input[name='iscreate']").val("1");
}

function showTopcSelect(){
	$(".createtopic").each(function(index,element){
		$(".createtopic").eq(index).hide(500,function(){
			$(".selectTopic").eq(index).show(500);
		});
	});
	
	$("input[name=topicname]").val("NULL");
	$("select[name='gscatalogid'] option").eq(1).attr("selected",true);
	$("select[name='zycatalogid'] option").eq(1).attr("selected",true);
	
	$("select[name='topicid'] option[value=10000000]").remove();
	$("select[name='topicid'] option").eq(0).attr("selected",true);

	$("input[name='iscreate']").val("0");
	
}

function warnPoints(p){
	return confirm("如果该资源不是您上传，下载需要扣除"+p+"积分，您确定要下载吗？");
	
}

function pageHide(){
	var pages=$("a.pageNum");
	var curPageIndex=pages.index($(".curPage"));
	
	var maxLength=5;

	pages.each(function(index,element){
		if(index<=curPageIndex-maxLength){
			pages.eq(index).css("display","none");
		}else if(index>=curPageIndex+maxLength){
			pages.eq(index).css("display","none");
		}
		
	});
	/*before方法居然是循环输出的
	*/
	if(curPageIndex-maxLength>=0){
		pages.eq(curPageIndex-maxLength).before("...");
	}else if(curPageIndex+maxLength<=curPageIndex){
		pages.eq(curPageIndex+maxLength).after("...");
	}
	
	
}
