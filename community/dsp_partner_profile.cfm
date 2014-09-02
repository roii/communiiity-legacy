<cfoutput>

<cfquery name="PartnerStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Organisations
WHERE OrganisationID=#OrganisationID#
</cfquery>



<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contact_transactions.ContactID, Contacts.SchoolID, Contacts.Charity
FROM Contact_transactions, Contacts
WHERE Contact_transactions.Transaction_Account = 'Points'
AND Contact_transactions.Transaction_SponsorID=#OrganisationID#
AND Contact_transactions.ContactID=Contacts.ContactID
GROUP BY Contact_transactions.ContactID, Contacts.SchoolID, Contacts.Charity
</cfquery>

<cfset SchoolList = "">
<cfset CharityList = "">

<cfloop query="TransactionHistory">

<cfif ListFind(SchoolList, TransactionHistory.SchoolID, ",") OR TransactionHistory.SchoolID EQ '9999999' OR TransactionHistory.SchoolID EQ '9999998' OR TransactionHistory.SchoolID EQ '0'>
<cfelse>
	<cfset SchoolList = SchoolList & "#TransactionHistory.SchoolID#,">
</cfif>

<cfif ListFind(CharityList, TransactionHistory.Charity, ",") OR TransactionHistory.Charity EQ '0'>
<cfelse>
	<cfset CharityList = CharityList & "#TransactionHistory.Charity#,">
</cfif>


</cfloop>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(session.AllSettings_DkTextColor)#" height="20"><strong>PARTNER PROFILE</strong></td>
<td align="right" width="30" height="20"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>



<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:18px;color:###TRIM(session.AllSettings_DkTextColor)#;padding-right:10px;"><strong>#TRIM(PartnerStuff.Organisation_Name)#</strong></td>
<td align="right"><cfif FileExists("#request.fileroot#\images\partners\#TRIM(PartnerStuff.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(PartnerStuff.LogoFile)#" border="0" title="#TRIM(PartnerStuff.Organisation_Name)#" alt="#TRIM(PartnerStuff.Organisation_Name)#"></cfif></td>
</tr>

<tr>
<td width="100%" colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td width="100%" colspan="2">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="65%" valign="top" style="padding-right:10px;">#TRIM(PartnerStuff.ProfileContent)#</td>
	<td width="35%" valign="top">
		
		
		<table width="100%" cellpadding="5" cellspacing="0" style="border:solid 1px ##b4b4b4;">
		
		<tr>
		<td>
		<cfinclude template="dsp_partnerprofile_community.cfm">
		<cfinclude template="dsp_partnerprofile_ideas.cfm">
		</td>
		</tr>
		
		</table>
		
		
	</td>
	</tr>
	
	</table>

	
</td>
</tr>

<tr>
<td width="100%" colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

</table><br>

</cfoutput>