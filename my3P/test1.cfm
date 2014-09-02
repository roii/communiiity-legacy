<cffunction name="getApplicationRootPath" returntype="string" hint="Returns the root path of the acting Application.cfm file." output="false" access="public">
  <cfargument name="base_path" default="./" hint="Normally you want to leave this as default" required="false">
  <cfset var actual_path = ExpandPath(arguments.base_path)>
  <cfif FileExists(ExpandPath(arguments.base_path & "Application.cfm"))>
    <cfreturn actual_path>
  <cfelseif REFind(".*[/\\].*[/\\].*", actual_path)>
    <cfreturn getApplicationRootPath("../#arguments.base_path#")>
  <cfelse>
    <!--- we have reached the root dir, so throw an error not found --->
    <cfthrow message="Unable to determine Application Root Path" detail="#actual_path#">
  </cfif>
</cffunction>
