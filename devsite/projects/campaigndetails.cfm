<cfif IsDefined("URL.campID") and URL.campID neq ''>  
			
<cfset campaign_id = Replace(#TRIM(URL.campID)#, "-", " ", "ALL")>  
  
<script language="javascript">
 	<!--
	function confirmCategoryDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmProjectDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Project?')) {
	      location.href = aURL;
	    }
	  }
	//--> 
	
	function followunfollow(followstatus, userid, userip, campaignID)
	{
	     // Launch AJAX request.
		 $.ajax({
			// The link we are accessing.
			url: "<cfoutput>#request.webroot#</cfoutput>/projects/follow_campaign.cfm", 
			// The type of request.
			type: "get", 
			data: { followstatus: followstatus, userid: userid, userip: userip, campaignID: campaignID },
			// The type of data that is getting returned.
			dataType: "html", 
			error: function(){
				/*ShowStatus( "AJAX - error()" ); 
				// Load the content in to the page.
				jContent.html( "<p>Page Not Found!!</p>" );*/
			}, 
			beforeSend: function(){
				/*ShowStatus( "AJAX - beforeSend()" );*/
			}, 
			complete: function(){
				/*ShowStatus( "AJAX - complete()" );*/
			}, 
			success: function( strData ){
				//ShowStatus( "AJAX - success()" ); 
				// Load the content in to the page.
				if(strData.trim() == 'follow')
				{
				       alert('You have been added in this campaign follow list.');
					    //$('#flluntextID').html('UnFollow'); 
				}
				else
				{
				       alert('You have been removed from this campaign follow list.');
					    //$('#flluntextID').html('Follow');
				}
				window.location = '<cfoutput>#request.webroot#</cfoutput>/projects/<cfoutput>#campaign_id#</cfoutput>';
			}
		 });
	} 
</script>
<cfoutput>
<!---<script src="#request.webroot#/js/jquery.hashchange.min.js" type="text/javascript"></script>
<script src="#request.webroot#/lib/jquery.easytabs.min.js" type="text/javascript"></script> --->

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script> 

</cfoutput>
 
<cfinclude template="/projects/includeData.cfm"> 
	  
<cfoutput> 
		<div class="headingTitle">  
			 <cfinclude template="/projects/headingData.cfm"> 	 		 
	    </div> 
		<link href="#request.webroot#/themes/1/js-image-slider.css" rel="stylesheet" type="text/css" />
		<script src="#request.webroot#/themes/1/js-image-slider.js" type="text/javascript"></script>
		<link href="#request.webroot#/themes/generic.css" rel="stylesheet" type="text/css" />
</cfoutput>		


<div id="tabs">
<ul>
<li><a href="#tabs-1">Nunc tincidunt</a></li>
<li><a href="#tabs-2">Proin dolor</a></li>
<li><a href="#tabs-3">Aenean lacinia</a></li>
</ul>
<div id="tabs-1">
<p>Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique tempus lectus.</p>
</div>
<div id="tabs-2">
<p>Morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. Duis scelerisque molestie turpis. Sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. Aenean aliquet fringilla sem. Suspendisse sed ligula in ligula suscipit aliquam. Praesent in eros vestibulum mi adipiscing adipiscing. Morbi facilisis. Curabitur ornare consequat nunc. Aenean vel metus. Ut posuere viverra nulla. Aliquam erat volutpat. Pellentesque convallis. Maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. Mauris consectetur tortor et purus.</p>
</div>
<div id="tabs-3">
<p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
<p>Duis cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>
</div>
</div>



	 
<div id="tab-container" class='tab-container'>
	 <ul class='etabs'>
	   <li class='tab'><a href="#tabs1-stat"><cfoutput>#hometab#</cfoutput></a></li>
	   <!---<li class='tab'><a href="#tabs1-updates"><cfoutput>#updatestab#</cfoutput></a></li>
	   <li class='tab'><a href="#tabs1-ideas"><cfoutput>#ideastab#</cfoutput></a></li>--->
	   <li class='tab'><a href="#tabs1-projects"><cfoutput>#tasks#</cfoutput></a></li>
	   <!---<li class='tab'><a href="#tabs1-supporters"><cfoutput>#contributors#</cfoutput></a></li>--->
	   <li class='tab'><a href="#tabs1-gallery"><cfoutput>#gallerytab#</cfoutput></a></li>
	 </ul>
	 <div class='panel-container'>
		<div id="tabs1-stat"> 
		         <cfoutput>  
					 <div class="fl campaigns-content">
						  <section class="box" style="width: 565px; background: none repeat scroll 0 0 ##FBF9FC; padding: 0px;">
							    <cfinclude template="/projects/campaign_video.cfm">
						  </section> 
						  <section id="share" class="fl sharing box rounded shadow" style="width: 450px;">  
								<cfinclude template="/projects/sharing_campaign_tool.cfm">   
					      </section>  
						  <section class="box2 rounded shadow" style="width: 531px; padding-top: 0px; padding-left: 20px; padding-right: 20px; padding-bottom: 5px;">
								 <h1 style=" margin: 6px;">
									  #description#
								 </h1> 
								 <p> 
									 <cfif TRIM(getCampaigns.details) neq ''> 
										  #TRIM(getCampaigns.details)# 
									 </cfif> 		  
								 </p>
						   </section> 
					 </div> 
					 <aside class="fr sidebar"> 
						   <section class="box rounded shadow">
								 <cfinclude template="/projects/dashboard_section.cfm">   
						   </section>   
						   <!---<section class="box rounded shadow">
							     <cfinclude template="/projects/rewards_section.cfm">
						   </section>   
						  <section class="box rounded shadow">
							     <cfinclude template="/projects/team_section.cfm">
					      </section> ---> 
					 </aside>  
	             </cfoutput>
		</div>
		<!---<div id="tabs1-updates" style="padding: 15px;"> 
		        Updates Coming Soon.......  
		</div>--->
		<!---<div id="tabs1-ideas" style="padding: 15px;"> --->
		     <!---Ideas Coming Soon....... --->
			     <!---<cfinclude template="dsp_ideas.cfm">
		</div>--->
		<div id="tabs1-projects" style="padding: 15px;">
		      <!---Project Coming Soon....... ---> 
                 <cfinclude template="dsp_tasks.cfm">
		</div>
		<!---<div id="tabs1-supporters" style="padding: 15px;">
			     Supporters Coming Soon....... 
                 <cfinclude template="dsp_contributors.cfm">
		</div>--->
		<div id="tabs1-gallery" style="padding: 42px;">
			 <!---Gallery Coming Soon....... ---> 
			     <cfinclude template="dsp_gallery_projects.cfm"> 
		</div>
	 </div>
</div> 
	  
<cfelse>
    <p style="color: red; font-weight: bold;">
	      You are accessing the wrong page.....
	</p>
</cfif>