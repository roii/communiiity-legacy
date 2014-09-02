<cfoutput>


<script>
function validateVote(VoteForm) {

<cfif Stage1Idea.recordcount>

	if (VoteForm.rate1.selectedIndex == "0") {
		alert("You must select either YES or NO to vote.");
		VoteForm.rate1.focus();
		return;
		}
		
		

	else if (document.VoteForm.comments1.value == "comments..." || document.VoteForm.comments1.value == "") {
		
		if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
			document.VoteForm.submit();
			}
			return;
		}
	
	<cfif Stage2Idea.recordcount>
	
		if (VoteForm.rate2.selectedIndex == "0") {
		alert("You must select either YES or NO to vote.");
		VoteForm.rate2.focus();
		return;
		}
		
		else if (document.VoteForm.comments2.value == "comments..." || document.VoteForm.comments2.value == "") {
		
		if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
			document.VoteForm.submit();
			}
			return;
		}
	
	</cfif>
	
	<cfif Stage3Idea.recordcount>
	
		if (VoteForm.rate3.selectedIndex == "0") {
		alert("You must select either YES or NO to vote.");
		VoteForm.rate3.focus();
		return;
		}
		
		else if (document.VoteForm.comments3.value == "comments..." || document.VoteForm.comments3.value == "") {
		
		if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
			document.VoteForm.submit();
			}
			return;
		}
	
	</cfif>
	
	else {
	VoteForm.submit(); //submit form
	}
	

	
<cfelseif Stage2Idea.recordcount>
	
	if (VoteForm.rate2.selectedIndex == "0") {
	alert("You must select either YES or NO to vote.");
	VoteForm.rate2.focus();
	return;
	}
	
	else if (document.VoteForm.comments2.value == "comments..." || document.VoteForm.comments2.value == "") {
		
		if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
			document.VoteForm.submit();
			}
			return;
		}

	<cfif Stage3Idea.recordcount>
	
		if (VoteForm.rate3.selectedIndex == "0") {
		alert("You must select either YES or NO to vote.");
		VoteForm.rate3.focus();
		return;
		}
		
		else if (document.VoteForm.comments3.value == "comments..." || document.VoteForm.comments3.value == "") {
		
		if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
			document.VoteForm.submit();
			}
			return;
		}
	
	</cfif>
	
	else {
	VoteForm.submit(); //submit form
	}
	

<cfelseif Stage3Idea.recordcount>
		
	if (VoteForm.rate3.selectedIndex == "0") {
	alert("You must select either YES or NO to vote.");
	VoteForm.rate3.focus();
	return;
	}
	
	else if (document.VoteForm.comments3.value == "comments..." || document.VoteForm.comments3.value == "") {
		
		if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
			document.VoteForm.submit();
			}
			return;
		}
	
	else {
	VoteForm.submit(); //submit form
	}
	
</cfif>
			
}
</script>



<table width="100%" cellspacing="0" cellpadding="0" border="0">


<tr>
<td><br><img src="#request.imageroot#/ideaFunL/critical_votes.gif" width="379" height="36" alt="Please vote for the following ideas first." border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form method="post" action="#request.webroot#/ideas/act_critical_votes.cfm" name="VoteForm" onsubmit="javascript:validateVote(VoteForm); return false;">
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="45"></td>
	<td width="100%">
	
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
		<tr>
		<td colspan="3" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>			

		<tr>
		<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		
		<cfif Stage1Idea.recordcount>
		
			<input type="hidden" name="sugID1" value="#Stage1Idea.sugID#">
				
			<tr>
			<td width="20" valign="top" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>1.</strong></td>
			<td width="*" style="padding-left:5px;padding-right:20px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>#Stage1Idea.suggestion#</strong><cfif TRIM(Stage1Idea.details) NEQ ''> &nbsp; <a title="#Stage1Idea.details#" style="font-size:10px;color:black;">[more info]</a></cfif></td>
			</tr>
			
			<tr>
			<td colspan="2" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
			</tr>
			
			<tr>
			<td width="20" valign="top"> </td>
			<td width="*" style="padding-left:5px;padding-right:20px;" valign="top"><select style="font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="rate1">
			<option value="0">Select</option>
			<option value="5">YES - It's a winner!</option>
			<option value="1">NO - Not so good</option>
			</select> <input type="text" style="width:250px;font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="comments1" onfocus="javascript: if (document.VoteForm.comments1.value == 'comments...'){document.VoteForm.comments1.value='';}" value="comments..."></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
		
		
		</cfif>
		
		
		<cfif Stage2Idea.recordcount>
		
			<input type="hidden" name="sugID2" value="#Stage2Idea.sugID#">
				
			<tr>
			<td width="20" valign="top" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>2.</strong></td>
			<td width="*" style="padding-left:5px;padding-right:20px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>#Stage2Idea.suggestion#</strong><cfif TRIM(Stage2Idea.details) NEQ ''> &nbsp; <a title="#Stage2Idea.details#" style="font-size:10px;color:black;">[more info]</a></cfif></td>
			</tr>
			
			<tr>
			<td colspan="2" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
			</tr>
			
			<tr>
			<td width="20" valign="top"> </td>
			<td width="*" style="padding-left:5px;padding-right:20px;" valign="top"><select style="font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="rate2">
			<option value="0">Select</option>
			<option value="5">YES - It's a winner!</option>
			<option value="1">NO - Not so good</option>
			</select> <input type="text" style="width:250px;font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="comments2" onfocus="javascript: if (document.VoteForm.comments2.value == 'comments...'){document.VoteForm.comments2.value='';}" value="comments..."></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
		
		
		</cfif>
		
		
		<cfif Stage3Idea.recordcount>
		
			<input type="hidden" name="sugID3" value="#Stage3Idea.sugID#">
				
			<tr>
			<td width="20" valign="top" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>3.</strong></td>
			<td width="*" style="padding-left:5px;padding-right:20px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>#Stage3Idea.suggestion#</strong><cfif TRIM(Stage3Idea.details) NEQ ''> &nbsp; <a title="#Stage3Idea.details#" style="font-size:10px;color:black;">[more info]</a></cfif></td>
			</tr>
			
			<tr>
			<td colspan="2" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
			</tr>
			
			<tr>
			<td width="20" valign="top"> </td>
			<td width="*" style="padding-left:5px;padding-right:20px;" valign="top"><select style="font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="rate3">
			<option value="0">Select</option>
			<option value="5">YES - It's a winner!</option>
			<option value="1">NO - Not so good</option>
			</select> <input type="text" style="width:250px;font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="comments3" onfocus="javascript: if (document.VoteForm.comments3.value == 'comments...'){document.VoteForm.comments3.value='';}" value="comments..."></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
			</tr>
		
		
		</cfif>
		
	
		<tr>
		<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr> 		
		<td> </td>
		<td valign="top"><input type="submit" value="Cast your votes!" class="whitefield"></td>
		</tr>
		
		</table>
	
		
	</td>
	</tr>
	</form>
	
	</table>
	
		
		
</td>
</tr>

</table>


</cfoutput>