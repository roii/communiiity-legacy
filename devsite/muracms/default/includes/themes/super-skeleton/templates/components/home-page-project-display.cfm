<div style="padding-top: 30px;"> 
<!--<hr style="font-weight: bold; font-size: 16pt;" />-->
<cfoutput> 
<br />   
#$.setDynamicContent($.component('body'))#
</cfoutput>
</div>

<cfquery name="getProjects" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDBUsername()#" password="#application.configBean.getDBPassword()#">
      SELECT TOP 3 ProjCat.title as CategoryTitle, proj.ProjectID as ProjectID, proj.ProjectCategoryID, ProjCat.GroupID, proj.title as projectTitle, proj.IntroText as IntroText, proj.Details as Details FROM Projects as proj INNER JOIN ProjectCategories as ProjCat
	   ON proj.ProjectCategoryID = ProjCat.ProjectCategoryID
</cfquery>

<cfoutput>

<div class="title-bar clearfix">
    <h2 class="fl title medium">Picks of the Crowd</h2>
</div>

<ul class="badges clearfix"> 
<cfloop query="getProjects">
     <li class="fl badge rounded shadow -ce-capture ">
	    <div class="project-category">
			  #CategoryTitle#
		</div>
        <div class="project-details" style="word-wrap: break-word;">
			<cfquery name="getDocumentID" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDBUsername()#" password="#application.configBean.getDBPassword()#">
			      SELECT * FROM ProjectGroups WHERE GroupID = #GroupID# 
        	</cfquery>
			<cfset pCID = trim(ProjectCategoryID)>
				  <a class="name bold" href="index.cfm/project-details/?documentID=#getDocumentID.DocumentID#&ProjectCategoryID=#pCID#&ProjectID=#ProjectID#">#projectTitle#</a> 
				  <p class="description">
					#IntroText#
				  </p>
		</div>
	 </li>
</cfloop>
</ul>

</cfoutput>
 