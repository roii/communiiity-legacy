<cfoutput>

<br><br>
<table cellpadding="0" cellspacing="0" border="0">

<tr>
<td><img src="#request.imageroot#/icons/moderator_comments.gif" width="29" height="24" border="0"></td>
<td style="font-size:12px;color:Blue;"><strong>Moderator Comments</strong></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</table>



<table width="100%" cellpadding="4" cellspacing="0" style="border:dashed 1px ##b4b4b4;">

<tr>
<td colspan="3">		
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="padding-left:10px;" width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="5" border="0"></td>
	<td width="130" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="5" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="5" border="0"></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;font-size:11px;color:##444444;"><strong>When</strong></td>
	<td style="font-size:11px;color:##444444;"><strong>Who</strong></td>
	<td style="font-size:11px;color:##444444;"><strong>Comments</strong></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="qry_sug_comments">
	<cfset this_moderator = qry_sug_comments.ScreenName>
	<cfset this_date = qry_sug_comments.CommentDate>
	<cfset this_comment = qry_sug_comments.Comment>
	<cfset this_public = qry_sug_comments.PublicView>
	
	<tr>
	<td style="font-size:11px;padding-left:10px;" valign="top" title="#TimeFormat(this_date, 'HH:MM TT')#">#DateFormat(this_date, "d-mmm-yyyy")#</td>
	<td style="font-size:11px;" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#this_moderator#"><img src="#request.imageroot#/icons/people_tiny_grey.gif" width="15" height="12" border="0" align="absmiddle" title="Moderator: #this_moderator#"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(this_moderator)#" style="color:###TRIM(Allsettings.BoxColour)#;" title="View Profile"><strong>#TRIM(this_moderator)#</strong></a></td>
	<td style="font-size:11px;padding-right:10px;" valign="top"><cfif this_public EQ 0>[comment for author only] - </cfif>#TRIM(this_comment)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>				
	
	</cfloop>				
	
	</table>
	

</td>
</tr>

</table>

</cfoutput>