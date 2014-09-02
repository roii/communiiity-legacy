<link rel="stylesheet" href="http://www.my3p.com/templates/survey_styles.css" type="text/css">
<script language="JavaScript">
		function valradioB(thisform) {
			 for (i=0; i<thisform.elements.length; i++) {
                type=thisform.elements[i].type;
				Bname=thisform.elements[i].name;
                  if (type == 'radio') {
    					myOption = -1;
						for (j=0; j<thisform.elements[Bname].length; j++) {
						  if (thisform.elements[Bname][j].checked) {
  						    myOption = j;
						  }
						}
						if (myOption == -1) {
						   alert("You've missed a single choice question!");
						  return false;
						}
					}
				}
				thisform.submit(); 
			}
</script>

<cfquery  name="surveyDetails" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * from forms,surveycom where forms.comid = surveycom.surveycomID
	and forms.formid = #trim(attributes.surveyid)# 
</cfquery>

<cfquery  name="BuildQuestion" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * from questions where formid = #trim(attributes.surveyid)# order by displayorder
</cfquery>

<cfoutput>
<table>
<tr><td class="header">
<center>
<cfif surveyDetails.comlogo neq ''>
  <p><img src="#request.webroot#/surveyengine/images/#surveyDetails.comlogo#" border=0></p>
<cfelse>
  <h3>#surveyDetails.comName#</h3>
</cfif>
<h3>#surveyDetails.title#</h3>
</center>
<hr>
</td></tr>
<tr><td>
    <cfset itemid1 = randrange(1,9999)>
	<cfset itemid2 = randrange(1,9999)>
	<cfform action="act_survey_form.cfm" name="surveyForm" method="post">
	<input type="hidden" name="surveyid" value="#surveyid#">
    <input type="hidden" name="itemid" value="#itemid1##itemid2#">
	<input type="hidden" name="formid" value="#surveyid#">
<cfloop query="BuildQuestion">

<cfquery  name="Choices" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * from surveyChoice where qid = #BuildQuestion.id# 
</cfquery>
<cfset id = #BuildQuestion.id#>
<cfif Questiontype neq "7">
	<table><tr>
          <td style="vertical-align: middle;"><p><span class="subheader">#BuildQuestion.question#</span></p></td>
           <cfif BuildQuestion.image neq ''><td>
            <img src="#request.webroot#/surveyengine/images/#BuildQuestion.image#">   
 	   </td></cfif>
         </tr></table>
<cfelseif Questiontype eq "7">
 <p>#BuildQuestion.question#</p>
</cfif>	
<table class="survey">
<cfswitch expression="#Questiontype#">
	<cfcase value="1">
                     <tr>
               		<cfloop query="Choices">
					   <cfif Choices.breakline>
					   </tr><tr>
					   </cfif>
                           <td style="text-align:center">
                            <cfif choices.image neq ''>
                              <img src="#request.webroot#/surveyengine/images/#choices.image#"><br>
			    			</cfif>
							<input type="radio" name="Variable#id#" value="#Choices.surveyChoiceID#">#trim(Choices.choice)#
                           </td>
					</cfloop>
		     </tr>

	</cfcase>	
	<cfcase value= "2">
             <tr>
               		<cfloop query="Choices">
					    <cfif Choices.breakline>
					   </tr><tr>
					   </cfif>
                           <td style="text-align:center">
                            <cfif choices.image neq ''>
                              <img src="#request.webroot#/surveyengine/images/#choices.image#"><br>
						    </cfif>
							<input type="checkbox" name="Variable#id#" value="#Choices.surveyChoiceID#">#trim(Choices.choice)#
                           </td>
					</cfloop>
		     </tr>
	</cfcase>	
	<cfcase value= "3">
		<cfselect name="Variable#id#" required="Yes" message="You've missed a question!">
		<option value="0">Please make your selection
		<cfloop query="Choices">
			<option value="#Choices.surveyChoiceID#">#trim(Choices.choice)#
		</cfloop>
		</cfselect>
		<br>
	</cfcase>	
	<cfcase value= "4">
		<cfselect name="Variable#id#" multiple required="Yes" message="You've missed a question!">
		<cfloop query="Choices">
			<option value="#Choices.surveyChoiceID#">#trim(Choices.choice)#
		</cfloop>
		</cfselect>
		<br>
	</cfcase>	
	<cfcase value= "5">
		<input type="text" name="Variable_#id#" size=70><br>
	</cfcase>	
	<cfcase value= "6">
		<textarea name="Variable_#id#" cols=70 rows=5></textarea><br>
	</cfcase>	
</cfswitch>	
</table>
<br>		
</cfloop>
<input type="Button" onclick="valradioB(surveyForm)" value="Submit">
</cfform>
</td></tr>
<tr><td class="header"><hr></td></tr>

</table>

</cfoutput>