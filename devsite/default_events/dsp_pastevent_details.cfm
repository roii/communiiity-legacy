<cfoutput>

<CFQUERY NAME="EventDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM Events
WHERE EventID=#EventID#
</CFQUERY>



<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Guidelines International Network - Past Event Details</title>
<cfif #session.textonly# EQ 'yes'>
		<cfinclude template="../templates/small_textonly.cfm">
	<cfelse>
		<link rel="stylesheet" type="text/css" href="#request.webroot#/templates/#session.textsize#.css">
	</cfif>
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="FF3300" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/settings_title_icon.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td background="#request.imageroot#/top_blue_pattern.gif" valign="middle" valign="top" height="40"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Past Event Details</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="FF3300" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>






	<table cellspacing="0" cellpadding="0" border="0" width="100%">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>	
    <td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5"  border="0"><br>
	<span class="page_header"><b>#EventDetails.EventTitle#</b></span><br>
	<span class="normal">#DateFormat(EventDetails.StartDate, "d mmmm")# <cfif EventDetails.enddate neq ''>- #DateFormat(EventDetails.EndDate, "d mmmm yyyy")#</cfif></span></td>
  	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>	
    <td colspan="2"><hr width="100%" size="1" color="ffffff"></td>
  	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
    <td valign="top" width="100" class="normal"><b>Dates:</b></td>
    <td valign="top" class="normal">#DateFormat(EventDetails.StartDate, "d mmmm")# <cfif EventDetails.enddate neq ''>- #DateFormat(EventDetails.EndDate, "d mmmm yyyy")#</cfif></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
    <td valign="top" class="normal"><b>Venue:&nbsp;</b></td>
    <td valign="top" class="normal">#EventDetails.Venue#</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<cfif EventDetails.furtherinfo neq ''>
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
    <td valign="top" class="normal"><b>Further Info:&nbsp;</b></td>
    <td valign="top" class="normal">#EventDetails.FurtherInfo#</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>	
	</cfif>
	
	<cfif EventDetails.ContactEmail neq ''>
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
    <td valign="top" class="normal"><b>Email:&nbsp;</b></td>
    <td valign="top" class="normal"><a href="mailto:#EventDetails.ContactEmail#">#EventDetails.ContactEmail#</a></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>	
	</cfif>
	
	<cfif EventDetails.webaddress neq ''>
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
    <td valign="top" class="normal"><b>Website:&nbsp;</b></td>
    <td valign="top" class="normal"><a href="#EventDetails.webaddress#" target="_Blank">#EventDetails.webaddress#</a></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>	
	</cfif>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>	
    <td colspan="2"><hr width="100%" size="1" color="ffffff"></td>
  	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>

	<cfif #TRIM(EventDetails.details)# neq ''>
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
    <td valign="top" width="100" class="normal"><b>Details:&nbsp;</b></td>
    <td valign="top" class="normal">#EventDetails.details#</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>	
    <td colspan="2"><hr width="100%" size="1" color="ffffff"></td>
  	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</cfif>
	
	
	<cfif #TRIM(EventDetails.PastEventDetails)# neq ''>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
   	<td valign="top" class="normal" colspan="2">#EventDetails.PastEventDetails#</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>	
    <td colspan="2"><hr width="100%" size="1" color="ffffff"></td>
  	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</cfif>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>	
    <td colspan="2"><cfif EventDetails.IncludeRegForm eq 1><input type="button" class="whitefield" value="Register Online >>" onclick="javascript:location='dsp_registerNow.cfm?eventID=#EventID#';">&nbsp;&nbsp;&nbsp;</cfif><input type="button" class="whitefield" value="Close Window" onclick="javascript:window.close();"><br><br></td>
  	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>

	</table>
	
	
</td>
</tr>

</table>

</body>
</html>
</cfoutput>