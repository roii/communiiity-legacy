<script language="JavaScript">
	function confirmDelete(aURL) {
	    if(confirm('This will delete this survey plus all its questions and responses!')) {
	      location.href = aURL;
	    }
	  }
	function typeselect(type) {
	   if(type=='online') {
	     document.forms.AddSurvey.price.value="0.0"; 
	   }
	   else {
	     document.forms.AddSurvey.price.value="0.5";
	   }
	}
</script>

<link rel="stylesheet" type="text/css" href="http://www.my3p.com/templates/survey_styles.css">
<cfquery name="AllSurveys" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * FROM forms,surveycom where forms.comid = surveycom.surveycomID order by formID desc
</cfquery>

<cfquery name="AllComs" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT 	* FROM 	surveyCom order by surveyComID
</cfquery>


<cfif AllSurveys.recordcount GT 0>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" class="list">
       <tr class="header">
         <td width="150"><b>Survey Title</b></td>
         <td width="80"><b>Type</b></td>
         <td width="80"><b>Date Added</b></td>
	 <td width="100"><b>Company</b></td>
	 <td width="50"><b>No.Req'd</b></td>
	 <td width="50"><b>No.Done</b></td>
	 <td width="80"><b>Deadline</b></td>
	 <td width="50"><b>Status</b></td>
	 <td width="220"><b>Action</b></td>
       </tr>

    <cfoutput query="AllSurveys">
       <tr bgColor="e3f4f6">
         <td><a href="#request.webroot#/surveyengine/default.cfm?fuseaction=survey_page&surveyid=#AllSurveys.formid#&at=1">#AllSurveys.title#</a></td>
         <td><cfif #AllSurveys.online# GT 0>Online<cfelse>Paper-Based</cfif></td>
	 <td>#dateformat(AllSurveys.datein,"dd/mmm/yyyy")#</td>
	 <td>#AllSurveys.comName#</td>
	 <td>#AllSurveys.NoNeeded#</td>
	 <td>#AllSurveys.NoDone#</td>
	 <td>#Dateformat(AllSurveys.deadline,"dd/mmm/yyyy")#</td>
	 <td><cfif #AllSurveys.verified# GT 0>Open<cfelse>Closed</cfif></td>
	 <td>
          [<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=edit_survey&surveyid=#AllSurveys.formid#&at=1">Edit</a>]  
          [<a href="javascript:confirmDelete('#request.webroot#/surveyengine/act_del_survey.cfm?formid=#AllSurveys.formid#')">Delete</a>]
	  [<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_term&surveyid=#AllSurveys.formid#&at=4">Terms</a>]
          [<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_Q&surveyid=#AllSurveys.formid#&at=5">Question</a>]
          <!---[<a href="#request.webroot#/surveyengine/dsp_survey_form.cfm?surveyid=#AllSurveys.formid#" target="_blank">Survey Form</a>]--->
	</td>
       </tr>
    </cfoutput>
  </table>
</cfif>

<cfoutput>
 
<br>
<TABLE class="reg">
  <TR>
    <TD WIDTH="100%" CLASS="steps"><IMG BORDER="0" SRC="#request.webroot#/images/1on.gif" align="absmiddle">&nbsp;   
      Add Survey&nbsp; <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp;            
      <IMG BORDER="0" SRC="#request.webroot#/images/2off.gif" align="absmiddle">&nbsp; Add Terms&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp; <IMG BORDER="0" SRC="#request.webroot#/images/3off.gif" align="absmiddle">&nbsp;            
      Add Questions &nbsp;
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp; <IMG BORDER="0" SRC="#request.webroot#/images/4off.gif" align="absmiddle">&nbsp;            
      Complete Survey
      </TD>           
  </TR>
</table>

<br>		


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>ADD A NEW SURVEY</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
			
			<cfform name="AddSurvey" action="#request.webroot#/surveyengine/act_add_survey.cfm" method="post">
			<tr>
			<td style="color:404040;">Title</td>
			<td><cfinput type="text" required="Yes" message="Please enter survey title first" name="surveyTitle" class="whitefield" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Description</td>
			<td><textarea name="Description" rows="6" cols="30"></textarea></td>
			</tr>

			<tr>
			<td style="color:404040;">Company</td>
			<td>
			<select name="comID" size="1">
			<option value="AllComs">Select a company</option>
			<cfloop query="AllComs">
			  <option value="#AllComs.surveyComID#">#AllComs.comName#</option>
			</cfloop>
			</select>
			<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_com&at=2">Add Company</a>
			</td>
			</tr>
			<tr>
			<td style="color:404040;">Survey Type</td>
			<td><input type="radio" name="online" value="1" onclick="Javascript:typeselect('online')" checked>Online <input type="radio" name="online" onclick="Javascript:typeselect('paperbased')" value="0">Paper-Based
			</td>
			</tr>
			<tr>
			<td style="color:404040;">Cost Per Survey</td>
			<td>$<cfinput type="text" name="price" value="0.0" class="whitefield" style="width:50px; border-color:a0d8e0;"></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Number Required</td>
			<td><cfinput type="text" name="NoNeeded" required="Yes" class="whitefield" message="Please enter Number required" style="width:250px; border-color:a0d8e0;"></td>
			</tr>
            
			<tr>
			<td style="color:404040;">Status</td>
			<td><input type="radio" name="status" value="1" checked>Open <input type="radio" name="status" value="0">Closed
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Deadline</td>
			<td><cfinput type="text" name="deadline" required="Yes" class="whitefield" validate="eurodate" message="please enter survey deadline" style="width:250px; border-color:a0d8e0;">
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.AddSurvey.deadline);return false;" HIDEFOCUS>
			<img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a>
			</td></tr>

			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>			
			
			<tr>
			<td style="color:404040;"> </td>
			<td>
			<cfset itemid = randrange(1,99999999)>
			<input type="hidden" name="itemid" value="#itemid#">
			<input type="hidden" name="vendorid" value="#vendorid#">
			<input type="submit" class="whitefield" style="border-color:a0d8e0;" value="Create Survey"></td>
			</tr>
			</cfform>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>
<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/kidzbiz/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>

</cfoutput>