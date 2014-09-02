
;(function ($) {

    $.fn.MultiField = function (options) {

        options = $.extend({
            addtext: 'Add Another',
            linkClass: 'addmorefields',
            removable: true,
            removetext: 'Remove',
            removeLinkClass: 'removefields',
            confirmremove: false,
            confirmmsg: 'Are you sure to remove?',
            maxitem: null,
			countField:"#t",
	
        },
        options);

        return this.each(function () {

            var self = $(this);
			self.parent().prepend(' <input type="hidden" id="t"  />');	
			
			
			
			$(options.countField).val("0");
            $(self).find("." + options.linkClass).remove();
            $(self).find("." + options.removeLinkClass).remove();
            $(self).append(" <a href='#' class='" + options.linkClass + "'>" + options.addtext + "</a>");			
            $(self).find("." + options.linkClass).click(function () {
                return Add($(this));
            });

            var myClone = $(self).clone();

           var Add  =  function (elem) {
				
				
				var content = parseInt($(options.countField).val());
					content = content+1;
					$(options.countField).val(content);	
					
                    var newElem = myClone.clone();

					

                    $(newElem).find("*[id!=''][name!='']").each(function () {

                        if ($(this).attr("id")) {
                            var strid = $(this).attr("id");
                            var strname = "";

                            if ($(this).attr("name")) {
                                strname = $(this).attr("name");
                            }

                            $(this).attr("id", strid + "_" + content);
							
                            //$(this).attr("name", strname + "" + fieldCount);
                        }
                    });

                    $(elem).parent().after(newElem);
                    $(elem).parent().find("." + options.linkClass).remove();
					//$(elem).parent().find("." + options.removeLinkClass).remove();

                    $(newElem).find("." + options.linkClass).remove();
                  $(newElem).find("." + options.removeLinkClass).remove();
		
                    if (options.removable) {
                        if ($(newElem).find("." + options.removeLinkClass).length === 0) {
                           $(newElem).append(" <a href='#' class='" + options.removeLinkClass + "'>" + options.removetext + "</a>");
                        }
                      
					  $(newElem).find("." + options.removeLinkClass).click(function () {
                            return Remove($(this));
                        });
					  
                    }

						
					
				ccontent = parseInt(content+2);
				if(options.maxitem!==null && options.maxitem<ccontent)
				{
			
				} else {
				
					$(newElem).append(" <a href='#' class='" + options.linkClass + "'>" + options.addtext + "</a>");
					
				}
					


                    newElem.find("." + options.linkClass).click(function () {
                        return Add($(this));
                    });


                return false;
            }


          var Remove  =  function(elem) {
				
				
			var content = parseInt($(options.countField).val());
					content = content-1;
					$(options.countField).val(content);
				
				
                var cnt = true;

					


                if (options.confirmremove) {
                    cnt = confirm(options.confirmmsg);
                }
                if (cnt) {
                    var prevParent = $(elem).parent().prev();
					
                    if ($(elem).parent().find("." + options.linkClass).length > 0) {
                        if (options.removable && $(self).attr("uniqueId") != $(prevParent).attr("uniqueId")) {
                            if ($(prevParent).find("." + options.removeLinkClass).length === 0) {
                                $(prevParent).append(" <a href='#' class='" + options.removeLinkClass + "'>" + options.removetext + "</a>");
                            }

                            $(prevParent).find("." + options.removeLinkClass).click(function () {
                                return Remove($(this));
                            });
                        }

                        $(prevParent).append(" <a href='#' class='" + options.linkClass + "'>" + options.addtext + "</a>");

                        prevParent.find("." + options.linkClass).click(function () {
                            return Add($(this));
                        });
                    }

                    if (options.maxitem !== null && content < options.maxitem) {
                        $(self).siblings().find("." + options.linkClass).fadeIn();
                    }

                    $(elem).parent().remove();

                  
                }
                return false;
            }
        });

    };
})(jQuery);