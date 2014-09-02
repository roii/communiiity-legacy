
<cfoutput>

<cfinclude template="qry_manageSugCategory.cfm">

<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">
	<tr>
	<td style="color:white;" width="230"><img src="images/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT CATEGORY</strong><img src="images/transparent_spc.gif" width="12" height="1"  border="0"></td>
	</tr>
</table>


<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0">
	<tr>
		<td>
			<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
				<tr>
					<td>
						<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
							<tr>
								<td width="140" height="1"><img src="images/transparent_spc.gif" width="140" height="1"  border="0"></td>
								<td></td>			
							</tr>
							<form name="frmEditSugCat" action="#request.webroot#/administration/act_sugCategoryEdit.cfm" method="post">
								<input type="hidden" name="categoryID" value="#categoryID#">
							<tr>
								<td style="color:404040;">Date</td>
								<td><input  name="date" type="text" size="25"  value="#CurrentCategory.date#" disabled >
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Name</td>
								<td><input name="name" type="text" size="25"  value="#CurrentCategory.Name#">
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Priority</td>
								<td>
									<select name="priority" size="1">
										<option value="1" <cfif CurrentCategory.priority EQ 1>selected</cfif>>1
										<option value="2" <cfif CurrentCategory.priority EQ 2>selected</cfif>>2
										<option value="3" <cfif CurrentCategory.priority EQ 3>selected</cfif>>3
										<option value="4" <cfif CurrentCategory.priority EQ 4>selected</cfif>>4
										<option value="5" <cfif CurrentCategory.priority EQ 5>selected</cfif>>5
									</select>
								</td>
							</tr>
							
							<tr>
								<td style="color:404040;">Description</td>
								<td><textarea rows="5" cols="25" name="description">#CurrentCategory.description#</textarea></td>
							</tr>
							<tr>
								<td style="color:404040;"> </td>
								<td><input type="submit" name="subSugCategoryEdit" value="SAVE NOW!" ></td>
							</tr>
							</form>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</cfoutput>