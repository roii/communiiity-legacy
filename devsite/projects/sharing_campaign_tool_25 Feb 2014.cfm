<cfoutput> 
<cfscript>
	// define the user variables
	strUser 	= 'gr8developervm';
	strKey		= 'R_cedc7b73201d55f62225e132a8be11c2'; 
	// instantiate the object
	objBitly = createObject('component', 
		'com.coldfumonkeh.bitly.bitly')
		.init(
			username	=	strUser,
			apikey		=	strKey,
			parse		=	true
		); 
	// let's shorten a URL
	shorten = objBitly.shorten(longURL='#request.webroot#/projects/#campaignID#',format='json',domain='j.mp');
</cfscript>
<h2 style="margin-right:10px;" class="fl label bold">#sharethisproj#:</h2>
<div class="share-link clearfix">
	 <div class="fl input-item-text clearfix">
		 <div style="position:absolute;padding-top:5px;padding-left:2px;" id="d_clip_container">
				<img width="32px" height="18px" src="#request.webroot#/images/icon_share_link-a6089e92716208c9626b3616059fbcf1.PNG" id="d_clip_button" alt="Icon_share_link" class=""> 
		  </div>
		  <input type="text" readonly="" style="padding-left:30px; width:167px;" value="#shorten.data.url#" onclick="true;javascript:this.select();" name="sharing_url" class="rounded inner-shadow" id="clip_text"> 
	  </div> 
	<script type="text/javascript" src="/assets/igg/projects/follow_link-d4ce5aef9fbe6a77b4cdfe5f13449a06.js"></script>
		<span class="fr add-to-favorites"> 
			 <cfif userid eq 0> 
				   <cfquery name="getFollowedD" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT * FROM followed_campaigns WHERE userip = '#userip#' and campaignid = #campaign_id#  
				   </cfquery> 
			 <cfelse>
				   <cfquery name="getFollowedD" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT * FROM followed_campaigns WHERE userid = #userid# and campaignid = #campaign_id#  
				   </cfquery> 
			 </cfif>
			 <cfif #getFollowedD.recordcount# gt 0>
				  <a class="unfollow" href="javascript: void(0);" style="color: ##FF0051; text-decoration: none;" onclick="javascript: followunfollow('yes', #userid#, '#URLEncodedFormat(userip)#', #campaign_id#, '#request.webroot#');"> 
					 <span id="flluntextID">#unfollowtext#</span>
				  </a> 
			 <cfelse>
				  <a class="follow" href="javascript: void(0);" style="color: ##FF0051; text-decoration: none;" onclick="javascript: followunfollow('no', #userid#, '#URLEncodedFormat(userip)#', #campaign_id#, '#request.webroot#');">
					 <span id="flluntextID">#followtext#</span>
				  </a>	  
			 </cfif>	  
		</span>
</div> 
<div class="fl social-networks" style="width: 217px;">
		  <div style="min-width: 83px;" class="fl">
			   <div class="fb-like" data-href="https://www.facebook.com/sherbrookois" data-layout="button_count" data-action="like" data-show-faces="true" data-share="false"></div>
		  </div>
		  <div class="fl" style="width: 83px;">
				 <a href="https://twitter.com/share" class="twitter-share-button" data-via="twitterapi" data-lang="en">Tweet</a> 
				 <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
		  </div>
		  <div class="fl" style="width: 50px;">
				  <script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
<g:plusone></g:plusone>
		  </div>		 
</div> 
<div class="fr tools">
	  <a class="fl embed white-button rounded" href="#request.webroot#/projects/createwidget/#campaignID#" oldtitle="Click to share on your website or blog" style="color: black; text-decoration: none;">
		#embedtext#</a> 
	  <a onclick="return true;" class="fl email white-button rounded" style="color: black; text-decoration: none;" href="mailto:roiipatterson@gmail.com?subject=#getCampaigns.TITLE#&amp;body=#Mid(TRIM(INTROTEXTData),1,400)#">#emailtext1#</a> 
</div>

</cfoutput>