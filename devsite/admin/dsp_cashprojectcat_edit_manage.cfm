<cffunction name="getTranslated" output="true" returntype="any">
    <cfargument name="qStr" type="string" default="" required="yes">
    <cfargument name="langpair" type="string" default="" required="yes">
	
	<cfhttp method="Post" url="http://api.mymemory.translated.net/get">  
		<cfhttpparam type="URL" value="#arguments.qStr#" name="q">
		<cfhttpparam type="url" value="#arguments.langpair#" name="langpair"> 
	</cfhttp>
	
	<cfset theData = #cfhttp.filecontent#>  
	<cfset cfData = DeserializeJSON(theData)> 

   <cfreturn #cfData.responseData.translatedText#>
</cffunction>

<cfoutput>

<cfquery name="qry_groups" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GroupID, GroupName
FROM ProjectGroups
ORDER BY GroupID
</cfquery>


<cfquery name="catDetails" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT *
FROM ProjectCategories
WHERE ProjectCategoryID=#ProjectCategoryID#
</cfquery>



<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head> 
	<title>#TRIM(AllSettings.SiteName)# - Edit Cash Project Category </title>
<cfinclude template="../templates/styles.cfm">
	
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Cash Project Category</strong></span></td>
</tr>



<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
	
	<form method="post" action="act_cashprojectcat_edit_manage.cfm">
	<input type="hidden" name="ProjectCategoryID" value="#ProjectCategoryID#">
	<input type="hidden" name="DocumentID" value="5">
		
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Project Group</td>
	<td class="normal" valign="top">
	         <cfset ctr = 1> 
			 <select name="GroupID" class="whitefield" style="width:300px;">
			     <cfloop query="qry_groups">
				     <cfif ctr lte 1>
				        <option value="#TRIM(qry_groups.GroupID)#"<cfif catdetails.GroupID EQ qry_groups.GroupID> selected</cfif>>#TRIM(qry_groups.GroupName)#</option>
				     </cfif>
					<cfset ctr = ctr + 1> 
				 </cfloop>
			 </select>
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Category Name</td>
	<td class="normal" valign="top"><input name="Title" class="whitefield" style="width:300px;" value="#TRIM(catdetails.title)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Display Order</td>
	<td class="normal" valign="top"><input name="displayorder" class="whitefield" style="width:300px;" value="#TRIM(catdetails.displayorder)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Active</td>
	<td class="normal" valign="top"><input type="radio" name="active" <cfif catdetails.active EQ 1>checked</cfif> value="1">Yes <input type="radio" <cfif catdetails.active NEQ 1>checked</cfif> name="active" value="0">No</td>
	</tr>

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="UPDATE NOW >>>"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	
	</table>
	</form>
		
		
		
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


