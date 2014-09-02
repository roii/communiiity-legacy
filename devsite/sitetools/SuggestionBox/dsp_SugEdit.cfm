
<cfoutput>

<script language="javascript" type="text/javascript" src="datepicker/datetimepicker.js">
</script>


<cfinclude template="qry_manageSug.cfm">

<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">
	<tr>
	<td style="color:white;" width="230"><img src="images/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT SUGGESTION</strong><img src="images/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
							<form name="frmEditSug" action="act_sugEdit.cfm" method="post">
								<input type="hidden" name="sugID" value="#sugID#">
							<tr>
								<td style="color:404040;">Date</td>
								<td><input  name="date" type="text" size="25"  value="#CurrentSuggestion.date#" disabled >
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Voting Close Date</td>
								<td><input name="closeDate" id="d#CurrentSuggestion.sugID#" type="text" size="25"  value="#CurrentSuggestion.voteCloseDate#">
									<a href="javascript:NewCal('d#CurrentSuggestion.sugID#','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Rated</td>
								<td><input type="text"  size="25" value="#CurrentSuggestion.rated#" disabled></td>
							</tr>
							<tr>
								<td style="color:404040;">Vote Received</td>
								<td><input type="text"  size="25" value="#CurrentSuggestion.voteReceived#" disabled></td>		
							</tr>
								<tr>
								<td style="color:404040;">Email</td>
								<td>
									<input type="text" name="email" value="#CurrentSuggestion.email#" size="25">
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Authorise</td>
								<td>
									Yes <input type="Radio" name="authorise" value="yes" <cfif CurrentSuggestion.authorise contains('yes')>checked</cfif>>
									No  <input type="Radio" name="authorise" value="no" <cfif CurrentSuggestion.authorise contains('no')>checked</cfif>>
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Category</td>
								<td>
									<select name="category" size="1">
										<cfloop query="CurrentCategory">
										  <cfif CurrentCategory.CategoryID EQ CurrentSuggestion.CategoryID>
											<option value="#CurrentCategory.CategoryID#" selected>#CurrentCategory.Name# 
										  <cfelse>
											<option value="#CurrentCategory.CategoryID#">#CurrentCategory.Name# 
										  </cfif> 
										</cfloop>
									</select>
								</td>
							</tr>
							<tr>
								<td style="color:404040;">Suggestion</td>
								<td><textarea rows="5" cols="40" name="suggestion">#CurrentSuggestion.suggestion#</textarea></td>
							</tr>
							<tr>
								<td colspan="2" style="color:404040;" height="5">
									<hr width="100%" size="1" color="a0d8e0">
								</td>
							</tr>
							<tr>
								<td style="color:404040;"> </td>
								<td><input type="submit" name="subSugEdit" value="SAVE NOW!" ></td>
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