<cfparam name="application.emailserver" default="mail14.ezhostingserver.com">

<cf_formurl2attributessearch createattributeslist="yes" displaybase="no">

<cfparam name="request.webroot" default="http://www.sherbrookois.com">
<!---<cfparam name="request.webroot" default="http://www.sherbrookois.com">--->
<cfparam name="request.imageroot" default="#request.webroot#/images">
<cfparam name="request.fileroot" default="D:\home\sherbrookois.com\wwwroot">
<cfparam name="request.ActiveEditInc" default="#request.webroot#/activedit/inc/">
<!--- SET THE DATASOURCE DSN's /sherbrookois.com/wwwroot--->
<cfparam name="dsn" default="sherbrooke_dsn">
 

<!--- SET THE DATASOURCE USERNAME and PASSWORD --->
<cfparam name="request.username" default="sherbrookois" />
<cfparam name="request.password" default="hjjk883_hfH" />	

<cfquery name="getSiteWidthSize" datasource="#dsn#" username="#request.username#" password="#request.password#">
    SELECT siteWidthSize FROM Settings WHERE ParserURL LIKE '%#cgi.http_host#%' 
</cfquery>   
<cfparam name="request.widthSize" default="#getSiteWidthSize.siteWidthSize#" />	 
	
<cfset ServerDateTime = CreateDateTime(DateFormat(now(), "yyyy"),  DateFormat(now(), "m"),  DateFormat(now(), "d"),  TimeFormat(now(), "H"),  TimeFormat(now(), "M"), TimeFormat(now(), "S"))>

<cfset localDateTime = CreateODBCDateTime(DateAdd('n',  1020,  ServerDateTime))>
