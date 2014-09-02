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

<cfcomponent extends="mura.cfobject">
<!--- Add theme-specific methods here --->

<cffunction name="getThemeSkin" output="false" returntype="any">
		<cfscript>
			var themeSkin = '';
			var themeColors = StructKeyList(getThemeColors());
		</cfscript>
		<cftry>
			<cfinclude template="theme-skin.cfm" />
			<cfcatch></cfcatch>
		</cftry>
		<cfscript>
			if ( not StructKeyExists(session, 'themeSkin') ) { 
				setThemeSkin(themeSkin); 
			};
			if ( StructKeyExists(url, 'skin') ) { 
				setThemeSkin(url.skin);
			};
			if ( not ListFindNoCase(themeColors, session.themeSkin) ) {
				setThemeSkin(ListFirst(themeColors));
			};
			return LCase(session.themeSkin);
		</cfscript>
</cffunction>
	
<cffunction name="setThemeSkin" output="false" returntype="void">
		<cfargument name="themeSkin" required="false" default="light" />
		<cfif not StructKeyExists(session, 'themeSkin') or session.themeSkin neq arguments.themeSkin>
			<cflock type="exclusive" scope="session" timeout="50">
				<cfset session.themeSkin = UCase(arguments.themeSkin)>
			</cflock>
		</cfif>
</cffunction>

<cffunction name="getThemeColorForCSS" output="false" returntype="any">
		<cfscript>
			var colors = getThemeColors();
			var keys = StructKeyList(colors);
			if ( not ListFindNoCase(keys, getThemeSkin()) ) {
				return '##' & colors[ListFirst(keys)];
			} else {
				return '##' & colors[LCase(getThemeSkin())];
			};
		</cfscript>
</cffunction>

<cffunction name="humanizeTimespan" output="false">
	<cfargument name="datetime">
	<cfset var diff=0>
	
	<cftry>	 	
	 		<cfset arguments.datetime=parseDateTime(arguments.datetime)>
		<cfcatch></cfcatch>
	</cftry>

	
	<cfif isDate(arguments.datetime)>
	
		<cfset diff=dateDiff("d", arguments.datetime, now()) />
		
		<cfif diff eq 1>
			<cfreturn diff & " day ago">
		<cfelseif diff gt 1>
			<cfreturn diff & " days ago">
		</cfif>
		
		<cfset diff=dateDiff("h", arguments.datetime, now()) />
		
		<cfif diff eq 1>
			<cfreturn diff & " hour ago">
		<cfelseif diff gt 1>
			<cfreturn diff & " hours ago">
		</cfif>
		
		<cfset diff=dateDiff("h", arguments.datetime, now()) />
		
		<cfif diff eq 1>
			<cfreturn diff & " minute ago">
		<cfelseif diff gt 1>
			<cfreturn diff & " minutes ago">
		</cfif>
		
		<cfset diff=dateDiff("s", arguments.datetime, now()) />
		
		<cfif diff eq 1>
			<cfreturn diff & " second ago">
		<cfelseif diff gt 1>
			<cfreturn diff & " seconds ago">
		</cfif>
	
	</cfif>
	
	<cfreturn "">
	
</cffunction>

</cfcomponent>