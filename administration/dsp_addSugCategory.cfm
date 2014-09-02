<script language="JavaScript">
function Validate(frm){
	
	if(frm.name.value.length == 0 || frm.name.value ==null){
		alert('Must give a name.');
		frm.name.focus();
		return false;
	}else if(frm.priority.value ==0){
		alert('Please select a category');
		frm.priority.focus();
		return false;
	}
	return true;
}

</script>


<cfoutput>

<cfinclude  template="qry_manageSugCategory.cfm">

<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">
	<tr>
	<td style="color:white;" width="230"><img src="images/transparent_spc.gif" width="12" height="1"  border="0"><strong>ADD CATEGORY</strong><img src="images/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
								
                  				<td width="140" height="1"><img src="images/transparent_spc.gif" width="140" height="8"  border="0"></td>
								<td></td>			
							</tr>
							<form name="frmAddSugCat" action="#request.webroot#/administration/act_addSugCategory.cfm" method="post" onSubmit="return Validate(this)">
							<tr>
								<td style="color:404040;">Name</td>
								<td><input name="name" type="text" size="25">
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Priority</td>
								<td>
								
									<select name="priority" size="1">
									<option value="0">select</option>
								<cfloop query="AddCategory">
									<option value="#priority#">#Priority#
									<cfset maxPrority= #priority#>
								</cfloop>
									<option value="#evaluate('maxPrority + 1')#">#evaluate('maxPrority + 1')#</option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td style="color:404040;">Description</td>
								<td><textarea rows="5" cols="25" name="description"></textarea></td>
							</tr>
							<tr>
								<td style="color:404040;"></td>
								<td><input type="submit" name="subSugCategoryAdd" value="SAVE NOW!" ></td>
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