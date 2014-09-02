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
			 <cfset videoArr = ListToArray(#videoArrF[3]#, "watch?")>
			 <cfset videoID  = Right(videoArr[1], Len(videoArr[1])-2)>
			   <br />
				<object width="565" height="281">
				   <param name="movie" value="http://www.youtube.com/v/#videoID#" />
				   <embed src="http://www.youtube.com/v/#videoID#" type="application/x-shockwave-flash" width="565" height="281" />
				</object>
	   <cfelse>
			 <p>
				 You have entered the wrong URL for video. It should only be Youtube or Vimeo.
			 </p>
	   </cfif>
</cfif> 
</cfoutput>