<script language="JavaScript">
	function typeselect(type) {
	   if(type=='online') {
	     document.forms.AddSurvey.price.value="0.0"; 
	   }
	   else {
	     document.forms.AddSurvey.price.value="0.5";
	   }
	}
</script>
	
<cfquery name="SurveyDetails" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * FROM forms,surveycom where forms.comid = surveycom.surveycomID and formid=#attributes.surveyid#
</cfquery>

<cfquery name="AllComs" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT 	* FROM 	surveyCom order by surveyComID
</cfquery>


<cfoutput>
 
<br>


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT SURVEY</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	</tr>
	</table>
	
	<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<cfform name="AddSurvey" action="#request.webroot#/surveyengine/act_edit_survey.cfm" method="post">
			
			<tr>
			<td style="color:404040;">Title</td>
			<td><cfinput type="text" required="Yes" value="#SurveyDetails.title#" message="Please enter survey title first" name="surveyTitle" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Description</td>
			<td><textarea name="Description" rows="6" cols="30">#SurveyDetails.description#</textarea></td>
			</tr>

			<tr>
			<td style="color:404040;">Company</td>
			<td>
			<select name="comID" size="1">
			<option value="AllComs">Please select a company</option>
			<cfloop query="AllComs">
			  <option value="#AllComs.surveyComID#" <cfif SurveyDetails.comid EQ AllComs.surveyComid>selected</cfif>>#AllComs.comName#</option>
			</cfloop>
			</td>
			</tr>
	
			<tr>
			<td style="color:404040;">Survey Type</td>
			<td><input type="radio" name="online" onclick="Javascript:typeselect('online')" value="1" <cfif #SurveyDetails.online# GT 0>checked</cfif>>Online <input type="radio" name="online" onclick="Javascript:typeselect('paperbased')" value="0" <cfif #SurveyDetails.online# EQ 0>checked</cfif>>Paper-Based
			</td>
			</tr>

			<tr>
			<td style="color:404040;">Cost Per Survey</td>
			<td>$<cfinput type="text" name="price" value="#SurveyDetails.price#" class="whitefield" style="width:50px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Number Required</td>
			<td><cfinput type="text" name="NoNeeded" value="#SurveyDetails.noNeeded#" class="whitefield" message="Please enter numbers only for No. required" validate="float" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
            
			<tr>
			<td style="color:404040;">Status</td>
			<td><input type="radio" name="status" value="1" <cfif #SurveyDetails.verified# GT 0>checked</cfif>>Open <input type="radio" name="status" value="0" <cfif #SurveyDetails.verified# EQ 0>checked</cfif>>Closed
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Deadline</td>
			<td><cfinput type="text" value="#dateformat(SurveyDetails.deadline,"dd/mm/yyyy")#" name="deadline" required="Yes" class="whitefield" validate="eurodate" message="please enter survey deadline" style="width:250px; border-color:a0d8e0;">
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.AddSurvey.deadline);return false;" HIDEFOCUS>
			<img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a>
			</td></tr>

			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>			
			
			<tr>
			<td style="color:404040;"> </td>
			<td>
			<input type="hidden" name="formid" value="#SurveyDetails.formid#">
			<input type="submit" class="whitefield" style="border-color:a0d8e0;" value="SAVE NOW!"></td>
			</tr>
			</cfform>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>
<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/members/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>

</cfoutput>