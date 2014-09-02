<cfset insert_date = DateFormat(form.Testimonial_Date)>
		
<!--- GENERATE NEW ORGANISATION ID --->	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT TestimonialID
FROM Testimonials
ORDER BY TestimonialID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.TestimonialID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>
		
		
<cfquery name="AddTestimonial" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Testimonials(TestimonialID, Testimonial_Date, Testimonial_ContactID, Testimonial_Details, testimonial_sidebar)
VALUES(#newid#, #CreateODBCDate(insert_date)#, #form.Testimonial_ContactID#, '#TRIM(form.Testimonial_Details)#', #form.testimonial_sidebar#)
 </cfquery>


<cfoutput>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	   alert("New testimonial has been added successfully!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_testimonials')"></body>
  
</cfoutput>