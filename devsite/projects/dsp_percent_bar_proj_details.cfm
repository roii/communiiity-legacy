<cfoutput>


<table cellpadding="0" cellspacing="0" border="0" width="100%">
	
<tr>
<td>

	<table cellpadding="0" cellspacing="0" border="0" width="302">
	
	<tr>
	<td width="1" height="3" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	<td width="149"><img src="#request.imageroot#/transparent_spc.gif" width="149" height="3" border="0"></td>
	<td width="1" height="3" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	<td width="150"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="3" border="0"></td>
	<td width="1" height="3" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" height="1" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" height="10" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
	<td colspan="3">
	
		<cfset bar_percentdone = (this_percentDone * 3)>
		
		<table width="300" height="10" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td width="#INT(bar_percentdone)#" background="#request.imageroot#/goals/bar_orange_bg.gif"><img src="#request.imageroot#/transparent_spc.gif" width="#INT(bar_percentdone)#" height="10" border="0"></td>		
		<td width="#INT(300 - bar_percentdone)#" background="#request.imageroot#/goals/bar_gray_bg.gif"><img src="#request.imageroot#/transparent_spc.gif" width="#INT(300 - bar_percentdone)#" height="10" border="0"></td>		
		</tr>
		
		</table>
	
	
	</td>
	<td width="1" height="10" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
	</tr>
	
	
	<tr>
	<td colspan="5" height="1" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" height="3" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	<td width="149"><img src="#request.imageroot#/transparent_spc.gif" width="149" height="3" border="0"></td>
	<td width="1" height="3" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	<td width="150"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="3" border="0"></td>
	<td width="1" height="3" bgcolor="8c8c8c"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" align="center" style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><strong>#INT(this_percentDone)#%</strong> done</td>
	</tr>
	
	</table>

</td>
</tr>

</table>


</cfoutput>