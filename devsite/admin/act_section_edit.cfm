<cfquery name="UpdateSection" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Sections
SET FrenchTitle='#form.FrenchTitle#',
MenuFrenchTitle='#form.MenuFrenchTitle#',

EnglishTitle='#form.EnglishTitle#',
MenuEnglishTitle='#form.MenuEnglishTitle#',

<cfif IsDefined("form.HomepageContent")>
	HomepageContent = '#form.HomepageContent#',
</cfif>

<cfif IsDefined("form.MainMenu") AND form.MainMenu EQ 1>
	MainMenu=1,
<cfelse>
	MainMenu=0,
</cfif>

<cfif IsDefined("form.TopMenu") AND form.TopMenu EQ 1>
	TopMenu=1,
<cfelse>
	TopMenu=0,
</cfif>

<cfif IsDefined("form.BottomMenu") AND form.BottomMenu EQ 1>
	BottomMenu=1,
<cfelse>
	BottomMenu=0,
</cfif>

<cfif IsDefined("form.MainMenuOrder")>
	MainMenuOrder=#form.MainMenuOrder#,
<cfelse>
	MainMenuOrder=0,
</cfif>

<cfif IsDefined("form.AdminView")>
	AdminView=1,
<cfelse>
	AdminView=0,
</cfif>

<cfif IsDefined("form.PublicView")>
	PublicView=1,
<cfelse>
	PublicView=0,
</cfif>

<cfif IsDefined("form.ContactTypeView")>
	ContactTypeView='#form.ContactTypeView#',
<cfelse>
	ContactTypeView='0',
</cfif>

Details = '#form.details#',
PageTitle='#form.PageTitle#',
MetaContent='#form.MetaContent#',
MetaKeywords='#form.MetaKeywords#',
<cfif IsDefined("form.DHTML_POS") and form.DHTML_POS neq ''>
DHTML_POS=#form.DHTML_POS#,
<cfelse>
DHTML_POS=0,
</cfif> 
<cfif IsDefined("form.DHTML_POS_LOGIN") and form.DHTML_POS_LOGIN neq ''>
DHTML_POS_LOGIN=#form.DHTML_POS_LOGIN#
<cfelse>
DHTML_POS_LOGIN=0
</cfif>


WHERE SectionID = #form.SectionID#
</cfquery>


<cfset logdetails = 'Edit Section - (Section: #form.fuseaction#)'>
<cfinclude template="act_adminlog.cfm">




<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#')"></body>
	
	
	</cfoutput>