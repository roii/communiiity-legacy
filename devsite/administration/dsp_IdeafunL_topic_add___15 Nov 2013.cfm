<cfquery name="AllPartners" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Organisations.*
FROM Organisations
WHERE OrgCatID=5
AND Organisation_Status LIKE '%Active%'
ORDER BY Organisation_Name
</cfquery>

<script language="javascript" type="text/javascript">
	function intOnlyfn(i)
	{
		if(i.value.length>0)
		{
		     i.value = i.value.replace(/[^\d]+/g, '');
		}
	}
</script>

<cfquery name="qry_maincategory_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugMainCategory
ORDER BY Active DESC, DisplayOrder
</cfquery>

<cfquery name="qry_all_moderators" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName, Contacts.EmailAddress
FROM Contacts
WHERE Roles LIKE '2' OR Roles LIKE '2,%' OR Roles LIKE '%,2' OR Roles LIKE '%,2,%'
</cfquery>

<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(session.AllSettings_SiteName)# - Add IDEAfunL Topic</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add IDEAfunL Topic</strong></span></td>
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
	else if(AddTopic.Moderators.value == "" || AddTopic.Moderators.value == 0 || AddTopic.Moderators.value == "0") {
	    alert("Required: You must select the Moderator");
		AddTopic.Moderators.focus();
		return false; 
	}   		
	else {
		AddTopic.submit(); //submit form
		}
	}
	// -->
	</script>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="AddTopic" action="#request.webroot#/administration/act_add_ideafunl_topic.cfm" method="post" onSubmit="javascript:validate(AddTopic); return false;">

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Category</td>
	<td><select name="MainCatID" class="whitefield" style="width:300px;"> 
<cfloop query="qry_maincategory_stuff">
	<option value="#qry_maincategory_stuff.MainCatID#">#TRIM(qry_maincategory_stuff.MainCatTitle)#</option>
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
	<td><input type="text" name="Name" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Description</td>
	<td>
		<textarea name="Description" rows="30" cols="60"></textarea>
		<!---<cf_activedit name="Description" inc="#request.ActiveEditInc#" image="true" imagepath="#request.fileroot#\images\" imageURL="#request.imageroot#/" width="300" height="200" toolbar="hyperlink" tabview="yes" DEFAULTFONT="8pt Verdana"></cf_activedit>--->
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
	<option value="#AllPartners.OrganisationID#">#TRIM(AllPartners.Organisation_Name)#
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
	<td><input type="text" name="PointsAllocated" class="whitefield" style="width:300px;" onKeyDown="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" onKeyUp="intOnlyfn(this);"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">New Idea Cut-Off</td>
	<td><input type="text" name="PointsCutOff" class="whitefield" style="width:300px;" onKeyDown="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" onKeyUp="intOnlyfn(this);"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Finish Date</td>
	<td><input type="text" name="WhenCategoryEnded" class="whitefield" style="width:300px;" readonly="readonly"><a href="javascript:void(0)" onClick="if(self.gfPop)gfPop.fPopCalendar(document.AddTopic.WhenCategoryEnded);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Active</td>
	<td style="font-size:11px;"><input type="radio" name="Active" class="whitefield" value="1" checked> Yes &nbsp;&nbsp;&nbsp; <input type="radio" name="Active" class="whitefield" value="0"> No</td>
	</tr>

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Display Order</td>
	<td><input type="text" name="DisplayOrder" class="whitefield" style="width:300px;" onKeyDown="intOnlyfn(this);" onKeyPress="intOnlyfn(this);" onKeyUp="intOnlyfn(this);"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110" valign="top">Moderators</td>
	<td valign="top"><select multiple name="Moderators" class="whitefield" style="width:300px;" size="6">
	<option value="0" selected="true">--- Select a moderator ---</option>
	<cfloop query="qry_all_moderators">
	<option value="#qry_all_moderators.contactID#">#TRIM(qry_all_moderators.Firstname)# #TRIM(qry_all_moderators.Lastname)# (#TRIM(qry_all_moderators.Screenname)#)
	</cfloop>
	</select></td>
	</tr>

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"><br><br><strong>POINT AND VOTE SETTINGS</strong><br><br>
        
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Pending</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Pending" class="whitefield" value="1" checked> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Pending" class="whitefield" value="0"> No</td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300">Pending - Total Votes</td>
    	<td><input type="text" name="Total_Pending" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>
    	<td style="font-size:11px;" width="300">Pending - Required "Yes" votes to move forward</td>
    	<td><input type="text" name="Required_Pending" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Stage 1</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage1" class="whitefield" value="1" checked> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage1" class="whitefield" value="0"> No</td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 1 - Total Votes</td>
    	<td><input type="text" name="Total_Stage_1" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>
    	<td style="font-size:11px;" width="300">Stage 1 - Required "Yes" votes to move forward</td>
    	<td><input type="text" name="Required_Stage_1" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>
    	<td style="font-size:11px;" width="300">Stage 1 - Pts Reward</td>
    	<td><input type="text" name="Points_Stage_1" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 1 - Prize Entries</td>
    	<td><input type="text" name="Prize_Stage_1" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Stage 2</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage2" class="whitefield" value="1" checked> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage2" class="whitefield" value="0"> No</td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 2 - Total Votes</td>
    	<td><input type="text" name="Total_Stage_2" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 2 - Required "Yes" votes to move forward</td>
    	<td><input type="text" name="Required_Stage_2" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 2 - Pts Reward</td>
    	<td><input type="text" name="Points_Stage_2" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 2 - Prize Entries</td>
    	<td><input type="text" name="Prize_Stage_2" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Stage 3</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage3" class="whitefield" value="1" checked> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage3" class="whitefield" value="0"> No</td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 3 - Total Votes</td>
    	<td><input type="text" name="Total_Stage_3" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 3 - Required "Yes" votes to move forward</td>
    	<td><input type="text" name="Required_Stage_3" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 3 - Pts Reward</td>
    	<td><input type="text" name="Points_Stage_3" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Stage 3 - Prize Entries</td>
    	<td><input type="text" name="Prize_Stage_3" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
        
        <tr>
    	<td style="font-size:11px;" width="300"><strong>Use Winning</strong></td>
    	<td><input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage4" class="whitefield" value="1" checked> Yes &nbsp; <input type="radio" style="border:0px;background-color:transparent;" name="Use_Stage4" class="whitefield" value="0"> No</td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Winning Idea - Pts Reward</td>
    	<td><input type="text" name="Points_Stage_4" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Winning Idea - Prize Entries</td>
    	<td><input type="text" name="Prize_Stage_4" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Submit Idea Points</td>
    	<td><input type="text" name="Points_SubmitIdea" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Submit Idea Prize Entries</td>
    	<td><input type="text" name="Prize_SubmitIdea" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Vote Points</td>
    	<td><input type="text" name="Points_Vote" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Vote Prize Ent.</td>
    	<td><input type="text" name="Prize_Vote" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Feedback Points</td>
    	<td><input type="text" name="Points_Feedback" class="whitefield" style="width:100px;"></td>
    	</tr>
    	
    	<tr>    	
    	<td style="font-size:11px;" width="300">Feedback Prize Ent.</td>
    	<td><input type="text" name="Prize_Feedback" class="whitefield" style="width:100px;"></td>
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
	<td><input type="submit" value="ADD TOPIC NOW >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
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