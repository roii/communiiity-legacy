<cfoutput>



<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Add Questionairre</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="white">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td bgcolor="###TRIM(AllSettings.BoxColour)#" valign="middle"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add a New Questionnaire</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" style="height:1px;"></td>
</tr>

<tr>
<td bgcolor="##000000" style="width:40px;" align="center"></td>
<td style="width:1px;" bgcolor="white"></td>
<td valign="top">
<br>




	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
	<tr>
	<td style="width:10px;"></td>
	<td class="normal" valign="top">
	
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td><br>
		
		
			
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
			
			<form name="details_form" method="post" action="#request.webroot#/administration/act_questionairre_add.cfm">
			
			
			<tr>
			<td width="130"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
			<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
			<td width="100%"></td>
			</tr>
				
			<tr>
			<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Name:</strong></td>
			<td></td>
			<td valign="top" class="small"><input name="Questionaire_Name" type="text" class="whitefield" style="width:450px;"></td>
			</tr>
	
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="silver"></td>
			</tr>
			
			<tr>
			<td class="small" align="right" style="padding-left:8px;color:##444444;" valign="top"><strong>Start Details:</strong><br><em>(Displayed at the start<br>of the questionairre)</em></td>
			<td></td>
			<td valign="top"><textarea name="Questionaire_details" class="whitefield" style="width:450px;" rows="6"></textarea></td>
			</tr>
			
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="silver"></td>
			</tr>
			
			<tr>
			<td align="right" class="small" style="padding-left:8px;color:##444444;" valign="top"><strong>End Details:</strong><br><em>(Displayed at the end<br>of the questionairre)</em></td>
			<td></td>
			<td valign="top"><textarea name="Questionaire_endDetails" class="whitefield" style="width:450px;" rows="6"></textarea></td>
			</tr>
			
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="silver"></td>
			</tr>
			
			<tr>
			<td class="small" style="padding-left:8px;color:##444444;" align="right"><strong>Status:</strong></td>
			<td></td>
			<td style="color:##444444;font-size:10px;"><input type="radio" name="Questionaire_status" style="border:solid 1px silver;" value="Active"> <strong>ACTIVE</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="Questionaire_status" style="border:solid 1px silver;" value="Inactive" checked> <strong>INACTIVE</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="Questionaire_status" style="border:solid 1px silver;" value="Complete"> <strong>COMPLETE</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
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
			<td valign="top" style="color:##444444;font-size:10px;"><select name="FromDate_day" class="whitefield"><cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif DateFormat(localDateTime, "d") EQ loopcount> selected</cfif>>#loopcount#</cfloop></select> <select name="FromDate_month" class="whitefield"><cfloop from="1" to="12" index="monthloopcount"><option value="#monthloopcount#"<cfif DateFormat(localDateTime, "mm") EQ monthloopcount> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="FromDate_year" class="whitefield"><cfloop from="2000" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif DateFormat(localDateTime, "yyyy") EQ yearloopcount> selected</cfif>>#yearloopcount#</cfloop></select><strong>&nbsp;&nbsp;&nbsp;- to -&nbsp;&nbsp;&nbsp;</strong><select name="ToDate_day" class="whitefield"><cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif DateFormat(DateAdd('d', 30, localDateTime), "d") EQ loopcount> selected</cfif>>#loopcount#</cfloop></select> <select name="ToDate_month" class="whitefield"><cfloop from="1" to="12" index="monthloopcount"><option value="#monthloopcount#"<cfif DateFormat(DateAdd('d', 30, localDateTime), "mm") EQ monthloopcount> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="ToDate_year" class="whitefield"><cfloop from="2000" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif DateFormat(DateAdd('d', 30, localDateTime), "yyyy") EQ yearloopcount> selected</cfif>>#yearloopcount#</cfloop></select></td>
			</tr>
			
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="silver"></td>
			</tr>
				
			<tr>
			<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Cash Account:</strong><br>
			<em>(Automatically transfered on<br>completion of survey)</em></td>
			<td></td>
			<td valign="top" class="small"><input name="Reward_Cash" type="text" class="whitefield" style="width:450px;"></td>
			</tr>
	
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="silver"></td>
			</tr>
				
			<tr>
			<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Education Account:</strong><br>
			<em>(Automatically transfered on<br>completion of survey)</em></td>
			<td></td>
			<td valign="top" class="small"><input name="Reward_Education" type="text" class="whitefield" style="width:450px;"></td>
			</tr>
	
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="silver"></td>
			</tr>
				
			<tr>
			<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Points Account:</strong><br>
			<em>(Automatically transfered on<br>completion of survey)</em></td>
			<td></td>
			<td valign="top" class="small"><input name="Reward_Points" type="text" class="whitefield" style="width:450px;"></td>
			</tr>
				
			<tr>
			<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Prize Draws:</strong><br>
			<em>(Automatically given prize entries into current draws)</em></td>
			<td></td>
			<td valign="top" class="small"><input name="Reward_PrizeEntries" type="text" class="whitefield" style="width:450px;"></td>
			</tr>
				
			<tr>
			<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Rewards - Other:</strong><br>
			<em>(i.e. Go in the draw to win $xxx)</em></td>
			<td></td>
			<td valign="top" class="small"><input name="Reward_Other" type="text" class="whitefield" style="width:450px;"></td>
			</tr>
	
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="silver"></td>
			</tr>
			
			<tr>
			<td colspan="3" align="right"><input type="submit" class="whitefield" value="ADD NOW >>" onclick="checkdate(details_form); return false;">&nbsp; &nbsp;<input type="button" class="whitefield" value="CANCEL" onclick="window.close();"></td>
			</tr>
			
			</form>
			
			</table>
		
		
		
		
		
		</td>
		</tr>
		
			
		</table>
	
	
	
	</td>
	<td style="width:10px;"></td>
	</tr>
	
		
	</table>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


