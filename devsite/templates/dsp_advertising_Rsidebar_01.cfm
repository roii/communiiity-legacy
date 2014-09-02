<cfoutput>

<cfquery name="Advert_Rsidebar01" dbtype="query">
SELECT *
FROM SectionAdvertising
WHERE AdvertPosition='Rside_01'
</cfquery>


<cfif Advert_Rsidebar01.RecordCount>
<tr>
<td align="center">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td align="center"><img src="#request.imageroot#/advertising/#TRIM(Advert_Rsidebar01.AdvertFile)#" alt="#TRIM(Advert_Rsidebar01.AdvertMouseover)#" border="0"></td>
	</tr>
	
	</table>
	
</td>
</tr>
</cfif>

</cfoutput>