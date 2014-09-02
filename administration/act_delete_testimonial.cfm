<cfquery name="UpdateTestimonial" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM Testimonials
WHERE TestimonialID=#TestimonialID#
 </cfquery>


<cfoutput>

	<script language="JavaScript">
	alert("Testimonial has been deleted!");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_testimonials";	
	</script>

</cfoutput>