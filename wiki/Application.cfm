<cfif #cgi.http_host# eq "sherbrookois.com">
     <cflocation url="http://www.sherbrookois.com/wiki" addtoken="no">
</cfif> 

<cfsetting showdebugoutput=false>
<cfsilent>

<!---
You can customize how CanvasWiki operates at runtime by adding values to the
struct below. Any key that matches a value in the CanvasConfig.xml file will
be overwritten here. 

There is one special key, applicationname. It will be used for the cfapplication name.
--->
<cfset instance = structNew()>
<cfset instance.applicationname = "wiki">
<cfset instance.wiki = "Default">

<cfparam name="dsn" default="sherbrooke_dsn">
<!--- SET THE DATASOURCE USERNAME and PASSWORD --->
<cfparam name="request.username" default="sherbrookois" />
<cfparam name="request.password" default="hjjk883_hfH" />	


<cfapplication name="#instance.applicationname#" sessionmanagement="true"/>
<cfset application.runtimeoverridesettings = instance>

</cfsilent>