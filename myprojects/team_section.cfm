<cfoutput> 
<h1>
  #team#
</h1>
  <cfset contactIDArr = ListToArray(#getCampaigns.Moderators#, ",")> 
  <cfset totalteams   = ArrayLen(contactIDArr)>
<span>
  <cfif totalteams gt 0>
	  <cfloop from="1" to="#totalteams#" index="i">
			  <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
				  SELECT ContactID, FirstName, LastName, profilepic, linkedinprofilepic, linkedinuser FROM contacts WHERE contactid = #contactIDArr[i]#
			  </cfquery>
			  <cfif #getProfilePic.profilepic# neq ''>
				  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank">
					   <img border="0" src="#request.webroot#/images/profiles/#getProfilePic.profilepic#" style="width: 45px; color:##FFFFFF;" alt="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
				  </a>
			  <cfelse>
				  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank"> 
						<img border="0" src="#request.webroot#/images/default_avatar.gif" style="width: 45px; color:##FFFFFF;" alt="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
				  </a>
			  </cfif>	  
	  </cfloop> 
   <cfelse>
		 Will be Shortly...   
   </cfif>	  
</span>
<br />
<h1>
  #contributors#
</h1>
<span> 
   <cfif getcontributorIdeasData.recordcount gt 0>
	   <cfloop query="getcontributorIdeasData">
			   <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#">
					 SELECT ContactID, FirstName, LastName, profilepic, linkedinprofilepic, linkedinuser FROM contacts
					  WHERE contactid = #getcontributorIdeasData.CONTACTID#
			   </cfquery>
			   <cfif #getProfilePic.profilepic# neq ''>
				  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank">
					   <img border="0" src="#request.webroot#/images/profiles/#getProfilePic.profilepic#" style="width: 45px; color:##FFFFFF;" alt="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
				  </a>
			   <cfelse>
				  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank"> 
						<img border="0" src="#request.webroot#/images/default_avatar.gif" style="width: 45px; color:##FFFFFF;" alt="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
				  </a>
			   </cfif>
	   </cfloop>
   <cfelse>
		 Will be Shortly...	    
   </cfif> 	   
</span>
<span> 
   <cfif getcontributorProjectsData.recordcount gt 0>
	   <cfloop query="getcontributorProjectsData">
			   <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#">
					 SELECT ContactID, FirstName, LastName, profilepic, linkedinprofilepic, linkedinuser FROM contacts
					  WHERE contactid = #getcontributorProjectsData.CONTACTID#
			   </cfquery>
			   <cfif #getProfilePic.profilepic# neq ''>
				  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank">
					   <img border="0" src="#request.webroot#/images/profiles/#getProfilePic.profilepic#" style="width: 45px; color:##FFFFFF;" alt="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
				  </a>
			   <cfelse>
				  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#getProfilePic.ContactID#" target="_blank"> 
						<img border="0" src="#request.webroot#/images/default_avatar.gif" style="width: 45px; color:##FFFFFF;" alt="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#" title="No Image for #ReReplace(getProfilePic.FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(getProfilePic.LastName,'\b(\w)','\u\1','ALL')#">
				  </a>
			   </cfif>
	   </cfloop> 
   </cfif>	   
</span> 
</cfoutput>