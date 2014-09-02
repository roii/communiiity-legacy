<cfoutput>

<cfinclude template="qry_bizidea.cfm">

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Edit Business</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Business</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<cfform method="post" action="#request.webroot#/administration/act_edit_bizidea.cfm" name="addform" enctype="multipart/form-data">

	<input type="hidden" name="bizideaid" value="#attributes.bizideaid#">
	<input type="hidden" name="fuseaction" value="#attributes.fuseaction#">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Idea</td>
	<td class="normal" valign="top"><cfinput type="text" required="Yes" message="Please enter your Biz Idea" name="biz_idea" value="#TRIM(Currentbizidea.biz_idea)#" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Type</td>
	<td class="normal" valign="top"><select name="bizideaTypeID" class="whitefield" style="width:300px;">
	<option value="0">Please select a type
	<cfloop query="bizideaType">
	<option value="#bizideaType.bizideatypeid#"<cfif Currentbizidea.biz_ideaTypeID EQ bizideaType.bizideaTypeID> selected</cfif>>#TRIM(bizideaType.biz_type)#	
	</cfloop>
	</select></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Minimum Age</td>
	<td class="normal" valign="top"><cfinput type="text" required="Yes" message="Please enter kids minimum age first" name="min_age" value="#Currentbizidea.min_age#" class="whitefield" style="width:300px;"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Short Summary</td>
	<td class="normal" valign="top"><textarea rows="5" style="width:300px;font-family:Arial;font-size:11px;" name="biz_summary">#TRIM(Currentbizidea.biz_summary)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Thumbnail Image</td>
	<td class="normal" valign="top"><input type="file" style="width:300px;font-family:Arial;font-size:11px;" name="lowres_image"><br>NOTE: Resizes to 80px(w) x 60px(h) when creating the thumbnail.<br>
	To avoid bad results please size originals to match scale (&frac34;)<br>
	i.e. 200px(w) x 150px(h)... 400px(w) x 300px(h)
	
	<cfif fileExists("#request.fileroot#\images\business\#TRIM(Currentbizidea.image_lowres)#")>
	<br><br>	
	CURRENT IMAGE<br>
	<img src="#request.imageroot#/business/#TRIM(Currentbizidea.image_lowres)#" width="80" height="60">
	
	</cfif></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr><!--- 
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Hi-res Image<br>(300 x 300 @ 300dpi)</td>
	<td class="normal" valign="top"><input type="file" style="width:300px;font-family:Arial;font-size:11px;" name="hires_image"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr> --->
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Display Order</td>
	<td Class="normal" valign="top"><input type="text" style="width:300px;font-family:Arial;font-size:11px;" name="bizOrder" value="#Currentbizidea.bizOrder#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Display</td>
	<td Class="normal" valign="top"><input type="Radio" name="show" value="1" <cfif Currentbizidea.show EQ '1'>checked</cfif>> Yes &nbsp; <input type="Radio" name="show" value="0" <cfif Currentbizidea.show EQ '0'>checked</cfif>> No</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Details</td>
	<td Class="normal" valign="top">
		<textarea name="details" rows="25" cols="40">#TRIM(Currentbizidea.details)#</textarea>
		<!--- <cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="500" height="400" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="yes" DEFAULTFONT="8pt Verdana">#TRIM(Currentbizidea.details)#</cf_activedit> ---></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" value="UPDATE BUSINESS NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</cfform>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>