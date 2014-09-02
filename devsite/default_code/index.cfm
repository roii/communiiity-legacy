<cfinclude template="app_locals.cfm">


<cfoutput>


<cfif #attributes.fusesubaction# EQ 'index'>

	
	<cfinclude template="../templates/qry_linked_documents.cfm">	
	<cfinclude template="../templates/dsp_section_details.cfm">		
	<!--- <cfinclude template="../templates/dsp_document_list.cfm"> --->



<cfelseif #attributes.fusesubaction# EQ 'docs'>

	<cfinclude template="../templates/qry_document_details.cfm">	
	
	
	<cfif #TRIM(DocumentDetails.PluginModule)# EQ 'news'>
		<cfinclude template="../default_news/index.cfm">	
		
		
	<cfelseif #TRIM(DocumentDetails.PluginModule)# EQ 'events'>
	
		<cfinclude template="../default_events/index.cfm">
		
		
	<cfelseif #TRIM(DocumentDetails.PluginModule)# EQ 'links'>	
		
		<cfinclude template="../default_links/qry_link_cats.cfm">
		<cfinclude template="../default_links/dsp_links.cfm">
		
		
	<cfelseif #TRIM(DocumentDetails.PluginModule)# EQ 'bulletin'>	
		
		<cfinclude template="../templates/dsp_document_details.cfm">
		<cfinclude template="../newsletter/qry_bulletin_list.cfm">
		<cfinclude template="../newsletter/dsp_bulletin_list.cfm">
		
		
	<cfelse>
	
		<cfinclude template="../templates/qry_document_details.cfm">
	
		<cfinclude template="../templates/dsp_document_details.cfm">
	
		<cfinclude template="../templates/qry_linked_articles.cfm">
		<cfinclude template="../templates/dsp_article_list.cfm">
	
		<cfinclude template="../templates/qry_related_downloads.cfm">
		<cfinclude template="../templates/dsp_related_downloads.cfm">

	</cfif>



<cfelseif #attributes.fusesubaction# EQ 'article'>

	<cfinclude template="../templates/qry_document_details.cfm">
	<cfinclude template="../templates/qry_article_details.cfm">
	
	
	
	<cfif #TRIM(ArticleDetails.PluginModule)# EQ 'news'>
		<cfinclude template="../default_news/index.cfm">	
		
		
	<cfelseif #TRIM(ArticleDetails.PluginModule)# EQ 'events'>
	
		<cfinclude template="../default_events/index.cfm">
		
		
	<cfelseif #TRIM(ArticleDetails.PluginModule)# EQ 'links'>	
		
		<cfinclude template="../default_links/qry_link_cats.cfm">
		<cfinclude template="../default_links/dsp_links.cfm">
		
		
	<cfelseif #TRIM(ArticleDetails.PluginModule)# EQ 'bulletin'>	
		
		<cfinclude template="../templates/dsp_document_details.cfm">
		<cfinclude template="../newsletter/qry_bulletin_list.cfm">
		<cfinclude template="../newsletter/dsp_bulletin_list.cfm">
		
		
	<cfelse>	
	
	
		<cfinclude template="../templates/dsp_article_details.cfm">
		
		<cfinclude template="../templates/qry_linked_subarticles.cfm">
		<cfinclude template="../templates/dsp_subarticle_list.cfm">
	
		<cfinclude template="../templates/qry_related_downloads.cfm">
		<cfinclude template="../templates/dsp_related_downloads.cfm">
		
	
	</cfif>



<cfelseif #attributes.fusesubaction# EQ 'subarticle'>

	
	<cfinclude template="../templates/qry_document_details.cfm">
	<cfinclude template="../templates/qry_article_details.cfm">
	<cfinclude template="../templates/qry_subarticle_details.cfm">
	<cfinclude template="../templates/dsp_subarticle_details.cfm">
	
	<cfinclude template="../templates/qry_linked_level4articles.cfm">
	<cfinclude template="../templates/dsp_level4article_list.cfm">
		
		
	<cfinclude template="../templates/qry_related_downloads.cfm">
	<cfinclude template="../templates/dsp_related_downloads.cfm">



<cfelseif #attributes.fusesubaction# EQ 'level4'>

	
	<cfinclude template="../templates/qry_document_details.cfm">
	<cfinclude template="../templates/qry_article_details.cfm">
	<cfinclude template="../templates/qry_subarticle_details.cfm">
	<cfinclude template="../templates/qry_level4_details.cfm">
	<cfinclude template="../templates/dsp_level4_details.cfm">
	
	<cfinclude template="../templates/qry_related_downloads.cfm">
	<cfinclude template="../templates/dsp_related_downloads.cfm">




</cfif>


</cfoutput>