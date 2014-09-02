<CFSETTING ENABLECFOUTPUTONLY="YES">

<cfinclude template="m#obj#.cfm">

<cfoutput>

<SCRIPT language="javascript">
	function verify(invariable) {
		if (invariable == 0 ) {
	  	    strOut += "\nPlease Select your question type";	
		}
	}	
	
	function testtype(options) {
		var blankstring = ",,,,,,,,,,";
		var element = options[options.selectedIndex].value;
			elements = element.concat(blankstring);
		var elementsArray = elements.split(',');
		document.myform.option1.value = elementsArray[0];
		document.myform.option2.value = elementsArray[1];
		document.myform.option3.value = elementsArray[2];
		document.myform.option4.value = elementsArray[3];
		document.myform.option5.value = elementsArray[4];
		document.myform.option6.value = elementsArray[5];
		document.myform.option7.value = elementsArray[6];
		document.myform.option8.value = elementsArray[7];
		document.myform.option9.value = elementsArray[8];
		document.myform.option10.value = elementsArray[9];
	  }
</SCRIPT>

<cfset itemid = randrange(1000000,9999999)>

<form action="default.cfm" method="POST" name="myform">

<input type="hidden" name="obj" value="002">
<input type="hidden" name="itemid" value="#itemid#">
<input type="hidden" name="datein" value="#now()#">

<table border="#tableborder#" cellpadding="3" cellspacing="0">
<tr><td valign="top">

<table width="500" border="#tableborder#" cellpadding="0" cellspacing="0" bgcolor="#bgcolor2#">
<tr><td align="center" bgcolor="#bgcolor1#">
	<font #fontstyle#><b>Question Editor</b></font>
</td></tr>
<tr><td align="center" bgcolor="#bgcolor2#">
<br>

</cfoutput>

<cfif m.recordcount is not "0">
<!--- Update Question --->

		<cfoutput query="M">
			<input type="Hidden" name="method" value="104">
			<input type="Hidden" name="id" value="#id#">
			<input type="Hidden" name="vendorid" value="#vendorid#">
			<input type="Hidden" name="formid" value="#formid#">
			<table width="470" border="#tableborder#" cellpadding="0" cellspacing="0" bgcolor="#bgcolor2#" align="center">
			<tr>	
				<td colspan=2 align="right">
					<font #fontstyle1#><b>(1) Question: (HTML supported)</b></font><br>
					<textarea name="question" cols="55" rows="3">#question#</textarea>
				</td>
			</tr>
			<tr>
				<td nowrap align="right" colspan="2">
					<font #fontstyle1#><b>(3) Type of question:</b></font>
				<select name="questiontype">
					<option value="0" <cfif m.questiontype is "0">selected</cfif>>Plain html inside the survey form
					<option value="1" <cfif m.questiontype is "1">selected</cfif>>Radio Buttons (single selection)
					<option value="2" <cfif m.questiontype is "2">selected</cfif>>Checkboxes (multiple selection)
					<option value="3" <cfif m.questiontype is "3">selected</cfif>>Single Select Box (drop down list)
					<option value="4" <cfif m.questiontype is "4">selected</cfif>>Multiple Select Box (multiple selection)
					<option value="5" <cfif m.questiontype is "5">selected</cfif>>Text Box (open question single line)
					<option value="6" <cfif m.questiontype is "6">selected</cfif>>Text Area (open question multiple lines)
					<cfif session.accesslevel gt 3>
						<option value="7" <cfif m.questiontype is "7">selected</cfif>>Hidden (will not be dispplayed)
					</cfif>
				</select>
			</td>
			</tr>
			 <tr>

		 	<td align="right" nowrap>
		   	<font #fontstyle1#>Option1:</font>
			</td>
			<td align="right" nowrap>
	   		<input type="Text" name="option1" size=57 maxlength=150 value="#m.option1#">
			</td></tr><tr>			
		   	<td align="right" nowrap>
			<font #fontstyle1#>Option2:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option2" size=57 maxlength=150 value="#m.option2#">
			</td></tr><tr>			
			<td align="right" nowrap>
			<font #fontstyle1#>Option3:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option3" size=57 maxlength=150 value="#m.option3#">
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option4:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option4" size=57 maxlength=150 value="#m.option4#">
			</td></tr><tr>
			<td align="right" nowrap>
				<font #fontstyle1#>Option5:</font>
			</td>			
			<td align="right" nowrap>
			<input type="Text" name="option5" size=57 maxlength=150 value="#m.option5#">
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option6:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option6" size=57 maxlength=150 value="#m.option6#">
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option7:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option7" size=57 maxlength=150 value="#m.option7#">
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option8:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option8" size=57 maxlength=150 value="#m.option8#">
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option9:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option9" size=57 maxlength=150 value="#m.option9#">
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option10:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option10" size=57 maxlength=150 value="#m.option10#">
			</td></tr><tr>			
	<td colspan="2" align="right">
		<dd><b>(4)</b> <input type="submit" value="Save Your Question" onsubmit="return verify ('#m.questiontype#')">
		<br><br>
		</td>
		</tr>	
		</table>
		</cfoutput>

<cfelse>
<!--- Insert Action --->
		
		<cfoutput>
		<input type="hidden" name="method" value="103">
		<input type="Hidden" name="vendorid" value="#vendorid#">
		<input type="Hidden" name="formid" value="#formid#">
		<table align="center" width="470" border="#tableborder#" cellpadding="0" cellspacing="0" bgcolor="#bgcolor2#">
		<tr>	
			<td colspan=2 align="right">
			<font face="Arial" size="-1" color="Black"><b>(1) Question: (HTML supported)</b></font>
			<BR><textarea name="question" cols="55" rows="3"></textarea></td>
		</tr>
		<tr>
			<td nowrap align="right" colspan="2">
			<font face="Arial" size="-1" color="Black"><b>(3) Type of question:</b></font>
				<select name="questiontype">
				<option value="0">Plain html
				<option value="1">Radio Buttons (single selection)
				<option value="2">Checkboxes (multiple selection)
				<option value="3">Single Select Box (drop down list)
				<option value="4">Multiple Select Box (multiple selection)
				<option value="5">Text Box (open question single line)
				<option value="6">Text Area (open question multiple lines)
				<cfif session.accesslevel gt 3>
					<option value="7">Hidden (will not be dispplayed)				
				</cfif>
				</select>
			</td>
		</tr>
			 <tr>

		 	<td align="right" nowrap>
		   	<font #fontstyle1#>Option1:</font>
			</td>
			<td align="right" nowrap>
	   		<input type="Text" name="option1" size=57 maxlength=150>
			</td></tr><tr>			
		   	<td align="right" nowrap>
			<font #fontstyle1#>Option2:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option2" size=57 maxlength=150>
			</td></tr><tr>			
			<td align="right" nowrap>
			<font #fontstyle1#>Option3:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option3" size=57 maxlength=150>
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option4:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option4" size=57 maxlength=150>
			</td></tr><tr>
			<td align="right" nowrap>
				<font #fontstyle1#>Option5:</font>
			</td>			
			<td align="right" nowrap>
			<input type="Text" name="option5" size=57 maxlength=150>
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option6:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option6" size=57 maxlength=150>
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option7:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option7" size=57 maxlength=150>
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option8:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option8" size=57 maxlength=150>
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option9:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option9" size=57 maxlength=150>
			</td></tr><tr>			
			<td align="right" nowrap>
				<font #fontstyle1#>Option10:</font>
			</td>
			<td align="right" nowrap>
			<input type="Text" name="option10" size=57 maxlength=150>
			</td></tr><tr>			
	<td colspan="2" align="right">
		<dd><b>(4)</b> <input type="submit" value="Save Your Question" onsubmit="return verify ('#m.questiontype#')">
		<br><br>
		</td>
		</tr>			</table>
		</cfoutput>

</cfif>
<cfoutput>
</td></tr></table>

	</td>
	<td valign="top">
	
	<table width="235" border="#tableborder#" cellpadding="0" cellspacing="0" bgcolor="#bgcolor2#">
	<tr><td align="center" bgcolor="#bgcolor1#">
		<font #fontstyle#><b>(2) Response options</b></font>
	</td></tr>
	<tr><td align="center" bgcolor="#bgcolor2#">
	<select name="options" size="24" onclick="testtype(options)">
		<option value="Yes,No">Yes / No (2 pt.)</option>
		<option value="Strongly Agree,Agree,I don't know,Disagree,Strongly Disagree">Agree / Disagree (5 pt.)</option>
		<option value="Strongly Believe,Believe,Neutral,Disbelieve,Strongly Disbelieve">Believe / Disbelieve (5 pt.)</option>
		<option value="Significantly Better,Better,Neutral,Worse,Significantly Worse">Better / Worse (5 pt.)</option>
		<option value="Credible,Somewhat Credible,Neutral,Somewhat Uncredible,Uncredible">Credible / Uncredible (5 pt.)</option>		
		<option value="Easy,Somewhat Easy,Neutral,Somewhat Difficult,Difficult">Easy / Difficult (5 pt.)</option>
		<option value="Highly Effective,Effective,Neutral,Ineffective,Highly Ineffective">Effective / Ineffective (5 pt.)</option>
		<option value="Excellent,Very Good,Good,Fair,Poor">Excellent / Poor (5 pt.)</option>
		<option value="Very Fast,Fast,Average,Slow,Very Slow">Fast / Slow (5 pt.)</option>		
		<option value="High,Somewhat High,Average,Somewhat Low,Low">High / Low (5 pt.)</option>		
		<option value="Highly Important,Important,Neutral,Unimportant,Highly Unimportant">Important / Unimportant (5 pt.)</option>		
		<option value="Highly Likely,Likely,Neutral,Unlikely,Highly Unlikely">Likely / Unlikely (5 pt.)</option>
		<option value="Relevant,Somewhat Relevant,Neutral,Somewhat Irrelevant,Irrelevant">Relevant / Irrelevant (5 pt.)</option>
		<option value="Safe,Somewhat Safe,Neutral,Somewhat Risky,Risky">Safe / Risky (5 pt.)</option>
		<option value="Satisfied,Somewhat Satisfied,Neutral,Somewhat Dissatisfied,Dissatisfied">Satisfied / Dissatisfied (5 pt.)</option>
		<option value="Significant,Somewhat Significant,Neutral,Somewhat Insignificant,Insignificant">Significant / Insignificant (5 pt.)</option>
		<option value="Superior,Somewhat Superior,Neutral,Somewhat Inferior,Inferior">Superior / Inferior (5 pt.)</option>
		<option value="Trust,Somewhat Trust,Neutral,Somewhat Distrust,Distrust">Trust / Distrust (5 pt.)</option>
		<option value="Useful,Somewhat Useful,Neutral,Somewhat Unuseful,Unuseful">Useful / Unuseful (5 pt.)</option>
		<option value=",,,,,,,,,,">------------------------
		<option value="Strongly Agree,Agree,Somewhat Agree,Neutral,Somewhat Disagree,Disagree,Strongly Disagree">Agree / Disagree (7 pt.)</option>
		<option value="Strongly Believe,Believe,Somewhat Believe,Neutral,Somewhat Disbelieve,Disbelieve,Strongly Disbelieve">Believe / Disbelieve (7 pt.)</option>
		<option value="Significantly Better,Better,Somewhat Better,Neutral,Somewhat Worse,Worse,Significantly Worse">Better / Worse (7 pt.)</option>
		<option value="Very Credible,Credible,Somewhat Credible,Neutral,Somewhat Uncredible,Uncredible, Very Uncredible">Credible / Uncredible (7 pt.)</option>		
		<option value="Very Easy,Easy,Somewhat Easy,Neutral,Somewhat Difficult,Difficult,Very Difficult">Easy / Difficult (7 pt.)</option>
		<option value="Highly Effective,Effective,Somewhat Effective,Neutral,Somewhat Ineffective,Ineffective,Highly Ineffective">Effective / Ineffective (7 pt.)</option>
		<option value="Excellent,Very Good,Good,Neutral,Bad,Very Bad,Poor">Excellent / Poor (7 pt.)</option>
		<option value="Very Fast,Fast,Somewhat Fast,Average,Somewhat Slow,Slow,Very Slow">Fast / Slow (7 pt.)</option>		
		<option value="Very High,High,Somewhat High,Average,Somewhat Low,Low,Very Low">High / Low (7 pt.)</option>		
		<option value="Highly Important,Important,Somewhat Important,Neutral,Somewhat Unimportant,Unimportant,Highly Unimportant">Important / Unimportant (7 pt.)</option>		
		<option value="Highly Likely,Likely,Somewhat Likely,Neutral,Somewhat Unlikely,Unlikely,Highly Unlikely">Likely / Unlikely (7 pt.)</option>
		<option value="Very Relevant,Relevant,Somewhat Relevant,Neutral,Somewhat Irrelevant,Irrelevant,Very Irrelevant">Relevant / Irrelevant (7 pt.)</option>
		<option value="Very Safe,Safe,Somewhat Safe,Neutral,Somewhat Risky,Risky,Very Risky">Safe / Risky (7 pt.)</option>
		<option value="Very Satisfied,Satisfied,Somewhat Satisfied,Neutral,Somewhat Dissatisfied,Dissatisfied,Very Dissatisfied">Satisfied / Dissatisfied (7 pt.)</option>
		<option value="Very Significant,Significant,Somewhat Significant,Neutral,Somewhat Insignificant,Insignificant,Very Insignificant">Significant / Insignificant (7 pt.)</option>
		<option value="Very Superior,Superior,Somewhat Superior,Neutral,Somewhat Inferior,Inferior,Very Inferior">Superior / Inferior (7 pt.)</option>
		<option value="Strongly Trust,Trust,Somewhat Trust,Neutral,Somewhat Distrust,Distrust,Strongly Distrust">Trust / Distrust (7 pt.)</option>
		<option value="Very Useful,Useful,Somewhat Useful,Neutral,Somewhat Unuseful,Unuseful,Very Unuseful">Useful / Unuseful (7 pt.)</option>
	</select>
	<br><br>
	</td></tr></table>
		

	</td></tr></table>

</form>
</cfoutput>

<CFSETTING ENABLECFOUTPUTONLY="NO">
