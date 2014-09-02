<cfinclude template="../app_globals.cfm">

<cfif IsDefined("form.selectTextID") and #form.selectTextID# neq ''>
	 <cfset newSkill = #form.selectTextID#>
<cfelse>
	 <cfset newSkill = ''>
</cfif>  

<cfif IsDefined("form.userID") and #form.userID# neq ''>
	 <cfset userid = #form.userID#>
<cfelse>
	 <cfset userid = 0>
</cfif>

<cfquery name="insertintoAllSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
	 INSERT INTO allmanageskills (skillName, skillKeyword) VALUES ('#trim(newSkill)#', '#trim(newSkill)#')
</cfquery>

<cfquery name="latestSkillID" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
	SELECT max(id) as latest FROM allmanageskills
</cfquery>

<cfset skillID = latestSkillID.latest>

<cfif skillID gt 0 and userid gt 0>


    <cfquery name="checkforUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
		 SELECT * FROM userSkills WHERE userID = #userid#
	</cfquery>
	
	<cfset skillIDs = checkforUSerSkills.SKILLIDS>
	<cfset skillIDsArray = ListToArray(skillIDs, ",")>
	<cfset totalSkills   = ArrayLen(skillIDsArray)>
	<cfset nextSkillPos  = totalSkills + 1>
	
	<cfset skillIDsArray[nextSkillPos] = skillID> 

    <cfset dataToSave = ArrayToList(skillIDsArray, ",")> 
	<cfquery name="updateUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
		 UPDATE userSkills SET SKILLIDS = '#dataToSave#' WHERE userID = #userid#
	</cfquery> 
	<cfoutput>Done</cfoutput>
</cfif>