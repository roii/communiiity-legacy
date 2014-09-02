<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->
<cfsilent>
	<cfif not structKeyExists(arguments,"type")>
		<cfset arguments.type="Feed">
	</cfif>
	
	<cfif not structKeyExists(arguments,"fields")>
		<cfset arguments.fields="Date,Title,Image,Summary,Credits,Tags">
	</cfif>
	
	<cfset hasImages=listFindNoCase(arguments.fields,"Image")>
	
	<cfif hasImages>
		<cfif not structKeyExists(arguments,"imageSize") or not listFindNoCase("small,medium,large,custom", arguments.imageSize) or $.event("muraMobileRequest")>
			<cfset arguments.imageSize="small">
		</cfif>
		<cfif not structKeyExists(arguments,"imageHeight")>
			<cfset arguments.imageHeight="auto">
		</cfif>
		<cfif not structKeyExists(arguments,"imageWidth")>
			<cfset arguments.imageWidth="auto">
		</cfif>
		
		<cfif not structKeyExists(arguments,"imagePadding")>
			<cfset arguments.imagePadding=20>
		</cfif>

		<cfset imageStyles='style="#$.generateListImageSyles(size=arguments.imageSize,width=arguments.imageWidth,height=arguments.imageHeight,padding=arguments.imagePadding)#"'>
	</cfif>
</cfsilent>
<!--- Filter Nav --->
<cfoutput>



<div class="sixteen columns portfolio-nav">
	<p class="portfolio-filters" id="portfolio-filter">
		<span>Filters:</span>
		<a class="button" href="##all">All</a>
		<cfsilent>
		<cfset tags=$.getBean('contentGateway').getTagCloud($.event('siteID'),$.content('contentID')) />
		</cfsilent>
		
		
		<cfif tags.recordcount>
		<cfoutput>
		<cfloop query="tags">
		<a class="button" href="###urlEncodedFormat(tag)#">#htmlEditFormat(tags.tag)#</a>
		</cfloop>
		</cfoutput>
		</cfif>
	</p>
	
	<p class="portfolio-view">
		<span>Layout:</span>
		<span class="grid_btn <cfif $.content('subType') eq 'portfolio2Column'>2<cfelseif $.content('subType') eq 'portfolio3Column'>3<cfelseif $.content('subType') eq 'portfolio4Column'>4</cfif>-col-grid"><img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/btn_grid.png" alt="Grid View" /></span> 
		<span class="hybrid_btn <cfif $.content('subType') eq 'portfolio2Column'>2<cfelseif $.content('subType') eq 'portfolio3Column'>3<cfelseif $.content('subType') eq 'portfolio4Column'>4</cfif>-col-hybrid"><img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/btn_hybrid.png" alt="Hybrid View" /></span>
		<span class="list_btn <cfif $.content('subType') eq 'portfolio2Column'>2<cfelseif $.content('subType') eq 'portfolio3Column'>3<cfelseif $.content('subType') eq 'portfolio4Column'>4</cfif>-col-list"><img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/btn_list.png" alt="List View" /></span>
	</p>
	<br /><br />
	<hr class="half-bottom" />
</div> 
				
<!-- Portfolio Items-->  
<div id="portfolio-list" class="content">
</cfoutput>	

<cfloop condition="iterator.hasNext()">
	<cfsilent>
		<cfset item=iterator.next()>
		<cfset class=""/>
		
		<cfif not iterator.hasPrevious()> 
			<cfset class=listAppend(class,"first"," ")/> 
		</cfif>
		
		<cfif not iterator.hasNext()> 
			<cfset class=listAppend(class,"last"," ")/> 
		</cfif>
			
		<cfset hasImage=hasImages and len(item.getValue('fileID')) and showImageInList(item.getValue('fileEXT')) />
			
		<cfif hasImage>
			<cfset class=listAppend(class,"hasImage"," ")>
		</cfif>


		<!--- thisDate --->
		<cfset thisDate = '' />
		<cfif arguments.type eq "Portal" and isDate(item.getValue('releaseDate'))>
			<cfset thisDate = LSDateFormat(item.getValue('releaseDate'),$.getLongDateFormat()) />
		<cfelseif ListFind("Search,Feed,Related",arguments.type) and item.getValue('parentType') eq 'Calendar' and isDate(item.getValue('displayStart'))>
			<cfif LSDateFormat(item.getValue('displayStart'),"short") lt LSDateFormat(item.getValue('displayStop'),"short")>
				<cfset thisDate = LSDateFormat(item.getValue('displayStart'), $.getShortDateFormat()) & ' &ndash; ' & LSDateFormat(item.getValue('displayStop'), $.getShortDateFormat()) />
			<cfelse>
				<cfset thisDate = LSDateFormat(item.getValue('displayStart'), $.getLongDateFormat()) />
			</cfif>
		<cfelseif arguments.type eq "Calendar">
			<cfif LSDateFormat(item.getValue('displayStart'),"short") lt LSDateFormat(item.getValue('displayStop'),"short")>
				<cfset thisDate = LSDateFormat(item.getValue('displayStart'),$.getShortDateFormat()) & ' &ndash; ' &  LSDateFormat(item.getValue('displayStop'),$.getShortDateFormat()) />
			<cfelse>
				<cfset thisDate = LSDateFormat(item.getValue('displayStart'),$.getLongDateFormat()) />
			</cfif>
		<cfelseif LSisDate(item.getValue('releaseDate'))>
			<cfset thisDate = LSDateFormat(item.getValue('releaseDate'),$.getLongDateFormat()) />	
		</cfif>

	</cfsilent>

	<cfoutput>

			
	<div class="<cfif $.content('subType') eq 'portfolio2Column'>eight</cfif><cfif $.content('subType') eq 'portfolio3Column'>one-third</cfif><cfif $.content('subType') eq 'portfolio4Column'>four</cfif> column<cfif $.content('subType') eq 'portfolio2Column'>s</cfif><cfif $.content('subType') eq 'portfolio4Column'>s</cfif> module-container #replace(item.getValue('tags'), ',',' ','all')#">				
		<div class="module">
			<cfif hasImage>					
				<div class="module-img">							
					<a href="#item.getImageURL()#" data-rel="prettyPhoto">
						<img src="#item.getImageURL(size=arguments.imageSize,width=arguments.imageWidth,height=arguments.imageHeight)#" title="#htmlEditFormat(item.getValue('title'))#" alt="image" />
						<span></span>
					</a>							
					<div class="lightboxLink">
						<a class="popLink boxLink" href="#item.getImageURL()#" data-rel="prettyPhoto[Lightbox]" title="Lightbox"></a>
				    </div>						    
					<div class="thumbLink">
					    <a class="popLink" href="#item.getURL()#?showMeta=2" title="Full Post"></a>
				    </div>						    
				</div>
			</cfif>
			<div class="module-meta">
				<h5>#HTMLEditFormat(item.getValue('title'))#</h5>	
				<hr class="half-bottom" />
				<cfif len(item.getValue('summary')) and item.getValue('summary') neq "<p></p>">
					#$.setDynamicContent(item.getValue('summary'))#
				</cfif>
			</div>						
		</div>				
	</div>	
	</cfoutput>
</cfloop>
</div>
<!--- End Portfolio --->