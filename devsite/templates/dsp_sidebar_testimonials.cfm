<cfoutput>

<cfquery name="TestimonialStuff" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT Testimonials.*, Contacts.ContactID, Contacts.ScreenName
FROM Testimonials, Contacts
WHERE Testimonials.testimonial_sidebar = 1
AND Testimonials.Testimonial_ContactID=Contacts.ContactID
ORDER BY Testimonials.testimonial_date DESC
</cfquery>

<a name="announcements"> </a>
<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ###TRIM(AllSettings.BoxColour)#;">

<tr>
<td bgcolor="###TRIM(AllSettings.BoxColour)#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>WHAT OUR MEMBERS SAY</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>

	
	<table width="150" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td colspan="2" style="font-size:11px;color:black;">
	
	<table cellpadding="0" cellspacing="0">
	
	<tr>
	<td style="font-size:11px;color:black;padding-bottom:4px;"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TestimonialStuff.ContactID#" title="View Profile"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0" align="absmiddle"></a></td>
	<td style="padding-left:6px;font-size:11px;color:black;padding-bottom:4px;"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TestimonialStuff.ContactID#" title="View Profile">#TRIM(TestimonialStuff.ScreenName)#</a><!---<br>[#DateFormat(TestimonialStuff.testimonial_date)#]---></td>
	</tr>
	</table>
	
	<div style="border-top:dashed 1px b4b4b4;border-bottom:dashed 1px b4b4b4;width:150px;"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	#TRIM(TestimonialStuff.Testimonial_details)#<br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	</div><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	
	<a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=109" style="color:###TRIM(AllSettings.BoxColour)#;">more testimonials...</a></td>
	</tr>
	
	</table><br>


</td>
</tr>

</table>


</cfoutput>