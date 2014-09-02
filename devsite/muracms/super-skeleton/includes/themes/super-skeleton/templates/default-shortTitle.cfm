<cfoutput>
<cfinclude template="inc/html_head.cfm" />
<body id="#$.getTopID()#" class="twoColSR depth#arrayLen($.event('crumbdata'))# #$.createCSSid($.content('menuTitle'))#">
	<cfinclude template="inc/header.cfm" />
	
<!-- Super Container -->
<div class="super-container full-width">

	<!-- 960 Container -->
	<div class="container">
	
		<cfset objects3=trim($.dspObjects(3))>
		
		<!-- CONTENT -->
		<div class="<cfif len(objects3)>eleven<cfelse>sixteen</cfif> columns content">
			
			<div id="page-header">
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

			<cfif $.content('subType') eq 'blog'>
			<!--- BLOG SUBTYPE OUTPUT --->
			
				<!-- ENTRY COLUMN -->
				<div id="entry" class="single">
						
					<!-- THE POST LOOP -->
					<h2 class="title"><span>#$.content('title')#</span></h2>
					
					<hr class="half-bottom"/>
					<cfif lsisDate($.content('releaseDate')) or len($.content('credits')) or len($.content('tags'))>
					<div class="date">Posted
						<cfif lsisDate($.content('releaseDate'))> on #LSDateFormat($.content('releaseDate'),'long')#</cfif>
						<cfif len($.content('credits'))><!---<cfif lsisDate($.content('releaseDate'))>,</cfif>---> by #$.content('credits')#</cfif>
						<cfif len($.content('tags'))> in 
						
						<cfset tagLen=listLen($.content('tags')) />
						
							<!---#$.rbKey('tagcloud.tags')#: --->
							
							<cfloop from="1" to="#tagLen#" index="t">
								<cfset tag=#trim(listgetAt($.content('tags'),t))#>
								<a href="#$.createHREF(filename='#$.event('currentFilenameAdjusted')#/tag/#urlEncodedFormat(tag)#')#" rel="category tag">#tag#</a><cfif tagLen gt t>, </cfif>
							</cfloop>
							
						</cfif>
					</div>
					<hr />
					</cfif>
					<cfif listFindNoCase("jpg,jpeg,png,gif",$.content("fileExt"))>
						<a href="#$.content().getImageURL('large')#" data-rel="prettyPhoto">
							<img src="#$.content().getImageURL(height=500,width=700)#"/>
						</a>
					</cfif>
					
					<!-- THE_CONTENT -->
					<div class="the_content" class="post type-post hentry">
					#$.dspBody(body=$.content('body'),pageTitle='',crumbList=0,showMetaImage=0)#
					<!--- TAGS --->
						<cfif len($.content('tags'))>
							<cfset tagLen=listLen($.content('tags')) />

							<hr class="half-bottom"/>
							<!-- META AREA -->
							<div class="meta-space">
								<div class="tags clearfix">
									<img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/tag.png" class="tag_icon" />
									<cfloop from="1" to="#tagLen#" index="t">
										<cfset tag=#trim(listgetAt($.content('tags'),t))#>
										<a href="#$.createHREF(filename='#$.event('currentFilenameAdjusted')#/tag/#urlEncodedFormat(tag)#')#" rel="tag" class="button yellow">#tag#</a><!---<cfif tagLen gt t>, </cfif>--->
									</cfloop>
								</div>
							</div> 
							<!-- /META AREA -->
						</cfif>
					#$.dspObjects(2)#
					</div>
				<!--- END BLOG OUTPUT --->
			
			<cfelse>
				<!--- DEFAULT OUTPUT --->
				#$.dspBody(body=$.content('body'),pageTitle='',crumbList=0,showMetaImage=0)#
				<!--- TAGS --->
					<cfif len($.content('tags'))>
						<cfset tagLen=listLen($.content('tags')) />

						<hr class="half-bottom"/>
						<!-- META AREA -->
						<div class="meta-space">
							<div class="tags clearfix">
								<img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/tag.png" class="tag_icon" />
								<cfloop from="1" to="#tagLen#" index="t">
									<cfset tag=#trim(listgetAt($.content('tags'),t))#>
									<a href="#$.createHREF(filename='#$.event('currentFilenameAdjusted')#/tag/#urlEncodedFormat(tag)#')#" rel="tag" class="button yellow">#tag#</a><!---<cfif tagLen gt t>, </cfif>--->
								</cfloop>
							</div>
						</div> 
						<!-- /META AREA -->
					</cfif>
				#$.dspObjects(2)#
				<!--- END DEFAULT OUTPUT --->
			</cfif>
		</div>
		<!-- /CONTENT -->
				
		<cfif len(objects3)>
		<!-- SIDEBAR -->
		<div class="five columns sidebar">
			#$.dspObjects(3)#
		</div>
		<!-- /SIDEBAR -->
		</cfif>

		
	</div>
	<!-- /End 960 Container -->
		
</div>
<!-- /End Super Container -->
	
	<cfinclude template="inc/footer.cfm" />
</body>
</html>
</cfoutput>
