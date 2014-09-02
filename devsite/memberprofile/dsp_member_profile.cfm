<cfif isDefined("contact")>
	<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM Contacts
	WHERE ContactID=#contact#
	</cfquery>
<cfelseif IsDefined("member")>
	<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM Contacts
	WHERE ScreenName LIKE '#member#'
	</cfquery>
</cfif>

<cfif ContactDetails.recordcount>

	<cfquery name="ProFileStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM UserProfiles
	WHERE UserID=#ContactDetails.ContactID#
	</cfquery>    
    
    <cfquery name="CountryDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Name
	FROM Countries
	WHERE CountryID=#ContactDetails.CountryID#
	</cfquery>	
	
	<cfquery name="CharityDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Organisation_Name
	FROM Organisations	
	<cfif IsNumeric("#ContactDetails.Charity#")>
		WHERE OrganisationID=#ContactDetails.Charity#
	<cfelse>
		WHERE OrganisationID=0
	</cfif>	
	</cfquery>	
	
	<cfquery name="PointsIn" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalPointsIn
	FROM contact_transactions
	WHERE ContactID = #ContactDetails.contactID#
	AND Transaction_Type LIKE '%credit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#PointsIn.TotalPointsIn#")>
		<cfset TotalUserPointsIn = INT(PointsIn.TotalPointsIn)>
	<cfelse>
		<cfset TotalUserPointsIn = 0>
	</cfif>
		
	<cfif IsDate("#ContactDetails.DateJoined#") AND DateCompare(ContactDetails.DateJoined, "1-Nov-2005") EQ -1>
		<cfset pointsStartMonth = "1-Nov-2005">
	<cfelseif IsDate("#ContactDetails.DateJoined#")>
		<cfset pointsStartMonth = ContactDetails.DateJoined>
	<cfelse>
		<cfset pointsStartMonth = "1-Nov-2005">
	</cfif>
	
	<cfset MemberMonths = DateDiff('m', pointsstartmonth, localdatetime)>
	
	<cfif MemberMonths LT 1>
		<cfset MemberMonths = 1>
	</cfif>	
	
	<cfif IsNumeric("#TotalUserPointsIn#") AND TotalUserPointsIn GT 0>
		<cfset avgPointsMonth = (TotalUserPointsIn / MemberMonths)>
	 <cfelse>
	 	<cfset avgPointsMonth = 0>
	 </cfif>	 
	 
	 <cfoutput>
	
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(SectionDetails.Title))#</strong></td>
	<td align="right" width="30" height="20"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" onclick="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a></cfif></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
	</tr>
	
	<cfif (TRIM(sectiondetails.details) NEQ '') AND (sectiondetails.details NEQ '<P>&nbsp;</P>')>		
		
		<tr>
		<td colspan="2">#TRIM(sectiondetails.details)#</td>
		</tr>
	
	</cfif>	
		
	</table>
	
	
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="100%" style="font-size:18px;color:###TRIM(AllSettings.BoxColour)#;"><strong><cfif TRIM(ContactDetails.ScreenName) NEQ ''>#TRIM(ContactDetails.ScreenName)#<cfelse>#TRIM(ContactDetails.FirstName)#</cfif></strong></td>
	</tr>
	
    <cfif ProFileStuff.recordCount>
	<tr>
	<td width="100%"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100%" style="color:###TRIM(AllSettings.DkTextColor)#;">
	    
        <cfif ProFileStuff.ProfilePic1 NEQ '' AND ProFileStuff.ProfilePic1 NEQ '' AND ProFileStuff.ProfilePic1 NEQ ''>
        
        <table border="0" cellpadding="10" cellspacing="0" align="center">
        <tr>
        <cfif fileexists("#request.fileroot#\memberprofile\#TRIM(ContactDetails.ScreenName)#\#TRIM(ProFileStuff.ProfilePic1)#")>
	    <td><img src="#request.webroot#/memberprofile/#TRIM(ContactDetails.ScreenName)#/#TRIM(ProFileStuff.ProfilePic1)#" border="0"></td>
        </cfif>
        <cfif fileexists("#request.fileroot#\memberprofile\#TRIM(ContactDetails.ScreenName)#\#TRIM(ProFileStuff.ProfilePic2)#")>
	    <td><img src="#request.webroot#/memberprofile/#TRIM(ContactDetails.ScreenName)#/#TRIM(ProFileStuff.ProfilePic2)#" border="0"></td>
        </cfif>
        <cfif fileexists("#request.fileroot#\memberprofile\#TRIM(ContactDetails.ScreenName)#\#TRIM(ProFileStuff.ProfilePic3)#")>
	    <td><img src="#request.webroot#/memberprofile/#TRIM(ContactDetails.ScreenName)#/#TRIM(ProFileStuff.ProfilePic3)#" border="0"></td>
        </cfif>
        </tr>
        </table><br><br>
        </cfif> 
    
    <strong>About Me:</strong><br>
    #TRIM(ProFileStuff.ProfileText)#<br><br>
    </td>
	</tr>
	</cfif>
    
    
	<tr>
	<td width="100%"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100%">	
	
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		
		<tr>
		<td width="120"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"></td>
		<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>		
		
		<cfif TRIM(ContactDetails.City) NEQ ''>
		
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>City:</strong></td>
			<td>#TRIM(ContactDetails.City)#</td>
			</tr>
			
			<tr>
			<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
			</tr>
		
		</cfif>		
		
		<cfif IsDefined("CountryDetails") AND CountryDetails.RecordCount>
		
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Country:</strong></td>
			<td>#TRIM(CountryDetails.Name)#</td>
			</tr>
			
			<tr>
			<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
			</tr>
			
		</cfif>
	
		<tr>
		<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Member Since:</strong></td>
		<td>#DateFormat(ContactDetails.DateJoined, "d mmmm yyyy")#</td>
		</tr>
			
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
		</tr>
	
		<cfif IsDefined("CharityDetails") AND CharityDetails.RecordCount>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Sponsored Charity:</strong></td>
			<td>#TRIM(CharityDetails.Organisation_Name)#</td>
			</tr>
			
			<tr>
			<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
			</tr>
			
		</cfif>
			
		</table>		
	
	</td>
	</tr>
	
	<tr>
	<td width="100%"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserID EQ ContactDetails.contactID>
		
		<tr>
		<td width="100%">
		<li style="color:###TRIM(AllSettings.DkTextColor)#;"><a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=41&mode=personal">Change my Personal Details</a>
        <li style="color:###TRIM(AllSettings.DkTextColor)#;"><a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=41&mode=profile">Change my Profile and Images</a>
		<li style="color:###TRIM(AllSettings.DkTextColor)#;"><a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=90">Change my Shipping Address</a>
		<li style="color:###TRIM(AllSettings.DkTextColor)#;"><a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=42">Change my Account Details</a></td>
		</tr>
		
		<tr>
		<td width="100%"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
	
	</cfif>	
		
	<tr>
	<td width="100%"><br>		
		<cfinclude template="dsp_member_profile_ideas.cfm">	
	</td>
	</tr>
	
	
	<tr>
	<td width="100%"><br>		
		<cfinclude template="dsp_member_profile_goals.cfm">	
	</td>
	</tr>
	
	
	<tr>
	<td width="100%"><br>		
		<cfinclude template="dsp_member_profile_business.cfm">	
	</td>
	</tr>
	
	<cfif IsDefined("TotalUserPointsIn") AND TotalUserPointsIn GT 0>
	
		<tr>
		<td width="100%"><br>			
			<cfinclude template="dsp_member_profile_points.cfm">		
		</td>
		</tr>
	
	</cfif>
	
	</table>	
	
	</cfoutput>

</cfif>
