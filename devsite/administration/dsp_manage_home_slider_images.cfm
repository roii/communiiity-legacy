<cfif IsDefined("URL.id") and URL.id neq ''>
		 <cfquery name="getSliderImageById" datasource="#dsn#" username="#request.username#" password="#request.password#">
			 SELECT * FROM homepage_slider_images WHERE id = #URL.id#
		 </cfquery>
		 <cfoutput>
		     <img src="#request.webroot#/images/homePageSliderImages/#getSliderImageById.image_name#" alt="" width="800" class="img-responsive" alt="#getSliderImageById.image_name#" />
			 <br />
			 <br />
			 Text to be displayed over image: <br />
			 <p>#getSliderImageById.image_text#</p> <br /> <br />
			 Button URL: <a href="#getSliderImageById.image_url#" target="_blank">#getSliderImageById.image_url#</a><br /><br />
			 <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_home_slider_images">Go Back to Image Listings</a>
		 </cfoutput>	 
<cfelse>
  <cfquery name="getSliderImages" datasource="#dsn#" username="#request.username#" password="#request.password#">
     SELECT * FROM homepage_slider_images;
  </cfquery>
  <cfif IsDefined("URL.add") and URL.add eq "done">
       <cfoutput>
	      <span style="color: blue;"> 
		    Home page slider image has been added successfully
		  </span>	
	   </cfoutput>
  </cfif>
  <cfif IsDefined("URL.update") and URL.update eq "done">
       <cfoutput>
	      <span style="color: blue;"> 
		    Home page slider image has been updated successfully
		  </span>	
	   </cfoutput>
  </cfif>
  <cfif IsDefined("URL.delete") and URL.delete eq "done">
       <cfoutput>
	      <span style="color: blue;"> 
		    Home page slider image has been deleted successfully
		  </span>	
	   </cfoutput>
  </cfif>
  <h2>
      Home page Slider Images
  </h2><br />
  <cfoutput>
  <span><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_edit_slider_image" class="paginate_button current" aria-controls="example" data-dt-idx="1" tabindex="0" style="background: linear-gradient(to bottom, white 0%, gainsboro 100%) repeat scroll 0 0 rgba(0, 0, 0, 0); border: 1px solid ##cacaca; color: ##333333 !important; padding: 10px; text-decoration: none; margin-bottom: 10px; cursor: pointer;">Add Image</a></span>
  <br /><br />
  
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
			    <th>ID</th> 
                <th>Name</th> 
                <th>Action</th> 
            </tr>
        </thead>
 
        <tfoot>
            <tr>
			    <th>ID</th>
                <th>Name</th> 
                <th>Action</th> 
            </tr>
        </tfoot>
 
        <tbody> <!---#image_url#--->
		    <cfloop query="getSliderImages">
				<tr>
					<td>#id#</td>
					<td><img src="#request.webroot#/images/homePageSliderImages/#image_name#" alt="" width="50" height="50" /></td> 
					<td>
					    <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_home_slider_images&id=#id#">View</a><br />
						<a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_edit_slider_image&id=#id#">Edit</a><br />
						<a href="javascript: void(0);" onclick="deleteImg(#id#);">Delete</a>
					</td> 
				</tr> 
		    </cfloop>			
        </tbody>
    </table> 
  </cfoutput>

<script language="javascript">
function deleteImg(id)
{
     var r = confirm("Are you sure want to delete this image from slider");
		if (r == true) {
			 window.location = '<cfoutput>#request.webroot#</cfoutput>/index.cfm?fuseaction=administration&fusesubaction=delete_slider_image&id='+id;
		} else {
			return false;
		}
}


$(document).ready(function() {
    $('#example').dataTable( {
        "order": [[ 0, "desc" ]]
    } );
} );
</script>
</cfif> 