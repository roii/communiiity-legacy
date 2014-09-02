<cfoutput>

<cfquery name="getSliderImages" datasource="#dsn#" username="#request.username#" password="#request.password#">
     SELECT * FROM homepage_slider_images;
</cfquery>

  <h2>
      Home page Slider Images
  </h2><br />
<table id="example" class="display" cellspacing="0" width="100%">
        <thead>
            <tr>
			    <th>ID</th> 
                <th>Name</th>
                <th>Text</th>
                <th>Action</th> 
            </tr>
        </thead>
 
        <tfoot>
            <tr>
			    <th>ID</th>
                <th>Name</th>
                <th>Text</th>
                <th>Action</th> 
            </tr>
        </tfoot>
 
        <tbody> <!---#image_url#--->
		    <cfloop query="getSliderImages">
				<tr>
					<td>#id#</td>
					<td>#image_name#</td>
					<td>#image_text#</td>
					<td>
					    <a href="##">View</a><br />
						<a href="##">Edit</a>
					</td> 
				</tr> 
		    </cfloop>			
        </tbody>
    </table>
 

</cfoutput>

<script language="javascript">
$(document).ready(function() {
    $('#example').dataTable( {
        "order": [[ 0, "desc" ]]
    } );
} );
</script>