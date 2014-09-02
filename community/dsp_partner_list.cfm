<cfoutput>

<cfquery name="AllPartners" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT OrganisationID, Organisation_Name, LogoFile
FROM Organisations
WHERE Organisations.OrgCatID=5
AND Organisations.Organisation_Status = 'Active'
ORDER BY Organisations.Organisation_Name
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
<cfset partners_total = 0>

<tr>
<cfloop query="AllPartners">
<td width="30%" align="center" height="100%">

	
	<table width="100%" height="100%" cellpadding="5" cellspacing="0" style="border:solid 1px ##b4b4b4;">
				
	<tr>
	<td width="100%" height="100%">
		
		<table width="100%" height="100%" cellpadding="0" cellspacing="0">
		
		<tr>
		<td style="font-size:11px;color:###TRIM(session.AllSettings_DkTextColor)#;" align="center" height="100%" valign="middle"><cfif FileExists("#request.fileroot#\images\partners\#TRIM(AllPartners.LogoFile)#")><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&partnermode=profile&organisationID=#AllPartners.OrganisationID#"><img src="#request.imageroot#/partners/#TRIM(AllPartners.LogoFile)#" border="0" title="#TRIM(AllPartners.Organisation_Name)#"></a></cfif></td>
		</tr>
		
		<tr>
		<td height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5"  border="0"></td>
		</tr>
		
		<tr>
		<td style="font-size:11px;color:###TRIM(session.AllSettings_DkTextColor)#;" align="center" valign="bottom"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&partnermode=profile&organisationID=#AllPartners.OrganisationID#">#TRIM(AllPartners.Organisation_Name)#</a></td>
		</tr>
		
		</table>				
	
	</td>
	</tr>
	
	</table>
	
	
</td>
<td width="20"></td>

<cfif AllPartners.CurrentRow MOD 3 IS 0>
	</tr>
	
	<tr>
	<td colspan="5"><br></td>
	</tr>
	
 	<tr>
</cfif>


</cfloop>	
</tr>

</table>


</cfoutput>