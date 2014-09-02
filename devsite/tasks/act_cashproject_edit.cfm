<cfinclude template="../app_globals.cfm">

	<cfscript>
	   imgDir = expandpath('../images/carcasses_new');
	</cfscript>
	
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

    <cfif IsDefined("form.introText") and #form.introText# neq ''>
	     <cfset introText = #form.introText#>
	<cfelse>
	     <cfset introText = ''>
	</cfif>
	
	<cfif IsDefined("form.start_date") and #form.start_date# neq ''>
	     <cfset start_date = #form.start_date#>
	<cfelse>
	     <cfset start_date = DateFormat(now(), 'yyyy-mmm-dd')>
	</cfif>
	
	<cfif IsDefined("form.finish_date") and #form.finish_date# neq ''>
	     <cfset finish_date = #form.finish_date#>
	<cfelse>
	     <cfset finish_date = ''>
	</cfif>
	
	<cfif IsDefined("form.skillsNeeded") and #form.skillsNeeded# neq ''>
	     <cfset skillsNeededData = #form.skillsNeeded#>
	<cfelse>
	     <cfset skillsNeededData = ''>
	</cfif>
	 
	
	<cfset skillsArray = ListToArray(#skillsNeededData#, ",")>
	<cfset skillsArraydata = arrayRemoveEmpty(skillsArray)>  
	<cfset skillIDs = "">  
	
	<cfif IsArray(skillsArraydata) and not ArrayIsEmpty(skillsArraydata)>
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
	<cfset uniqueSkillsList = arrayToList( uniqueArray ) />
	 
	
	<cfquery name="AddProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Projects
	SET Title='#form.title#',
	related_campaign = #FORM.campaignID#,
	introText='#form.title#',
	Details='#form.details#', 
	CreditsOffered=#form.CreditsOffered#,
	AssignedTo='#form.assignedto#',
	PercentComplete=#form.percentcomplete#,
	currentstatus='#form.currentstatus#',
	startdate='#start_date#', 
	finishdate='#finish_date#', 
	skills='#uniqueSkillsList#', 
	<cfif IsDefined("FORM.location") and FORM.location neq "">
	   location = '#FORM.location#',
    <cfelse>
	   location = '',	  
    </cfif> 
	<cfif IsDefined("FORM.displayProject") and FORM.displayProject neq "">
	  displayProject = '#FORM.displayProject#', 
    </cfif>
	<cfif IsDefined("form.ProjectPriority") and #form.ProjectPriority# neq ''>
	  Priority = '#form.ProjectPriority#'
	<cfelse>
	  Priority = ''
	</cfif>
	WHERE ProjectID=#form.ProjectID#
	</cfquery>

	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<!---<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>--->
	
	
	<cfif FORM.maintask eq 0>
		<!---<cfoutput>  
			<body onLoad="showParentAndClose('#request.webroot#/projects/#FORM.campaignID###tabs1-projects')"></body> 
		</cfoutput>--->
		<cflocation url="#request.webroot#/projects/#FORM.campaignID###tabs1-projects" addtoken="no">
    <cfelse> 
	    <!---<cfoutput> 
			<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#documentID#')"></body> 
		</cfoutput>--->
		<cflocation url="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=docs&documentID=#documentID#" addtoken="no">
	</cfif> 