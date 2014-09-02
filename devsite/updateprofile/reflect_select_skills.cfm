<cfinclude template="../app_globals.cfm">

<cfif IsDefined("form.userid") and #form.userid# neq ''>
	 <cfset userid = #form.userid#>
<cfelse>
	 <cfset userid = 0>
</cfif>  

<cfquery name="checkforUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
	 SELECT * FROM userSkills WHERE userID = #userid#
</cfquery>

<cfset skillsArray = ListToArray(#checkforUSerSkills.SKILLIDS#, ",")> 

<cfif IsArray(skillsArray) and not ArrayIsEmpty(skillsArray)>   
  <cfoutput>
	 <p>List of selected Skills as below:</p>   
		<ul style="width:171px; border: none !important;" class="hidden_items_box"> 
			  <cfloop from="1" to="#ArrayLen(skillsArray)#" index="i">
					<cfquery name="getuserSkills" datasource="#dsn#" username="#request.username#" password="#request.password#">
						 SELECT * FROM allmanageskills WHERE id = #skillsArray[i]#
					</cfquery>  
							<li>
								   <input type="hidden" value="12" autocomplete="off"> 
								   <span>#getuserSkills.skillName#</span>
								   <a href="javascript:;" onclick="removeID(#skillsArray[i]#, #userid#);">×</a>
							</li> 	 
			  </cfloop>	
		</ul>	  	
  </cfoutput>
</cfif>