<html>
<head>
<meta name="Description" content="">
<meta name="keywords" content="">
<cfparam name="attributes.prizepoolid" default="">
<title>myKidsBiz.com - Prize Pool Entry Detail</title>
<link rel="stylesheet" type="text/css" href="http://www.mykidsbiz.com/templates/small.css">

</head>

<cfquery name="entryQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select prize_pool.name as pname, activity.name as aname, activity.description as adesc, entries,date_entry from prize_entry,
  activity,prize_pool where prize_entry.prizepoolid = prize_pool.prizepoolid and prize_entry.activityid = activity.activityid
  and prize_entry.prizepoolid = #attributes.prizepoolid#
</cfquery>

<cfoutput>
<body>
<!---
<table width="100%" cellpadding="0" cellspacing="0" border="1">
			
			<tr>
			<td width="15%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="15%" height="1"  border="0"></td>
			<td width="20%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="45%" height="1"  border="0"></td>
			<td width="35%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="10%" height="1"  border="0"></td>
			<td width="15%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="10%" height="1"  border="0"></td>
			<td width="10%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="15%" height="1"  border="0"></td>
			</tr>
			<cfset totle = 0>
			<cfif #entryQ.RecordCount# GT 0>
			
			<tr>
			<td style="font-size:11px;"><strong>Prize</strong></td>
			<td style="font-size:11px;"><strong>Activity</strong></td>
			<td style="font-size:11px;"><strong>Description (how you got your entries)</strong></td>
			<td style="font-size:11px;"><strong>Entry Date</strong></td>
			<td style="font-size:11px;"><strong>No. of entries</strong></td>
			</tr>
			
			<cfloop query="entryQ">
			<tr bgcolor="white">
			<td valign="top">#TRIM(entryQ.pname)#</td>
			<td valign="top">#TRIM(entryQ.aname)#</td>
			<td valign="top">#TRIM(entryQ.adesc)#</td>
			<td valign="top">#Dateformat(entryQ.date_entry,"DD-MMM-YYYY")#</td>
			<td valign="top" align="center">1</td>
			</tr>
			<cfset totle = totle + 1>
			</cfloop>
			<tr>
			<td colspan="5" align="right">Total Entries: <b>#totle#</b>&nbsp;&nbsp;&nbsp;</td>
			</tr>
			</cfif>
	
</table> --->
<br>
<cfquery  name="activitiesQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT name,pe.activityid FROM prize_entry pe,activity a where a.activityid = pe.activityid and pe.prizepoolid = #attributes.prizepoolid#
  group by name,pe.activityid
</cfquery>
            
<table border="0"  width="100%" cellpadding="3" cellspacing="0">
			<tr>
				<td>
				<b>Bar Chart</b>
				</td>
				</tr>
				<tr>
				<td valign="top" align="center">
				<APPLET CODE="BarChart.class" CODEBASE="CFGraphs/" WIDTH="500" HEIGHT="300">
				<PARAM NAME="ChartData.Columns" VALUE="Items,Values"> 
				<PARAM NAME="ChartData.Items" VALUE="<cfloop query="activitiesQ">#activitiesQ.Name#,</cfloop>"> 
				<PARAM NAME="ChartData.Values" VALUE="
				<cfloop query="activitiesQ">
				   <cfquery  name="countsQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
				      SELECT * FROM prize_entry where activityId = #activitiesQ.activityid# and prizepoolid = #attributes.prizepoolid#
			           </cfquery>
				   #countsQ.recordcount#,
				</cfloop>"> 
				<PARAM NAME="Title" VALUE="Bar Chart"> 
				<PARAM NAME="TitleFontName" VALUE="Arial">
				<PARAM NAME="TitleFontHeight" VALUE="15">
				<PARAM NAME="DebugInfoEnabled" VALUE="yes">
				<PARAM NAME="Orientation" VALUE="horizontal">
				<PARAM NAME="BackgroundColor" VALUE="FFFFFF">
				This template displays Java based graph.<br>
				If you see this message it means that:<br>
				<H2> Your Browser Does Not Support JAVA!</H2> 
				</APPLET>
				</td></tr>
</table>
</body>
</cfoutput>
</html>