<cfparam name="application.emailserver" default="mail15.ezhostingserver.com">
<!---mail.communautiii.com--->
<cf_formurl2attributessearch createattributeslist="yes" displaybase="no">

<cfparam name="request.webroot" default="http://www.crowdsourciiing.com">
<!---<cfparam name="request.webroot" default="http://www.communautiii.com">--->
<cfparam name="request.imageroot" default="#request.webroot#/images">
<cfparam name="request.fileroot" default="D:\home\crowdsourciiing.com\wwwroot">
<cfparam name="request.ActiveEditInc" default="#request.webroot#/activedit/inc/">
<!--- SET THE DATASOURCE DSN's /communautiii.com/wwwroot--->
<cfparam name="dsn" default="crowdsourciiingdsn"> 


<!--- SET THE DATASOURCE USERNAME and PASSWORD --->
<cfparam name="request.username" default="crowdsourciiinguser" />
<cfparam name="request.password" default="dfkdsf344J" />	

<cfquery name="getSiteWidthSize" datasource="#dsn#" username="#request.username#" password="#request.password#">
    SELECT siteWidthSize, siteBttnColor, siteBackGColor FROM Settings WHERE ParserURL LIKE '%#cgi.http_host#%' 
</cfquery>   
<cfparam name="request.widthSize" default="#getSiteWidthSize.siteWidthSize#" /> 
<cfparam name="request.buttonColor" default="#getSiteWidthSize.siteBttnColor#" />	
<cfparam name="request.siteBackGColor" default="#getSiteWidthSize.siteBackGColor#" />	
	
	
<cfset ServerDateTime = CreateDateTime(DateFormat(now(), "yyyy"),  DateFormat(now(), "m"),  DateFormat(now(), "d"),  TimeFormat(now(), "H"),  TimeFormat(now(), "M"), TimeFormat(now(), "S"))>

<cfset localDateTime = CreateODBCDateTime(DateAdd('n',  1020,  ServerDateTime))>

<cfset langArr = ArrayNew(1)>
<cfset langArr[1]['lang']  = 'fr'>
<cfset langArr[1]['title'] = 'Français(beta)'>
<cfset langArr[2]['lang']  = 'eng'>
<cfset langArr[2]['title'] = 'English'>


<cfif IsDefined("Session.defaultlang") and Session.defaultlang neq ''>
     <cfset defaultlang  = #Session.defaultlang#> 
<cfelse>
     <cfset defaultlang  = "eng">
</cfif> 
<cfset langFilesStr = StructNew()>
<cfset langFilesStr[1]['eng'] = "English.csv">
<cfset langFilesStr[1]['fr'] = "French.csv">