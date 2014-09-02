<cfquery  datasource="#datasourceW#" name="surveyDetails">
    select * from forms where forms.formid=#attributes.surveyid#
</cfquery>

<cfquery  datasource="#datasourceW#" name="Qdetail">
    select * from questions,surveyQType where surveyQType.questionTypeID=questions.questionType
    and questions.formid=#attributes.surveyid# and id=#attributes.QID#
</cfquery>

<cfquery  datasource="#datasourceW#" name="choices">
    select * from surveyChoice where QID=#attributes.QID#
</cfquery>

<cfquery  datasource="#datasourceW#" name="Qtype">
    select * from surveyQType order by questionTypeID
</cfquery>

<script language="JavaScript">
	function confirmDelete(aURL) {
	    if(confirm('Are you sure you want to delete this question?')) {
	      location.href = aURL;
	    }
	  }
</script>


<CFSETTING ENABLECFOUTPUTONLY="YES">

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

<form action="default.cfm?fuseaction=act_edit_Q" method="POST" name="myform" enctype="multipart/form-data">

<h3>#surveyDetails.title#</h3>

<table border="#tableborder#" cellpadding="3" cellspacing="0" with="100%">
<tr><td valign="top">

<table width="650" border="#tableborder#" cellpadding="0" cellspacing="0" bgcolor="#bgcolor2#">
<tr><td align="center" bgcolor="#bgcolor1#">
	<font #fontstyle#><b>Question Editor</b></font>
</td></tr>
<tr><td align="center" bgcolor="#bgcolor2#">
<br>

</cfoutput>


<!--- Insert Action --->
		
		<cfoutput>

		<input type="Hidden" name="formid" value="#surveyid#">
		<input type="Hidden" name="qid" value="#qid#">
		<table align="center" width="670" border="#tableborder#" style="padding-left:5px;" cellpadding="0" cellspacing="0" bgcolor="#bgcolor2#">
		<tr>	
			<td colspan=2 align="left">
			<font face="Arial" size="-1" color="Black"><b>(1) Question: (HTML supported)</b></font>
			<BR><textarea name="question" cols="55" rows="3">#Qdetail.question#</textarea>
			<cfif Qdetail.image neq ''>
			  <img src="#request.webroot#/surveyengine/images/#Qdetail.image#">
			</cfif>
			</td>
		</tr>
		<tr>
			<td nowrap align="left" colspan="2">
			<font face="Arial" size="-1" color="Black"><b>(3) Type of question:</b></font>
				<select name="questiontype">
				<option value="0">Choose a type
				<cfloop query="Qtype">
				  <option value="#Qtype.questionTypeID#" <cfif Qdetail.questionType EQ Qtype.questionTypeID>selected</cfif>>#Qtype.type# (#Qtype.description#)
				</cfloop>

				</select>
			</td>
		</tr>
		<tr>
			<td nowrap align="left" colspan="2">
			<font face="Arial" size="-1" color="Black"><b>(4) Display Order:</b></font>
			  <input type="text" name="displayorder" size="5" value="#Qdetail.displayorder#">
			</td>
		</tr>

		<tr>
			<td colspan=2 align="left">
			<font face="Arial" size="-1" color="Black"><b>(6) Question Image: </b></font>
			<input type="file" name="file_location" size="55"></td>
		
		</tr>
			<cfloop from="1" to="#NoofQ#" index="i">
			<tr>			
			<td align="left" nowrap>
				<font #fontstyle1#>Option#i#:</font>
			</td>
			<td align="left" nowrap> 
			<cfif choices['image'][i] neq ''>
			  <img src="#request.webroot#/surveyengine/images/#choices['image'][i]#" width=100 height=100>
			</cfif>
			<input type="Text" name="option#i#" size=25 maxlength=150 value="#choices['choice'][i]#">
			Image: <input type="file" name="image#i#"> 
			Break: <input type="Checkbox" <cfif choices['breakline'][i] eq '1'>checked</cfif> name="breakline#i#" value="1">
			<cfif choices['surveyChoiceID'][i] neq ''>
			  <input type="hidden" name="choice#i#" value="#choices['surveyChoiceID'][i]#">
			</cfif>
			</td>
			</tr>
			</cfloop>
	
	<tr>			
	<td colspan="2" align="left">
		<dd><b>(7)</b> <input type="submit" value="Save Your Question" name="submit">
		<br><br>
		</td>
		</tr>			</table>
		</cfoutput>

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
