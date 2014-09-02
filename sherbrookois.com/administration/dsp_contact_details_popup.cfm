<cfoutput>
		
<cfquery name="ContactDetails" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE Contacts.ContactID=#ContactID#
</cfquery>

<cfquery name="RegionDetails" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT Region
FROM Region
WHERE RegionID=#ContactDetails.RegionID#
</cfquery>

<cfquery name="DistrictDetails" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT District
FROM District
WHERE DistrictID=#ContactDetails.DistrictID#
</cfquery>

<cfquery name="SuburbDetails" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT Suburb
FROM Suburb
WHERE SuburbID=#ContactDetails.SuburbID#
</cfquery>

<cfquery name="CountryDetails" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT name
FROM Countries
WHERE CountryID=#ContactDetails.CountryID#
</cfquery>

<cfif isDefined("rewardID")>

	<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM prize_pool 
	WHERE PrizePoolID=#RewardID#
	</cfquery>

</cfif>

<html>

<head>
<cfinclude template="../templates/styles.cfm">
</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" bgcolor="white">
<div align="center">
<br>


<table border="0" cellpadding="0" cellspacing="0" width="95%">

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td width="90%">


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td class="PageTitle">People Profile</td>
	<td width="150" align="right" class="maincopy"><a href="javascript:window.close();" class="textlinks">Close Window</a> | <a href="javascript:window.print();" class="textlinks">Print page</a></td>
	</tr>
	
	</table>
	

</td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td bgcolor="black" width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td width="90%">


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td>Printed:<b> #dateformat(localDateTime, "mmm d, yyyy")#</b></td>
	<td align="center" class="maincopy"></td>
	<td align="right"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td width="90%" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td width="90%">


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td class="maincopy"><br>


									
									
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td style="font-size:14px;font-family:Trebuchet MS, Arial, Verdana, Helvetica;"><strong>Contact Details</strong></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="18" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" class="objectcopysmall" colspan="2" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" class="objectcopysmall" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
		</tr>
		
		</table>


		<table border="0" cellpadding="0" cellspacing="0">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(session.AllSettings_TextColour)#;" valign="top">Contact Name:&nbsp;&nbsp;</td>
		<td valign="top"><strong>#TRIM(ContactDetails.FirstName)# #TRIM(ContactDetails.LastName)#</strong> (#TRIM(ContactDetails.ScreenName)#)</td>
		<td align="right" style="color:###TRIM(session.AllSettings_TextColour)#;" valign="top">Address 1:&nbsp;&nbsp;</td>
		<td valign="top"><cfif TRIM(ContactDetails.Address1) NEQ ''>#TRIM(ContactDetails.Address1)#</cfif></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(session.AllSettings_TextColour)#;" valign="top">Email:&nbsp;&nbsp;</td>
		<td valign="top">#TRIM(ContactDetails.EmailAddress)#</td>
		<td valign="top" align="right" style="color:###TRIM(session.AllSettings_TextColour)#;">Address 2:&nbsp;&nbsp;</td>
		<td valign="top"><cfif TRIM(ContactDetails.Address2) NEQ ''>#TRIM(ContactDetails.Address2)#</cfif></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(session.AllSettings_TextColour)#;" valign="top">Mobile:&nbsp;&nbsp;</td>
		<td valign="top">#TRIM(ContactDetails.MobilePhone)#</td>
		<td align="right" style="color:###TRIM(session.AllSettings_TextColour)#;" valign="top">Address 3:&nbsp;&nbsp;</td>
		<td valign="top"><cfif TRIM(ContactDetails.Address3) NEQ ''>#TRIM(ContactDetails.Address3)#<br></cfif>
		<cfif SuburbDetails.RecordCount>#SuburbDetails.Suburb#<br></cfif>
		<cfif DistrictDetails.RecordCount>#DistrictDetails.District#<br><cfelse>#TRIM(ContactDetails.City)#<br></cfif>
		<cfif CountryDetails.RecordCount>#TRIM(CountryDetails.name)#</cfif></td>
		</tr>
		
		</table><br>
		

	
	</td>
	</tr>
	
	</table>


</td>
</tr>


<cfif IsDefined("RewardDetails.RecordCount")>

	<tr>
	<td width="90%">
	
	
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		
		<tr>
		<td class="maincopy"><br>
	
										
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
			
			<tr>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
			</tr>
			
			<tr>
			<td style="font-size:14px;font-family:Trebuchet MS, Arial, Verdana, Helvetica;"><strong>Reward Details</strong></td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="18" border="0"></td>
			</tr>	
			
			<tr>
			<td align="right" class="objectcopysmall" colspan="2" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td align="right" class="objectcopysmall" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
			</tr>
			
			</table>
			
			<table border="0" cellpadding="0" cellspacing="0">
	
			<tr>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="4" border="0"></td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="4" border="0"></td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="4" border="0"></td>
			</tr>
			
			<tr>
			<td align="right" style="color:###TRIM(session.AllSettings_TextColour)#;" valign="top">Reward:&nbsp;&nbsp;</td>
			<td valign="top">#TRIM(RewardDetails.Description)#</td>
			<td align="right" style="color:###TRIM(session.AllSettings_TextColour)#;" valign="top">Points Value:&nbsp;&nbsp;</td>
			<td valign="top">#RewardDetails.pointsvalue#</td>
			</tr>
			
			</table><br>
			
	
		
		</td>
		</tr>
		
		</table>
	
	
	</td>
	</tr>
	
	<tr>
	<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>
	
	<tr>
	<td width="90%" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>


</cfif>

</table><br>





<table border="0" cellpadding="0" cellspacing="0" width="95%">

<tr>
<td bgcolor="d3d3d3" width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td bgcolor="d3d3d3" width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>
</div>
</body>

</html>

</cfoutput>