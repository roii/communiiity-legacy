<cfoutput>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Points</strong></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="2" border="0"></td>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	<td width="120"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="2" border="0"></td>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">Total Points Earned:</td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"><strong>#TotalUserPointsIn#</strong></td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;"></td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">Avg. Points Per Month:</td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;" colspan="4"><strong>#ROUND(avgPointsMonth)#</strong></td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;"></td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	
	</table>


</td>
</tr>

</table><br>



</cfoutput>