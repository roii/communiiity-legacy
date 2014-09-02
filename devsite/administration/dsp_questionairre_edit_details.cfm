<cfoutput>

<tr>
<td bgcolor="silver" style="padding:2px;">

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td class="normal"><strong>&nbsp;QUESTIONNAIRE DETAILS</strong></td>
	<td align="right" style="padding-right:2px;"><cfif session.details_editmode EQ 'closed'><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?details_editmode=open" style="color:##444444;text-decoration:none;">[EDIT]</a><cfelse><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?details_editmode=closed" style="color:##444444;text-decoration:none;">[VIEW]</a></cfif></td>
	</tr>
	
	</table>
	
			
</td>
</tr>


<tr>
<td><br>


<cfif session.details_editmode EQ 'closed'>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="130"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
	<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
	<td width="100%"></td>
	</tr>
		
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Name:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Questionaire_Name)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Start Details:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Questionaire_details)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>End Details:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Questionaire_endDetails)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Status:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Questionaire_status)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Active Date Range:</strong></td>
	<td></td>
	<td valign="top" class="small">#DateFormat(QuestionairreStuff.Questionaire_startdate, "d mmmm yyyy")# &nbsp;&nbsp; - to - &nbsp;&nbsp; #DateFormat(QuestionairreStuff.Questionaire_enddate, "d mmmm yyyy")#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Cash Acc:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Reward_Cash)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Education Acc:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Reward_Education)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Points Acc:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Reward_Points)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Prize Draw Entries:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Reward_PrizeEntries)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Other Rewards:</strong></td>
	<td></td>
	<td valign="top" class="small">#TRIM(QuestionairreStuff.Reward_other)#</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e8e8e8"></td>
	</tr>
	
	</table>
	
	
	
<cfelse>

	<script language="JavaScript"><!--
	function checkdate(details_form) {
	
	var theday = details_form.FromDate_day.value;
	var themonth = details_form.FromDate_month.value;
	var theyear = details_form.FromDate_year.value;
	
	var theday2 = details_form.ToDate_day.value;
	var themonth2 = details_form.ToDate_month.value;
	var theyear2 = details_form.ToDate_year.value;
	
	function y2k(number) { return (number < 1000) ? number + 1900 : number; }
	
	function isDate (day,month,year) {
	// checks if date passed is valid
	// will accept dates in following format:
	// isDate(dd,mm,ccyy), or
	// isDate(dd,mm) - which defaults to the current year, or
	// isDate(dd) - which defaults to the current month and year.
	// Note, if passed the month must be between 1 and 12, and the
	// year in ccyy format.
	
	    var today = new Date();
	    year = ((!year) ? y2k(today.getYear()):year);
	    month = ((!month) ? today.getMonth():month-1);
	    if (!day) return false
	    var test = new Date(year,month,day);
	    if ( (y2k(test.getYear()) == year) &&
	         (month == test.getMonth()) &&
	         (day == test.getDate()) )
	        return true;
	    else
	        return false
	}
	
	
	if (isDate(theday,themonth,theyear) & isDate(theday2,themonth2,theyear2)) {
	    details_form.submit();
		}
	
		
	else {
	alert("The date range you have entered contains an invalid date.");
	return;
	
	}
	//-->
	
	}
	</script>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="details_form" method="post" action="#request.webroot#/administration/act_questionairre_edit_details.cfm">
	
	<input type="hidden" name="QuestionaireID" value="#session.Edit_QuestionaireID#">
	
	<tr>
	<td width="130"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
	<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
	<td width="100%"></td>
	</tr>
		
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Name:</strong></td>
	<td></td>
	<td valign="top" class="small"><input name="Questionaire_Name" type="text" class="whitefield" style="width:450px;" value="#TRIM(QuestionairreStuff.Questionaire_Name)#"></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td class="small" align="right" style="padding-left:8px;color:##444444;" valign="top"><strong>Start Details:</strong><br><em>(Displayed at the start<br>of the questionairre)</em></td>
	<td></td>
	<td valign="top"><textarea name="Questionaire_details" class="whitefield" style="width:450px;" rows="6">#TRIM(QuestionairreStuff.Questionaire_details)#</textarea></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td align="right" class="small" style="padding-left:8px;color:##444444;" valign="top"><strong>End Details:</strong><br><em>(Displayed at the end<br>of the questionairre)</em></td>
	<td></td>
	<td valign="top"><textarea name="Questionaire_endDetails" class="whitefield" style="width:450px;" rows="6">#TRIM(QuestionairreStuff.Questionaire_endDetails)#</textarea></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" align="right"><strong>Status:</strong></td>
	<td></td>
	<td style="color:##444444;font-size:10px;"><input type="radio" name="Questionaire_status" style="border:solid 1px silver;" value="Active"<cfif TRIM(QuestionairreStuff.Questionaire_status) EQ 'Active'> checked</cfif>> <strong>ACTIVE</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="Questionaire_status" style="border:solid 1px silver;" value="Inactive"<cfif TRIM(QuestionairreStuff.Questionaire_status) EQ 'Inactive'> checked</cfif>> <strong>INACTIVE</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="Questionaire_status" style="border:solid 1px silver;" value="Complete"<cfif TRIM(QuestionairreStuff.Questionaire_status) EQ 'Complete'> checked</cfif>> <strong>COMPLETE</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td align="right" class="small" style="padding-left:8px;color:##444444;" valign="top"><strong>Active Date Range:</strong><br>
	<em>(Enter the date range<br>
	that the questionairre<br>
	is available to answer)</em></td>
	<td></td>
	<td valign="top" style="color:##444444;font-size:10px;"><select name="FromDate_day" class="whitefield"><cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif DateFormat(QuestionairreStuff.Questionaire_startdate, "d") EQ loopcount> selected</cfif>>#loopcount#</cfloop></select> <select name="FromDate_month" class="whitefield"><cfloop from="1" to="12" index="monthloopcount"><option value="#monthloopcount#"<cfif DateFormat(QuestionairreStuff.Questionaire_startdate, "mm") EQ monthloopcount> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="FromDate_year" class="whitefield"><cfloop from="2000" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif DateFormat(QuestionairreStuff.Questionaire_startdate, "yyyy") EQ yearloopcount> selected</cfif>>#yearloopcount#</cfloop></select><strong>&nbsp;&nbsp;&nbsp;- to -&nbsp;&nbsp;&nbsp;</strong><select name="ToDate_day" class="whitefield"><cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif DateFormat(QuestionairreStuff.Questionaire_enddate, "d") EQ loopcount> selected</cfif>>#loopcount#</cfloop></select> <select name="ToDate_month" class="whitefield"><cfloop from="1" to="12" index="monthloopcount"><option value="#monthloopcount#"<cfif DateFormat(QuestionairreStuff.Questionaire_enddate, "mm") EQ monthloopcount> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="ToDate_year" class="whitefield"><cfloop from="2000" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif DateFormat(QuestionairreStuff.Questionaire_enddate, "yyyy") EQ yearloopcount> selected</cfif>>#yearloopcount#</cfloop></select></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
				
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Cash Account:</strong><br>
	<em>(Automatically transfered on<br>completion of survey)</em></td>
	<td></td>
	<td valign="top" class="small"><input name="Reward_Cash" type="text" class="whitefield" style="width:450px;" value="#QuestionairreStuff.Reward_Cash#"></td>
	</tr>

	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
		
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Education Account:</strong><br>
	<em>(Automatically transfered on<br>completion of survey)</em></td>
	<td></td>
	<td valign="top" class="small"><input name="Reward_Education" type="text" class="whitefield" style="width:450px;" value="#QuestionairreStuff.Reward_Education#"></td>
	</tr>

	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
		
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Points Account:</strong><br>
	<em>(Automatically transfered on<br>completion of survey)</em></td>
	<td></td>
	<td valign="top" class="small"><input name="Reward_Points" type="text" class="whitefield" style="width:450px;" value="#QuestionairreStuff.Reward_Points#"></td>
	</tr>

	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
		
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Prize Entries:</strong><br>
	<em>(Automatically give entries into prize draws on completion of survey)</em></td>
	<td></td>
	<td valign="top" class="small"><input name="Reward_PrizeEntries" type="text" class="whitefield" style="width:450px;" value="#QuestionairreStuff.Reward_PrizeEntries#"></td>
	</tr>

	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
		
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Other:</strong><br>
	<em>(i.e. Go in the draw to win $xxx)</em></td>
	<td></td>
	<td valign="top" class="small"><input name="Reward_Other" type="text" class="whitefield" style="width:450px;" value="#QuestionairreStuff.Reward_Other#"></td>
	</tr>

	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td colspan="3" align="right"><input type="submit" class="whitefield" value="UPDATE NOW >>" onclick="checkdate(details_form); return false;">&nbsp; &nbsp;<input type="button" class="whitefield" value="CANCEL" onclick="javascript:location='#request.webroot#/administration/dsp_questionairre_edit.cfm?details_editmode=closed';"></td>
	</tr>
	
	</form>
	
	</table>

</cfif>



</td>
</tr>

</cfoutput>