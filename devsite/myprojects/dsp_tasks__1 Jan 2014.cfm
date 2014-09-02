<cfoutput>
<cfquery name="getTasks" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT * FROM Projects WHERE related_campaign = #campaignID# and displayProject = 1
  ORDER BY ProjectID DESC
</cfquery>
<h1>
 Related Tasks
</h1> 
<cfset totaltasks = getTasks.recordcount>

<cfif totaltasks gt 0>
	<ul>
	  <cfloop query="getTasks"> 
		   <cfif totaltasks lte 5>
					<li>
						<a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=index&documentID=5&projectmode=template&ProjectCategoryID=#getTasks.ProjectCategoryID#&ProjectID=#getTasks.ProjectID#" target="_blank">
							<strong>#getTasks.Title#</strong> <br />
						</a> 
							<span style="padding-left: 20px;">
									#getTasks.IntroText#
							</span><br />
						 <span style="padding-left: 20px;">#getTasks.Details#</span> <br /><br />
						 <strong>Current Status: </strong>#getTasks.CurrentStatus# <br />
						 <strong>Percent Completed: </strong>#getTasks.PercentComplete# 
					</li>
		   </cfif>		
	  </cfloop>
	</ul>	
	<cfif totaltasks gt 5>
			<a href="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=index&documentID=5">
				 Read More Tasks...
			</a>
	</cfif>
<cfelse>
    Will be Shortly...
</cfif>
	
</cfoutput>