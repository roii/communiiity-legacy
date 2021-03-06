<cfapplication name="3pV" sessionmanagement="Yes" sessiontimeout="#createtimespan(0,1,0,0)#" clientmanagement="Yes">

<cfinclude template="app_globals.cfm">

<!---<cfdump var="#CGI#">
<cfabort>--->

 
<cfif #cgi.http_host# eq "crowdsourciiing.com">
     <cflocation url="http://www.crowdsourciiing.com/" addtoken="no">
</cfif> 

<cfparam name="session.UserIsAuthenticated" DEFAULT="No">
<cfparam name="session.UserType" DEFAULT="Public">

<cfset this_path="#cgi.query_string#">

<cfquery name="AllSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Settings
WHERE ParserURL LIKE '%#cgi.http_host#%' 
</cfquery>  

<cfif NOT IsDefined("session.AllSettings_SiteName")>

	<!-----AllSettings.SiteName------>
	<cfset session.AllSettings_SiteName = AllSettings.SiteName> 
	<cfset session.AllSettings_Logo_file = AllSettings.Logo_file>
	<cfset session.AllSettings_MenubarBG_file = AllSettings.MenubarBG_file>
	<cfset session.AllSettings_TextColour = AllSettings.TextColour>
	<cfset session.AllSettings_DkTextColor = AllSettings.DkTextColor>
	<cfset session.AllSettings_HeadingColor = AllSettings.HeadingColor>
	<cfset session.AllSettings_DkHeadingColor = AllSettings.DkHeadingColor>
	<cfset session.AllSettings_LinkColour = AllSettings.LinkColour>
	<cfset session.AllSettings_SubMenuLinkColour = AllSettings.SubMenuLinkColour>
	<cfset session.AllSettings_BoxColour = AllSettings.BoxColour>
	<cfset session.AllSettings_BoxTextColour = AllSettings.BoxTextColour>
	<cfset session.AllSettings_EmailAlertFrom = AllSettings.EmailAlertFrom>
	<cfset session.AllSettings_DkBoxColour = AllSettings.DkBoxColour>
	<cfset session.AllSettings_DkBoxTextColour = AllSettings.DkBoxTextColour> 
</cfif> 

<!--- IF LOGGED IN THEN GET POINTS BALANCE --->
<cfif session.UserIsAuthenticated EQ 'Yes' AND IsDefined("session.UserID")>
	<cfinclude template="act_user_points_balance.cfm">
</cfif>

<cfinclude template="act_authenticate.cfm">


<cfcomponent displayname="Application">
<cfset this.name="communiity">
<cfinclude template="version.cfm">    
    

<cfif IsDefined("killcookies")>
	<!--- KILL THE COOKIES --->
	<cfcookie name="mykidsbizn" expires="NOW">
	<cfcookie name="mykidsbizp" expires="NOW">
</cfif>

<cffunction name="CapFirst" returntype="string" output="false">
	<cfargument name="str" type="string" required="true" />
 
	<cfset var newstr = "" />
 
	<cfset newstr = UCase(left(arguments.str,1)) & Right(arguments.str,Len(arguments.str)-1)>
 
	<cfreturn newstr />
</cffunction>


<cffunction name="onApplicationStart" returntype="boolean">
    <cfset application.fullversion = this.version & "-" & this.build>
    <cfreturn true>
</cffunction>


<cffunction name="onRequestStart" returntype="boolean">
    <cfargument name="targetPage" type="string">
    <cfset this.fullversion = this.version & "-" & this.build>
    <cfif not isDefined('application.fullversion') OR this.fullversion neq application.fullversion>
        <cfset onApplicationStart()>
    </cfif>

    <cfreturn true>
</cffunction>


<cfset BadUserAgents = "gigablast,gogglebot">
    