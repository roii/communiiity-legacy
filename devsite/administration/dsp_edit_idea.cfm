<cfquery name="Category" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugCategory
WHERE Active=1
</cfquery>

<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Suggestion
WHERE SugID=#SugID#
</cfquery>

<cfquery name="memberstuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Firstname, Lastname, EmailAddress
FROM Contacts
WHERE ContactID=#IdeaStuff.ContactID#
</cfquery>

<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Update Idea</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Update Idea</strong></span></td>
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
	function validateIdea(EditIdea) {    
	
	if (EditIdea.suggestion.value == "") {
		alert("You must enter an Idea Title.");
		EditIdea.suggestion.focus();
		return;
		} 
		
	else {
		ae_onSubmit();
		EditIdea.submit();
		}
	}
	</script>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="EditIdea" action="#request.webroot#/administration/act_edit_idea.cfm" method="post">
	
	<input type="hidden" name="sugID" value="#sugID#">
	
	<cfif isDefined("winnerIdeas")>
		<input type="hidden" name="winnerIdeas" value="1">
	</cfif>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Made By:</td>
	<td style="font-size:11px;">#TRIM(memberstuff.Firstname)# #TRIM(memberstuff.Lastname)#<br>
	#TRIM(memberstuff.EmailAddress)#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Idea Title</td>
	<td><input type="text" name="suggestion" class="whitefield" style="font-size:11px;width:300px;" value="#Replace(TRIM(IdeaStuff.suggestion), '"', '&quot;', "ALL")#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110" valign="top">Details</td>
	<td><textarea name="Details" class="whitefield" rows="5" style="font-size:11px;width:300px;">#TRIM(IdeaStuff.Details)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Category</td>
	<td><select name="CategoryID" class="whitefield" style="font-size:11px;width:300px;">
	<cfloop query="Category">
	<option value="#Category.categoryID#"<cfif IdeaStuff.CategoryID EQ Category.categoryID> selected</cfif>>#TRIM(Category.Name)#
	</cfloop>
	</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Stage</td>
	<td><select name="SugStage" class="whitefield" style="font-size:11px;width:300px;">
	<option value="Pending"<cfif TRIM(ideaStuff.SugStage) EQ 'Pending'> selected</cfif>>Pending
	<option value="Stage 1"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 1'> selected</cfif>>Stage 1
	<option value="Stage 2"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 2'> selected</cfif>>Stage 2
	<option value="Stage 3"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 3'> selected</cfif>>Stage 3
	<option value="Stage 4"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 4'> selected</cfif>>Stage 4 - Winner ideas HOLDING STAGE
	<option value="Stage 5"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 5'> selected</cfif>>Stage 5 - Winner ideas 3P WILL NOT be doing now
	<option value="Stage 6"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 6'> selected</cfif>>Stage 6 - Winner ideas 3P MIGHT do
	<option value="Stage 7"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 7'> selected</cfif>>Stage 7 - Winner ideas 3P WILL do 
	<option value="Stage 8"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 8'> selected</cfif>>Stage 8 - Winner ideas IN PROGRESS
	<option value="Stage 9"<cfif TRIM(ideaStuff.SugStage) EQ 'Stage 9'> selected</cfif>>Stage 9 - Done
	</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Display On<br>Winners Page</td>
	<td><input name="DisplayAsWinner" type="radio" style="border:0px;background-color:transparent;" class="whitefield" value="1"<cfif TRIM(ideaStuff.DisplayAsWinner) EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp;&nbsp; <input name="DisplayAsWinner" type="radio" style="border:0px;background-color:transparent;" class="whitefield" value="0"<cfif TRIM(ideaStuff.DisplayAsWinner) NEQ 1> checked</cfif>> No</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Status</td>
	<td><select name="archived" class="whitefield" style="font-size:11px;width:300px;">
	<option value="0"<cfif TRIM(ideaStuff.archived) EQ 0> selected</cfif>>Active
	<option value="1"<cfif TRIM(ideaStuff.archived) EQ 1> selected</cfif>>Archived
	</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Bonus Rewards</td>
	<td><input type="text" name="reward" class="whitefield" style="font-size:11px;width:300px;" value="#TRIM(IdeaStuff.reward)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110" valign="top">Comments</td>
	<td>
	<textarea name="comments" rows="25" cols="40">#TRIM(IdeaStuff.comments)#</textarea>
	<!--- <cf_activedit name="comments" inc="#request.ActiveEditInc#" image="true"
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="300" height="250"
	toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,bullets,numbers,table,image,hyperlink,help,showdetails" tabview="yes" DEFAULTFONT="8pt Verdana">#TRIM(IdeaStuff.comments)#</cf_activedit> --->
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110">Date Finished (dd/mm/yyyy)</td>
	<td><input type="text" name="WhenSugEnded" value="#dateformat(IdeaStuff.WhenSugEnded,'dd/mm/yyyy')#" class="whitefield" style="width:265px;"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.EditIdea.WhenSugEnded);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" onclick="javascript:validateIdea(EditIdea); return false;" value="UPDATE IDEA NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
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