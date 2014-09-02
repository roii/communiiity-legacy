<cfinclude template="../app_globals.cfm">

<cfif IsDefined("form.DATA") and #form.DATA# neq ''>
	 <cfset skillsNeededData = #form.DATA#>
<cfelse>
	 <cfset skillsNeededData = ''>
</cfif>  

<cfif IsDefined("form.userID") and #form.userID# neq ''>
	 <cfset userid = #form.userID#>
<cfelse>
	 <cfset userid = ''>
</cfif>

<cfset skillsNeededData = Replace(skillsNeededData, "&editname=", ";;;;")> 

<cfset skillsIDsData1 = ListToArray(skillsNeededData, ';;;;')>

<cfset skillsNeededData = skillsIDsData1[2]>

<cfquery name="checkforUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
	 SELECT * FROM userSkills WHERE userID = #userid#
</cfquery>  

<cfif checkforUSerSkills.recordcount gt 0>
    <!---Update Skills into Table for User---> 
	 <cfset allSkillIds = checkforUSerSkills.skillIDs> 
	 
	 <cfset skillIDsArray = ListToArray(allSkillIds, ",")>
	 <cfset totalSkills   = ArrayLen(skillIDsArray)>
	 <cfset position = 0> 
	 <cfoutput>
	     <cfloop from="1" to="#totalSkills#" index="i"> 
		        <cfif skillIDsArray[i] eq skillsNeededData>
				    <cfset position = i>
					<cfbreak>
				</cfif>
		 </cfloop>
	 </cfoutput> 
	 
          <cfif position gt 0>
		  <cfelse>
		        <cfset alreadyAdded = checkforUSerSkills.skillIDs & "," & #trim(skillsNeededData)#>
				<cfquery name="updateintoUserSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
					 UPDATE userSkills SET skillIDs = '#trim(alreadyAdded)#' WHERE userID = #userid#
				</cfquery>
				<cfoutput>Updated</cfoutput>
		  </cfif> 
<cfelse>
    <!---Insert Skills into Table for User--->
	    <cfquery name="insertintoUserSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
			 INSERT INTO userSkills (userID, skillIDs) VALUES (#userid#, '#trim(skillsNeededData)#')
		</cfquery> 
		<cfoutput>Inserted</cfoutput>
</cfif>