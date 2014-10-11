/**
 *@author Z
 *2013-10-25 20:56
 *E-mail:464631487@qq.com
 */

;(function($) {

	$.extend($.fn, {
		treeview_addon:function(options){
			var defaults = {
				jsonArray : null,
				jsonUrl:"",//通过url获取json数据，暂时未完成。
					/*in the jsonArray,the key of json will become the a tag's href or the value of the input tag, 
						and the value is also a json data made by two key-value, "text"(string,the display text of the tree's leaves) and "children"(jsonArray,the children of this 
						 branch).
					eg.	 [
							{
								"1":{
									"text":"Item1",
									"children":
										[
											{
												"2":{
														"text":"Item2",
														"children":[]
													}
											}
										]
									}
							}
						 ]
					*/
				inputType:false,/*you can choose checkbox,radio. if you don't want input support, you can write false*/
				inputName:false,
				leavesTag:"span",/*just like the treeview support, you can use a or span, */
				folderAHref:"",/*文件夹的链接，未完成*/
				fileAhref:"",/*文件的链接，未完成*/
				target:"_blank",
				aHref:"javascript:;",
				checkedArray:[],/*已经选择的列表，数组的元素是checkbox的value值。可以写"checkall"代表全选*/
					
				partCheckedImageSrc:"./treeviewaddon/partChecked.jpg",
				
				
				
				/*properties below belong to jquery.treeview*/
				
				control: null,
				animated: "fast",
				collapsed: true,
				unique: true,
				persist: "cookie",
				toggle: function() {}
			};
			var options = $.extend(defaults,options);
			var $this=$(this);
			if(options.jsonArray!=null){
				$this.html(getTreeHtml(options.jsonArray));
			}
			$this.treeview({
				animated: options.animated,
				persist: options.persist,
				collapsed: options.collapsed,
				unique: options.unique,
				toggle: options.toggle
			})
			
			
			if(options.inputType=="checkbox"){

	
				/*初始化已经选择的input标签*/
				if(options.checkedArray=="checkall"){
					$this.find("li input:checkbox").attr("checked",true);
				}else if(options.checkedArray.length>0){
					for(var i in options.checkedArray){
						$this.find("li input[value='"+options.checkedArray[i]+"']").attr("checked",true);
					}
				}
				
				
				var inputs=$this.find("input:"+options.inputType);
				inputs.click(function(e){
					updateCheckBoxStates($(this));
				}).each(function(index, element) {
					var input=inputs.eq(index);
					if(input.nextAll("ul").length==0){
						updateCheckBoxParentsStates(input);
					}
				});
			}
			
			
			function getTreeHtml(jsonArray){
				var treeHtml="";

				recurseTreeHtml(jsonArray);
				return treeHtml;
				
				function recurseTreeHtml(jsonArray){
					
					for(var i =0;i<jsonArray.length;i++){
						treeHtml+="<li>";
						var value,treeItem;
						for(var ind in jsonArray[i])
						{
							value=ind;
							treeItem=jsonArray[i][ind];
						}
						if(options.inputType){
							treeHtml+="<input type=\""+options.inputType+"\"";
							if(options.inputName){
								treeHtml+=" name=\""+options.inputName+"\"";
								treeHtml+=" value=\""+value+"\"";
							}
							treeHtml+=" />";
						}
						
						treeHtml+="<"+options.leavesTag+" "+
							((options.leavesTag=="a")?
								"href=\""+options.aHref+value+"\""
								+" target=\""+options.target+"\" "
								:"")
							+">"+treeItem.text+"</"+options.leavesTag+">";
						
						if(treeItem.children.length>0){
							treeHtml+="<ul>"
							recurseTreeHtml(treeItem.children);
							treeHtml+="</ul>";
						}
						
						treeHtml+="</li>"
					}		
				};
				
			}
			
			function updateCheckBoxStates($this)
			{
				if($this.attr("checked")=="checked"||$this.attr("checked")==true)
				{
					//update lower chechbox's states
					$this.nextAll("ul").find("input:"+options.inputType).attr("checked",true)
						.css("display","inline").next("img").remove();
					//update upper chechbox's states
					updateCheckBoxParentsStates($this);
				}else{
					//update lower chechbox's states
					$this.nextAll("ul").find("input:"+options.inputType).attr("checked",false)
						.next("img").css("display","inline").remove();
					//update upper chechbox's states
					updateCheckBoxParentsStates($this);
				}
			}
			
			
			//update the states of the upper checkbox 
			function updateCheckBoxParentsStates($this)
			{
				var parents = findCheckBoxParents($this);
				for(i in parents){
					var parent=parents[i];
					var children=parent.nextAll("ul").find("input:"+options.inputType);
					var allChecked=true;
					var allNotChecked=true;
					children.each(function(ind){
						if(children.eq(ind).attr("checked")=="checked"||children.eq(ind).attr("checked")==true){
							allNotChecked=false;
						}else{
							allChecked=false;
						}
					});
					if(allChecked){
						parent.attr("checked",true);
							if(parent.next().is("img")){
								parent.css("display","inline").next("img").remove();
							}
					}else if(allNotChecked){
						parent.attr("checked",false);
							if(parent.next().is("img")){
								parent.css("display","inline").next("img").remove();
							}
					}else{
						parent.attr("checked",false);
						if(!parent.next().is("img")){
							parent.css("display","none").after("<img src='"+options.partCheckedImageSrc+"' class='partChecked' />")
								.next("img").click(function(){
									parent.click();
									if(parent.attr("checked")=="checked"||parent.attr("checked")==true){
										parent.css("display","inline").next("img").remove();
									}else{
										parent.css("display","none").after("<img src='"+options.partCheckedImageSrc+"' class='partChecked' />");
									}
									updateCheckBoxStates(parent);
								});
						}
						//css("background","url(./images/partChecked.jpg)");
					}
				}
						
			}
			
			//find the upper checkbox
			function findCheckBoxParents(c)
			{
				var checkBoxParents=new Array();
				function pushCheckBoxParent(cc)
				{
					//alert(cc.parent().parent().html());
					var checkBoxParent=cc.parent().parent().prevAll("input:"+options.inputType);
					if(checkBoxParent.length>0){
						checkBoxParents.push(checkBoxParent);
						pushCheckBoxParent(checkBoxParent);
					}
				}
				
				pushCheckBoxParent(c);
				return checkBoxParents;
				
			}
			
		}
	});
	
})(jQuery);