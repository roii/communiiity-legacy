<cfoutput>
<div style="min-height: 140px;"> 

<cfif IsDefined("URL.uid") and URL.uid neq ''> 
	  <cfset userID = #URL.uid#> 
<cfelse>
      <cfset userID = 0>
</cfif> 
 
<cfscript>
function split(string s, numeric length) {
	return reMatch(".{1,#arguments.length#}", s);
} 
</cfscript> 
 
<cfif userID gt 0>  
	<cfif IsDefined("SESSION.userid") and SESSION.userid gt 0>
	          <cfif SESSION.userid eq userID>
			      <cfset editRights = 1>
			  <cfelse>
			      <cfset editRights = 0>	  
			  </cfif>
	<cfelse>
	          <cfset editRights = 0>		  
	</cfif>

<cfinclude template="functions.cfm"> 
<cfinclude template="qry_update_profile.cfm"> 

<cfset browserDetectValue = browserDetect()> 
<cfset isfirefox = #ListContains(browserDetectValue, "Firefox")#>
<cfset ischrome  = #ListContains(browserDetectValue, "Chrome")#> 

<div class="i-management-bar">
	<div class="profileHeader">
		  <div class="i-item i-selected">
		     <cfif ischrome eq 1 OR ischrome eq '1'>
				 <span class="i-icon i-glyph-icon-30-view" style="margin-top: -27px;">
				    <img src="/images/view-image.jpg" border="0" />
				 </span>
			 <cfelse>
			     <span class="i-icon i-glyph-icon-30-view">
				    <img src="/images/view-image.jpg" border="0" />
				 </span>
			 </cfif>	 
				 <span class="i-text">View Profile</span>
		  </div>
		  <cfif editRights eq 1>
			  <div class="i-item">
					 <a href="/index.cfm?fuseaction=updateprofile&fusesubaction=index" class="headerAnchor">
						  <span class="i-icon i-glyph-icon-30-edit">
							  <img src="/images/edit-image.jpg" border="0" />
						  </span>
						  <span class="i-text">Edit Profile &amp; Settings</span>
					 </a>
			  </div>
		 </cfif>	  
	</div>
</div>	  
 
<div style="float:left; width:100%; margin-top: 20px;"> 
		<div style="width: 30%; float:left;">
		     <cfif IsDefined("getUserDetails.PROFILEPIC") and #getUserDetails.PROFILEPIC# neq ''>
			   <img src="/images/profiles/#getUserDetails.PROFILEPIC#" border="0" />
			 <cfelse> 
			   <img src="/images/default_avatar.gif" border="0" />   
			 </cfif>   
		</div>
		<div style="float: left; width: 70%;">
		     <h1 style="font-size:31px; margin:0 !important; padding:0 !important;">#getUserDetails.FIRSTNAME# #getUserDetails.LASTNAME#</h1>
			 <span style="font-size:20px;"> 
				 <cfset totalheadlineStr = Len(getUserDetails.individual_tagline)> 
				 <cfif totalheadlineStr eq 130>
				       <cfloop from="70" to="130" index="i">
					           <cfset FirstSpacePosIn70C = #find(" ",getUserDetails.individual_tagline,i)#> 
					           <cfif FirstSpacePosIn70C gt 0>
							        <cfset ytStr     = #Replace(getUserDetails.individual_tagline, ' ', ';')#> 
									<cfset spaceChar = "yes">
									<cfbreak>
							   <cfelse>
							        <cfset spaceChar = "no">
									<cfbreak>	
							   </cfif>
					   </cfloop>  
					   <cfif spaceChar eq "yes">
							<cfset showSTr = ListToArray(#ytStr#, ";")>
							<cfset totalStr = ArrayLen(showSTr)>
							<cfloop from="1" to="#totalStr#" index="j">
								#showSTr[j]#
							</cfloop>
					   <cfelse>	
							 <cfset SplitindividualTagline = split(#getUserDetails.individual_tagline#,55)>
							 <cfset totalStrTagsLen = ArrayLen(SplitindividualTagline)>
							 <cfloop from="1" to="#totalStrTagsLen#" index="i">
									 #SplitindividualTagline[i]# <br />
							 </cfloop>
					   </cfif>		 
				 <cfelse>
				        <cfif totalheadlineStr lte 70> 
				             #getUserDetails.individual_tagline# 
						<cfelse>
						     <cfloop from="71" to="129" index="i">
					           <cfset FirstSpacePosIn71C = #find(" ",getUserDetails.individual_tagline,i)#>
					           <cfif FirstSpacePosIn71C gt 0>
							        <cfset ytStr = #Replace(getUserDetails.individual_tagline, ' ', ';')#> 
									<cfset spaceChar = "yes">
									<cfbreak>
							   <cfelse>
							        <cfset spaceChar = "no">
									<cfbreak>
							   </cfif>
						     </cfloop>  
							 <cfif spaceChar eq "yes">
									 <cfset showSTr = ListToArray(#ytStr#, ";")>
									 <cfset totalStr = ArrayLen(showSTr)>
										<cfloop from="1" to="#totalStr#" index="j">
											#showSTr[j]# 
										</cfloop>
							 <cfelse>	
									 <cfset SplitindividualTagline = split(#getUserDetails.individual_tagline#,55)>
									 <cfset totalStrTagsLen = ArrayLen(SplitindividualTagline)>
									 <cfloop from="1" to="#totalStrTagsLen#" index="i">
											 #SplitindividualTagline[i]# <br />
									 </cfloop>
							 </cfif>			
						</cfif>	 
				 </cfif> 
			 </span>
			 <br /> 
			 <span style="font-size: 17px;">
			     #getUserDetails.country# 
			 </span>
		</div>
</div>   

<div style="float:left; width:100%;"> 
         <div class="i-about-me"> 
			  <span>About Me</span>
			  <div> 
			        <cfset cleanindividual_description_html = #replace(getUserDetails.individual_description_html,Chr(13),"<br>", "all")#>
				    #cleanindividual_description_html#
			  </div>
		 </div> 
		  <div class="i-about-me"> 
			<span>My Skills</span><br />
			<cfquery name="checkforUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
				 SELECT * FROM userSkills WHERE userID = #userIDtoUse#
			</cfquery> 
			<cfif TRIM(checkforUSerSkills.SKILLIDS) neq ''>
				 <cfset skillsArray = ListToArray(#TRIM(checkforUSerSkills.SKILLIDS)#, ",")>
				 <cfset totalSkills = ArrayLen(skillsArray)>
				 <cfset skillsTmp   = "">
				 <cfloop from="1" to="#totalSkills#" index="i">
						<cfquery name="getManageSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
							 SELECT * FROM allmanageskills WHERE id = '#skillsArray[i]#'
						</cfquery>
						<cfif skillsTmp eq ''>
							   <cfset skillsTmp = #getManageSkills.skillName#>
						<cfelse>
							   <cfset skillsTmp = "," & #getManageSkills.skillName#>
						</cfif> 
						#skillsTmp#
				 </cfloop>	  
			</cfif>	
		  </div> 
</div> 
 
 
<cfelse> 
     <p style="color: red; font-weight: bold;">
	        You are accessing the wrong user profile page.
	 </p>
</cfif> 

</div>
</cfoutput>
