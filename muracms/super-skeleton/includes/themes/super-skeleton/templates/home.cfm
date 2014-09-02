<cfoutput>
<cfinclude template="inc/html_head.cfm" />
<body id="#$.getTopID()#" class="#$.createCSSid($.content('menuTitle'))#">

<cfinclude template="inc/header.cfm" />

<!-- Super Container -->
<div class="super-container full-width" id="section-slider">

	<!-- 960 Container -->
	<div class="container">
		
		<!-- Row Break 
		<div class="sixteen columns" id="page-header">
			<br class="clear" />
			<hr />
		</div>
		/End Row Break-->				
		 
		<!-- Full Width Slider -->
		
		<cfset feed=$.getBean("feed").loadBy(name="Home Slideshow",siteID=$.event("siteid"))>
		<cfset iterator=feed.getIterator()>
		
		<div class="sixteen columns">
			
			<div class="slider-shadow">
				<div class="flexslider-container">
					<div class="flexslider">
					  <ul class="slides">
					<cfif iterator.hasNext()>
					  <cfloop condition="iterator.hasNext()">
					  <cfset item=iterator.next()>
					    <li>
					      <a href="#item.getImageURL(height=392,width=940)#" data-rel="prettyPhoto[SuperSkeleton]">
					      	<img src="#item.getImageURL(height=392,width=940)#" alt="SuperSkeleton" />
					      </a>
					      <cfif len(#item.getSummary()#) ><div class="flex-caption">#item.getSummary()#</div></cfif>
					    </li>
					  </cfloop>
					  </cfif>
					  </ul>
					</div>
				</div>			
			</div>
			
		</div>		
		<!-- /End Full Width Slider-->

	</div>
	<!-- /End 960 Container -->
	
</div>
<!-- /End Super Container -->


<!-- ============================================== -->


<!-- Super Container -->
<div class="super-container full-width" id="section-thirds">

	<!-- 960 Container -->
	<div class="container">
		#$.dspBody(body=$.content('body'),pageTitle="",crumbList=0,showMetaImage=0)#
		#$.dspObjects(2)#		
	</div>
	<!-- /End 960 Container -->

</div>
<!-- /End Super Container -->

<cfinclude template="inc/footer.cfm" />

</body>
</html>
</cfoutput>

