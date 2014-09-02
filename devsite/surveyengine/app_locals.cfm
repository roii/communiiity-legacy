<!--- Survey Engine 2.0 Evaluation --->
<!--- This is a fully functional application.
To obtain open source license please visit the following URL
http://www.activefeedback.com/af/order
 --->
<!---<cfapplication name="staffnet" sessionmanagement="Yes" sessiontimeout="#createTimeSpan( 0, 0, 100, 1)#">--->
<cfparam name="session.accesslevel" default=""> 
<cfinclude template="../app_globals.cfm">
<cfinclude template="../application.cfm">

<!---
<cfif session.UserIsAuthenticated EQ 'no'>
  <cflocation url="http://www.my3p.com">
<cfelseif Session.UserType NEQ "Administrator">  
  <cflocation url="http://www.my3p.com">
<cfelse>
</cfif>
--->

<!---<cf_authenticate application="survey" UserName="ed" Password="ed" Variable="security">
			<cfif IsAuthenticated>
				<!--- <cflocation url="#getFileFromPath(cgi.script_name)#?#cgi.query_string#">--->
				<cflock timeout="20" throwontimeout="no" name="security_lock" type="readonly"> 
				<!---
				<cfoutput>test cfoutput in lock</cfoutput>--->
				
				<cfset session.permission= security>
				</cflock>
			</cfif>	  
	  
<!---   <cfif not isDefined("session.permission")>
   You must be authorized to edit this web site.
   <cfinclude template="/rootmapping/staffnet/keymaster.cfm"> <cfabort>
   
   <cfelse>--->

           <cf_authorize resource="StaffNet" action="write" storage="session.permission">
           <cfif isAuthorized><cfset session.accesslevel=1></cfif>

		
           <cf_authorize resource="WebTeam" action="write" storage="session.permission">
           <cfif isAuthorized><cfset session.accesslevel=3><cfset owner="WebTeam"> <cfset session.ownlist="webTeam"></cfif>
	       <cf_authorize resource="Root" action="write" storage="session.permission">
           <cfif isAuthorized><cfset session.accesslevel=4><cfset owner="Root"> <cfset session.ownlist="Root"></cfif>
  <!--- </cfif>

--->
--->
<cfparam name="cookie.pass" default="">
<cfparam name="cookie.user" default="">
<!--- Color scheme preferences --->
<cfparam name="bgcolor2" default="ededfd">
<cfparam name="bgcolor1" default="333399">
<cfparam name="bgcolor3" default="ededfd">
<cfparam name="bgcolor4" default="99ccff">
<cfparam name="bgcolor5" default="99ccff">


<!--- You may use our application as part of you
existing authentication system. Make sure that you are passing VENDORID parameter
to the system as cookies or a session variable to provide secure
multiuser environment --->

<!--- Default parameters for username and formid --->
<cfparam name="vendorid" default="0">
<cfparam name="formid" default="0">

<!--- Database Administartor Interface preferences 
<cfparam name="datasourceR" default="af1">
<cfparam name="datasourceW" default="af1">--->

<!--- Database Username and password --->
<cfparam name="dbpassword" default="w29snfc66r">
<cfparam name="dbusername" default="mykidsbizcom">

<!--- Names for SQL tables used in the Survey Engine 2.0 --->
<!--- Sql scripts are located in the HELP folder --->
<cfparam name="tableforms" default="forms">
<cfparam name="tablequestions" default="questions">
<cfparam name="tableresponses" default="responses">

<!--- Default Survey Title --->
<cfparam name="title" default="n/a">

<cfparam name="at" default="2">
<cfparam name="chartwidth" default="350">
<cfparam name="chartheight" default="300">

<!--- Application specific preferences --->
<cfparam name="datasourceR" default="mykidsbiz">
<cfparam name="datasourceW" default="mykidsbiz">

<!--- Color scheme preferences --->
<cfparam name="bgcolor1" default="c0c0c0">
<cfparam name="bgcolor2" default="333366">
<cfparam name="bgcolor3" default="dcdcdc">
<cfparam name="bgcolor4" default="ececec">
<cfparam name="bgcolor5" default="dcdcdc">

<!--- Question category --->
<cfparam name="category" default="0">

<!--- Our system allows you to place administration utility behind password protected 
directory and publish feedback forms anywhere on Windows NT network as long as COLDFUSION
has access to the server via CFFILE and CFDIRECTORY tag 

/surveyengine/ - administration utility
/survey/ - folder for publishing
--->

<!--- 
 Custom Location of Survey Engine Online Administrator 
--->
<cfparam name="setupdir" default="http://www.my3p.com/surveyengine/survey">
<!--- Physical Location on the Network of Survey Engine Online Administrator (used by CFFILE)--->
<cfparam name="enginedir" default="D:\Web\DYNAMIC\surveyengine">
<!--- Physical Location on the Network of Survey Engine Log Dir (used by CFFILE)--->
<cfparam name="logdir" default="D:\Web\DYNAMIC\surveyengine\log">
<!--- Live Front End Location for Internet Users --->
<cfparam name="livedir" default="http://www.my3p.com/surveyengine/survey">
<!--- Any location on coporate network --->
<cfparam name="publishdir" default="D:\Web\DYNAMIC\surveyengine\survey">

<!--- Font preferences --->
<cfparam name="tablewidth" default="100%">
<cfparam name="tableborder" default="0">

<!---
  Custom Font Style (Change the style according to your own preferences
  --->
<cfset fontstyle = "face=""Arial, Helvetica"" size=2 color=""FFFFFF"" style=""color:FFFFFF;""">
<cfset fontstyle1 = "face=""Arial, Helvetica"" size=2 color=""000000"" style=""color:000000;""">
<cfset fontstyle2 = "face=""Arial, Helvetica"" size=1 color=""000000"" style=""color:000000;""">
<cfset fontstyle3 = "face=""Arial, Helvetica"" size=3 color=""000000"" style=""color:000000;font-weight:bold;""">

<!--- The following set of variables allows administrator to configure application security level  --->

<!--- Data Entry Access Only - Allows creation of surveys (no access to reports or libraries) --->
 <cfset session.accesslevel =1>

<!--- Data Entry / Reporting Access Only - Allows creation of surveys ( with access to reports or libraries) --->
 <cfset session.accesslevel = 2>	

<!--- Administrator Access --->
<cfset session.accesslevel = 3> 

<!--- Full Access --->
<cfset session.accesslevel = 4>  