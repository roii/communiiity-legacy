<cfoutput>
<cfset videoPlayerCheck = Find('vimeo.com', #getCampaigns.campaign_video#)>	 
<cfif #videoPlayerCheck# gt 0>
	<cfset videoArr = ListToArray(#getCampaigns.campaign_video#, "/")>
	<cfset videoID  = videoArr[3]>
				 <object width="565" height="281">
					   <param name="allowfullscreen" value="true" />
					   <param name="allowscriptaccess" value="always" />
					   <param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=#videoID#&server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=00adef&fullscreen=1" />
					   <embed src="http://vimeo.com/moogaloop.swf?clip_id=#videoID#&server=vimeo.com&show_title=1&show_byline=1&show_portrait=0&color=00adef&fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="565" height="281"></embed>
				 </object>
<cfelse>
	  <cfset videoPlayerCheck2 = Find('youtube.com', #getCampaigns.campaign_video#)>
	   <cfif #videoPlayerCheck2# gt 0> 
			 <cfset videoArrF = ListToArray(#getCampaigns.campaign_video#, "/")>
			 <cfset videoArr = ListToArray(#videoArrF[3]#, "?")>
			 <cfset videoID  = Right(videoArr[2], Len(videoArr[2])-2)>
			   <br />   
				<object width="565" height="281">
				   <param name="movie" value="http://www.youtube.com/v/#videoID#" />
				   <embed src="http://www.youtube.com/v/#videoID#" type="application/x-shockwave-flash" width="565" height="281" />
				</object>
	   <cfelse>
			  <cfset project_media_image = getCampaigns.project_media_image>
			  <cfif project_media_image neq ''>
			     <img src="/images/carcasses_new/#project_media_image#" border="0" />
			  <cfelse>
			      <p>
				       Added video was wrong. It should be of vimeo or youtube.
				  </p>	 
			  </cfif>	 
	   </cfif>
</cfif> 
</cfoutput>