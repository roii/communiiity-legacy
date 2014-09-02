<!---
	Name         : Factory.cfc
	Author       : Rob Gonda
	Created      : August 25, 2006
	Last Updated : August 25, 2006
	History      : 
	Purpose		 : Simple Object Factory / Service Locator
--->
<cfcomponent displayname="objectFactory" hint="I am a simple object factory" output="false">

	<cfset variables.settings = structNew()>
	
	<cffunction name="init" access="public" output="No" returntype="Factory">
		<cfargument name="settings" type="struct" required="true">
	
		<cfset variables.settings = arguments.settings>
			
		<cfscript>
			// persistance of objects
			variables.com = structNew();
		</cfscript>

		<cfreturn this />
	</cffunction>

	<!--- 
		function getObject
		in:		name of object
		out:	object
		notes:	
	 --->
	<cffunction name="createObj" access="public" output="No" returntype="any">
		<cfargument name="objName" type="string" required="Yes" />
		
		<cfscript>
			switch(arguments.objName) {
				case "pageGateway":
					return createObject('component','PageGateway').init(
						dsn = settings.dsn,
						databasetype = settings.databasetype,
						databasetableprefix = settings.databasetableprefix,
						pageDAO = getInstance('pageDAO'),
						utils = getInstance('utils'),
						pageRender = getInstance('pageRender'),
						wiki = settings.wiki
					);
				break;
	
				case "pageDAO":
					return createObject('component','PageDAO').init(
						dsn = settings.dsn,
						databasetype = settings.databasetype,
						databasetableprefix = settings.databasetableprefix,
						wiki = settings.wiki
					);
				break;

				case "pageRender":
					return createObject('component','PageRender').init(
						wikitermsenabled = settings.wikitermsenabled,
						wikitocminitems = settings.wikitocminitems,
						utils = getInstance('utils')
					);
				break;
				
				case "diffObj":
					return createObject('component','util.wikidiff').init();
				break;

				case "utils":
					return createObject('component','Utils');
				break;
				
			}


		</cfscript>
		
	</cffunction>
	
	
	<!--- 
		function getInstance
		in:		name of object
		out:	object
		notes:	create a persistant object if doen not previously exists
	 --->
	<cffunction name="getInstance" access="public" output="No" returntype="any">
		<cfargument name="objName" required="Yes" />
		
		<cfscript>
			if ( not StructKeyExists(variables.com, arguments.objName) ){
				variables.com[arguments.objName] = createObj(arguments.objName);
			}
			
			return variables.com[arguments.objName];
		</cfscript>
	</cffunction>

	<cffunction name="removeInstance" access="public" output="No" returntype="void">
		<cfargument name="objName" required="Yes" />
	
		<cfscript>
			if ( StructKeyExists(variables.com, arguments.objName) ){
				structDelete(variables.com, arguments.objName);
			}
		</cfscript>
	</cffunction>

</cfcomponent>