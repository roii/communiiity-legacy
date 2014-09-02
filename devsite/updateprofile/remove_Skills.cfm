<cfinclude template="../app_globals.cfm">
<cfif IsDefined("form.skillID") and #form.skillID# neq ''>
	 <cfset skillID = #form.skillID#>
<cfelse>
	 <cfset skillID = 0>
</cfif>   

<cfif IsDefined("form.userid") and #form.userid# neq ''>
	 <cfset userid = #form.userid#>
<cfelse>
	 <cfset userid = 0>
</cfif>  

<cfif skillID gt 0 and userid gt 0>

	<cfquery name="checkforUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
		 SELECT * FROM userSkills WHERE userID = #userid#
	</cfquery>
	
	<cfset skillIDs = checkforUSerSkills.SKILLIDS>
	<cfset skillIDsArray = ListToArray(skillIDs, ",")>
	<cfset totalSkills   = ArrayLen(skillIDsArray)>
	<cfset position = 0>
	
	<cfoutput>
	     <cfloop from="1" to="#totalSkills#" index="i"> 
		        <cfif skillIDsArray[i] eq skillID>
				    <cfset position = i>
					<cfbreak>
				</cfif>
		 </cfloop>
		 <cfset ArrayDeleteAt(skillIDsArray, position)>
		 #position#
	</cfoutput> 
	
	<cfif position gt 0>
			<cfset dataToSave = ArrayToList(skillIDsArray, ",")> 
			<cfquery name="updateUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
				 UPDATE userSkills SET SKILLIDS = '#dataToSave#' WHERE userID = #userid#
			</cfquery> 
			<cfoutput>Done</cfoutput>
    <cfelse>
	        <cfoutput>Not Done</cfoutput>
	</cfif> 
</cfif>