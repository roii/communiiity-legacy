<!--- GET ALL STAFF --->
<cfquery name="AllStaff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, Lastname, EmailAddress
FROM Contacts
WHERE OrganisationID=#OrganisationID#
AND ContactStatus = 'Active'
ORDER BY FirstName
</cfquery>

<cfif IsNumeric("#PartnerStuff.PrimaryContactID#")>

	<cfquery name="PrimaryContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, Lastname, EmailAddress
	FROM Contacts
	WHERE ContactID=#PartnerStuff.PrimaryContactID#
	</cfquery>

</cfif>


<cfquery name="CountryStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Name
FROM Countries
WHERE CountryID=#PartnerStuff.CountryID#
</cfquery>

<cfquery name="RegionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Region
FROM Region
WHERE RegionID=#PartnerStuff.RegionID#
</cfquery>


<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Name:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(PartnerStuff.Organisation_Name)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Logo:</strong></td>
<td style="font-size:11px;color:##444444;"><cfif FileExists("#request.fileroot#\images\partners\#TRIM(PartnerStuff.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(PartnerStuff.LogoFile)#" border="0" title="#TRIM(PartnerStuff.Organisation_Name)#"></cfif></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Phone:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(PartnerStuff.WorkPhone)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Website:</strong></td>
<td style="font-size:11px;color:##444444;"><a href="#TRIM(PartnerStuff.WebsiteURL)#" target="_Blank">#TRIM(PartnerStuff.WebsiteURL)#</a></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Address:</strong></td>
<td style="font-size:11px;color:##444444;" valign="top"><cfif TRIM(PartnerStuff.Address1) NEQ ''>#TRIM(PartnerStuff.Address1)#<br></cfif>
<cfif TRIM(PartnerStuff.Address2) NEQ ''>#TRIM(PartnerStuff.Address2)#</cfif></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>City/Town:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(PartnerStuff.City)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
<td colspan="2"></td>
</tr>


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Region:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(RegionStuff.Region)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
<td colspan="2"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Country:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(CountryStuff.Name)#</td>
</tr>


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>No. of Staff:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(AllStaff.RecordCount)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Primary Contact:</strong></td>
<td valign="top" style="font-size:11px;color:##444444;"><cfif IsNumeric("#PartnerStuff.PrimaryContactID#")>#TRIM(PrimaryContactStuff.FirstName)# #TRIM(PrimaryContactStuff.LastName)#<br>
<a href="mailto:#TRIM(PrimaryContactStuff.EmailAddress)#">#TRIM(PrimaryContactStuff.EmailAddress)#</a><cfelse>Un-assigned</cfif></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Notes:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(PartnerStuff.Notes)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2" style="font-size:11px;color:##444444;"><hr width="100%" size="1" color="silver"><br><strong>Profile Content:</strong><br><br></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" colspan="2">#TRIM(PartnerStuff.ProfileContent)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>


</table>

<div align="center"><input type="button" onclick="javascript:window.close();" value="CLOSE WINDOW >>" class="whitefield"></div><br>


</cfoutput>