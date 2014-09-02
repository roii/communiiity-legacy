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
	
	<cfset arguments.hasImages=listFindNoCase(arguments.fields,"Image")>
	
	<cfif arguments.hasImages>
		<cfif not structKeyExists(arguments,"imageSize") or not listFindNoCase("small,medium,large,custom",arguments.imageSize) or $.event("muraMobileRequest")>
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

		<cfset arguments.imageStyles='style="#$.generateListImageSyles(size=arguments.imageSize,width=arguments.imageWidth,height=arguments.imageHeight,padding=arguments.imagePadding)#"'>
	</cfif>
</cfsilent>	

<div id="entry" class="single">				
	<cfloop condition="arguments.iterator.hasNext()">
		<cfsilent>
			<cfset arguments.item=arguments.iterator.next()>
			<cfset arguments.class=""/>
			
			<cfif not arguments.iterator.hasPrevious()> 
				<cfset arguments.class=listAppend(arguments.class,"first"," ")/> 
			</cfif>
			
			<cfif not arguments.iterator.hasNext()> 
				<cfset arguments.class=listAppend(arguments.class,"last"," ")/> 
			</cfif>
				
			<cfset arguments.hasImage=arguments.hasImages and len(arguments.item.getValue('fileID')) and showImageInList(arguments.item.getValue('fileEXT')) />
				
			<cfif arguments.hasImage>
				<cfset arguments.class=listAppend(arguments.class,"hasImage"," ")>
			</cfif>
		</cfsilent>
		<cfoutput>
			<!-- THE POST EXCERPT -->	
			<div class="the_content post type-post hentry excerpt clearfix">	
				
				<cfset userBean = $.getBean("user").loadBy( userID = arguments.item.getvalue('lastupdatedid') )>
				<div class="my-avatar">
					<a href="##">
						<img class="avatar avatar-32 photo" height="32" width="32" src="<cfif len(userBean.getPhotoFileID())>#$.createHREFForImage(userBean.getSiteID(),userBean.getPhotoFileID(),"jpg", "small")#<cfelse>http://www.gravatar.com/avatar/#lcase(Hash(lcase(userBean.getEmail())))#</cfif>">
					</a>
				</div>		
				
				<h4><cfif arguments.type eq "Search">#arguments.iterator.getRecordIndex()#. </cfif>#$.addLink(arguments.item.getValue('type'),arguments.item.getValue('filename'),arguments.item.getValue('menutitle'),arguments.item.getValue('target'),arguments.item.getValue('targetparams'),arguments.item.getValue('contentID'),arguments.item.getValue('siteID'),'',$.globalConfig('context'),$.globalConfig('stub'),$.globalConfig('indexFile'))#</h4>
				
				<div class="date">
					<cfif arguments.type eq "Portal" and isDate(arguments.item.getValue('releaseDate'))>
						#LSDateFormat(arguments.item.getValue('releaseDate'),$.getLongDateFormat())#,
					<cfelseif listFind("Search,Feed,Related",arguments.type) and arguments.item.getValue('parentType') eq 'Calendar' and isDate(arguments.item.getValue('displayStart'))>
						<cfif LSDateFormat(arguments.item.getValue('displayStart'),"short") lt LSDateFormat(arguments.item.getValue('displayStop'),"short")>#LSDateFormat(arguments.item.getValue('displayStart'),$.getShortDateFormat())# - #LSDateFormat(arguments.item.getValue('displayStop'),$.getShortDateFormat())#<cfelse>#LSDateFormat(arguments.item.getValue('displayStart'),$.getLongDateFormat())#</cfif>,
					<cfelseif arguments.type eq "Calendar">
						<cfif LSDateFormat(arguments.item.getValue('displayStart'),"short") lt LSDateFormat(arguments.item.getValue('displayStop'),"short")>#LSDateFormat(arguments.item.getValue('displayStart'),$.getShortDateFormat())# - #LSDateFormat(arguments.item.getValue('displayStop'),$.getShortDateFormat())#<cfelse>#LSDateFormat(arguments.item.getValue('displayStart'),$.getLongDateFormat())#</cfif>,
					<cfelseif LSisDate(arguments.item.getValue('releaseDate'))>
						#LSDateFormat(arguments.item.getValue('releaseDate'),$.getLongDateFormat())#,
					</cfif>
					by #HTMLEditFormat(arguments.item.getValue('lastupdateby'))# 
					<cfset rsCategories=application.contentManager.getCategoriesByHistID(arguments.item.getContentHistID())>
					<cfif rsCategories.recordCount>
						in
						<cfloop query="rsCategories">
							<cfif currentRow gt 1>, </cfif>
							<a href="?categoryID=#categoryId#" rel="category tag">#name#</a>
						</cfloop>
					</cfif>
				</div>	
			 
				<!-- ASIDE SECTION -->
				<cfif arguments.hasImage>
				<div class="columns alpha">
					<div class="aside"> 
						<a href="#arguments.item.getURL()#" title="#HTMLEditFormat(arguments.item.getValue('title'))#"><img src="#arguments.item.getImageURL(size=arguments.imageSize,width=arguments.imageWidth,height=arguments.imageHeight)#"  alt="#htmlEditFormat(arguments.item.getValue('title'))#" /></a>
					</div>
				</div>
				</cfif>
				
				<div class="omega"<cfif arguments.hasImage>#arguments.imageStyles#</cfif>>
					<cfif len(arguments.item.getValue('summary')) and arguments.item.getValue('summary') neq "<p></p>">
					 	#$.setDynamicContent(arguments.item.getValue('summary'))#
					</cfif>
				</div> 
				
				<br class="clearfix" />
				
				<!-- META AREA -->
				<div class="meta-space">					
					<cfif len(arguments.item.getValue('tags'))>
						<div class="tags clearfix">
							<cfset arguments.tagLen=listLen(arguments.item.getValue('tags')) />
							<!---#$.rbKey('tagcloud.tags')#: --->
							<img class="tag_icon" src="#$.siteConfig('themeAssetPath')#/assets/images/theme/tag.png">
							<cfloop from="1" to="#arguments.tagLen#" index="t">
								<cfset arguments.tag=#trim(listgetAt(arguments.item.getValue('tags'),t))#>
								<a class="button yellow" href="#$.createHREF(filename='#$.event('currentFilenameAdjusted')#/tag/#urlEncodedFormat(arguments.tag)#')#">#arguments.tag#</a><!---<cfif arguments.tagLen gt t>, </cfif>--->
							</cfloop>
						</div>				
					</cfif>
				</div> 
				<!-- /META AREA -->

			</div>
			<!-- /THE POST EXCERPT -->
		</cfoutput>
			<hr class="partial-bottom" />
	</cfloop>
</div>
