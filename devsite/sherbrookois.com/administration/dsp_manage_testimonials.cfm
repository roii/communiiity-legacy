<script language="javascript">
 <!--
	function confirmTestimonialDelete(aURL) {
	    if(confirm('Are you sure you want to delete this testimonial?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>


<cfquery name="qry_all_testimonials" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM Testimonials
ORDER BY Testimonial_Date DESC
</cfquery>

<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Testimonials_StartRow" default="1">
</cflock>

	<cfif isdefined("Testimonials_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Testimonials_StartRow = Testimonials_StartRow>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Testimonials_MaxRows" default="50">
</cflock>

	<cfif isdefined("Testimonials_MaxRows")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Testimonials_MaxRows = Testimonials_MaxRows>
		</cflock>
	</cfif>

<cfif session.Testimonials_MaxRows NEQ 'ALL'>
	
		<cfif qry_all_testimonials.RecordCount GT (session.Testimonials_StartRow+session.Testimonials_MaxRows)-1>
			<cfset Testimonials_endrow = session.Testimonials_StartRow+session.Testimonials_MaxRows-1>
		<cfelse>
			<cfset Testimonials_endrow = qry_all_testimonials.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset Testimonials_endrow = qry_all_testimonials.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.Testimonials_Startrow GT session.Testimonials_Maxrows>
		<cfset prev = session.Testimonials_Startrow-session.Testimonials_Maxrows>
	
	<cfelse>
		<cfset prev = session.Testimonials_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif Testimonials_endrow LT qry_all_testimonials.RecordCount>
		<cfset next = (Testimonials_endrow+1)>
	
	<cfelse>
		<cfset next = session.Testimonials_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.Testimonials_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(qry_all_testimonials.RecordCount/session.Testimonials_Maxrows)>
		<cfset TestimonialsNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset TestimonialsNumberCount=1>
		
	</cfif>	
<cfoutput>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="40%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE TESTIMONIALS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<tr>
<td style="font-size:11px;"><a href="#request.webroot#/administration/dsp_add_testimonial.cfm" target="AddTest" onclick="fdbackwindow=window.open ('','AddTest','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=550,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A TESTIMONIAL &raquo;</strong></a></td>
<td></td>
</tr>

</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<!--- display allow sorting column --->
	
	<tr>
	<td style="font-size:11px;"><strong>Date</strong></td>
	<td style="font-size:11px;"><strong>Member</strong></td>
	<td style="font-size:11px;"><strong>Details</strong></td>
	<td style="font-size:11px;"><strong>Sidebar</strong></td>
	<td style="font-size:11px;">&nbsp;</td>
	</tr>
	
	<tr>
	<td height="2" width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="2" border="0"></td>
	<td height="2" width="140"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="2" border="0"></td>
	<td height="2" width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	<td height="2" width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="2" border="0"></td>
	<td height="2" width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	
	<cfloop query="qry_all_testimonials" startrow="#session.Testimonials_StartRow#" endrow="#Testimonials_endrow#">
	
	<cfquery name="qry_member_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM Contacts
	WHERE ContactID=#qry_all_testimonials.Testimonial_ContactID#
	</cfquery>
	
	<tr>
	<td style="font-size:11px;" valign="top">#DateFormat(qry_all_testimonials.testimonial_date)#</td>
	<td style="font-size:11px;" valign="top">#TRIM(qry_member_details.FirstName)# #TRIM(qry_member_details.LastName)#</td>
	<td style="font-size:11px;" valign="top">#TRIM(qry_all_testimonials.testimonial_details)#</td>
	<td style="font-size:11px;" valign="top">#YesNoFormat(qry_all_testimonials.testimonial_sidebar)#</td>
	<td align="right" valign="top"><a href="#request.webroot#/administration/dsp_edit_testimonial.cfm?TestimonialID=#qry_all_testimonials.TestimonialID#" target="editTest" onclick="fdbackwindow=window.open ('','editTest','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Testimonial" border="0"></a>&nbsp;<a href="javascript:confirmTestimonialDelete('#request.webroot#/administration/act_delete_testimonial.cfm?TestimonialID=#qry_all_testimonials.TestimonialID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Testimonial" border="0"></a>
	</tr>
	
	</cfloop>	
	
	<tr>
	<td colspan="5" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</table>
	
    <hr width="100%" size="1" color="e2e2e2">
	
	<div align="right"><cfif session.Testimonials_Startrow GT session.Testimonials_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Testimonials_Startrow=#prev#">Prev Page</a> | </cfif><cfif Testimonials_endrow LT qry_all_testimonials.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Testimonials_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Testimonials_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#TestimonialsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Testimonials_Maxrows*NumberCount-session.Testimonials_Maxrows+1)><cfif thisStartRow EQ session.Testimonials_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Testimonials_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Testimonials_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ TestimonialsNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div></td>
</tr>

</table>

</cfoutput>