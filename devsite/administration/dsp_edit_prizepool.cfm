<cfquery name="CurrentPrizepool" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool
WHERE PrizePoolID=#PrizePoolID#
</cfquery>
<cfquery name="getCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM campaigns
ORDER BY CampaignsID ASC
</cfquery>
<cfinclude template="../templates/qry_all_countries.cfm">

<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Edit Prize</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Prize</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
		
	<script language="JavaScript">
	<!--
	function validate(editPrize) {    
	
	if (editPrize.name.value == "") {
		alert("You must enter a Name for this prize.");
		editPrize.name.focus();
		return;
		} 
	else if (editPrize.related_campaign.value == "") {
		alert("You must select the Campaign for this prize.");
		editPrize.related_campaign.focus();
		return;
		}	
	else {
		editPrize.submit(); //submit form
		}
	}
	// -->
	</script>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="editPrize" action="#request.webroot#/administration/act_edit_prizepool.cfm" method="post" enctype="multipart/form-data">

	<input type="hidden" name="prizepoolid" value="#attributes.prizepoolid#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Prize Name</td>
	<td><input type="text" value="#TRIM(CurrentPrizepool.name)#" name="name" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Related Campaign</td>
	<td><select name="related_campaign" id="related_campaign" style="width:300px;">
		    <option value="">Select Campaign</option>
		    <cfloop query="getCampaigns">
		        <option value="#getCampaigns.CampaignsID#">#getCampaigns.Title#</option>
			</cfloop>
		</select> 
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Prize Description</td>
	<td><textarea rows="5" style="width:300px;" class="whitefield" name="description">#TRIM(CurrentPrizepool.description)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Country</td>
	<td><select name="countryID" class="whitefield" style="width:300px;">
	<option value="0"<cfif INT(CurrentPrizepool.Country) EQ 0> selected</cfif>>--- ALL Countries ---
	<cfloop query="allCountries">
	<option value="#allcountries.countryID#"<cfif INT(CurrentPrizepool.Country) EQ allcountries.countryID> selected</cfif>>#TRIM(allcountries.name)#
	</cfloop>
	</select></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Start Date (dd/mm/yyyy)</td>
	<td><input type="text" name="Start_Date" value="#dateformat(CurrentPrizepool.start_date,'dd/mm/yyyy')#" class="whitefield" style="width:265px;"><a href="javascript:void(0)" onClick="if(self.gfPop)gfPop.fPopCalendar(document.editPrize.Start_Date);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Draw Date (dd/mm/yyyy)</td>
	<td><input type="text" name="Draw_Date" value="#dateformat(CurrentPrizepool.draw_date,'dd/mm/yyyy')#" class="whitefield" style="width:265px;"><a href="javascript:void(0)" onClick="if(self.gfPop)gfPop.fPopCalendar(document.editPrize.Draw_Date);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Points Value</td>
	<td><input type="text" name="pointsvalue" value="#INT(CurrentPrizepool.pointsvalue)#" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110" valign="top">Prize Image</td>
	<td class="normal" style="color:##444444;"><input type="file" name="PrizeImage" class="whitefield" style="width:300px;"><br>NOTE: Resizes to 80px(w) x 60px(h) when creating the thumbnail.<br>
	To avoid bad results please size originals to match scale (&frac34;)<br>
	i.e. 200px(w) x 150px(h)... 400px(w) x 300px(h)
	<cfif CurrentPrizepool.image neq ''>
	<br><br>
	<em>Current Image:</em><br>
	<img src="#request.webroot#/images/prize/#TRIM(CurrentPrizepool.image)#" width="80" height="60">
	</cfif></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Display Order</td>
	<td><input type="text" Class="whitefield" size="15" name="DisplayOrder" value="#CurrentPrizepool.DisplayOrder#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Invite Friend Prize</td>
	<td Class="normal" valign="top"><input type="radio" class="small" name="InviteFriend" value="0"<cfif CurrentPrizepool.InviteFriend EQ 0 OR CurrentPrizepool.InviteFriend EQ ''> checked</cfif>> No &nbsp; <input type="radio" class="small" name="InviteFriend" value="1"<cfif CurrentPrizepool.InviteFriend EQ 1> checked</cfif>> Yes</td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" onClick="javascript:validate(editPrize); return false;" value="UPDATE PRIZE NOW >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table>


	
</td>
</tr>

</table>

</body>
</html>




<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/administration/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>
</cfoutput>