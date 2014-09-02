<cfoutput>


<cfquery name="qry_all_testimonials" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM Testimonials
ORDER BY Testimonial_Date DESC
</cfquery>


<table border="0" cellpadding="0" cellspacing="0" width="100%">


<tr>
<td height="20"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="20"></td>
</tr>

<tr>
<td height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
</tr>

<tr>
<td height="20"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="20"></td>
</tr>

<cfloop query="qry_all_testimonials">

<cfquery name="qry_member_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, ScreenName
FROM Contacts
WHERE ContactID=#qry_all_testimonials.Testimonial_ContactID#
</cfquery>



<tr>
<td style="color:##333333;font-size:13px;"><strong>#TRIM(qry_all_testimonials.Testimonial_Details)#</strong></td>
</tr>

<tr>
<td height="4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="4"></td>
</tr>

<tr>
<td style="padding-left:5px;"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#qry_member_details.ContactID#" title="View Profile"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#qry_member_details.ContactID#" title="View Profile">#TRIM(qry_member_details.ScreenName)#</a><!--- &nbsp;&nbsp; [#DateFormat(qry_all_testimonials.testimonial_date)#]---></td>
</tr>

<tr>
<td height="20"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="20"></td>
</tr>

<tr>
<td height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
</tr>

<tr>
<td height="20"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="20"></td>
</tr>

</cfloop>

</table>


</cfoutput>