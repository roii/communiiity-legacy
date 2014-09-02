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
	<cfif not isNumeric($.event('month'))>
		<cfset $.event('month',month(now()))>
	</cfif>
	<cfif not isNumeric($.event('year'))>
		<cfset $.event('year',year(now()))>
	</cfif>
	<cfif isNumeric($.event('day')) and $.event('day')
		and $.event('filterBy') eq "releaseDate">
		<cfset menuType="releaseDate">
		<cfset menuDate=createDate($.event('year'),$.event('month'),$.event('day'))>
		<cfelseif $.event('filterBy') eq "releaseMonth">
		<cfset menuType="releaseMonth">
		<cfset menuDate=createDate($.event('year'),$.event('month'),1)>
		<cfelse>
		<cfset menuDate=now()>
		<cfset menuType="default">
	</cfif>
	<cfset maxPortalItems=$.globalConfig("maxPortalItems")>
	<cfif not isNumeric(maxPortalItems)>
		<cfset maxPortalItems=100>
	</cfif>
	<cfset variables.rsPreSection=$.getBean('contentGateway').getKids('00000000000000000000000000000000000',$.event('siteID'),$.content('contentID'),menuType,menuDate,maxPortalItems,$.event('keywords'),0,$.content('sortBy'),$.content('sortDirection'),$.event('categoryID'),$.event('relatedID'),$.event('tag'))>
	<cfif $.siteConfig('extranet') eq 1 and $.event('r').restrict eq 1>
		<cfset variables.rssection=$.queryPermFIlter(variables.rsPreSection)/>
		<cfelse>
		<cfset variables.rssection=variables.rsPreSection/>
	</cfif>
	<cfset variables.iterator=$.getBean("contentIterator")>
	<cfset variables.iterator.setQuery(rsSection,$.content('nextN'))>
	<cfset event.setValue("currentNextNID",$.content('contentID'))>
	<cfif not len($.event("nextNID")) or $.event("nextNID") eq $.event("currentNextNID")>
		<cfif event.getContentBean().getNextN() gt 1>
			<cfset variables.currentNextNIndex=$.event("startRow")>
			<cfset variables.iterator.setStartRow(variables.currentNextNIndex)>
			<cfelse>
			<cfset variables.currentNextNIndex=$.event("pageNum")>
			<cfset variables.iterator.setPage(variables.currentNextNIndex)>
		</cfif>
		<cfelse>
		<cfset variables.currentNextNIndex=1>
		<cfset variables.iterator.setPage(1)>
	</cfif>
	<cfset variables.nextN=$.getBean('utility').getNextN(rsSection,$.content('nextN'),variables.currentNextNIndex)>
	<cfif NOT len($.content("displayList"))>
		<cfset variables.contentListFields="Date,Title,Image,Summary,ReadMore,Credits">
		<cfif $.getBean('contentGateway').getHasComments($.event('siteid'),$.content('contentID'))>
			<cfset variables.contentListFields=listAppend(contentListFields,"Comments")>
		</cfif>
		<cfset variables.contentListFields=listAppend(variables.contentListFields,"Tags")>
		<cfif $.getBean('contentGateway').getHasRatings($.event('siteid'),$.content('contentID'))>
			<cfset variables.contentListFields=listAppend(variables.contentListFields,"Rating")>
		</cfif>
		<cfset $.content("displayList",variables.contentListFields)>
	</cfif>

	<cfscript>
			displayPortalDivWrapper = false;
	        // switch the list item output based on the subType
	        switch ( $.content('subType') ) {
	            case 'Portfolio2Column' :
	                $.content('ImageSize','large');
	                theFile = 'custom/dsp_portfolio.cfm';
	                break;
	            case 'Portfolio3Column' :
	                $.content('ImageSize','large');
	                theFile = 'custom/dsp_portfolio.cfm';
	                break;
	            case 'Portfolio4Column' :
	                $.content('ImageSize','large');
	                theFile = 'custom/dsp_portfolio.cfm';
	                break;
				case 'BlogLoop' :
	                theFile = 'custom/dsp_blogloop.cfm';
	                break;
	            default : 
	                // if default selected or unknown, then allow the default portal rendering method to display
	                displayPortalDivWrapper = true;
	                theFile = 'dsp_content_list.cfm';
	        };
	    </cfscript>
</cfsilent>
<cfoutput>
	<cfif iterator.getRecordcount()>
	<cfif displayPortalDivWrapper><div id="svPortal" class="svIndex"></cfif>
	<!---<cfif displayPortalDivWrapper><div id="entry" class="single"></cfif>--->
		#$.dspObject_Include(
			thefile = theFile
			, fields = $.content('displayList')
			, type = 'Portal'
			, iterator= variables.iterator
			, imageSize = $.content('ImageSize')
			, imageHeight = $.content('ImageHeight')
			, imageWidth = $.content('ImageWidth')
			, imagePadding = 40
		)#
		<cfif variables.nextn.numberofpages gt 1>
			#$.dspObject_Include(thefile='dsp_nextN.cfm')#
		</cfif>	
		<cfif displayPortalDivWrapper></div></cfif>
	</cfif>
	<cfif not variables.iterator.getRecordCount()>
		<cfif $.event('filterBy') eq "releaseMonth">
			<div id="svPortal"> <br>
				<p>#$.rbKey('list.nocontentmonth')#</p>
			</div>
			<cfelseif $.event('filterBy') eq "releaseDate">
			<div id="svPortal"> <br>
				<p>#$.rbKey('list.nocontentday')#</p>
			</div>
			<cfelse>
			<div id="svPortal">
				<p>#$.rbKey('list.nocontent')#</p>
			</div>
		</cfif>
	</cfif>
</cfoutput>