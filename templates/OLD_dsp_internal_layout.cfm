<cfoutput>

<cfif attributes.fusesubaction EQ 'index'>

	
	<cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(TRIM(SectionDetails.ContactTypeView), session.User_ContactTypeID, ",")) OR (SectionDetails.PublicView EQ 1) OR (session.UserType EQ 'Administrator') OR fuseaction EQ 'Survey'>

		<cfset this_metatitle = TRIM(SectionDetails.PageTitle)>
		<cfset this_metadescription = TRIM(SectionDetails.MetaContent)>
		<cfset this_metakeywords = TRIM(SectionDetails.MetaKeywords)>
		
	<cfelse>
		
		<script>
		alert("You must be a member and logged-in to access this page.");
		history.back(-1);
		</script>
		<cfabort>
	
	</cfif>

<cfelseif attributes.fusesubaction EQ 'docs'>

	<cfinclude template="../templates/qry_document_details.cfm">	
	<cfinclude template="../templates/qry_document_details.cfm">
	<cfinclude template="../templates/qry_linked_articles.cfm">
	
	<cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(TRIM(DocumentDetails.ContactTypeView), session.User_ContactTypeID, ",")) OR (DocumentDetails.PublicView EQ 1) OR (session.UserType EQ 'Administrator')>
	
		<cfset this_metatitle = TRIM(DocumentDetails.PageTitle)>
		<cfset this_metadescription = TRIM(DocumentDetails.MetaContent)>
		<cfset this_metakeywords = TRIM(DocumentDetails.MetaKeywords)>
		
	<cfelse>
		
		<script>
		alert("You must be a member and logged-in to access this page.");
		history.back(-1);
		</script>
		<cfabort>
	
	</cfif>

	
<cfelseif attributes.fusesubaction EQ 'article'>

	<cfinclude template="../templates/qry_document_details.cfm">
	<cfinclude template="../templates/qry_article_details.cfm">
	<cfinclude template="../templates/qry_linked_subarticles.cfm">
	
	<cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(TRIM(ArticleDetails.ContactTypeView), session.User_ContactTypeID, ",")) OR (ArticleDetails.PublicView EQ 1) OR (session.UserType EQ 'Administrator')>
	
		<cfset this_metatitle = TRIM(ArticleDetails.PageTitle)>
		<cfset this_metadescription = TRIM(ArticleDetails.MetaContent)>
		<cfset this_metakeywords = TRIM(ArticleDetails.MetaKeywords)>
			
	<cfelse>
		
		<script>
		alert("You must be a member and logged-in to access this page.");
		history.back(-1);
		</script>
		<cfabort>
	
	</cfif>
	

<cfelseif attributes.fusesubaction EQ 'subarticle'>
	
	<cfinclude template="../templates/qry_document_details.cfm">
	<cfinclude template="../templates/qry_article_details.cfm">
	<cfinclude template="../templates/qry_subarticle_details.cfm">	
	<cfinclude template="../templates/qry_linked_level4articles.cfm">
	
	
	<cfset this_metatitle = TRIM(SubArticleDetails.SubArticleTitle)>
	<cfset this_metadescription = TRIM(ArticleDetails.MetaContent)>
	<cfset this_metakeywords = TRIM(ArticleDetails.MetaKeywords)>

<cfelseif attributes.fusesubaction EQ 'level4'>
	
	<cfinclude template="../templates/qry_document_details.cfm">
	<cfinclude template="../templates/qry_article_details.cfm">
	<cfinclude template="../templates/qry_subarticle_details.cfm">
	<cfinclude template="../templates/qry_level4_details.cfm">

</cfif>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title><cfif IsDefined("this_metatitle")>#TRIM(this_metatitle)#<cfelse>#TRIM(session.AllSettings_SiteName)#</cfif></title>

<cfif IsDefined("this_metadescription")>
	<meta name="Description" content="#TRIM(this_metadescription)#">
</cfif>

<cfif IsDefined("this_metakeywords")>
	<meta name="Keywords" content="#TRIM(this_metakeywords)#">
</cfif>


<cfinclude template="styles.cfm">

</head>

<body leftmargin="5" topmargin="0" rightmargin="5" bottommargin="0" marginwidth="5" marginheight="0" bgcolor="##FFFFFF" text="###session.AllSettings_TextColour#">


<table width="100%" cellpadding="0" cellspacing="0" border="0">


<!--- HEADER BAR - Logo / Subnav / Advert --->

<tr>
<td colspan="3">
	<cfinclude template="dsp_topbar.cfm">
</td>
</tr>


<!--- NAVIGATION BAR - Main Navigation --->

<tr>
<td colspan="3">
	<cfinclude template="dsp_menubar.cfm">
</td>
</tr>



<!--- MAIN LAYOUT - Leftside column, main column, rightside column --->

<tr>


<td width="170" valign="top">
	<cfinclude template="dsp_internal_Lsidebar.cfm">
</td>


<td width="*" valign="top" style="padding-left:10px;padding-right:10px;">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="459" height="8" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	
	<td width="100%" style="padding-left:10px;padding-right:10px;">
		
		<cfinclude template="../#TRIM(attributes.fuseaction)#/index.cfm">
		
	</td>
	
	
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	
	</tr>
	
	</table>
	
	
</td>



<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
	<td width="0"></td>
<cfelse>
	<td width="170" valign="top" align="right">
		<cfinclude template="dsp_internal_Rsidebar.cfm">	
	</td>
</cfif>


</tr>



<!--- BOTTOM BAR - Copyright --->

<tr>
<td colspan="3">
	<cfinclude template="dsp_bottombar.cfm">
</td>
</tr>


</table>

<cfinclude template="dsp_partners.cfm">

</body>
</html>

</cfoutput>