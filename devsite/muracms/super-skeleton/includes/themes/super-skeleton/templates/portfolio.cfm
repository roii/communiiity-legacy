<cfoutput>
<cfinclude template="inc/html_head.cfm" />
<body id="#$.getTopID()#" class="twoColSR depth#arrayLen($.event('crumbdata'))# #$.createCSSid($.content('menuTitle'))#">
	<cfinclude template="inc/header.cfm" />
	

<!-- Super Container -->
<div class="super-container full-width content" id="section-thirds">
	<!-- 960 Container -->
	<div class="container">

		
		<div class="sixteen columns" id="page-header">
			<h2 class="title"><span>#$.content('title')#</span></h2>
			<hr />
			<cfif len($.content('ssSupertagline'))>
				<span class="supertagline">
					#$.content('ssSupertagline')#
				</span>
				<br class="clear" />
				<hr />
			</cfif>
		</div>
		
	</div>
	<!-- /End 960 Container -->

</div>
<!-- /End Super Container -->
<!-- ============================================== -->
	
<!-- Super Container -->
<div class="super-container full-width">

	<!-- 960 Container -->
	<div class="container">
		
		<!-- CONTENT -->
				#$.dspBody(body=$.content('body'),pageTitle='',crumbList=0,showMetaImage=0)#
				#$.dspObjects(2)#	
		<!-- /CONTENT -->

		
	</div>
	<!-- /End 960 Container -->
		
</div>
<!-- /End Super Container -->
	
	<cfinclude template="inc/footer.cfm" />
</body>
</html>
</cfoutput>
