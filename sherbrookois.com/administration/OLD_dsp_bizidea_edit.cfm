
 <cfoutput>

<cfinclude template="qry_bizidea.cfm">
		


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT BIZ IDEA</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	</tr>
	</table>
	
	<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<cfform name="AddGoal" action="#request.webroot#/administration/act_edit_bizidea.cfm" method="post">
			<input type="hidden" name="bizideaid" value="#attributes.bizideaid#">
			<tr>
			<td style="color:404040;">Biz Idea</td>
			<td>
			  <cfinput type="text" required="Yes" message="Please enter your Biz Idea" name="biz_idea" value="#Currentbizidea.biz_idea#" class="whitefield" style="width:250px; border-color:a0d8e0;">
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Biz Type</td>
			<td>
			<select name="bizideaTypeID" class="whitefield" size="1">
			<option value="0">Please select a type
			<cfloop query="bizideaType">
			  <cfif Currentbizidea.biz_ideaTypeID EQ bizideaType.bizideaTypeID>
			    <option value="#bizideaType.bizideatypeid#" selected>#bizideaType.biz_type#
			  <cfelse>
			    <option value="#bizideaType.bizideatypeid#">#bizideaType.biz_type#
			  </cfif>
			</cfloop>
			</select>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Minimum Age</td>
			<td>
			  <cfinput type="text" required="Yes" message="Please enter kids minimum age first" name="min_age" value="#Currentbizidea.min_age#" class="whitefield" style="width:250px; border-color:a0d8e0;">
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Biz Summary</td>
			<td>
			  <textarea rows="5" cols="30" name="biz_summary">#Currentbizidea.biz_summary#</textarea>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Details</td>
			<td>
	<cf_activedit name="details" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="645" height="520" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifycenter,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck,specialchars,subscript,superscript,replace" tabview="yes" DEFAULTFONT="8pt Verdana">#Currentbizidea.details#</cf_activedit>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Display</td>
			<td>
			  Yes <input type="Radio" name="show" value="1" <cfif Currentbizidea.show EQ '1'>checked</cfif>> No <input type="Radio" name="show" value="0" <cfif Currentbizidea.show EQ '0'>checked</cfif>>
			</td>
			</tr>
		
			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>			
			
			<tr>
			<td style="color:404040;"> </td>
			<td><input type="submit" class="whitefield" style="border-color:a0d8e0;" value="SAVE NOW!"></td>
			</tr>
			</cfform>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>

</cfoutput>