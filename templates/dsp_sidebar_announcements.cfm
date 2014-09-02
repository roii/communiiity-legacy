<cfoutput>

<cfquery name="AnnounceStuff" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT *
FROM Announcements
ORDER BY AnnouncementDate DESC
</cfquery>

<a name="announcements"> </a>
<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ###TRIM(AllSettings.BoxColour)#;">

<tr>
<td bgcolor="###TRIM(AllSettings.BoxColour)#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>SITE ANNOUNCEMENTS</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>

	
	<table width="150" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td colspan="2" style="font-size:11px;color:black;">#TRIM(AnnounceStuff.AnnoucementShort)#<br>
	<a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=100" style="color:###TRIM(AllSettings.BoxColour)#;">more announcements...</a></td>
	</tr>
	
	</table><br>


</td>
</tr>

</table>


</cfoutput>