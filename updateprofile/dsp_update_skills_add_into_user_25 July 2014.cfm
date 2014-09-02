<cfinclude template="../app_globals.cfm">

<cfif IsDefined("form.skillsNeeded") and #form.skillsNeeded# neq ''>
	 <cfset skillsNeededData = #form.skillsNeeded#>
<cfelse>
	 <cfset skillsNeededData = ''>
</cfif>

<cfset skillsIDsData = ListToArray(skillsNeededData, '&editname=')>
<cfset skillArray = ArrayNew(1)>
<cfset ictr = 1>

<cfoutput>
    <cfloop from="3" to="#ArrayLen(skillsIDsData)#" index="i">
	       <cfset skillArray[ictr++] = skillsIDsData[i]>
	</cfloop>
</cfoutput>

<cfset skillsNeededData = ArrayToList(skillArray, ",")>  

<cffunction name="arrayRemoveEmpty" access="public" description="removes empty array elements" output="false" returntype="array">    
       <cfargument name="theArray" required="true" type="array" />        
	   <cfset var i = 0 />    
	   <cfset var newArray = duplicate(arguments.theArray) />    
	   <cfloop from="#arrayLen(newArray)#" to="1" index="i" step="-1">       
	         <cftry>          
			      <cfset newArray[i] />          
				 <cfcatch type="coldfusion.runtime.UndefinedElementException">             
					  <cfset arrayDeleteAt(newArray,i) />         
				 </cfcatch>          
				 <cfcatch type="coldfusion.runtime.CfJspPage$ArrayBoundException">             
					  <cfset arrayDeleteAt(newArray,i) />          
				 </cfcatch>       
		     </cftry>    
		</cfloop>    
		<cfreturn newArray /> 
  </cffunction>  

<cfif IsDefined("SESSION.userid") and #SESSION.userid# neq ''>
	 <cfset userid = #SESSION.userid#>
<cfelse>
	 <cfset userid = ''>
</cfif>

<cfquery name="checkforUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
	 SELECT * FROM userSkills WHERE userID = #userid#
</cfquery> 

<cfset skillsArray = ListToArray(#skillsNeededData#, ",")>
<cfset skillsArraydata = arrayRemoveEmpty(skillsArray)>  
<cfset skillIDs = ""> 
	
<!---<cfif IsArray(skillsArraydata) and not ArrayIsEmpty(skillsArraydata)>
	<cfoutput>  
		<cfloop from="1" to="#arrayLen(skillsArraydata)#" index="i">
			 <cfif trim(skillsArraydata[i]) neq ''>
					<cfquery name="checkManageSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
						 SELECT * FROM allmanageskills WHERE skillName = '#trim(skillsArraydata[i])#'
					</cfquery>  
					<cfif checkManageSkills.recordcount eq 0>
							<cfquery name="insertManageSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
								 INSERT INTO allmanageskills (skillName, skillKeyword) VALUES ('#trim(skillsArraydata[i])#', '#trim(skillsArraydata[i])#')
							</cfquery>
							<cfquery name="getMaxID" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
								 SELECT max(id) as total FROM allmanageskills
							</cfquery>
							<cfset getMaxIDValues = getMaxID.total> 
							<cfif skillIDs eq "">
								  <cfset skillIDs = getMaxIDValues> 
							<cfelse>
								  <cfset skillIDs = skillIDs & ',' & getMaxIDValues> 
							</cfif>
					<cfelse>
							<cfif skillIDs eq "">
								  <cfset skillIDs = checkManageSkills.id> 
							<cfelse>
								  <cfset skillIDs = skillIDs & ',' & checkManageSkills.id> 
							</cfif>  		
					</cfif> 
			 </cfif>
		</cfloop> 
	</cfoutput>   
</cfif> 	 
 

<cfset skillsArray = listtoArray(#skillIDs#, ",")>
<cfset myHashSet = createObject("java", "java.util.HashSet") />
<cfset myHashSet.init( skillsArray ) /> 
<cfset uniqueArray = myHashSet.toArray() />
<cfset uniqueSkillsList = arrayToList( uniqueArray ) />--->

<cfif checkforUSerSkills.recordcount gt 0>
    <!---Update Skills into Table for User--->
	    <cfquery name="updateintoUserSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
			 UPDATE userSkills SET skillIDs = '#trim(skillsNeededData)#' WHERE userID = #userid#
		</cfquery>
<cfelse>
    <!---Insert Skills into Table for User--->
	    <cfquery name="insertintoUserSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
			 INSERT INTO userSkills (userID, skillIDs) VALUES (#userid#, '#trim(skillsNeededData)#')
		</cfquery> 
</cfif>

<cfoutput>
<script language="javascript">
 alert('Your Skills have been updated....');
window.top.location.href="#request.webroot#/index.cfm?fuseaction=updateprofile&fusesubaction=index&skilladd=1"; 

</script>
</cfoutput>
<!---<cflocation url="#request.webroot#/index.cfm?fuseaction=updateprofile&fusesubaction=index&skilladd=1##tabs1-skills" addtoken="no">--->