	// =====================================================================================
	// CUSTOM MURA CMS SCRIPTS
	// =====================================================================================

	// Primary Nav sub-text
	jQuery(document).ready(function($) {
		$('#navPrimary > li > a').each(function(index, element) {
			$(this).wrapInner('<strong />');
			var oldStr = $(this).html();
			var newStr = oldStr.replace("(","</strong><span>").replace(")</strong>","</span>");
			$(this).html(newStr);
		});
		$("h2.pageTitle").append("<span></span>");
	});