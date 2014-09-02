<cfoutput>


<!--- GET TEMPLATE DETAILS --->
<cfquery name="qry_bizidea_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea 
WHERE BizIdeaID=#BizIdeaID#
</cfquery>

<!--- GET ALL FEEDBACK --->
<cfquery name="AllFeedback" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Feedback
WHERE Feedback_Type LIKE '%BusinessTemplate%'
AND LinkID=#BizIdeaID#
</cfquery>


<!--- CHECK FOR CURRENT USER FEEDBACK --->
<cfquery name="UserFeedbackCheck" dbtype="query">
SELECT *
FROM AllFeedback
WHERE ContactID=#session.UserID#
</cfquery>



<!--- DISPLAY --->

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td style="font-size:12px;"><span style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Rate this business template based on the following criteria...</strong></span><br><br>
&nbsp;&nbsp; - &nbsp; Can you understand the general concept?<br>
&nbsp;&nbsp; - &nbsp; Is it realistic for someone your age to take on this business?<br>
&nbsp;&nbsp; - &nbsp; Is the information provided enough for you to feel confident about running this business?<br><br></td>
</tr>

<tr>
<td><br>


<cfif UserFeedbackCheck.RecordCount>

	<script>
	alert("You have already rated this business template.");
	history.back(-1);
	</script>
	
	<cfabort>


<cfelse>


	
	<script language="JavaScript">
	<!--
	function validateRate(RateItForm) {
	
	if ((RateItForm.Feedback_rating[0].checked == false) && (RateItForm.Feedback_rating[1].checked == false) && (RateItForm.Feedback_rating[2].checked == false) && (RateItForm.Feedback_rating[3].checked == false) && (RateItForm.Feedback_rating[4].checked == false)) {
	alert("You must select a rating.");
	RateItForm.Feedback_rating[1].focus();
	return;
	}
	
	else if (RateItForm.Feedback_details.value == '') {
	alert("You must add some feedback.");
	RateItForm.Feedback_details.focus();
	return;
	}
	
	else {	
	RateItForm.submit();
	}
	
	}
	// -->
	</script>


	<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 1px ###TRIM(AllSettings.DkTextColor)#;">
	
	<tr>
	<td style="padding-left:10px;padding-top:10px;padding-bottom:10px;color:###TRIM(AllSettings.DkTextColor)#;"><strong>Business Template:</strong></td>
	<td style="padding-left:10px;padding-top:10px;padding-bottom:10px;color:###TRIM(AllSettings.DkTextColor)#;">#TRIM(qry_bizidea_details.biz_idea)#</td>
	</tr>
	
	<tr>
	<td height="1" width="150" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1" border="0"></td>
	<td height="1" width="100%" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;padding-top:10px;padding-bottom:10px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>Overview:</strong></td>
	<td style="padding-left:10px;padding-top:10px;padding-bottom:10px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top">#TRIM(qry_bizidea_details.biz_summary)#</td>
	</tr>
	
	<tr>
	<td height="1" width="150" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1" border="0"></td>
	<td height="1" width="100%" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
	</tr>
	
	<form method="post" action="#request.webroot#/feedback/act_add_rating.cfm" name="RateItForm" onsubmit="validateRate(RateItForm); return false;">
	
	<input type="hidden" name="Feedback_type" value="#type#">
	<input type="hidden" name="LinkID" value="#BizIdeaID#">
	<input type="hidden" name="Business" value="#TRIM(qry_bizidea_details.biz_idea)#">
	
	
	<tr>
	<td style="padding-left:10px;padding-top:10px;padding-bottom:10px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>Your Rating:</strong></td>
	<td style="padding-left:10px;padding-top:10px;padding-bottom:10px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top">
	
		<table width="100%" cellpadding="0" cellspacing="2" border="0">
		
		<tr>
		<td style="color:red;"><input type="radio" class="whitefield" name="Feedback_rating" value="5"> <img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Great!" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Great!" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Great!" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Great!" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Great!" border="0" align="absmiddle"></td>
		</tr>
		
		<tr>
		<td style="color:red;"><input type="radio" class="whitefield" name="Feedback_rating" value="4"> <img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Good" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Good" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Good" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Good" border="0" align="absmiddle"></td>
		</tr>
				
		<tr>
		<td style="color:red;"><input type="radio" class="whitefield" name="Feedback_rating" value="3"> <img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Average" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Average" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Average" border="0" align="absmiddle"></td>
		</tr>
				
		<tr>
		<td style="color:red;"><input type="radio" class="whitefield" name="Feedback_rating" value="2"> <img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Not so good" border="0" align="absmiddle"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - Not so good" border="0" align="absmiddle"></td>	
		</tr>
		
		<tr>
		<td style="color:red;"><input type="radio" class="whitefield" name="Feedback_rating" value="1"> <img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Rate It - No thanks!" border="0" align="absmiddle"></td>		
		</tr>
		
		</table>
	
	
	</td>
	</tr>
	
	<tr>
	<td height="1" width="150" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1" border="0"></td>
	<td height="1" width="100%" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;padding-top:10px;padding-bottom:10px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>Your Feedback:</strong></td>
	<td style="padding-left:10px;padding-top:10px;padding-bottom:10px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><textarea name="Feedback_details" class="whitefield" rows="6" style="width:350px;"></textarea><br><br>


	<input type="image" src="#request.imageroot#/add_button.gif" title="ADD NOW!">
	</td>
	</tr>
	
	
	
	
	
	</form>
	
	</table>
	



</cfif>


</td>
</tr>

</table>


</cfoutput>