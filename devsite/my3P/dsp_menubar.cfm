<cfoutput>

<cfinclude template="qry_main_menu.cfm">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="100%" align="center" background="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#.gif" height="30" valign="middle">


	<table align="center" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="1"><img src="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_spc.gif" width="1" height="30" border="0"></td>


	<cfloop query="mainmenu">
	<td width="18" <cfif TRIM(mainmenu.fuseaction) EQ attributes.fuseaction>background="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_on.gif"</cfif>><img src="#request.imageroot#/transparent_spc.gif" width="18" height="30" border="0"></td>
	<td nowrap<cfif TRIM(mainmenu.fuseaction) EQ attributes.fuseaction> background="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_on.gif"</cfif>><a href="#request.webroot#/index.cfm?fuseaction=#TRIM(mainmenu.fuseaction)#" style="color:<cfif TRIM(mainmenu.fuseaction) EQ attributes.fuseaction>##000000<cfelse>##FFFFFF</cfif>;font-family:Trebuchet MS;font-size:12px;text-decoration:none;"><strong>#TRIM(mainmenu.menuTitle)#</strong></a></td>
	<td width="18"<cfif TRIM(mainmenu.fuseaction) EQ attributes.fuseaction> background="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_on.gif"</cfif>><img src="#request.imageroot#/transparent_spc.gif" width="18" height="30" border="0"></td>
	<td width="1"><img src="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_spc.gif" width="1" height="30" border="0"></td>
	</cfloop>
	</tr>
	
	</table>

</td>
</tr>




<cfinclude template="qry_linked_documents.cfm">

<tr>
<td width="100%" bgcolor="##EAEAEA" height="24" style="padding-left:10px;padding-right:10px;">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td align="center"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"><br><cfif AllDocuments.RecordCount AND fuseaction NEQ 'Profile' AND fuseaction NEQ 'benefits'>|&nbsp; </cfif><cfif fuseaction NEQ 'Profile' AND fuseaction NEQ 'benefits'><cfloop query="AllDocuments"><a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=docs&documentid=#AllDocuments.documentID#"  style="text-decoration:none; <cfif attributes.fusesubaction EQ 'docs' AND attributes.documentID EQ AllDocuments.DocumentID>background-color:##909090; padding-left:4px; padding-right:4px; color:white;<cfelse>color:###TRIM(AllSettings.SubMenuLinkColour)#;</cfif>">#TRIM(AllDocuments.Title)#</a> &nbsp;|&nbsp; </cfloop></cfif></td>
	</tr>
	
	</table>


</td>
</tr>

</table>

</cfoutput>