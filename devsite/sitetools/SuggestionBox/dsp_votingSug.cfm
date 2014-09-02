<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" type="text/css" href="CSS/small.css">

<script language="javascript">
	var ie4 = false; 
	if(document.all) { ie4 = true; }
	
	function getObject(id) { 
		if (ie4) { 
			return document.all[id]; 
		} else { 
			return document.getElementById(id); 
		}
	 }
	 
	function toggle(divIdDisplay,divIdHide) {
		var display = getObject(divIdDisplay);
		var hide = getObject(divIdHide);
		display.style.display = 'block';
		hide.style.display ='none';
	  }
	 
	function validateSelRate(frm){
		if(frm.rate.value == 0){
			alert('Please select a value before clicking vote');
			frm.rate.focus();
			return false;
		}
		return true;
	}
	
</script>
</head>

<body>

<cfoutput>

<cfinclude template="qry_votingSug.cfm">

<table width="100%" cellspacing="1" cellspacing="1">
<tr>
	<td class="section_header">Vote Suggestion</td>
</tr>
<tr class="normal">
	<td>Help us to rate the suggestion so we know which is the most popular.<p></p></td>
</tr>

<tr>
	<td>
	<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
		<tr bgcolor="004080" height="35" class="normal">
			<td style="color:white;" align="center">Date</td>
			<td style="color:white;" align="center">Suggestion</td>
			<td style="color:white;" align="center">Closed <br> Date</td>
			<td style="color:white;" align="center">Rate</td>
			<td>&nbsp;</td>
		</tr>
		<cfif votingCategory.RecordCount NEQ 0>
		<cfloop query="votingCategory">
		
		<tr class="normal">
			<td colspan="5" bgcolor="e3f4f6" height="12"><b>#TRIM(Name)#</b></td>
		</tr>		
			<cfset catName = #Name#>
			<cfloop query="votingSuggestion">
				<cfif #catName# EQ #sugName#>
				<form  action="act_voteSug.cfm" method="post" onSubmit="return validateSelRate(this)">
				<input type="hidden" name="sugID" value="#sugID#">
				<tr class="normal">
				<td align="center">#date#</td>
				<td>
				<cfif len(suggestion) GT 50>
					<div id="d1#sugID#">
					#mid(suggestion,1,50)# 
					<a title="show" href="javascript: void(0);" onClick="toggle('d2#sugID#', 'd1#sugID#');">more..</a>
					</div>
					<div id="d2#sugID#">
					#suggestion#
					<a title="hide" href="javascript: void(0);" onClick="toggle('d1#sugID#', 'd2#sugID#');">collapse</a>
					</div>
					<script language="javascript">toggle('d1#sugID#', 'd2#sugID#');</script>
				<cfelse>
					#suggestion#
				</cfif>
				</td>
				<td align="center">#closeDate#</td>
				<td align="center">
				<select name="rate" class="normal">
					<option value="0">Select</option>
					<option value="1">No Way</option>
					<option value="2">Not Good</option>
					<option value="3">May Be</option>
					<option value="4">Good</option>
					<option value="5">Great</option>
				</select>
				</td>
				<td align="center"><input  type="submit" name="subVote" value="Vote Now!"></td>
				</tr>
				</form>
				</cfif>	
			</cfloop>
		
		
		<tr>
			<td colspan="5"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
		</cfloop>
		<cfelse>
		<tr class="normal">
			<td>Currently we don't have any suggestion for you to vote!</td>
		</tr>
		</cfif>
	</table>
	</td>
</tr>
<tr class="normal">
	<td>To make a suggestion click <a href="dsp_suggestionboxInputForm.cfm" title="to made a suggestion">here</a></td>
</tr>
</table>
</cfoutput>
</body>
</html>
