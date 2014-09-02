<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ###AllSettings.BoxColour#;">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>my Profile</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
		
	<table width="160" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td colspan="3" align="center" style="color:Black;"><strong>Hi #UCASE(session.User_FirstName)#!</strong><br>
	<span style="font-size:11px;">If you are not #session.User_FirstName#...<br><a href="#request.webroot#/act_logout.cfm" style="color:black;">CLICK HERE</a></span></td>
	</tr>
	
	<tr>
	<td colspan="3" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"><hr width="100%" size="1" color="###AllSettings.BoxColour#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>
	
	<cfif session.permission1_view EQ 1 OR session.permission40_view EQ 1>
		<tr>
		<td width="15" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td colspan="2" width="150" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentid=92" style="color:Black;">myDashboard</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission64_view EQ 1>
		<tr>
		<td width="15" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td colspan="2" width="150" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#session.UserID#" style="color:Black;">myPersonal Profile</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission86_view EQ 1>
		<tr>
		<td width="15" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="150" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=83" style="color:Black;">myPoints</a> <span style="color:black"><b>(<cfif user_points GT 10000>#NumberFormat(user_points, "00,000")#<cfelseif user_points GT 1000>#NumberFormat(user_points, "0,000")#<cfelse>#user_points#</cfif>)</b></span></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_add EQ 1 OR session.permission85_view EQ 1>
		<tr>
		<td width="15" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="150" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=112" style="color:Black;">Purchase Points</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_add EQ 1 OR session.permission102_view EQ 1>
		<tr>
		<td colspan="3" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"><br>	
		<a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=95&resource_mode=create_cards" style="color:Black;"><img src="#request.imageroot#/businesscard_button.gif" width="153" height="38" alt="" border="0"></a></td>
		</tr>
	</cfif>
    
    <tr>
    <td colspan="3" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
    </tr>
	
	</table>

</td>
</tr>

</table>

</cfoutput>