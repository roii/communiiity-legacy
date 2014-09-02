<cfif IsDefined("FORM.id") and FORM.id neq ''>
       <cfset id = FORM.id>
<cfelse>
       <cfset id = 0> 
</cfif>  

<cfif IsDefined("FORM.image_name") and FORM.image_name neq ''>
       <cfset image_name = FORM.image_name>
<cfelse>
       <cfset image_name = ''> 
</cfif>  

<cfif IsDefined("FORM.image_text") and FORM.image_text neq ''>
       <cfset image_text = FORM.image_text>
<cfelse>
       <cfset image_text = ''> 
</cfif>  

<cfif IsDefined("FORM.image_url") and FORM.image_url neq ''>
       <cfset image_url = FORM.image_url>
<cfelse>
       <cfset image_url = ''> 
</cfif> 

<cfif id gt 0>  <!---Update Case--->

     <cfif image_name neq ''>
	            <cffile action = "upload" fileField = "image_name" destination = "D:/home/crowdsourciiing.com/wwwroot/devsite/images/homePageSliderImages/" accept = "image/jpg, image/jpeg, image/png, image/gif, image/pjpeg, image/jpe, image/jfif, image/jif, image/exif, image/tiff" nameConflict = "MakeUnique"> 
				<cfset uploadProfileImgFileName = cffile.SERVERFILE>
	 </cfif>
	 
	 <cfquery name="insertSliderImages" datasource="#dsn#" username="#request.username#" password="#request.password#">
	      UPDATE homepage_slider_images
		   SET image_text = '#image_text#', 
			   image_url  = '#image_url#' 
			   <cfif image_name neq ''>
			       , image_name = '#uploadProfileImgFileName#'
			   </cfif>
		  WHERE id = #id#
	 </cfquery>
	 
	 <cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_home_slider_images&update=done" addtoken="no">

<cfelse>  <!---INSERT CASE--->

     <cfif image_name neq ''>
	            <cffile action = "upload" fileField = "image_name" destination = "D:/home/crowdsourciiing.com/wwwroot/devsite/images/homePageSliderImages/" accept = "image/jpg, image/jpeg, image/png, image/gif, image/pjpeg, image/jpe, image/jfif, image/jif, image/exif, image/tiff" nameConflict = "MakeUnique"> 
				<cfset uploadProfileImgFileName = cffile.SERVERFILE>
	 </cfif>
	 
	 <cfquery name="insertSliderImages" datasource="#dsn#" username="#request.username#" password="#request.password#">
	      INSERT INTO homepage_slider_images
		  (image_name, image_text, image_url)
		  VALUES
		  ('#uploadProfileImgFileName#', '#image_text#', '#image_url#')
	 </cfquery>
	 
	 <cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_home_slider_images&add=done" addtoken="no">

</cfif>