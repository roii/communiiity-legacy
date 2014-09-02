<cfoutput>

<cfif attributes.fusesubaction EQ 'index'>

	<cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(TRIM(SectionDetails.ContactTypeView), session.User_ContactTypeID, ",")) OR (SectionDetails.PublicView EQ 1) OR (session.UserType EQ 'Administrator') OR fuseaction EQ 'Survey' OR fuseaction EQ 'updateprofile' OR fuseaction EQ 'followedproj'>
 
		<cfset this_metatitle = TRIM(SectionDetails.PageTitle)>
		<cfset this_metadescription = TRIM(SectionDetails.MetaContent)>
		<cfset this_metakeywords = TRIM(SectionDetails.MetaKeywords)>
		
	<cfelse>
	
		<script type="text/javascript">
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
		
	<cfelse> <!---gg--->
		
		<cfif session.UserType EQ 'kid'>
		    <script type="text/javascript">
				alert("You don't have administrative rights to access this page.");
				history.back(-1);
			</script>
			<cfabort>
		<cfelse> 
			<script type="text/javascript">
				alert("You must be a member and logged-in to access this page.");
				history.back(-1);
			</script>
			<cfabort>
		</cfif>	
	
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
		
		<script type="text/javascript">
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

<cfinclude template="../#TRIM(attributes.fuseaction)#/index.cfm">


</cfoutput>