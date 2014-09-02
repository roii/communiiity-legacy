<cfparam name="application.emailserver" default="maila46.webcontrolcenter.com">

<cf_formurl2attributessearch createattributeslist="yes" displaybase="no">

<cfparam name="request.webroot" default="http://www.my3p.com">
<cfparam name="request.imageroot" default="#request.webroot#/images">
<cfparam name="request.fileroot" default="D:\Inetpub\my3p">
<cfparam name="request.ActiveEditInc" default="#request.webroot#/activedit/inc/">
<!--- SET THE DATASOURCE DSN's --->
<cfparam name="DSN" default="mykidsbiznew">


<!--- SET THE DATASOURCE USERNAME and PASSWORD --->
<cfparam name="request.username" default="mykidsbizcom" />
<cfparam name="request.password" default="w29snfc66r" />	

	
<cfset ServerDateTime = CreateDateTime(DateFormat(now(), "yyyy"),  DateFormat(now(), "m"),  DateFormat(now(), "d"),  TimeFormat(now(), "H"),  TimeFormat(now(), "M"), TimeFormat(now(), "S"))>

<cfset localDateTime = CreateODBCDateTime(DateAdd('n',  1020,  ServerDateTime))>
