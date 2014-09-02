<cfoutput>

<cfquery name="CurrentPrizepool" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool
WHERE PrizePoolID=#PrizePoolID#
</cfquery>

<cfset this_PrizePoolID = CurrentPrizepool.PrizePoolID>
<cfset this_Country = INT(CurrentPrizepool.Country)>
<cfset this_start = CurrentPrizepool.start_date>
<cfset this_end = CurrentPrizepool.draw_date>


<cfif this_Country NEQ 0>
	
	<cfquery name="CountryDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Name
	FROM Countries 
	WHERE CountryID=#this_Country#
	</cfquery>
	
</cfif>


<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_entry
WHERE EntryDate >= #CreateODBCDate(this_start)#
AND EntryDate <= #CreateODBCDate(this_end)#
</cfquery>


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="*" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>PRIZE DETAILS</strong></td>
<td align="right" width="100"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>





<table cellSpacing="0" cellPadding="0" border="0" width="400">

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="90" style="padding-right:10px;" valign="top"><b>Name:</b></td>
<td valign="top">#TRIM(CurrentPrizepool.Name)#</td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="90" style="padding-right:10px;" valign="top"><b>Description:</b></td>
<td valign="top">#TRIM(CurrentPrizepool.Description)#</td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="90" style="padding-right:10px;" valign="top"><b>Country:</b></td>
<td valign="top"><cfif this_Country NEQ 0>#TRIM(CountryDetails.Name)#<cfelse>All Countries</cfif></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="90" style="padding-right:10px;" valign="top"><b>Start Date:</b></td>
<td valign="top">#dateformat(this_start,'d-mmm-yy')#</td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="90" style="padding-right:10px;" valign="top"><b>End Date:</b></td>
<td valign="top">#dateformat(this_end,'d-mmm-yy')#</td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="90" style="padding-right:10px;" valign="top"><b>Points Value:</b></td>
<td valign="top">#INT(CurrentPrizepool.pointsvalue)#</td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="90" style="padding-right:10px;" valign="top"><b>Image:</b></td>
<td valign="top"><cfif FileExists("#request.fileroot#\images\prize\#TRIM(CurrentPrizepool.image)#")><img src="#request.webroot#/images/prize/#TRIM(CurrentPrizepool.image)#"></cfif></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="90" style="padding-right:10px;" valign="top"><b>Entries:</b></td>
<td valign="top">

	<table width="300" cellpadding="0" cellspacing="0" border="0">
	
	<cfloop query="PrizeEntries">
	<cfset this_contactID = PrizeEntries.ContactID>
	
	<cfquery name="ContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, LastName
	FROM Contacts
	WHERE ContactID=#this_contactID#
	</cfquery>
	
	<tr>
	<td width="100">#DateFormat(PrizeEntries.EntryDate, "dd/mm/yy")#</td>
	<td width="200">#TRIM(ContactStuff.FirstName)# #TRIM(ContactStuff.LastName)#</td>
	</tr>
	
	</cfloop>
	
	</table><br>






</td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"><br><br></td>
</tr>


</table>


</cfoutput>