<cfoutput>

<cfquery name="SectionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Sections
WHERE sectionID = #sectionID#
</cfquery>

<cfquery name="AllContactTypes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ContactTypes
ORDER BY ContactTypeID
</cfquery>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Edit Section</title>
<script src="/administration/ckeditor.js"></script>
<script src="/administration/sample.js"></script>
<cfparam name="URL.fuseaction" default="administration">
<cfparam name="URL.fusesubaction" default="">
<cfparam name="URL.secti" default="">
<link href="/administration/sample.css" rel="stylesheet"> 	
<cfinclude template="../templates/styles.cfm">
	
<script language="JavaScript">
<!--

function validateFun(editsection) { 
  if (editsection.FrenchTitle.value == "") {
	alert("You must enter a Page French Title for this section.");
	editsection.FrenchTitle.focus();
	return false;
	}
	
else if (editsection.MenuFrenchTitle.value == "") {
	alert("You must enter a Menu French Title for this section.");
	editsection.MenuFrenchTitle.focus();
	return false;
	} 
	
else if (editsection.EnglishTitle.value == "") {
	alert("You must enter a Page English Title for this section.");
	editsection.EnglishTitle.focus();
	return false;
	}
	
else if (editsection.MenuEnglishTitle.value == "") {
	alert("You must enter a Menu English Title for this section.");
	editsection.MenuEnglishTitle.focus();
	return false;
	}
			
	else {  
		//ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
		editsection.submit(); //submit form
		}
}

function validate(editsection) {  

		
if (editsection.FrenchTitle.value == "") {
	alert("You must enter a Page French Title for this section.");
	editsection.FrenchTitle.focus();
	return false;
	}
	
else if (editsection.MenuFrenchTitle.value == "") {
	alert("You must enter a Menu French Title for this section.");
	editsection.MenuFrenchTitle.focus();
	return false;
	}
	
else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	editsection.submit(); //submit form
	}
}
// -->

</script>	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Section Details</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<form method="post" action="#request.webroot#/admin/act_section_edit.cfm" name="editsection" onSubmit="return validateFun(this);">
	<input type="hidden" name="SectionID" value="#sectionID#">
	
	<cfif IsDefined("fuseaction")>
		<input type="hidden" name="fuseaction" value="#fuseaction#">
	<cfelse>
		<input type="hidden" name="fuseaction" value="administration">
	</cfif>
	
	<cfif IsDefined("fusesubaction")>
		<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<cfelse>
		<input type="hidden" name="fusesubaction" value="sections">	
	</cfif>
	
		
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120">Page French Title</td>
	<td><input type="text" name="FrenchTitle" style="width:600px;font-size:10px;font-family:Arial;" value="#TRIM(SectionStuff.FrenchTitle)#" class="whitefield"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120">Menu French Title</td>
	<td><input type="text" name="MenuFrenchTitle" style="width:600px;font-size:10px;font-family:Arial;" value="#TRIM(SectionStuff.MenuFrenchTitle)#" class="whitefield"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120">Page English Title</td>
	<td><input type="text" name="EnglishTitle" style="width:600px;font-size:10px;font-family:Arial;" value="#TRIM(SectionStuff.EnglishTitle)#" class="whitefield"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120">Menu English Title</td>
	<td><input type="text" name="MenuEnglishTitle" style="width:600px;font-size:10px;font-family:Arial;" value="#TRIM(SectionStuff.MenuEnglishTitle)#" class="whitefield"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Display on Main Menu?</td>
	<td><input type="radio" Class="whitefield" name="MainMenu" value="1"<cfif SectionStuff.MainMenu EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="MainMenu" value="0"<cfif SectionStuff.MainMenu EQ 0> checked</cfif>> No</td>
	</tr>
			
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Top sub-menu?</td>
	<td><input type="radio" Class="whitefield" name="TopMenu" value="1"<cfif SectionStuff.TopMenu EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="TopMenu" value="0"<cfif SectionStuff.TopMenu EQ 0> checked</cfif>> No</td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Bottom sub-menu?</td>
	<td><input type="radio" Class="whitefield" name="BottomMenu" value="1"<cfif SectionStuff.BottomMenu EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;<input type="radio" Class="whitefield" name="BottomMenu" value="0"<cfif SectionStuff.BottomMenu EQ 0> checked</cfif>> No</td>
	</tr>	
			
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Menu Display Order</td>
	<td><input type="text" class="whitefield" size="10" name="MainMenuOrder" value="#SectionStuff.MainMenuOrder#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
			
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td valign="top">Details</td>
	<td>
	<!---<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="600" height="450" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="yes" DEFAULTFONT="10pt Arial">#TRIM(SectionStuff.details)#</cf_activedit>--->
	     <p> 
			<textarea cols="80" id="details" name="details" rows="10">#TRIM(SectionStuff.details)#</textarea>
			<script> 
				 CKEDITOR.replace( 'details', {
					extraPlugins: 'magicline',	// Ensure that magicline plugin, which is required for this sample, is loaded.
					allowedContent: true		// Switch off the ACF, so very complex content created to
												// show magicline's power isn't filtered.
				} ); 
			</script>
		 </p>
	<!---<cf_fckeditor name="details" value="#TRIM(SectionStuff.details)#" width="650" height="450" toolbarset="Default">--->
	
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>		

<cfif SectionStuff.fuseaction CONTAINS 'Homepage'>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td valign="top">Homepage Content</td>
	<td><!---<cf_activedit name="HomepageContent" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="600" height="450" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,font,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="yes" DEFAULTFONT="10pt Arial">#TRIM(SectionStuff.HomepageContent)#</cf_activedit>--->
	
	<cf_fckeditor name="HomepageContent" value="#TRIM(SectionStuff.HomepageContent)#" width="650" height="450" toolbarset="Default">
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
</cfif>	

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Allow to View</td>
	<td Class="normal" valign="top"><input type="checkbox" class="whitefield" name="AdminView" value="1"<cfif SectionStuff.AdminView CONTAINS 1> checked</cfif>> Administrators<br>
	
	<input type="checkbox" class="whitefield" name="PublicView" value="1"<cfif SectionStuff.PublicView CONTAINS 1> checked</cfif>> Public<br>

	<cfloop query="AllContactTypes">
	
	<input type="checkbox" Class="whitefield" name="ContactTypeView" value="#AllContactTypes.ContactTypeID#"<cfif ListFind(SectionStuff.ContactTypeView, AllContactTypes.ContactTypeID)> checked</cfif>> #TRIM(AllContactTypes.ContactType)#<br>
	
	</cfloop>
	
	</td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120">Meta Title</td>
	<td><input type="text" name="PageTitle" style="width:600px;font-size:10px;font-family:Arial;" value="#TRIM(SectionStuff.PageTitle)#" class="whitefield"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120" valign="top">Meta Description</td>
	<td><textarea name="MetaContent" style="width:600px;font-size:10px;font-family:Arial;" class="whitefield" rows="4">#TRIM(SectionStuff.MetaContent)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="120" valign="top">Meta Keywords<br>
	<em>Comma-delimited</em></td>
	<td><textarea name="MetaKeywords" style="width:600px;font-size:10px;font-family:Arial;" class="whitefield" rows="4">#TRIM(SectionStuff.MetaKeywords)#</textarea></td>
	</tr>
	
	<input type="hidden" name="DHTML_POS" value="#SectionStuff.DHTML_POS#">
	<input type="hidden" name="DHTML_POS_LOGIN" value="#SectionStuff.DHTML_POS_LOGIN#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<!---<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Menu Pos. (not logged in)</td>
	<td><input type="text" class="whitefield" size="10" name="DHTML_POS" value="#SectionStuff.DHTML_POS#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Menu Pos. (logged in)</td>
	<td><input type="text" class="whitefield" size="10" name="DHTML_POS_LOGIN" value="#SectionStuff.DHTML_POS_LOGIN#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>--->	
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td> <!---onClick="javascript:ae_onSubmit(); validate(editsection); return false;"--->
	<td><input type="submit" style="font-size:10px;font-family:Arial;" value="UPDATE NOW >>>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
			
	</table>
			
		
	</form>
		
		
		
		
</td>
</tr>

</table>

</body>
</html>
	
</cfoutput>

