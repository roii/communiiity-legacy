<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:##ffffff;font-size:12px;" align="center" height="20"><strong>#UCASE(TRIM(SectionDetails.Title))#</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td background="#request.imageroot#/sidebar_boxL_bg.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	
	
	<table width="207" cellpadding="0" cellspacing="0" border="0" align="center">


<cfif attributes.fusesubaction EQ 'docs'>
	
	<tr>
	<td colspan="2"><strong>#UCASE(DocumentDetails.Title)#</strong></td>
	</tr>
	
	<tr>
	<td width="20">-</td>
	<td>Article Title</td>
	</tr>

<cfelseif attributes.fusesubaction EQ 'article'>	
	
	
</cfif>
	
	</table><br>


</td>
</tr>

</table><br>


</cfoutput>