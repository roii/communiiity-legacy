<cfinclude template="qry_adminLog.cfm">

<br><br>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td class="page_header">Administration Audit</td>
<td align="right" width="10"><img src="#request.imageroot#/where_icon.gif" width="9" height="15" alt="Membership Directory" border="0"></td>
</tr>

<tr>
<td bgcolor="222222" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</table>


<table width="100%" cellpadding="0" cellspacing="0" border="0">


<form method="post" action="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=#attributes.fusesubaction#">		
<tr bgcolor="e2e2e2" height="25">
<td colspan="3" valign="middle">&nbsp;<select name="LogPeriod" class="whitefield">
<option value="0"<cfif #logperiod# EQ 0> selected</cfif>>Last 7 days</option>
<option value="1"<cfif #logperiod# EQ 1> selected</cfif>>Last 30 days</option>
<option value="2"<cfif #logperiod# EQ 2> selected</cfif>>Last 2 months</option>
<option value="3"<cfif #logperiod# EQ 3> selected</cfif>>Last 3 months</option>
<option value="4"<cfif #logperiod# EQ 4> selected</cfif>>Last 4 months</option>
<option value="5"<cfif #logperiod# EQ 5> selected</cfif>>Last 5 months</option>
<option value="6"<cfif #logperiod# EQ 6> selected</cfif>>Last 6 months</option>
<option value="12"<cfif #logperiod# EQ 12> selected</cfif>>Last 12 months</option>
</select> <input type="submit" class="whitefield" value=">>"></td>
</tr>
</form>

<tr>
<td colspan="3"><br></td>
</tr>

<tr>
<td class="normal" width="76" valign="top"><b>Date/Time</b></td>
<td class="normal" width="100" valign="top" align="center"><b>Administrator</b></td>
<td class="normal" width="430" valign="top"><b>Details</b></td>
</tr>
		
<tr>
<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>
	
<cfoutput query="adminLog">

<cfquery name="administratordetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Administrator
WHERE AdministratorID = #Administrator#
</cfquery>

<tr>
<td class="small" width="76" valign="top" align="center">#DateFormat(LogDate, "dd/mm/yy")#<br>
#TimeFormat(LogDate, "HH:mm.ss")#</td>
<td class="small" width="100" valign="top" align="center">#administratordetails.LastName#, #administratordetails.firstName#</td>
<td class="small" width="430" valign="top">#Details#</td>
</tr>

<tr>
<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>
</cfoutput>		


	
</table>
