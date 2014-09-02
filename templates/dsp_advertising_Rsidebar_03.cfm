<cfoutput>

<cfquery name="Advert_Rsidebar03" dbtype="query">
SELECT *
FROM SectionAdvertising
WHERE AdvertPosition = 'Rside_03'
</cfquery>


<cfif Advert_Rsidebar03.RecordCount>
<tr>
<td align="center">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td align="center"><img src="#request.imageroot#/advertising/#TRIM(Advert_Rsidebar03.AdvertFile)#" alt="#TRIM(Advert_Rsidebar03.AdvertMouseover)#" border="0"></td>
	</tr>
	
	</table>
	
</td>
</tr>
</cfif>

</cfoutput>