<!--- Be sure to reload Mura after adding methods here. A site's local eventHandler.cfc does not need to be init'd via appreload, only theme-specific ones (like this) --->
<cfcomponent extends="mura.cfobject" output="false">

	<cffunction name="onSiteRequestStart">
		<cfscript>
			var DEFAULT_FONT = "sans";
			var DEFAULT_STYLE = "";
			
			if (not StructKeyExists(session, 'themeFont')) { 
				setThemeFont(DEFAULT_FONT); 
			};
			if (not StructKeyExists(session, 'themeStyle')) { 
				setThemeStyle(DEFAULT_STYLE); 
			};
			if (StructKeyExists(url, 'font') and len(trim(url.font))) { 
				setThemeFont(url.font);
			};
			if (StructKeyExists(url, 'style') and len(trim(url.style))) { 
				setThemeStyle(url.style);
			};
		</cfscript>
	</cffunction>

	<cffunction name="onRenderStart" output="false">
		<cfargument name="$" hint="mura scope" />
		<cfscript>
			var renderer = arguments.$.getContentRenderer();

			// general vars
			renderer.jsLib = 'jquery';
			renderer.jsLibLoaded = true;
		</cfscript>
	</cffunction>


	<!--- HELPERS --->

	<cffunction name="setThemeFont" output="false" returntype="void">
		<cfargument name="themeFont" required="true" />
		<cfif not StructKeyExists(session, 'themeFont') or session.themeFont neq arguments.themeFont>
			<cflock type="exclusive" scope="session" timeout="50">
				<cfset session.themeFont = arguments.themeFont>
			</cflock>
		</cfif>
	</cffunction>
	
	<cffunction name="setThemeStyle" output="false" returntype="void">
		<cfargument name="themeStyle" required="true" />
		<cfif not StructKeyExists(session, 'themeStyle') or session.themeStyle neq arguments.themeStyle>
			<cflock type="exclusive" scope="session" timeout="50">
				<cfset session.themeStyle = arguments.themeStyle>
			</cflock>
		</cfif>
	</cffunction>

</cfcomponent>