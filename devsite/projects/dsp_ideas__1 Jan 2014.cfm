<cfoutput>
<cfquery name="getIdeaTopics" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT CategoryID, Name, Description, WhenCategoryCreated, WhenCategoryEnded FROM SugCategory WHERE related_campaign = #campaignID# and Active = 1
  ORDER BY CategoryID DESC
</cfquery>
<h1>
 Related Ideas
</h1> 
<cfset totalideas = getIdeaTopics.recordcount>

<cfif totalideas gt 0>
	<ul>
	  <cfloop query="getIdeaTopics"> 
		   <cfif totalideas lte 5>
					<li>
						<a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#getIdeaTopics.CategoryID#&IdeaFunL_StartRow=1&srch_stage=ALL" target="_blank">
							<strong>#getIdeaTopics.Name#</strong> <br />
						</a> 
						 <span style="padding-left: 20px;">#getIdeaTopics.Description#</span> <br /><br />
						 <strong>Started on: </strong>#DateFormat(getIdeaTopics.WhenCategoryCreated, "dd mmmm yyyy")# <br />
						 <strong>Finished on: </strong>#DateFormat(getIdeaTopics.WhenCategoryEnded, "dd mmmm yyyy")#
							<h1>
							   Ideas/Summaries
							</h1>
						  <cfquery name="getIdeaSumaries" datasource="#dsn#" username="#request.username#" password="#request.password#">
							  SELECT suggestion, details, WhenSugMade, WhenSugEnded FROM Suggestion WHERE CategoryID = #getIdeaTopics.CategoryID# ORDER BY sugID DESC
						  </cfquery>  
							   <ol>
									 <cfloop query="getIdeaSumaries">
										 <li>
										   <strong>#getIdeaSumaries.suggestion#</strong> <br />
										   <span style="padding-left: 20px;">#getIdeaSumaries.details#</span> <br /><br />
										   <cfif getIdeaSumaries.WhenSugMade neq ''>
											  <strong>Started on: </strong>#DateFormat(getIdeaSumaries.WhenSugMade, "dd mmmm yyyy")# <br />
										   </cfif>
										   <cfif getIdeaSumaries.WhenSugEnded neq ''>
											  <strong>Finished on: </strong>#DateFormat(getIdeaSumaries.WhenSugEnded, "dd mmmm yyyy")#
										   </cfif> <br />
										 </li>  
									 </cfloop>
							   </ol>
					</li>
		   </cfif>		
	  </cfloop>
	</ul>	
	<cfif totalideas gt 5>
			<a href="#request.webroot#/index.cfm?fuseaction=ideas">
				 Read More ideas...
			</a>
	</cfif>
<cfelse>
     Will be Shortly...
</cfif>
	
</cfoutput>