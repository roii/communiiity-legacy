<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Things To Do Today</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/Todo_sml.jpg" alt="Points" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	
	
	
	
	<cfif TRIM(MemberDetails.ScreenName) EQ ''>
			
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=41" style="color:###TRIM(AllSettings.BoxColour)#;">Choose your unique Screen-Name</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn 5 points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
	</cfif>
	
	
	
	
	
	<cfif MemberDetails.RegionID EQ 0 OR MemberDetails.RegionID EQ 0 OR MemberDetails.RegionID EQ 0>
	
		
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=41" style="color:###TRIM(AllSettings.BoxColour)#;">Tell us what region, city, suburb you live in</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn 3 points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
	
	</cfif>
	
	<cfif MemberDetails.SchoolID EQ 0 OR MemberDetails.SchoolID EQ ''>
	
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=41" style="color:###TRIM(AllSettings.BoxColour)#;">Select your school</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn 3 points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
	
	</cfif>
	
	<cfif MemberDetails.mobilePhone EQ ''>
	
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=41" style="color:###TRIM(AllSettings.BoxColour)#;">What's your mobile number</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn 50 points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
	
	</cfif>
	
	<cfif MemberDetails.VideoTestimonial EQ 0>
	
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/act_video_testimonial.cfm" style="color:###TRIM(AllSettings.BoxColour)#;">Be in our Promo Video</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn up to 2100 points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
	
	</cfif>
	
	<cfif MemberDetails.Charity EQ 0 OR MemberDetails.Charity EQ ''>
	
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=41" style="color:###TRIM(AllSettings.BoxColour)#;">Select your favorite charity</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn 3 points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
	</cfif>
	
	
	<cfif TRIM(MemberDetails.PrintBizCards) EQ 0>
			
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=95&resource_mode=create_cards" style="color:###TRIM(AllSettings.BoxColour)#;">Print your own business cards</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn 50 points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
	</cfif>
	
	
	<cfif NoIdeas EQ 1>
	
		
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75" style="color:###TRIM(AllSettings.BoxColour)#;">Add your first idea &amp; start getting feedback from the community</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn up to 18 points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
	</cfif>	
	
	
	<cfif AllGoals.RecordCount EQ 0>
			
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentID=43" style="color:###TRIM(AllSettings.BoxColour)#;">Add your first goal</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn 1 point</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
	</cfif>
	
	
	
	
	<cfif Allbizideas.RecordCount NEQ BizTemplates_Rated>
	
		<cfset totaltorate = (Allbizideas.RecordCount-BizTemplates_Rated)>
		
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentID=48" style="color:###TRIM(AllSettings.BoxColour)#;">Rate and give feedback on Business Templates</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn up to #totaltorate# points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
	</cfif>
	
	
	
	
	
	<cfif tovoteontotal GT 0>
	
		<cfset tovoteontotal = (tovoteontotal*2)>
		
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75" style="color:###TRIM(AllSettings.BoxColour)#;">Vote and give feedback in the IDEAfunL</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn up to #tovoteontotal# points</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
	</cfif>

	<cfif InviteSendToday EQ 0>
	
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=contacts" style="color:###TRIM(AllSettings.BoxColour)#;">Invite a friend to join #TRIM(AllSettings.SiteName)#</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn up to 3000 points when they join</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
	
	</cfif>
	
	<cfif goalupdatedtoday EQ 0>
	
		<tr>
		<td style="font-size:11px;padding-left:5px;"><strong><span style="font-family:WebDings;color:###TRIM(AllSettings.BoxColour)#;">4</span>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentID=38" style="color:###TRIM(AllSettings.BoxColour)#;">Review and update your goals</a></strong></td>
		<td style="font-size:11px;padding-right:5px;" width="200">earn at least 1 point</td>
		</tr>
	
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
	
	</cfif>
	
	</table><br>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table><br>


</cfoutput>