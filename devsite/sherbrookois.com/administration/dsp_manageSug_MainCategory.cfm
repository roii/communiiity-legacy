<cfoutput>

<cfquery name="qry_all_maincategories" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugMainCategory
ORDER BY Active DESC, DisplayOrder
</cfquery>

<script language="JavaScript">
<!--
function confirmCatDelete(aURL) {
    if(confirm('Are you sure you want to delete this Category?')) {
      location.href = aURL;
    }
  }
//-->
</script>

	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE IDEA CATEGORIES</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><a href="#request.webroot#/administration/dsp_IdeafunL_maincat_add.cfm" target="editsection" onclick="fdbackwindow=window.open ('','editsection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=600,height=350,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A CATEGORY &raquo;</strong></a>

	<hr width="100%" size="1" color="e2e2e2">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>	
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
	</tr>
	
	
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><b>Order</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><b>Name</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Active</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="qry_all_maincategories">
	
	<cfset this_categoryID = qry_all_maincategories.MainCatID>
	
	<cfquery name="AllCat_ActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID
	FROM Suggestion
	WHERE CategoryID=#this_categoryID#
	AND Authorise LIKE '%Yes%'
	GROUP BY SugID
	</cfquery>
	
	<tr>
	<td style="font-size:11px;" valign="top">#DecimalFormat(qry_all_maincategories.DisplayOrder)#</td>
	<td style="font-size:11px;" valign="top"><strong>#TRIM(qry_all_maincategories.MainCatTitle)#</strong><br>
	#TRIM(qry_all_maincategories.Description)#</td>
	<td style="font-size:11px;" valign="top" align="center">#YesNoFormat(qry_all_maincategories.Active)#</td>
	<td align="right" style="font-size:11px;" valign="top"><a href="#request.webroot#/administration/dsp_IdeafunL_maincat_edit.cfm?MainCatID=#this_CategoryID#" target="editcat" onclick="fdbackwindow=window.open ('','editcat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=600,height=350,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Category" border="0"></a>&nbsp;<a href="javascript:confirmCatDelete('#request.webroot#/administration/act_delete_maincat.cfm?MainCatID=#this_categoryID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Category" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>	
	
	
	</table>


</td>
</tr>

</table>

</cfoutput>