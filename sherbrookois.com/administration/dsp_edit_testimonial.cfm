<cfoutput>
<cfquery name="qry_testimonial" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM Testimonials
WHERE TestimonialID=#TestimonialID#
</cfquery>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Edit Testimonial</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.contactid, contacts.firstname, contacts.lastname, contacts.emailaddress, Contacts.ScreenName
FROM Contacts
WHERE Contacts.ContactTypeID IN (1,2,4)
AND Contacts.ContactStatus <> 'deleted'
AND Contacts.ContactStatus <> 'pending'
ORDER BY contacts.firstname, contacts.lastname
</cfquery>


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Testimonial</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
		
	<script language="JavaScript">
	<!--
	function validate(AddTestimonial) {    
		
	if (AddTestimonial.testimonial_details.value == "") {
		alert("You must enter the details.");
		AddTestimonial.testimonial_details.focus();
		return;
		} 
		
	else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	AddTestimonial.submit(); //submit form
		}
	}
	// -->
	</script>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="AddTestimonial" action="#request.webroot#/administration/act_edit_testimonial.cfm" method="post" onsubmit="javascript:validate(AddTestimonial); return false;">
	<input type="hidden" name="testimonialID" value="#testimonialID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Date Submitted</td>
	<td><input type="text" name="Testimonial_Date" class="whitefield" style="width:300px;" value="#DateFormat(qry_testimonial.testimonial_date, "dd/mm/yyyy")#"> <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.AddTestimonial.Testimonial_Date);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Member</td>
	<td><select name="Testimonial_ContactID" class="whitefield" style="width:300px;">
	<cfloop query="allkids">
	<option value="#allkids.contactID#"<cfif qry_testimonial.testimonial_contactID EQ allkids.contactID> selected</cfif>>#TRIM(AllKids.FirstName)# #TRIM(AllKids.LastName)#
	</cfloop>
	</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110" valign="top">Details</td>
	<td><cf_activedit name="testimonial_details" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="450" height="420" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="no" defaultfont="8pt Verdana">#TRIM(qry_testimonial.Testimonial_Details)#</cf_activedit></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Sidebar</td>
	<td><input type="radio" name="Testimonial_sidebar" class="whitefield" value="1"<cfif qry_testimonial.testimonial_sidebar EQ 1> checked</cfif>> Yes &nbsp; <input type="radio" name="Testimonial_sidebar" class="whitefield" value="0"<cfif qry_testimonial.testimonial_sidebar EQ 0> checked</cfif>> No</td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" value="UPDATE TESTIMONIAL NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table><br><br>


	
</td>
</tr>

</table>
<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/administration/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>
</body>
</html>

</cfoutput>