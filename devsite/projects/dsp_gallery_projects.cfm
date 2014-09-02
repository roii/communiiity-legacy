<cfset galleryImage1 = #getCampaigns.gallery_pics_1#>
<cfset galleryImage2 = #getCampaigns.gallery_pics_2#>
<cfset galleryImage3 = #getCampaigns.gallery_pics_3#>
<cfset galleryImage4 = #getCampaigns.gallery_pics_4#>
<cfset galleryImage5 = #getCampaigns.gallery_pics_5#>

<cfset imagesAllUp = 0>

<cfif galleryImage1 neq '' or galleryImage2 neq '' or galleryImage3 neq '' or galleryImage4 neq '' or galleryImage5 neq ''>
      <cfset imagesAllUp = imagesAllUp + 1>
</cfif>

<cfif imagesAllUp gt 0>
	<cfoutput> 
	<div id="sliderFrame">
		<div id="slider">
		  <cfif galleryImage1 neq ''>
		      <img src="#request.webroot#/images/carcasses_new/#galleryImage1#" alt="Gallery Image 1" />
		  </cfif>	  
		  <cfif galleryImage2 neq ''>
			<img src="#request.webroot#/images/carcasses_new/#galleryImage2#" alt="Gallery Image 2" />
		  </cfif>
		  <cfif galleryImage3 neq ''>	
			<img src="#request.webroot#/images/carcasses_new/#galleryImage3#" alt="Gallery Image 3" />
		  </cfif>
		  <cfif galleryImage4 neq ''>	
			<img src="#request.webroot#/images/carcasses_new/#galleryImage4#" alt="Gallery Image 4" />
		  </cfif>
		  <cfif galleryImage5 neq ''>	
			<img src="#request.webroot#/images/carcasses_new/#galleryImage5#" alt="Gallery Image 5" /> 
		  </cfif>	
			<!---<a href="http://www.menucool.com/javascript-image-slider" target="_blank">
				<img src="#request.webroot#/images/image-slider-1.jpg" alt="Welcome to Menucool.com" />
			</a>
			<img src="#request.webroot#/images/image-slider-2.jpg" alt="" />
			<img src="#request.webroot#/images/image-slider-3.jpg" alt="Pure Javascript. No jQuery. No flash." />
			<img src="#request.webroot#/images/image-slider-4.jpg" alt="##htmlcaption" />
			<img src="#request.webroot#/images/image-slider-5.jpg" />--->
		</div>
		<div id="htmlcaption" style="display: none;">
			<em>HTML</em> caption. Link to <a href="http://www.google.com/">Google</a>.
		</div>
	</div> 
	</cfoutput>
<cfelse>
   <table cellpadding="0" cellspacing="0" border="0" width="100%">
			    <tr>
				     <td> 
						  <img src="/images/DataNotFound.jpg" border="0" />
					 </td>
				</tr>
    </table>
</cfif>	