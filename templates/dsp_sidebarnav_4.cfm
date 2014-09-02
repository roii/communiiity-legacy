<cfoutput>


<!--- IF 3 --->
<cfif AllLevel4Articles.recordcount>		

<tr>
<td colspan="2">
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<!--- LOOP 4 --->
	<cfloop query="AllLevel4Articles">

	<cfset this_Level4articleID=AllLevel4Articles.Level4articleID>

	<cfif IsDefined("attributes.Level4articleID") AND attributes.Level4articleID EQ this_Level4articleID>
		<cfset this_L4ArtTextColor = SectionDetails.MenuBarColor>
		<cfset this_L4Artimage = 'sml_nav_arrow.gif'>
		<cfset this_L4ArtTextdecoration = "none">
	<cfelse>
		<cfset this_L4ArtTextColor = "444444">
		<cfset this_L4Artimage = 'transparent_spc.gif'>
		<cfset this_L4ArtTextdecoration = "none">
	</cfif>
	
	
	<tr>
	<td valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="32" height="1" border="0"></td>
	<td nowrap style="font-size:11px;" width="100%" valign="top"><span style="font-family:WebDings;color:###TRIM(this_L4ArtTextColor)#;text-decoration:#this_L4ArtTextdecoration#;">4</span>&nbsp;<cfif TRIM(AllLevel4Articles.LinkType) EQ 'HTML'><a href="#request.webroot#/index.cfm/fuseaction/#fuseaction#/fusesubaction/level4/documentID/#this_docID#/articleID/#this_articleID#/subarticleID/#this_subarticleID#/Level4ArticleID/#this_Level4articleID#" style="color:###TRIM(this_L4ArtTextColor)#;text-decoration:#this_L4ArtTextdecoration#;"><cfelseif TRIM(AllLevel4Articles.LinkType) EQ 'URL'><a href="#AllLevel4Articles.URLLink#"<cfif TRIM(AllLevel4Articles.LinkAction) EQ 'Blank'> target="_Blank"</cfif> style="color:###TRIM(this_L4ArtTextColor)#;text-decoration:#this_L4ArtTextdecoration#;"><cfelseif TRIM(AllLevel4Articles.LinkType) EQ 'File'><a href="#request.webroot#/download/files/#AllLevel4Articles.Filename#" target="_Blank" style="color:###TRIM(this_L4ArtTextColor)#;text-decoration:#this_L4ArtTextdecoration#;"><cfelseif TRIM(AllLevel4Articles.LinkType) EQ 'Library'><a href="#request.webroot#/#TRIM(AllLevel4Articles.FileLocation)#/#TRIM(AllLevel4Articles.Filename)#" target="_Blank" style="color:###TRIM(this_L4ArtTextColor)#;text-decoration:#this_L4ArtTextdecoration#;"></cfif>#TRIM(AllLevel4Articles.Level4ArticleTitle)#</a></td>
	</tr>
	
	
	</cfloop>
	<!--- LOOP 4 --->
	
	<tr>
	<td height="8"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
	</tr>

	</table>


</td>
</tr>

</cfif>
<!--- IF 3 --->

</cfoutput>