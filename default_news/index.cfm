<cfinclude template="app_locals.cfm">


<cfif #newsmode# EQ 'current'>

	
		<cfinclude template="../default_news/qry_news_cats.cfm">
		<cfinclude template="../default_news/dsp_current_news.cfm">	
	
	
<cfelseif #newsmode# EQ 'archive'>
	
		<cfinclude template="../default_news/qry_news_cats.cfm">
		<cfinclude template="../default_news/dsp_past_news.cfm">


<cfelseif #newsmode# EQ 'template'>

	<cfinclude template="../default_news/qry_news_ind.cfm">
	<cfinclude template="../default_news/dsp_news_template.cfm">
	
	<cfinclude template="../templates/qry_related_downloads.cfm">
	<cfinclude template="../templates/dsp_related_downloads.cfm">

</cfif>