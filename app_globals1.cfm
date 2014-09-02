<cfparam name="application.emailserver" default="mail14.ezhostingserver.com">

<cf_formurl2attributessearch createattributeslist="yes" displaybase="no">

<cfparam name="request.webroot" default="http://www.my3p.com">
<cfparam name="request.imageroot" default="#request.webroot#/images">
<cfparam name="request.fileroot" default="D:\home\securecb1.ezhostingserver.com\wwwroot">
<cfparam name="request.ActiveEditInc" default="#request.webroot#/activedit/inc/">
<!--- SET THE DATASOURCE DSN's --->
<cfparam name="DSN" default="mykidsbiznew">
	
<cfset ServerDateTime = CreateDateTime(DateFormat(now(), "yyyy"),  DateFormat(now(), "m"),  DateFormat(now(), "d"),  TimeFormat(now(), "H"),  TimeFormat(now(), "M"), TimeFormat(now(), "S"))>

<cfset localDateTime = CreateODBCDateTime(DateAdd('n',  1020,  ServerDateTime))>
