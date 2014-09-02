<cfoutput>

<!--- GET ALL SUGGESTIONS --->
<cfquery name="AllIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM suggestion
</cfquery>	

<!--- GET UNAUTHORISED SUGGESTIONS --->
<cfquery name="AllUnAuthorisedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID, WhenSugMade, suggestion, SugStage, Archived
FROM suggestion
WHERE Authorise = 'no'
ORDER BY WhenSugMade DESC
</cfquery>	


<!--- GET AUTHORISED SUGGESTIONS --->
<cfquery name="AllAuthorisedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID, WhenSugMade, suggestion, SugStage
FROM suggestion
WHERE Authorise = 'yes'
AND Archived=0
ORDER BY WhenSugMade DESC
</cfquery>


<!--- GET DRAFT SUGGESTIONS --->
<cfquery name="DraftIdeas" dbtype="query">
SELECT SugID
FROM AllUnAuthorisedIdeas
WHERE SugStage='Draft'
</cfquery>


<!--- GET PENDING SUGGESTIONS --->
<cfquery name="PendingIdeas" dbtype="query">
SELECT SugID
FROM AllUnAuthorisedIdeas
WHERE SugStage LIKE '%Pending%'
AND Archived=0
</cfquery>


<cfquery name="Stage1Ideas" dbtype="query">
SELECT SugID
FROM AllAuthorisedIdeas
WHERE SugStage LIKE '%Stage 1%'
</cfquery>


<cfquery name="Stage2Ideas" dbtype="query">
SELECT SugID
FROM AllAuthorisedIdeas
WHERE SugStage LIKE '%Stage 2%'
</cfquery>

<cfquery name="Stage3Ideas" dbtype="query">
SELECT SugID
FROM AllAuthorisedIdeas
WHERE SugStage LIKE '%Stage 3%'
</cfquery>

<cfquery name="WinningIdeas" dbtype="query">
SELECT SugID
FROM AllAuthorisedIdeas
WHERE SugStage LIKE '%Stage 4%'
OR SugStage LIKE '%Stage 5%'
</cfquery>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Ideas</strong></td>
	<td align="right" valign="bottom"><!--- <img src="#request.imageroot#/SiteIcons/ideafunl_sml.jpg" alt="Feedback" border="0"> ---></td>
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
	
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Draft Ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DraftIdeas.RecordCount#</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Pending Ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#PendingIdeas.RecordCount#</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Stage 1 Ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#Stage1Ideas.RecordCount#</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Stage 2 Ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#Stage2Ideas.RecordCount#</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Stage 3 Ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#Stage3Ideas.RecordCount#</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Winning Ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#WinningIdeas.RecordCount#</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Total Ideas submitted:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllIdeas.RecordCount#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>	
	
	
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>