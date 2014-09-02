<cfinclude template="../app_globals.cfm">  

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
 

<cfset skillsArray = ListToArray(#FORM.SKILLSNEEDED#, ",")>
<cfset skillsArraydata = arrayRemoveEmpty(skillsArray)>  
<cfset skillIDs = "">  
<cfset uniqueSkillsList = "">

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
	<cfset skillsArray = listtoArray(#skillIDs#, ",")>
	<cfset myHashSet = createObject("java", "java.util.HashSet") />
	<cfset myHashSet.init( skillsArray ) /> 
	<cfset uniqueArray = myHashSet.toArray() />
	<cfset uniqueSkillsList = arrayToList( uniqueArray ) />   
</cfif>	 

    <cfquery name="getProjectCat" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
	       SELECT PC.ProjectCategoryID FROM campaigns as P INNER JOIN ProjectCategoryRelation as PCR ON P.CampaignsID = PCR.ProjectID INNER JOIN ProjectCategories as PC ON PCR.ProjectCategoryID = PC.ProjectCategoryID WHERE P.CampaignsID = #FORM.PROJECTID#
	</cfquery>
	<cfset projectCategoryIDs = ArrayNew(1)>
	<cfset counter = 1>
	<cfoutput query="getProjectCat">
	    <cfset projectCategoryIDs[counter++] = getProjectCat.PROJECTCATEGORYID>
	</cfoutput> 

<!--- GENERATE NEW PROJECT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT ProjectID
	FROM Projects
	ORDER BY ProjectID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.ProjectID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	
	<cfscript>
	   imgDir = expandpath('../images/carcasses_new');
	</cfscript>
	
	<cfif IsDefined("FORM.project_pic") and len(project_pic)>
	   
	   <cffile action="upload" filefield="form.project_pic" destination="#imgDir#" accept="image/jpeg, image/gif, image/png, image/jpg, image/bmp, image/cgm, image/vnd.djvu, image/jp2, image/pjpeg" nameconflict="makeunique">
	    <cfset localImage1 =  #CFFILE.ServerFile#>  
		<!---<cffile
			action="upload"
			destination = "#imgDIR#"
			nameconflict="makeunique"
			filefield="project_pic" />
			
			<cfdump var="#cffile#">
			<cfabort>
			
		    <cfset fileExt = cffile.CLIENTFILEEXT>
			<cfset localImage1 = replace(cffile.SERVERFILE," ","","all")>
			<cfset localImage1 = localImage1 & "." & fileExt>--->
	<cfelse>
	       	<cfset localImage1 = "">	
	</cfif>


<!--- INSERT ARTICLE INFO 
<cfif IsDefined("form.ProjectPriority") and #form.ProjectPriority# neq ''>
	  Priority = '#form.ProjectPriority#'
	<cfelse>
	  Priority = ''
	</cfif>
---> 
	
	<cfif IsDefined("form.CreditsOffered") and #form.CreditsOffered# neq ''>
	     <cfset CreditsOffered = #form.CreditsOffered#>
	<cfelse>
	     <cfset CreditsOffered = 0>
	</cfif>
	
	<cfif IsDefined("form.assignedto") and #form.assignedto# neq ''>
	     <cfset assignedto = #form.assignedto#>
	<cfelse>
	     <cfset assignedto = "">
	</cfif>
	
	<cfif IsDefined("form.PercentComplete") and #form.PercentComplete# neq ''>
	     <cfset PercentComplete = #form.PercentComplete#>
	<cfelse>
	     <cfset PercentComplete = 0>
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
	     <cfset skillsNeeded = #form.skillsNeeded#>
	<cfelse>
	     <cfset skillsNeeded = ''>
	</cfif>
	
	<cfif IsDefined("form.introText") and #form.introText# neq ''>
	     <cfset introText = #form.introText#>
	<cfelse>
	     <cfset introText = ''>
	</cfif>
	
	<cfset createDateV = DateFormat(now(), 'yyyy-mmm-dd')>
	 
	
	
	<cfquery name="AddProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Projects(ProjectID, Title, related_campaign, introText, Details, CreditsOffered, currentstatus, percentcomplete, assignedto, projectpic, project_owner, Priority, location, displayProject, createDate, startdate, finishdate, skills)
	VALUES(#newid#, '#form.title#', #FORM.related_campaign# , '#form.title#', '#form.details#', #CreditsOffered#, '#form.currentstatus#', '#percentcomplete#', '#assignedto#', '#localImage1#', '#FORM.userid#', '#form.ProjectPriority#'
	   <cfif IsDefined("FORM.location") and FORM.location neq "">
	      ,'#FORM.location#',
	   <cfelse>
	      ,'',	  
	   </cfif>
	   <!---<cfif IsDefined("FORM.project_order") and FORM.project_order neq "">
	      '#FORM.project_order#',
	   <cfelse>
	      '',	  
	   </cfif>--->
	   <cfif IsDefined("FORM.displayProject") and FORM.displayProject neq "">
	      '#FORM.displayProject#',
	   <cfelse>
	      0,	  
	   </cfif>
	   '#createDateV#',
	   '#start_date#',
	   '#finish_date#',
	   '#uniqueSkillsList#'
	   <!---<cfif IsDefined("FORM.addedBy") and FORM.addedBy neq "">
	      '#FORM.addedBy#'
	   <cfelse>
	      '' 
	   </cfif>--->
	)
	</cfquery>

	<cfif IsArray(projectCategoryIDs) and not ArrayIsEmpty(projectCategoryIDs)>
	      <cfoutput>
		        <cfset totalprojectCats = ArrayLen(projectCategoryIDs)>
						<cfquery name="selectProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
							 SELECT * FROM taskCategoryRelation 
							   WHERE taskID = #newid#
						</cfquery> 
					    <cfif selectProjCat.recordcount gt 0>
							<cfquery name="insertProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
								 DELETE FROM ProjectCategoryRelation 
								   WHERE ProjectID = #newid#
							</cfquery> 
						</cfif>	
		            <cfloop from="1" to="#totalprojectCats#" index="i">  
						   <cfquery name="insertProjCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
						         INSERT INTO taskCategoryRelation 
								 (taskID, projectCategoryID)
								 VALUES
								 (#newid#, #projectCategoryIDs[i]#)
						   </cfquery>
		            </cfloop>
		  </cfoutput>
	</cfif>
	
<cflocation url="#request.webroot#/projects/#FORM.ProjectID###tabs1-projects" addtoken="no">
<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	 
	 
