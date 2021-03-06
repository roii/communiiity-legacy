<!---Newly created CFC component class to get the project lists  Added by Veena --->
<cfcomponent>

<cffunction name="getProjectsList" access="remote" returntype="any" returnformat="plain" output="false">
	<!--- These are the values passed from the grid when the user pages --->
	<cfargument name="page" type="numeric" default="1">
	<cfargument name="rows" type="numeric" default="10">
	<cfargument name="sidx" type="string" default="Priority">
	<cfargument name="sord" type="string" default="asc">
	<cfargument name="ProjectCatIDList" type="any" default="0"> 
	
	<cfargument name="allowTasks" type="any" default="0">
	
	<cfargument name="userid" type="any" default="0">
	<cfargument name="userip" type="any" default="0">
	
	<cfargument name="selStatus" type="any" default="">
	<cfargument name="selCategory" type="any" default="">
	<cfargument name="selPriority" type="any" default="">
	<cfargument name="search_keyword" type="any" default="">
	
	<cfargument name="webroot" type="any" default="">
	<cfargument name="fuseaction" type="any" default="">
	<cfargument name="fusesubaction" type="any" default="">
	<cfargument name="documentID" type="any" default="">
	<cfargument name="groupID" type="any" default="0">
	 
	
	<!--- set up generic variables --->
	<cfset var tmp = structnew()>
	<cfset var tmp2 = 0>
	<cfset var start = 1>
	<cfset var output = ''>
	
	<cfquery name="getGroupName" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J">
	     SELECT *
              FROM ProjectGroups
		  WHERE GroupID = #groupID#	  
	</cfquery>

	<!--- get the total number of records --->
	<cfquery name="records" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J">
		SELECT count(*) as total FROM Projects P 
		WHERE displayProject = 1   
		<cfif isdefined("arguments.selStatus")>
		    <cfif arguments.selStatus neq ''> 
			   <cfif arguments.selStatus neq 'showallstatus'>  
				   AND P.currentstatus IN ('#Replace(trim(arguments.selStatus), ",", "','", "ALL")#') 	   
			   </cfif>	
			<cfelse> 
			       AND P.CurrentStatus <> 'All done'
			</cfif> 
		<cfelse> 
			    AND P.CurrentStatus <> 'All done'	
		</cfif>
		<!---<cfif isDefined("arguments.selCategory")>
		     <cfif arguments.selCategory neq ''>
			   <cfif arguments.selCategory neq 'showallcats'> 
				  WHERE P.ProjectCategoryID IN (#trim(arguments.selCategory)#)
			   </cfif>	  
			 </cfif> 
		</cfif>--->
		<cfif isDefined("arguments.selPriority")>
			<cfif arguments.selPriority neq ''>
			   <cfif arguments.selPriority neq 'showallpriorities'>  
				  AND P.Priority IN ('#Replace(trim(arguments.selPriority), ",", "','", "ALL")#')
			   </cfif>	  
			</cfif> 
		</cfif>
		<cfif isdefined("arguments.search_keyword")>
			<cfif arguments.search_keyword neq ''>  
				   AND (P.Title LIKE '%#trim(arguments.search_keyword)#%' or P.INTROTEXT LIKE '%#trim(arguments.search_keyword)#%' or P.details LIKE '%#trim(arguments.search_keyword)#%') 
			</cfif> 
		</cfif>
	</cfquery> 
	
	<!--- figure out how many pages their will be --->
	<cfif records.total gt 0>
		<cfset tmp.total =  Ceiling(records.total/rows)>
	<cfelse>
		<cfset tmp.total = 0>
	</cfif>
	
	<!--- if they happen to type a page higher than the last set it to the last --->
	<cfif arguments.page gt tmp.total>
		<cfset arguments.page = tmp.total>
	</cfif>
	
	<!--- determine the starting point and query data --->
	<cfset start = arguments.rows * arguments.page - arguments.rows>
	<cfif page eq 1> 
	     <cfset var start2 = 0>
		 <cfset var start  = 0>
		 <cfset var end2   = #arguments.rows#>
		 <cfset var ctr2   = 0>
	<cfelse>
	     <cfset var start2 = (#arguments.rows# * #arguments.page#) - #arguments.rows#>
		 <cfset var start  = (#arguments.rows# * #arguments.page#) - #arguments.rows#>
		 <cfset var end2   = #arguments.rows# * #arguments.page#>  	 
		 <cfset var ctr2   = #arguments.rows# + 0>
	</cfif>	    
	
	<cfif records.total gt 10>
				  <cfquery name="this_page" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J"> 
			   SELECT *
				from Projects where displayProject = 1    
				<cfif isdefined("arguments.selStatus")>
					<cfif arguments.selStatus neq ''> 
					   <cfif arguments.selStatus neq 'showallstatus'>  
						   and Projects.currentstatus IN ('#Replace(trim(arguments.selStatus), ",", "','", "ALL")#') 
					   <cfelse>
						   and
								(Projects.currentstatus = 'Being Planned' OR
								Projects.currentstatus = 'Available Now'  OR
								Projects.currentstatus = 'In progress'  OR
								Projects.currentstatus = 'All Done')	   
					   </cfif>	
					<cfelse> 
						   and Projects.CurrentStatus <> 'All done'
					</cfif> 
				<cfelse> 
						   and Projects.CurrentStatus <> 'All done'
				</cfif>
				<!---<cfif isDefined("arguments.selCategory")>
					<cfif arguments.selCategory neq ''>
					   <cfif arguments.selCategory neq 'showallcats'> 
						  where Projects.ProjectCategoryID IN (#trim(arguments.selCategory)#)
					   </cfif>	  
					</cfif> 
				</cfif>--->
				<cfif isDefined("arguments.selPriority")>
					<cfif arguments.selPriority neq ''>
					   <cfif arguments.selPriority neq 'showallpriorities'>  
						  and Projects.Priority IN ('#Replace(trim(arguments.selPriority), ",", "','", "ALL")#')
					   </cfif>	  
					</cfif> 
				</cfif>
				<cfif isdefined("arguments.search_keyword")>
					<cfif arguments.search_keyword neq ''>  
						   and (Projects.Title LIKE '%#trim(arguments.search_keyword)#%' or Projects.INTROTEXT LIKE '%#trim(arguments.search_keyword)#%' or Projects.details LIKE '%#trim(arguments.search_keyword)#%') 
					</cfif> 
				</cfif>   
				  order by #arguments.sidx# #arguments.sord#    
				  OFFSET #start# ROWS
				  FETCH NEXT #end2# ROWS ONLY; 
			</cfquery> 
	<cfelse> 
			  <cfquery name="this_page" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J"> 
		   SELECT *
			from Projects WHERE displayProject = 1 
			<cfif isdefined("arguments.selStatus")>
				<cfif arguments.selStatus neq ''> 
				   <cfif arguments.selStatus neq 'showallstatus'>  
					   and Projects.currentstatus IN ('#Replace(trim(arguments.selStatus), ",", "','", "ALL")#') 
				   <cfelse>
					   and
							(Projects.currentstatus = 'Being Planned' OR
							Projects.currentstatus = 'Available Now'  OR
							Projects.currentstatus = 'In progress'  OR
							Projects.currentstatus = 'All Done')	   
				   </cfif>	
				<cfelse> 
					   and Projects.CurrentStatus <> 'All done'
				</cfif> 
			<cfelse> 
					   and Projects.CurrentStatus <> 'All done'
			</cfif>
			<!---<cfif isDefined("arguments.selCategory")>
				<cfif arguments.selCategory neq ''>
				   <cfif arguments.selCategory neq 'showallcats'> 
					  where Projects.ProjectCategoryID IN (#trim(arguments.selCategory)#)
				   </cfif>	  
				</cfif> 
			</cfif>--->
			<cfif isDefined("arguments.selPriority")>
				<cfif arguments.selPriority neq ''>
				   <cfif arguments.selPriority neq 'showallpriorities'>  
					  and Projects.Priority IN ('#Replace(trim(arguments.selPriority), ",", "','", "ALL")#')
				   </cfif>	  
				</cfif> 
			</cfif>
			<cfif isdefined("arguments.search_keyword")>
				<cfif arguments.search_keyword neq ''>  
					   and (Projects.Title LIKE '%#trim(arguments.search_keyword)#%' or Projects.INTROTEXT LIKE '%#trim(arguments.search_keyword)#%' or Projects.details LIKE '%#trim(arguments.search_keyword)#%') 
				</cfif> 
			</cfif>   
			  order by #arguments.sidx# #arguments.sord#  
		</cfquery> 
	</cfif> 
	
	<cfset tmp.page = arguments.page> <!--- send back what page you are on --->
	<cfset tmp.records = records.total> <!--- total number of records --->
	<cfset tmp.rows = arraynew(1)> <!--- array to hold the data rows --->
	<cfloop query="this_page"> <!---the grid wants the data inthis format [id,cell{column,column...}]---> 
				<cfset tmp2 = structnew()>
				<cfset tmp2.id = this_page.ProjectID>
				<cfset tmp2.cell = arraynew(1)>
				<cfset tmp2.cell[1] = '<span style="padding-left: 20px;">'&this_page.ProjectID&"</span>">
				<cfset tmp2.cell[2] = "<a href='#arguments.webroot#/index.cfm?fuseaction=#arguments.fuseaction#&fusesubaction=#arguments.fusesubaction#&documentID=#arguments.documentID#&projectmode=template&ProjectCategoryID=0&ProjectID=#TRIM(this_page.ProjectID)#&campaignID=#TRIM(this_page.related_campaign)#&maintask=1'>"&this_page.INTROTEXT&"</a>">
				<!---<cfset tmp2.cell[3] = this_page.category> 
				
				<cfset tmp2.cell[4] = this_page.CurrentStatus> --->
				 
				<cfif this_page.Priority eq "1">
					<cfset tmp2.cell[3] = '<img align="center" src="#arguments.webroot#/images/dot-red.gif" style="text-align: center; padding-left: 15px;">'>
				<cfelseif this_page.Priority eq "3">
					<cfset tmp2.cell[3] = '<img align="center" src="#arguments.webroot#/images/dot_green.gif" style="text-align: center; padding-left: 15px;">'>
				<cfelseif this_page.Priority eq "2">
					<cfset tmp2.cell[3] = '<img align="center" src="#arguments.webroot#/images/yellow.gif" style="text-align: center; padding-left: 15px;">'>
				<cfelse>
					<cfset tmp2.cell[3] = this_page.Priority>
				</cfif>
				<!---<cfset tmp2.cell[5] = this_page.CurrentStatus>	
				<cfif tmp2.cell[5] eq 'All done'> 
					  <cfset tmp2.cell[4] = 'dd'>
				<cfelseif tmp2.cell[5] eq 'Available Now'> 	
					  <cfset tmp2.cell[4] = 'ddsxccc'>   
				</cfif>--->
				
				<cfset tmp2.cell[4] = #this_page.CreditsOffered#>
				<cfset tmp2.cell[5] = #this_page.AssignedTo#>
				<cfset tmp2.cell[6] = #this_page.PercentComplete#>
				<!---<cfset tmp2.cell[7] = this_page.PaidIn>--->
				<!---<cfif #arguments.allowTasks# eq 1>
				<cfset tmp2.cell[7] = '<a onclick="fdbackwindow=window.open (\"\",\"editArt\",\"toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10\")" target="editArt" href="#arguments.webroot#/admin/dsp_cashproject_edit.cfm?projectID=#TRIM(this_page.ProjectID)#&amp;documentID=#arguments.documentID#"><img width="10" border="0" height="10" alt="Edit this Project" src="#arguments.webroot#/images/but_edit_icon.gif"></a>
				<a href="javascript:confirmProjectDelete(''#arguments.webroot#/admin/act_cashproject_delete.cfm?projectID=#TRIM(this_page.ProjectID)#&documentID=#arguments.documentID#'')"><img width="10" border="0" height="10" alt="Delete this Project" src="#arguments.webroot#/images/but_delete_icon.gif"></a>'>
				</cfif>--->
				<cfset tmp.rows[currentrow] = tmp2> 
	</cfloop>
	
	<cfif arguments.userid gt 0>
			<cfquery name="selectSession" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J"> 
					SELECT * FROM tasks_page_options 
					WHERE userid = #arguments.userid#
			</cfquery>
		    <cfif selectSession.recordcount gt 0>
		        <cfquery name="updateSession" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J"> 
					UPDATE tasks_page_options
					SET pageoption = #rows#
					WHERE userid = #arguments.userid#
		        </cfquery>  
		    <cfelse>
		        <cfquery name="insertSession" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J"> 
					INSERT INTO tasks_page_options (pageoption, userid) VALUES
					(#rows#, #arguments.userid#) 
		        </cfquery>
		    </cfif> 
	<cfelse>
	        <cfquery name="selectSession" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J"> 
					SELECT * FROM tasks_page_options 
					WHERE userip = '#arguments.userip#'
			</cfquery>
			<cfif selectSession.recordcount gt 0>
			        <cfquery name="updateSession" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J"> 
						UPDATE tasks_page_options
						SET pageoption = #rows#
						WHERE userip = '#arguments.userip#'
					</cfquery>  
			<cfelse>
			        <cfquery name="insertSession" datasource="crowdsourciiingdsn" username="crowdsourciiinguser" password="dfkdsf344J"> 
						INSERT INTO tasks_page_options (pageoption, userip) VALUES
					     (#rows#, '#arguments.userip#') 
					</cfquery>
			</cfif> 
	</cfif>
	<!--- convert the structure to JSON --->
	<cfset output = SerializeJSON(tmp)>
	
	<!--- coldfusion likes to capitalize things and change integers to floats so we clean these up --->
	<cfset output = replace(output,'.0','','all')>
	<cfset output = replace(output,'ROWS','rows','all')>
	<cfset output = replace(output,'PAGE','page','all')>
	<cfset output = replace(output,'TOTAL','total','all')>
	<cfset output = replace(output,'RECORDS','records','all')>
	<cfset output = replace(output,'CELL','cell','all')>
	
	<!--- send back the JSON data --->
	<cfreturn output>
</cffunction>

</cfcomponent>