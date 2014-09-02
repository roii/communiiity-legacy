<link rel="stylesheet" href="http://www.mykidsbiz.com/templates/survey_styles.css" type="text/css">
<cfquery  name="surveyDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * from forms,surveycom where forms.comid = surveycom.surveycomID
	and forms.formid = #trim(attributes.surveyid)# 
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
<cfquery  name="BuildQuestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * from questions where formid = #trim(attributes.surveyid)# order by displayorder
</cfquery>

    <cfset itemid1 = randrange(1,9999)>
	<cfset itemid2 = randrange(1,9999)>

<cfloop query="BuildQuestion">

<cfquery  name="Choices" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * from surveyChoice where qid = #BuildQuestion.id# 
</cfquery>
<cfset id = #BuildQuestion.id#>
<p>
<cfif Questiontype neq "7">
	<table width="650"><tr>
          <td style="vertical-align: middle; align:left;"><p><span class="subheader">#BuildQuestion.question#</span></p></td>
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
	    (Choose One) <br>
                     <tr>
               		<cfloop query="Choices">
					   <cfif Choices.breakline>
					   </tr><tr>
					   </cfif>
                           <td style="text-align:center">
                            <cfif choices.image neq ''>
                              <img src="#request.webroot#/surveyengine/images/#choices.image#"><br>
			                </cfif>
							<img src="http://www.mykidsbiz.com/images/tickbox.gif" align="absmiddle">&nbsp;#trim(Choices.choice)#&nbsp;&nbsp;
                           </td>
					</cfloop>
		</tr>
	</cfcase>	
	<cfcase value= "2">
	    (Multiple Selection) <br>
                     <tr>
               		<cfloop query="Choices">
					   <cfif Choices.breakline>
					   </tr><tr>
					   </cfif>
                           <td style="text-align:center">
                            <cfif choices.image neq ''>
                              <img src="#request.webroot#/surveyengine/images/#choices.image#"><br>
						    </cfif>
							<img src="http://www.mykidsbiz.com/images/tickbox.gif" align="absmiddle">&nbsp;#trim(Choices.choice)#&nbsp;&nbsp;
                         </td>
			</cfloop>
		     </tr>
	</cfcase>	
	<cfcase value= "3">
	    (Single Selection) <br>
		<cfloop query="Choices">
			<img src="http://www.mykidsbiz.com/images/tickbox.gif" align="absmiddle">&nbsp;#trim(Choices.choice)#&nbsp;&nbsp;
		</cfloop>
		<br>
	</cfcase>	
	<cfcase value= "4">
		(Multiple Selection) <br>
		<cfloop query="Choices">
			<img src="http://www.mykidsbiz.com/images/tickbox.gif" align="absmiddle">&nbsp;#trim(Choices.choice)#&nbsp&nbsp;
		</cfloop>
		<br>
	</cfcase>	
	<cfcase value= "5">
		<table class="textbox">
		<tr><td class="textbox">&nbsp;</td>
		</tr>
		</table><br>
	</cfcase>	
	<cfcase value= "6">
		<table class="textarea">
		<tr><td class="textarea">&nbsp;</td>
		</tr>
		</table><br>
	</cfcase>	
</cfswitch>	
</table>
</p>
<br>
</cfloop>
<tr><td class="header"><hr></td></tr>
</td></tr>

</table>
</cfoutput>