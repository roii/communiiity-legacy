<cfprocessingdirective suppresswhitespace="Yes">

<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="100%" background="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#.gif" height="30" valign="middle" style="background: black;">

<div class="menuRowSet">
   <div class="container clearfix">
			<table cellpadding="0" cellspacing="0" border="0">
			
			<tr>	
			<cfif fusesubaction NEQ 'step2'>
			
			<cfinclude template="qry_main_menu.cfm">
			
			<cfloop query="mainmenu">
			<cfset thisfuseaction = TRIM(mainmenu.fuseaction)>
			
			  <cfif IsDefined("Session.defaultlang") and Session.defaultlang neq ''>
				   <cfif Session.defaultlang eq 'fr'>
						 <cfset menutitle2Disp = #TRIM(mainmenu.MenuFrenchTitle)#>
				   <cfelse>
						 <cfset menutitle2Disp = #TRIM(mainmenu.MenuEnglishTitle)#>
				   </cfif>
			  <cfelse>
				   <cfset menutitle2Disp = #TRIM(mainmenu.MenuFrenchTitle)#>
			  </cfif> 
			<td>
				
				<table cellpadding="0" cellspacing="0" border="0">
				<tr>
				<td width="13" <cfif TRIM(thisfuseaction) EQ attributes.fuseaction>background="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_on2.gif"</cfif>><img src="#request.imageroot#/transparent_spc.gif" width="13" height="30" border="0"></td>
				<td nowrap<cfif TRIM(thisfuseaction) EQ attributes.fuseaction> background="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_on2.gif"</cfif>><a href="#request.webroot#/index.cfm?fuseaction=#thisfuseaction#"><span style="color:<cfif TRIM(thisfuseaction) EQ attributes.fuseaction>##FFFFFF<cfelse>##FFFFFF</cfif>;font-family:Trebuchet MS;font-size:12px;text-decoration:none;"><strong>#menutitle2Disp#</strong></span></a></td>
				<td width="13"<cfif TRIM(mainmenu.fuseaction) EQ attributes.fuseaction> background="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_on2.gif"</cfif>><img src="#request.imageroot#/transparent_spc.gif" width="13" height="30" border="0"></td>
				<td width="1"><img src="#request.imageroot#/navigation/#TRIM(AllSettings.menubarBG_file)#_spc.gif" width="1" height="30" border="0"></td>
				</tr>
				</table>
				
			</td>
			</cfloop>
			</cfif>
			</tr>
			
			</table>
   </div>			
</div>

</td>
</tr>
<cfif fusesubaction NEQ 'step2'>

<cfinclude template="qry_linked_documents.cfm">

</cfif>
<tr>
<td width="100%" bgcolor="##E5E5E5" height="24" style="padding-left:10px;padding-right:10px;">

<div class="rowSet2">
  <div class="container clearfix"> 
	<cfif fusesubaction NEQ 'step2'>
		<cfif (IsDefined("URL.fuseaction") and URL.fuseaction eq 'projectss') or (IsDefined("URL.fuseaction") and URL.fuseaction eq 'tasks') or (IsDefined("URL.fuseaction") and URL.fuseaction eq 'followedproj') or (IsDefined("URL.fuseaction") and URL.fuseaction eq 'myprojects') or (IsDefined("URL.fuseaction") and URL.fuseaction eq 'myprofile')>
		<cfelse>
		    <table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
	<!---   	<td align="center" style="color:black;"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"><br><cfif AllDocuments.RecordCount AND fuseaction NEQ 'benefits'>|&nbsp; </cfif><cfloop query="AllDocuments"><cfset this_contacttypeview = TRIM(AllDocuments.ContactTypeView)><cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFindNoCase(this_contacttypeview, session.User_ContactTypeID, ",")) OR AllDocuments.PublicView CONTAINS 1><a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=docs&documentid=#AllDocuments.documentID#"  style="<cfif (attributes.fusesubaction EQ 'docs' OR attributes.fusesubaction EQ 'BusinessDetails') AND attributes.documentID EQ AllDocuments.DocumentID>background-color:###TRIM(AllSettings.BoxColour)#; padding-left:4px; padding-right:4px; color:white;text-decoration:none;<cfelse>color:Black;text-decoration:underline;</cfif>">#TRIM(AllDocuments.Title)#</a><cfelse><span style="color:595959;" title="Members only area">#TRIM(AllDocuments.Title)#</span></cfif> &nbsp;|&nbsp; </cfloop></td> --->
	    
		<cfif (IsDefined("URL.fuseaction") and URL.fuseaction eq 'projects') or (IsDefined("URL.fuseaction") and URL.fuseaction eq 'projectss')>
		    <td></td>
		<cfelse>
			<td align="center" style="color:black;"> 
			  <cfif IsDefined("URL.fuseaction") and URL.fuseaction eq "updateprofile"> 
			       <p style="font-size: 14px; font-weight: bold; margin: 0 !important; padding: 0 !important;">
				        Edit/Update Profile Section
				   </p>
			  <cfelse> 
				   <img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"><br><cfif AllDocuments.RecordCount AND fuseaction NEQ 'benefits'>|&nbsp; </cfif>
				    <cfloop query="AllDocuments">
						<cfset this_contacttypeview = TRIM(AllDocuments.ContactTypeView)>
						<cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFindNoCase(this_contacttypeview, session.User_ContactTypeID, ",")) OR AllDocuments.PublicView CONTAINS 1>
							  <a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=docs&documentid=#AllDocuments.documentID#"  style="<cfif (attributes.fusesubaction EQ 'docs' OR attributes.fusesubaction EQ 'BusinessDetails') AND attributes.documentID EQ AllDocuments.DocumentID>background-color:##333333; padding-left:4px; padding-right:4px; color:white;text-decoration:none;<cfelse>color:Black;text-decoration:underline;</cfif>">
							       <cfset printV = REReplace(#TRIM(AllDocuments.Title)#, " ", "", "All")> 
								    <cfif printV eq "myPointsaccount">
		  								 #myPointsaccount#	
							        <cfelseif printV eq "myCashaccount">
								         #myCashaccount#
								    <cfelseif printV eq "myEducationaccount">
								   		 #myEducationaccount# 	
								    <cfelseif printV eq "Moneymanagement">
								   		 #Moneymanagement#
								    <cfelseif printV eq "Howitworks">
								   		 #Howitworks#
								    <cfelseif printV eq "PurchasePoints">
								   		 #purchasepts#	 
									<cfelseif printV eq "Tirages">
								   		 #Tirages#
									<cfelseif printV eq "Récompenses">
								   		 #Awards#
									<cfelseif printV eq "Listedeprix">
								   		 #pricelist#
									<cfelseif printV eq "Lecercledesgagnants">
								   		 #Thewinnerscircle#
									<cfelseif printV eq "Commentçamarche">
								   		 #Howitworks#
									<cfelseif printV eq "Suggestionsderécompense">
								   		 #Suggestionsreward#  
								   <cfelse>
								         #TRIM(AllDocuments.Title)#		   
		                           </cfif>		   
							  </a>
						<cfelse>
							  <span style="color:595959;" title="Members only area">
							       <cfset printV = REReplace(#TRIM(AllDocuments.Title)#, " ", "", "All")>  
								    <cfif printV eq "myPointsaccount">
		  								 #myPointsaccount#	
							        <cfelseif printV eq "myCashaccount">
								         #myCashaccount#
								    <cfelseif printV eq "myEducationaccount">
								   		 #myEducationaccount# 	
								    <cfelseif printV eq "Moneymanagement">
								   		 #Moneymanagement#
								    <cfelseif printV eq "Howitworks">
								   		 #Howitworks#
								    <cfelseif printV eq "PurchasePoints">
								   		 #purchasepts#	 
									<cfelseif printV eq "Tirages">
								   		 #Tirages#
									<cfelseif printV eq "Récompenses">
								   		 #Awards#
									<cfelseif printV eq "Listedeprix">
								   		 #pricelist#
									<cfelseif printV eq "Lecercledesgagnants">
								   		 #Thewinnerscircle#
									<cfelseif printV eq "Commentçamarche">
								   		 #Howitworks#
									<cfelseif printV eq "Suggestionsderécompense">
								   		 #Suggestionsreward#  
								   <cfelse>
								         #TRIM(AllDocuments.Title)#		   
		                           </cfif>			
							  </span>
						</cfif> 
						&nbsp;|&nbsp; 
			        </cfloop>
			   </cfif>	   
			</td>
		 </cfif>
		 	
		</tr>
		
		</table> 
		</cfif>
	</cfif>
  </div>	
</div>

</td>
</tr>

</table>
</cfoutput> 

</cfprocessingdirective> 
