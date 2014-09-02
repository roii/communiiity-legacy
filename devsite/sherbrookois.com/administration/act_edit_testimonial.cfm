<cfset insert_date = CREATEDATE(mid(form.Testimonial_Date,7,4),mid(form.Testimonial_Date,4,2),mid(form.Testimonial_Date,1,2))>
<cfset insert_date = DateFormat(insert_date,"mm/dd/yyyy")>
		
<cfquery name="UpdateTestimonial" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Testimonials
SET Testimonial_Date=#CreateODBCDate(insert_date)#,
Testimonial_ContactID=#form.Testimonial_ContactID#,
Testimonial_Details='#TRIM(form.Testimonial_Details)#',
testimonial_sidebar=#form.testimonial_sidebar#
WHERE TestimonialID=#form.TestimonialID#
 </cfquery>


<cfoutput>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	   alert("Testimonial has been updated!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_testimonials')"></body>
  
</cfoutput>