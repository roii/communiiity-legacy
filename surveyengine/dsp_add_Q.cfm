<cfif not isdefined("attributes.surveyID")>
<script>
self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_survey&at=1";
</script>
</cfif>
<cfparam name="attributes.wizard" default="on">
<script language="JavaScript">
function validateform(thisform) {
  var qtype=document.myform.questiontype;
  
  if(document.myform.question.value == '') {
    alert("Please enter the question first!");
    document.myform.question.focus();
    return false;
  }
  if (qtype.selectedIndex==0){
		alert("Please select a question type first!");
		qtype.focus();
		return false;
  }
  thisform.submit(); 
}
</script>

<cfquery  datasource="#datasourceW#" name="surveyDetails" username="mykidsbizcomi" password="u+67eNfJ">
    select * from forms where forms.formid=#attributes.surveyid#
</cfquery>

<cfquery  datasource="#datasourceW#" name="Qlist" username="mykidsbizcomi" password="u+67eNfJ">
    select * from questions,surveyQType where surveyQType.questionTypeID=questions.questionType
    and questions.formid=#attributes.surveyid# order by displayorder
</cfquery>

<script language="JavaScript">
	function confirmDelete(aURL) {
	    if(confirm('Are you sure you want to delete this question?')) {
	      location.href = aURL;
	    }
	  }
</script>

<cfoutput>
<cfif attributes.wizard eq 'on'>
<br>
<TABLE class="reg">
  <TR>
    <TD WIDTH="100%" CLASS="steps">
      <IMG BORDER="0" SRC="#request.webroot#/images/1off.gif" align="absmiddle">&nbsp;   
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_survey&at=1">Add Survey</a>&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp;            
      <IMG BORDER="0" SRC="#request.webroot#/images/2off.gif" align="absmiddle">&nbsp; 
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_term&surveyid=#attributes.surveyID#&at=4">Add Terms</a>&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/3on.gif" align="absmiddle">&nbsp;            
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_Q&surveyid=#attributes.surveyID#&at=5">Add Questions</a> &nbsp;
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/4off.gif" align="absmiddle">&nbsp;            
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=survey_page&surveyid=#attributes.surveyID#&at=1">Complete Survey</a>
      </TD>           
  </TR>
</table>
<br>
</cfif>
</cfoutput>

<cfif Qlist.recordcount GT 0>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0">
	<tr bgColor="a0d8e0">
         <td width="250"><b>Question</b></td>
         <td width="150"><b>Question Type</b></td>
         <td width="150"><b>Image</b></td>
	 <td width="150"><b>Date</b></td>
	 <td width="250"><b>Action</b></td>
       </tr>

    <cfoutput query="Qlist">
       <tr bgColor="e3f4f6">
	 <td>#Qlist.question#</td>
	 <td>#Qlist.type#</td>
         <td><cfif Qlist.image NEQ ''><img src="#request.webroot#/surveyengine/images/#Qlist.image#" width="100" height="100"></cfif></td>
         <td>#dateformat(Qlist.datein,"dd/mmm/yyyy")#</td>
	 <td>
          [<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=edit_q&Qid=#Qlist.id#&at=5&surveyid=#attributes.surveyid#">Edit</a>]  
          [<a href="javascript:confirmDelete('#request.webroot#/surveyengine/act_del_Q.cfm?Qid=#Qlist.id#&surveyid=#attributes.surveyid#')">Delete</a>]
	</td>
       </tr>
    </cfoutput>
  </table>
</cfif>

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

<form action="default.cfm?fuseaction=act_add_Q" method="POST" name="myform" enctype="multipart/form-data">
<input type="hidden" name="wizard" value="#attributes.wizard#">
<h3>#surveyDetails.title#</h3>

<table border="#tableborder#" cellpadding="3" cellspacing="0">
<tr><td valign="top">

<table width="500" border="#tableborder#" cellpadding="0" cellspacing="0" bgcolor="#bgcolor2#">
<tr><td align="center" bgcolor="#bgcolor1#">
	<font #fontstyle#><b>Question Editor</b></font>
</td></tr>
<tr><td align="center" bgcolor="#bgcolor2#">
<br>

</cfoutput>


<!--- Insert Action --->
		
		<cfoutput>

		<input type="Hidden" name="formid" value="#surveyid#">
		<table align="center" width="670" border="#tableborder#" style="padding-left:5px;" cellpadding="0" cellspacing="0" bgcolor="#bgcolor2#">
		<tr>	
			<td colspan=2 align="left">
			<font face="Arial" size="-1" color="Black"><b>(1) Question: (HTML supported)</b></font>
			<BR><textarea name="question" cols="55" rows="3"></textarea></td>
		</tr>
		<tr>
			<td nowrap align="left" colspan="2">
			<font face="Arial" size="-1" color="Black"><b>(3) Type of question:</b></font>
				<select name="questiontype">
				<option value="">Choose a type
				<option value="1">Radio Buttons (single selection)
				<option value="2">Checkboxes (multiple selection)
				<option value="3">Single Select Box (drop down list)
				<option value="4">Multiple Select Box (multiple selection)
				<option value="5">Text Box (open question single line)
				<option value="6">Text Area (open question multiple lines)
				<option value="7">HTML (Survey Description)
				<!---<cfif session.accesslevel gt 3>
					<option value="7">Hidden (will not be dispplayed)				
				</cfif>--->
				</select>
			</td>
		</tr>
		<tr>
			<td colspan=2 align="left">
			<font face="Arial" size="-1" color="Black"><b>(4) Question Image: </b></font>
			<input type="file" name="file_location" size="55"></td>
		
		</tr>
			
		
			<cfloop from="1" to="#NoofQ#" index="i">
			<tr>			
			<td align="left" nowrap>
				<font #fontstyle1#>Option#i#:</font>
			</td>
			<td align="left" nowrap>
			<input type="Text" name="option#i#" size=50 maxlength=150>
			Image: <input type="file" name="image#i#">
			</td>
			</tr>
			</cfloop>
	
	<tr>			
	<td colspan="2" align="left">
		<dd><b>(5)</b> <input type="Button" value="Add Your Question" onclick="validateform(myform)">
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
