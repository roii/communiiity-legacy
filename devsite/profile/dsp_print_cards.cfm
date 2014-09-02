<cfoutput>



<!--- CHECK IF THEY PRINTED BEFORE --->
<cfquery name="PrintedBefore" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT PrintBizCards
FROM Contacts
WHERE ContactID=#session.UserID#
</cfquery>

<cfif PrintedBefore.PrintBizCards EQ 0>

	<!--- INSERT POINTS TRANSACTION --->

	<cftransaction action="BEGIN">	
	
	<!--- INSERT THE TRANSACTION --->
		
		<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Related_Identifier, Related_description, Transaction_SponsorID, RoyaltyPaid, PointsType)
		VALUES(#session.userID#, #CreateODBCDateTime(localDateTime)#, 'Credit', 50, 'Printed business cards', 'Points', 0, 'PrintBizCards', 0, 0, 'Earned')
		</cfquery>
	
	</cftransaction>


	<!--- UPDATE PROFILE --->
	<cfquery name="PrintedBefore" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET PrintBizCards=1
	WHERE ContactID=#session.UserID#
	</cfquery>


</cfif>


<html>

<head>
<style>
td {
font-size: 11px;
font-family: Arial, Verdana, Helvetica;
}
</style>
</head>

<body marginheight="10" marginwidth="10" leftmargin="10" topmargin="10" bgcolor="white">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
	
<tr>
<td width="100%" height="100%" valign="middle" align="center">

	
	<table cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="5" background="#request.imageroot#/horz_dot_line.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" background="#request.imageroot#/horz_dot_line.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" background="#request.imageroot#/horz_dot_line.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" background="#request.imageroot#/horz_dot_line.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" background="#request.imageroot#/horz_dot_line.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" background="#request.imageroot#/horz_dot_line.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" background="#request.imageroot#/horz_dot_line.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><cfinclude template="dsp_card_landscape.cfm"></td>
	<td width="1" background="#request.imageroot#/vert_dot_line.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" background="#request.imageroot#/horz_dot_line.gif" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
		
	</table>
	

</td>
</tr>
	
</table>
</body>

</html>


</cfoutput>