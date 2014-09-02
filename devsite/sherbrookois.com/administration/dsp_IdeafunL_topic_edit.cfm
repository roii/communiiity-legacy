<cfquery name="AllPartners" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Organisations.*
FROM Organisations
WHERE OrgCatID=5
AND Organisation_Status LIKE '%Active%'
ORDER BY Organisation_Name
</cfquery>

<cfquery name="qry_maincategory_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugMainCategory
ORDER BY Active DESC, DisplayOrder
</cfquery>

<cfquery name="qry_category_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugCategory
WHERE CategoryID=#CategoryID#
</cfquery>

<cfquery name="qry_all_moderators" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName, Contacts.EmailAddress
FROM Contacts
WHERE Roles LIKE '2' OR Roles LIKE '2,%' OR Roles LIKE '%,2' OR Roles LIKE '%,2,%'
</cfquery>

<cfquery name="qry_stage_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM idea_topic_settings
WHERE TopicID=#CategoryID#
</cfquery>


<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(session.AllSettings_SiteName)# - Edit IDEAfunL Topic</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit IDEAfunL Topic</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
		
	<script language="JavaScript">
	<!--
	function validate(AddTopic) {    
		
	
	if (AddTopic.Name.value == "") {
		alert("You must enter a Title for this topic.");
		AddTopic.Name.focus();
		return;
		} 
		
	else if (AddTopic.Description.value == "") {
		alert("You must enter a description.");
		AddTopic.Description.focus();
		return;
		}
		
	else if (AddTopic.SponsorID.selectedIndex == "0") {
		alert("You must select a Sponsor.");
		AddTopic.SponsorID.focus();
		return;
		}
		
	else if (AddTopic.PointsAllocated.value == "") {
		alert("You must enter the amount of points allocated.");
		AddTopic.PointsAllocated.focus();
		return;
		}
		
	else if (AddTopic.PointsCutOff.value == "") {
		alert("You must enter the amount of points that can\nbe earned before the \"Add New idea\" function is disabled.");
		AddTopic.PointsCutOff.focus();
		return;
		}
		
	else if (AddTopic.WhenCategoryEnded.value == "") {
		alert("You must enter the date this topic expires.");
		AddTopic.WhenCategoryEnded.focus();
		return;
		}
		
	else {
		AddTopic.submit(); //submit form
		}
	}
	// -->
	</script>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="AddTopic" action="#request.webroot#/administration/act_edit_ideafunl_topic.cfm" method="post" onsubmit="javascript:validate(AddTopic); return false;">
	
	<input type="hidden" name="CategoryID" value="#CategoryID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Category</td>
	<td><select name="MainCatID" class="whitefield" style="width:300px;"> 
<cfloop query="qry_maincategory_stuff">
	<option value="#qry_maincategory_stuff.MainCatID#"<cfif qry_maincategory_stuff.MainCatID EQ qry_category_stuff.MainCatID> selected</cfif>>#TRIM(qry_maincategory_stuff.MainCatTitle)#</option>
</cfloop>
</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Topic Title</td>
	<td><input type="text" name="Name" class="whitefield" style="width:300px;" value="#TRIM(qry_category_stuff.Name)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Description</td>
	<td>
		<textarea name="Description" rows="25" cols="40">#TRIM(qry_category_stuff.Description)#</textarea>
		<!---<cf_activedit name="Description" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="300" height="200" toolbar="hyperlink" tabview="yes" DEFAULTFONT="8pt Verdana">#TRIM(qry_category_stuff.Description)#</cf_activedit>--->
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Sponsor</td>
	<td><select name="SponsorID" class="whitefield" style="width:300px;">
	<option value="0">-- Select a Sponsor --
	<cfloop query="AllPartners">
	<option value="#AllPartners.OrganisationID#"<cfif qry_category_stuff.SponsorID EQ AllPartners.OrganisationID> selected</cfif>>#TRIM(AllPartners.Organisation_Name)#
	</cfloop>
	</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Points Cap</td>
	<td><input type="text" name="PointsAllocated" class="whitefield" style="width:300px;" value="#TRIM(qry_category_stuff.PointsAllocated)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Finish Date</td>
	<td><input type="text" name="WhenCategoryEnded" class="whitefield" style="width:300px;" value="#DateFormat(qry_category_stuff.WhenCategoryEnded, "dd/mm/yyyy")#"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.AddTopic.WhenCategoryEnded);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Active</td>
	<td style="font-size:11px;"><input type="radio" style="border:0px;background-color:transparent;" name="Active" class="whitefield" value="1"<cfif qry_category_stuff.Active EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Active" class="whitefield" value="0"<cfif qry_category_stuff.Active EQ 0> checked</cfif>> No</td>
	</tr>

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Show Add Idea</td>
	<td style="font-size:11px;"><input type="radio" style="border:0px;background-color:transparent;" name="ShowAdd" class="whitefield" value="1"<cfif qry_category_stuff.ShowAdd EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="ShowAdd" class="whitefield" value="0"<cfif qry_category_stuff.ShowAdd EQ 0> checked</cfif>> No</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Display Order</td>
	<td><input type="text" name="DisplayOrder" class="whitefield" style="width:300px;" value="#qry_category_stuff.DisplayOrder#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110" valign="top">Moderators</td>
	<td valign="top"><select name="Moderators" size="6" multiple class="whitefield" style="width:300px;">
	<cfloop query="qry_all_moderators">
	<option value="#qry_all_moderators.contactID#"<cfif ListFind(qry_category_stuff.Moderators, qry_all_moderators.contactID, ",")> selected</cfif>>#TRIM(qry_all_moderators.Firstname)# #TRIM(qry_all_moderators.Lastname)# (#TRIM(qry_all_moderators.Screenname)#)
	</cfloop>
	</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"><br><br><strong>POINT AND VOTE SETTINGS</strong><br><br>
        
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Pending</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Pending" class="whitefield" value="1"<cfif qry_stage_details.Use_Pending EQ 1> checked</cfif>> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Pending" class="whitefield" value="0"<cfif qry_stage_details.Use_Pending NEQ 1> checked</cfif>> No</td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300">Pending - Total Votes</td>
    	<td><input type="text" name="Total_Pending" class="whitefield" style="width:100px;" value="#qry_stage_details.Total_Pending#"></td>
    	</tr>
    	
    	<tr>
    	<td style="font-size:11px;" width="300">Pending - Required "Yes" votes to move forward</td>
    	<td><input type="text" name="Required_Pending" class="whitefield" style="width:100px;" value="#qry_stage_details.Required_Pending#"></td>
    	</tr>
    	
    	<tr>
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Stage 1</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage1" class="whitefield" value="1"<cfif qry_stage_details.Use_Stage1 EQ 1> checked</cfif>> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage1" class="whitefield" value="0"<cfif qry_stage_details.Use_Stage1 NEQ 1> checked</cfif>> No</td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 1 - Total Votes</td>
    	<td><input type="text" name="Total_Stage_1" class="whitefield" style="width:100px;" value="#qry_stage_details.Total_Stage_1#"></td>
    	</tr>
    	
    	<tr>
    	<td style="font-size:11px;" width="300">Stage 1 - Required "Yes" votes to move forward</td>
    	<td><input type="text" name="Required_Stage_1" class="whitefield" style="width:100px;" value="#qry_stage_details.Required_Stage_1#"></td>
    	</tr>
    	
    	<tr>
    	<td style="font-size:11px;" width="300">Stage 1 - Pts Reward</td>
    	<td><input type="text" name="Points_Stage_1" class="whitefield" style="width:100px;" value="#qry_stage_details.Points_Stage_1#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 1 - Prize Entries</td>
    	<td><input type="text" name="Prize_Stage_1" class="whitefield" style="width:100px;" value="#qry_stage_details.Prize_Stage_1#"></td>
    	</tr>
    	
    	<tr>    	
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Stage 2</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage2" class="whitefield" value="1"<cfif qry_stage_details.Use_Stage2 EQ 1> checked</cfif>> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage2" class="whitefield" value="0"<cfif qry_stage_details.Use_Stage2 NEQ 1> checked</cfif>> No</td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 2 - Total Votes</td>
    	<td><input type="text" name="Total_Stage_2" class="whitefield" style="width:100px;" value="#qry_stage_details.Total_Stage_2#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 2 - Required "Yes" votes to move forward</td>
    	<td><input type="text" name="Required_Stage_2" class="whitefield" style="width:100px;" value="#qry_stage_details.Required_Stage_2#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 2 - Pts Reward</td>
    	<td><input type="text" name="Points_Stage_2" class="whitefield" style="width:100px;" value="#qry_stage_details.Points_Stage_2#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 2 - Prize Entries</td>
    	<td><input type="text" name="Prize_Stage_2" class="whitefield" style="width:100px;" value="#qry_stage_details.Prize_Stage_2#"></td>
    	</tr>
    	
    	<tr>    	
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Stage 3</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage3" class="whitefield" value="1"<cfif qry_stage_details.Use_Stage3 EQ 1> checked</cfif>> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage3" class="whitefield" value="0"<cfif qry_stage_details.Use_Stage3 NEQ 1> checked</cfif>> No</td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 3 - Total Votes</td>
    	<td><input type="text" name="Total_Stage_3" class="whitefield" style="width:100px;" value="#qry_stage_details.Total_Stage_3#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 3 - Required "Yes" votes to move forward</td>
    	<td><input type="text" name="Required_Stage_3" class="whitefield" style="width:100px;" value="#qry_stage_details.Required_Stage_3#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 3 - Pts Reward</td>
    	<td><input type="text" name="Points_Stage_3" class="whitefield" style="width:100px;" value="#qry_stage_details.Points_Stage_3#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 3 - Prize Entries</td>
    	<td><input type="text" name="Prize_Stage_3" class="whitefield" style="width:100px;" value="#qry_stage_details.Prize_Stage_3#"></td>
    	</tr>
    	
    	<tr>    	
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Winning</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage4" class="whitefield" value="1"<cfif qry_stage_details.Use_Stage4 EQ 1> checked</cfif>> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage4" class="whitefield" value="0"<cfif qry_stage_details.Use_Stage4 NEQ 1> checked</cfif>> No</td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Winning Idea - Pts Reward</td>
    	<td><input type="text" name="Points_Stage_4" class="whitefield" style="width:100px;" value="#qry_stage_details.Points_Stage_4#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Winning Idea - Prize Entries</td>
    	<td><input type="text" name="Prize_Stage_4" class="whitefield" style="width:100px;" value="#qry_stage_details.Prize_Stage_4#"></td>
    	</tr>
    	
    	<tr>    	
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Submit Idea Points</td>
    	<td><input type="text" name="Points_SubmitIdea" class="whitefield" style="width:100px;" value="#qry_stage_details.Points_SubmitIdea#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Submit Idea Prize Entries</td>
    	<td><input type="text" name="Prize_SubmitIdea" class="whitefield" style="width:100px;" value="#qry_stage_details.Prize_SubmitIdea#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Vote Points</td>
    	<td><input type="text" name="Points_Vote" class="whitefield" style="width:100px;" value="#qry_stage_details.Points_Vote#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Vote Prize Ent.</td>
    	<td><input type="text" name="Prize_Vote" class="whitefield" style="width:100px;" value="#qry_stage_details.Prize_Vote#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Feedback Points</td>
    	<td><input type="text" name="Points_Feedback" class="whitefield" style="width:100px;" value="#qry_stage_details.Points_Feedback#"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Feedback Prize Ent.</td>
    	<td><input type="text" name="Prize_Feedback" class="whitefield" style="width:100px;" value="#qry_stage_details.Prize_Feedback#"></td>
    	</tr>
    
        </table>
        
    </td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" value="UPDATE TOPIC NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table><br><br>


	
</td>
</tr>

</table>
<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/administration/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>
</body>
</html>

</cfoutput>