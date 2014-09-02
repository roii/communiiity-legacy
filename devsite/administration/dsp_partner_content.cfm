<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<form name="PartnerContent" action="#request.webroot#/administration/act_edit_partner_content.cfm" method="post">

<input type="hidden" name="organisationID" value="#OrganisationID#">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110" valign="top">Profile Content</td>
<td>
	<textarea name="profilecontent" rows="25" cols="40">#TRIM(PartnerStuff.ProfileContent)#</textarea>
	<!--- <cf_activedit name="profilecontent" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="500" height="520" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="yes" DEFAULTFONT="8pt Verdana">#TRIM(PartnerStuff.ProfileContent)#</cf_activedit> --->
</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td> </td>
<td><input type="submit" value="UPDATE CONTENT NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:location='#request.webroot#/administration/dsp_edit_Partner_popup.cfm?organisationID=#OrganisationID#';" value="CANCEL >>" class="whitefield"></td>
</tr>

</form>

</table><br><br>



</cfoutput>