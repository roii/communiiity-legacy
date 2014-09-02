/*!
 * jQuery Based Multiple select box to Tag Suggssion
 * http://www.richmediabd.com/
 *
 * Copyright 2011, Emran Ahmed
 * Email: emran.bd.08@gmail.com 
 * Licensed under the GNU General Public License (GPL).
 * Example:
 
 $('.suggest').select2tag({
            
			'limit' : 10,	//  Displaying tag suggssion limit
			'csstop':25,	//  Suggssion list absolute css top
			'hidesuggssion':300	//	Hide suggssion after 300 ms. when mouseout from suggssion list.
        });


 */


;(function ($) {
	
	$.fn.extend({
		
		
		"select2tag":function(options){	
		var setting  = {
            
			'limit' : 10,
			'csstop':25,
			'hidesuggssion':300
        }
					
				var settings = $.extend(setting,options);
				return this.each(function(){
				$this = $(this);
			
				 _this = this;
				
				var $id = $this.attr('id');
				
				
				
				
				
				$name = $this.attr('name');
				
				
				$this.hide();
				
				$width = $this.width()+'px';
				
				$this.before('<ul class="hidden_items" id="mainulID" style="width:'+$width+'"><li><input  type="text" value="" id="selectTextID" name="selectText" /></li></ul><ul class="suggest_item"></ul>');
				
				
				
				$this.find('option:selected').each(function(){
					
					
					$id = $.trim($(this).val());
					$content = $(this).html();
					
					
					if( $id!='' )
					{
					
					$(this).parent().prev().prev().find('li:last').before('<li><input type="hidden" value="'+$id+'"  /> <span>'+$content+'</span><a href="javascript:;">&times;</a></li>');
					
					
					
					if( $(this).parent().attr('multiple')==false )
					{
						
						$(this).parent().prev().prev().find('li:last input').attr('disabled', 'disabled');
						
					
						
					}
					
					
					}
					
					
					
					
					
					
					
					
					
					
					
					});
				
				
				
							
				
				
				
				$('.hidden_items').live('click',function(){
					
					
					$(this).find('input[type=text]').focus();
					
					
					
					});
				
			
			
				$('.hidden_items input').attr('autocomplete','off');
				
				
				$.time;
				

				
				
				$('.hidden_items li a').live('click', function(){
					
					
					
					
		
					if( $(this).parents('.hidden_items').next().next().attr('multiple')==false )
					{
						
						
					$(this).parents('.hidden_items').find('li:last input').removeAttr('disabled');
						
					}
					
					
					
					
					$id = $(this).prev().prev().val();
					
					$(this).parents('.hidden_items').next().next().find('option[value='+$id+']').removeAttr('selected');
					
					
					$(this).parents('.hidden_items').find('li:last input').val('');
					$(this).parents('.hidden_items').find('li:last input').focus();
					$(this).parents('.hidden_items').next().html('');
					$(this).parent().remove();
					
					
					
					
					
					
					
					
					
					
					
					})
				/**
				On click
				*/
				
				
				
				$('.suggest_item').live('mouseover', function(){
					
					
					
					clearTimeout( $.time );
					
					
					
					});
				
				
				
				
				
				
				
				
				$('ul.suggest_item').live('mouseleave', function(){
					
					
					
					
					
					
					$listeditem = $(this).prev();
					$suggitem = $(this);
					
			
					
					
					
					
					
					
						  
						  $.time = setTimeout(function(){
						  
						  
						  $suggitem.html('');	
						  $listeditem.find('li:last input').val('');								
						  $listeditem.find('li:last input').focus();
						  
						  
						  
						  }, settings.hidesuggssion)
				
					
					
					
					});
				
				
				
			
			$('ul.suggest_item li').live('click', function(){
					
					
					$listeditem = $(this).parent().prev();
					$suggitem = $(this).parent();
					$content = $(this).html();
					$id = $(this).attr('rel');
					
					$selectbox = $(this).parent().next();
					
					
					
					
					
					
					
					
					
					
					
					
					
					$selectbox.find('option[value='+$id+']').attr('selected', 'selected');
					
					
					$listeditem.find('li:last').before('<li><input type="hidden" value="'+$id+'"  /> <span>'+$content+'</span><a href="javascript:;">&times;</a></li>');
					
					$listeditem.find('li:last input').val('');
					$listeditem.find('li:last input').focus();
					
					
					$suggitem.html('');
					
					
					
					
					
					if( $selectbox.attr('multiple')==false )
					{
						
						
					$listeditem.find('li:last input').attr('disabled', 'disabled');
						
					}
					
					
					
					
				});
				
				
				
				
				/**
				
				on key up
				
				*/
			
			$('.hidden_items input').live('keyup', function(){
				
			
				
				
			
				
				
				
				
				
			
				$inputvalue = $(this).val();
				$input = $(this);
				$suggitem = $(this).parent().parent().next();
				$select = $(this).parent().parent().next().next();
				$inputcontainer = $(this).parent().parent();
				
				
				
				
				
				if( $select.attr('multiple')==false )
				{
			
				$selectednow = $.trim($select.find('option:selected').val());
				
				
				
				if( $selectednow!='' )
				{
					
					$input.attr('disabled', 'disabled');
					
				}
				
				
				
				
				}
				
				
				
				
				
				
				
				$css =  $input.offset().top+settings.csstop ;
				
				//$suggitem.css('left', -$css);
				$suggitem.css('top', $css);
				
				
			
				
				
				$suggitem.html('');
				
				
				
				var allValue = $inputvalue.split(settings.separator);
				$lastitem = allValue.length-1;
				
				$val =  $.trim( allValue[$lastitem] );
				
				if( $val=='' )
				{				
					return $this;	
				}
				
				
				
				//alert( $lastitem );
				
				
				
				
				
				var pattern=new RegExp("^"+$val+"","gi");
				
				var total =  $select.find('option').length;
				
				
				
				
				var inc = 0;
				
				
				for(i=0; i<total; i++)
				{
				
				
				var thisid = $select.find('option').eq(i).attr('value');
				var str = $.trim($select.find('option').eq(i).html());
				
							
				if( str.match(pattern)!=null )
				{
							
				
				
				 if( settings.limit > inc )
				 {
					  
					 $selected = $inputcontainer.find('input:hidden').length;
						 
					$return=false;
						 
						 for(j=0; j<$selected; j++)
						 {
							 
							 
							 $currentvalue = $inputcontainer.find('input:hidden').eq(j).val();
							if(  $currentvalue==thisid  )
							{ $return=true;  }
						
							 
							 
						}
						 
						 
						 
					 
					if( $return )
					{ continue; }
					
					 
					  inc++;
					  
					 //alert( str );
					 
					 
					 
					  
					 $suggitem.append('<li rel="'+thisid+'">'+str+'</li>');
					  
					  
				 }
				  
				
				}
				
				
					
				
				}
				
				
				
				});
			
			
			
			


				// end
				});
				
			},
		
	});
	
	
})(jQuery);