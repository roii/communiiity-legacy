
 <cfoutput>
 

	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>Market Research Survey</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	</tr>
	</table>
	
	<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<cfquery name="All_questions" datasource="#dsn#" username="#request.username#" password="#request.password#">
				select * from surveyQuestions
			</cfquery>
			
			<form name="ClientReg" action="#request.webroot#/projects/act_survey_form.cfm" method="post">
			
			<tr>
			<td style="color:404040;">First Name</td>
			<td style="color:404040;">Last Name</td>
			<td style="color:404040;">Email Address</td>
			<cfloop query="All_questions">
			<td>#All_questions.question#</td>
			</cfloop>
			</tr>
			
			<cfloop from="1" to="1" index="i">
			<tr>
			<td><input type="text" name="FirstName#i#" class="whitefield" style="width:100px; border-color:a0d8e0;"></td>
			<td><input type="text" name="LastName#i#" class="whitefield" style="width:100px; border-color:a0d8e0;"></td>
			<td><input type="text" name="EmailAddress#i#" class="whitefield" style="width:150px; border-color:a0d8e0;"></td>
			<td><input type="radio" name="Q1#i#" value="1">Yes <input type="radio" name="Q1#i#" value="0">No</td>
			<td><input type="radio" name="Q2#i#" value="1">Yes <input type="radio" name="Q2#i#" value="0">No</td>
			<td><input type="radio" name="Q3#i#" value="1">Yes <input type="radio" name="Q3#i#" value="0">No</td>
			</tr>
			<tr>
			<td colspan="6" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>	
			</cfloop>
		
			<tr>
			<td colspan="6"><input type="submit" class="whitefield" style="border-color:a0d8e0;" value="Submit Survey"></td>
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