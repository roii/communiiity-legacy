<cfoutput>

<!--- GET ALL BUSINESSES --->
<cfquery name="Currentbiz" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT bizidea.biz_idea
FROM bizKidsLink, business, bizidea
WHERE bizKidsLink.kidsid=#ContactDetails.contactID#
AND bizKidsLink.bizID=Business.bizID
AND business.bizideaID=bizidea.bizideaID
AND Business.BizStatus LIKE 'Active'
AND bizidea.show=1
ORDER BY bizidea.biz_idea
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Businesses</strong></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	</tr>
	
	<cfloop query="Currentbiz">
	
	<tr>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">#TRIM(Currentbiz.biz_idea)#</td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>


</td>
</tr>

</table><br>



</cfoutput>