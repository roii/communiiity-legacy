<cfoutput>

<cfquery name="rewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE reward=1
AND deleted=0
AND Display=1
AND (country=0<cfif session.UserIsAuthenticated EQ 'Yes'> OR country=#session.User_CountryID#</cfif>)
ORDER BY pointsvalue
</cfquery>



<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contact_transactions.*, Contacts.FirstName, Contacts.LastName
FROM Contact_transactions, Contacts
WHERE Contact_transactions.Transaction_Account = 'Points'
AND Contact_transactions.ContactID=Contacts.ContactID

<cfif session.UserIsAuthenticated EQ 'Yes'>
AND Contacts.ContactID=#session.UserID#
</cfif>
</cfquery>

<cfset thistotal=0>

<cfloop query="TransactionHistory">


<cfif IsNumeric("#TransactionHistory.Transaction_amount#")>
	<cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>
		<cfset thistotal=(thisTotal - TransactionHistory.Transaction_amount)>
	<cfelse>
		<cfset thistotal=(thisTotal + TransactionHistory.Transaction_amount)>
	</cfif>
</cfif>

</cfloop>


<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="font-size:12px;color:###TRIM(AllSettings.TextColour)#;">
<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=50" style="color:###TRIM(AllSettings.BoxColour)#;">Click here</a> to see how to earn points.<cfif session.UserIsAuthenticated EQ 'Yes'><br><br>
Your current point balance is: <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#thistotal# pts</strong></span></cfif><br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="4"  border="0">

	<hr width="100%" size="1" color="##b4b4b4"> 
	
	<cfif rewards.recordcount gt 0>  
			<cfset start = 1>
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<cfloop query="rewards">
					<cfif start eq 1>
						  <tr>
					</cfif> 
							 <td valign="top">   
								<div class="fl badge rounded shadow -ce-capture "> 
									<div class="image clearfix" style="padding: 20px;"> 
										 <cfif FileExists("#request.fileroot#\images\prize\#TRIM(rewards.image)#")>
										 	<img src="#request.imageroot#/prize/#TRIM(rewards.image)#" border="0" width="178" height="110">
										 <cfelse>
											<img src="#request.imageroot#/prize_placeholder.gif" width="178" height="110" border="0">
										 </cfif> 
									 </div>  
									 
									<cfquery name="getRewardCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
										SELECT Title FROM campaigns WHERE CampaignsID = #rewards.related_campaign#
									</cfquery>

									 <div class="project-category" style="height: 39px; line-height: 18px;">   
												 <cfset nameNOHTML = ReReplaceNoCase(TRIM(getRewardCampaigns.Title),"<[^>]*>","","ALL") /> 
												 <strong>Project: </strong>
											     <a href="#request.webroot#/projects/#rewards.related_campaign#" class="name bold" style="text-decoration: none; color: white;" target="_blank">	 
												     #Mid(TRIM(nameNOHTML),1, 30)#
										         </a>
									 </div>
									
									<div class="project-details" style="word-wrap: break-word; color: black; height: 143px; margin-top: 12px;"> 
										 <cfset nameNOHTML = ReReplaceNoCase(TRIM(rewards.name),"<[^>]*>","","ALL") /> 
										    #nameNOHTML# 
										 <p class="description"> 
											 <cfset nameNOHTML = ReReplaceNoCase(TRIM(rewards.description),"<[^>]*>","","ALL") /> 
											 #Mid(TRIM(nameNOHTML),1, 90)#...
										 </p>   
									</div>  
								</div>	  
							 </td>
					<cfif start MOD 3 eq 0>
						  </tr>
						  <tr>
					</cfif> 
					<cfset start = start + 1>
				</cfloop>
			</table> 
	 <cfelse>
	        <table cellpadding="0" cellspacing="0" border="0" width="100%">
			    <tr>
				     <td> 
						  <img src="/images/DataNotFound.jpg" border="0" />
					 </td>
				</tr>
			</table>   		
	 </cfif> 
	
</td>
</tr>

</table>


</cfoutput>