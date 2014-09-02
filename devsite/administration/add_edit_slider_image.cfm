<cfif IsDefined("URL.id") and URL.id neq ''>
       <cfset id = URL.id>
<cfelse>
       <cfset id = 0> 
</cfif>  
<cfif id gt 0>
		<cfquery name="getSliderImage" datasource="#dsn#" username="#request.username#" password="#request.password#">
		     SELECT * FROM homepage_slider_images WHERE id = #id#;
	    </cfquery>
		<cfset image_text = getSliderImage.image_text>
		<cfset image_url  = getSliderImage.image_url>
		<cfset image_name = getSliderImage.image_name>
<cfelse>
        <cfset image_text = ''>
		<cfset image_url  = ''>
		<cfset image_name = ''>		
</cfif>
<form method="post" enctype="multipart/form-data" action="<cfoutput>#request.webroot#</cfoutput>/index.cfm?fuseaction=administration&fusesubaction=save_home_slider_image" name="PageLoginForm" class="form-signin" role="form">
	<h2 class="form-signin-heading">
	      <cfif id gt 0>
		  <cfelse>
			   Add New Image for Slider.    
		  </cfif>
	</h2>
	<input type="hidden" name="id" value="<cfoutput>#id#</cfoutput>" />
	Image added: <br /><img src="<cfoutput>#request.webroot#</cfoutput>/images/homePageSliderImages/<cfoutput>#image_name#</cfoutput>" alt="" width="200" class="img-responsive" alt="<cfoutput>#image_name#</cfoutput>" />
	<cfif id gt 0>
	     <input type="file" name="image_name" class="form-control" value="" />
	<cfelse>
	     <input type="file" name="image_name" class="form-control" value="" required />
	</cfif> 
	<textarea name="image_text" class="form-control"><cfoutput>#image_text#</cfoutput></textarea>
	<input type="text" class="form-control" placeholder="Image URL" name="image_url" value="<cfoutput>#image_url#</cfoutput>"> <br />
	<cfif id gt 0>
	     <button class="btn btn-lg btn-primary btn-block" type="submit">Update Slider Image</button>  
	<cfelse>
	     <button class="btn btn-lg btn-primary btn-block" type="submit">Add New Slider Image</button> 
	</cfif> 
</form>
<br /><br />
 <a href="<cfoutput>#request.webroot#</cfoutput>/index.cfm?fuseaction=administration&fusesubaction=manage_home_slider_images">Go Back to Image Listings</a>