<cfparam name="application.emailserver" default="mail14.ezhostingserver.com">

<cf_formurl2attributessearch createattributeslist="yes" displaybase="no">

<cfparam name="request.webroot" default="http://iii-coop.securec1.hostek.net">
<cfparam name="request.imageroot" default="#request.webroot#/images">
<cfparam name="request.fileroot" default="D:\home\iii.coop\wwwroot">
<cfparam name="request.ActiveEditInc" default="#request.webroot#/activedit/inc/">
<!--- SET THE DATASOURCE DSN's /iii.coop/wwwroot--->
<cfparam name="dsn" default="mykidsbiznewi">
 

<!--- SET THE DATASOURCE USERNAME and PASSWORD --->
<cfparam name="request.username" default="mynewacct" />
<cfparam name="request.password" default="wleocme123@W" />	
<cfparam name="request.widthSize" default="1000px" />	 
	
<cfset ServerDateTime = CreateDateTime(DateFormat(now(), "yyyy"),  DateFormat(now(), "m"),  DateFormat(now(), "d"),  TimeFormat(now(), "H"),  TimeFormat(now(), "M"), TimeFormat(now(), "S"))>

<cfset localDateTime = CreateODBCDateTime(DateAdd('n',  1020,  ServerDateTime))>
