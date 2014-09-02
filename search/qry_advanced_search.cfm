<cfif IsDefined("UsePubDate")>

	<cfset Pub_StartDate='#PublicationDate_startday#' & ' ' & '#PublicationDate_startmonth#' & ' ' & '#PublicationDate_startyear#'>

	<cfset Pub_EndDate='#PublicationDate_endday#' & ' ' & '#PublicationDate_endmonth#' & ' ' & '#PublicationDate_endyear#'>

</cfif>





<!--- DOCUMENTS / PAGES --->

<cfif (#SearchType# EQ 'Documents') OR (#SearchType# EQ 'ALL')>


	<!--- SECTIONS --->
	
	<cfquery name="SectionResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SectionID, Fuseaction, Title
	FROM Sections
	WHERE SectionID<>0
	
	<cfif (IsDefined("keywords")) AND (#TRIM(keywords)# NEQ '')>
	AND (
	
	(Title LIKE '%#keywords#%' OR Introduction LIKE '%#keywords#%' OR Details LIKE '%#keywords#%')

	<cfif (IsDefined("keywords2")) AND (#TRIM(keywords2)# NEQ '') AND (#Operator1# NEQ 'NONE')>
	#Operator1# (Title LIKE '%#keywords2#%' OR Introduction LIKE '%#keywords2#%' OR Details LIKE '%#keywords2#%')
	</cfif>
	
	<cfif (IsDefined("keywords3")) AND (#TRIM(keywords3)# NEQ '') AND (#Operator2# NEQ 'NONE')>
	#Operator2# (Title LIKE '%#keywords3#%' OR Introduction LIKE '%#keywords3#%' OR Details LIKE '%#keywords3#%')
	</cfif>

	)
	
	</cfif>	
	
	</cfquery>
	
	
	
	<!--- DOCUMENTS --->
	
	<cfquery name="DocumentResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT DocumentID, Title, PubDate
	FROM Documents
	WHERE DocumentID<>0
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<cfelse>
	
	AND Released=1
	
		<cfif session.UserIsAuthenticated EQ 'no'>
		AND NonMember=1
		<cfelse>
		AND Member=1
		</cfif>
	
	</cfif>
	
		
	<cfif (IsDefined("keywords")) AND (#TRIM(keywords)# NEQ '')>
	AND (
	
	(Title LIKE '%#keywords#%' OR Introduction LIKE '%#keywords#%' OR Details LIKE '%#keywords#%')

	<cfif (IsDefined("keywords2")) AND (#TRIM(keywords2)# NEQ '') AND (#Operator1# NEQ 'NONE')>
	#Operator1# (Title LIKE '%#keywords2#%' OR Introduction LIKE '%#keywords2#%' OR Details LIKE '%#keywords2#%')
	</cfif>
	
	<cfif (IsDefined("keywords3")) AND (#TRIM(keywords3)# NEQ '') AND (#Operator2# NEQ 'NONE')>
	#Operator2# (Title LIKE '%#keywords3#%' OR Introduction LIKE '%#keywords3#%' OR Details LIKE '%#keywords3#%')
	</cfif>

	)
	
	</cfif>
	
	
	
	<cfif IsDefined("UsePubDate")>
	AND PubDate >= #CreateODBCDate(Pub_StartDate)#
	AND PubDate <= #CreateODBCDate(Pub_EndDate)#	
	</cfif>
	
	
	<cfif IsDefined("UseAuthor")>
	AND Author LIKE '%#Author#%'
	</cfif>
	
		
	AND (DocExpireDate > #now()# 
	OR DocExpireDate IS NULL)
	
	</cfquery>
	
	
	
	<!--- ARTICLES --->
	
	<cfquery name="ArticleResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ArticleID, ArticleTitle, PubDate
	FROM Articles
	WHERE ArticleID<>0
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<cfelse>
	
	AND Released=1
	
		<cfif session.UserIsAuthenticated EQ 'no'>
		AND NonMember=1
		<cfelse>
		AND Member=1
		</cfif>
	
	</cfif>
	
		
	<cfif (IsDefined("keywords")) AND (#TRIM(keywords)# NEQ '')>
	AND (
	
	(ArticleTitle LIKE '%#keywords#%' OR Introduction LIKE '%#keywords#%' OR Details LIKE '%#keywords#%')

	<cfif (IsDefined("keywords2")) AND (#TRIM(keywords2)# NEQ '') AND (#Operator1# NEQ 'NONE')>
	#Operator1# (ArticleTitle LIKE '%#keywords2#%' OR Introduction LIKE '%#keywords2#%' OR Details LIKE '%#keywords2#%')
	</cfif>
	
	<cfif (IsDefined("keywords3")) AND (#TRIM(keywords3)# NEQ '') AND (#Operator2# NEQ 'NONE')>
	#Operator2# (ArticleTitle LIKE '%#keywords3#%' OR Introduction LIKE '%#keywords3#%' OR Details LIKE '%#keywords3#%')
	</cfif>

	)
	
	</cfif>
	
	
	
	<cfif IsDefined("UsePubDate")>
	AND PubDate >= #CreateODBCDate(Pub_StartDate)#
	AND PubDate <= #CreateODBCDate(Pub_EndDate)#	
	</cfif>
	
	
	<cfif IsDefined("UseAuthor")>
	AND Author LIKE '%#Author#%'
	</cfif>
	
		
	AND (ExpireDate > #now()# 
	OR ExpireDate IS NULL)
	
	</cfquery>
	
	
	
	<!--- SUBARTICLES --->
	
	<cfquery name="SubArticleResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SubArticleID, SubArticleTitle, PubDate
	FROM SubArticles
	WHERE SubArticleID<>0
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<cfelse>
	
	AND SubReleased=1
	
		<cfif session.UserIsAuthenticated EQ 'no'>
		AND NonMember=1
		<cfelse>
		AND Member=1
		</cfif>
	
	</cfif>
	
		
	<cfif (IsDefined("keywords")) AND (#TRIM(keywords)# NEQ '')>
	AND (
	
	(SubArticleTitle LIKE '%#keywords#%' OR SubIntroduction LIKE '%#keywords#%' OR SubDetails LIKE '%#keywords#%')

	<cfif (IsDefined("keywords2")) AND (#TRIM(keywords2)# NEQ '') AND (#Operator1# NEQ 'NONE')>
	#Operator1# (SubArticleTitle LIKE '%#keywords2#%' OR SubIntroduction LIKE '%#keywords2#%' OR SubDetails LIKE '%#keywords2#%')
	</cfif>
	
	<cfif (IsDefined("keywords3")) AND (#TRIM(keywords3)# NEQ '') AND (#Operator2# NEQ 'NONE')>
	#Operator2# (SubArticleTitle LIKE '%#keywords3#%' OR SubIntroduction LIKE '%#keywords3#%' OR SubDetails LIKE '%#keywords3#%')
	</cfif>

	)
	
	</cfif>
	
	
	
	<cfif IsDefined("UsePubDate")>
	AND PubDate >= #CreateODBCDate(Pub_StartDate)#
	AND PubDate <= #CreateODBCDate(Pub_EndDate)#	
	</cfif>
	
	
	<cfif IsDefined("UseAuthor")>
	AND Author LIKE '%#Author#%'
	</cfif>
	
		
	AND (SubExpireDate > #now()# 
	OR SubExpireDate IS NULL)
	
	</cfquery>
	
	


</cfif>







<!--- EVENTS --->

<cfif (#SearchType# EQ 'Events') OR (#SearchType# EQ 'ALL')>


	
	<cfquery name="EventResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventID, EventTitle
	FROM Events
	WHERE EventID<>0
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<cfelse>
		
		<cfif session.UserIsAuthenticated EQ 'no'>
		AND NonMember=1
		<cfelse>
		AND Member=1
		</cfif>
	
	</cfif>
	
		
	<cfif (IsDefined("keywords")) AND (#TRIM(keywords)# NEQ '')>
	AND (
	
	(EventTitle LIKE '%#keywords#%' OR Venue LIKE '%#keywords#%' OR Details LIKE '%#keywords#%')

	<cfif (IsDefined("keywords2")) AND (#TRIM(keywords2)# NEQ '') AND (#Operator1# NEQ 'NONE')>
	#Operator1# (EventTitle LIKE '%#keywords2#%' OR Venue LIKE '%#keywords2#%' OR Details LIKE '%#keywords2#%')
	</cfif>
	
	<cfif (IsDefined("keywords3")) AND (#TRIM(keywords3)# NEQ '') AND (#Operator2# NEQ 'NONE')>
	#Operator2# (EventTitle LIKE '%#keywords3#%' OR Venue LIKE '%#keywords3#%' OR Details LIKE '%#keywords3#%')
	</cfif>

	)
	
	</cfif>
	
	
	
	<cfif IsDefined("UsePubDate")>
	AND StartDate >= #CreateODBCDate(Pub_StartDate)#
	AND StartDate <= #CreateODBCDate(Pub_EndDate)#	
	</cfif>
	
	
	<cfif IsDefined("UseAuthor")>
	AND FurtherInfo LIKE '%#Author#%'
	</cfif>
	
	
	</cfquery>



</cfif>







<!--- DOWNLOADS --->

<cfif (#SearchType# EQ 'Downloads') OR (#SearchType# EQ 'ALL')>


	
	<cfquery name="DownloadResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT RecordID, Title, DateUploaded
	FROM Library
	WHERE RecordID<>0
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<cfelse>
	
		AND Released=1
		
		
		<cfif session.UserIsAuthenticated EQ 'no'>
		AND NonMember=1
		<cfelse>
		AND Member=1
		</cfif>
	
	</cfif>
	
		
	<cfif (IsDefined("keywords")) AND (#TRIM(keywords)# NEQ '')>
	AND (
	
	(Title LIKE '%#keywords#%' OR Filename LIKE '%#keywords#%' OR Details LIKE '%#keywords#%')

	<cfif (IsDefined("keywords2")) AND (#TRIM(keywords2)# NEQ '') AND (#Operator1# NEQ 'NONE')>
	#Operator1# (Title LIKE '%#keywords2#%' OR Filename LIKE '%#keywords2#%' OR Details LIKE '%#keywords2#%')
	</cfif>
	
	<cfif (IsDefined("keywords3")) AND (#TRIM(keywords3)# NEQ '') AND (#Operator2# NEQ 'NONE')>
	#Operator2# (Title LIKE '%#keywords3#%' OR Filename LIKE '%#keywords3#%' OR Details LIKE '%#keywords3#%')
	</cfif>

	)
	
	</cfif>
	
	
	
	<cfif IsDefined("UsePubDate")>
	AND DateUploaded >= #CreateODBCDate(Pub_StartDate)#
	AND DateUploaded <= #CreateODBCDate(Pub_EndDate)#	
	</cfif>
	
	
	<cfif IsDefined("UseAuthor")>
	AND Author LIKE '%#Author#%'
	</cfif>	
		
	AND (DateExpires > #now()# 
	OR DateExpires IS NULL)
	</cfquery>



</cfif>







<!--- NEWS ARTICLES --->

<cfif (#SearchType# EQ 'News') OR (#SearchType# EQ 'ALL')>


	
	<cfquery name="NewsResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT RecordID, Title, ReleasedDate
	FROM News
	WHERE RecordID<>0
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<cfelse>
	
		AND Released=1
		
		
		<cfif session.UserIsAuthenticated EQ 'no'>
		AND NonMember=1
		<cfelse>
		AND Member=1
		</cfif>
	
	</cfif>
	
		
	<cfif (IsDefined("keywords")) AND (#TRIM(keywords)# NEQ '')>
	AND (
	
	(Title LIKE '%#keywords#%' OR Introduction LIKE '%#keywords#%' OR Details LIKE '%#keywords#%')

	<cfif (IsDefined("keywords2")) AND (#TRIM(keywords2)# NEQ '') AND (#Operator1# NEQ 'NONE')>
	#Operator1# (Title LIKE '%#keywords2#%' OR Introduction LIKE '%#keywords2#%' OR Details LIKE '%#keywords2#%')
	</cfif>
	
	<cfif (IsDefined("keywords3")) AND (#TRIM(keywords3)# NEQ '') AND (#Operator2# NEQ 'NONE')>
	#Operator2# (Title LIKE '%#keywords3#%' OR Introduction LIKE '%#keywords3#%' OR Details LIKE '%#keywords3#%')
	</cfif>

	)
	
	</cfif>
	
	
	
	<cfif IsDefined("UsePubDate")>
	AND ReleasedDate >= #CreateODBCDate(Pub_StartDate)#
	AND ReleasedDate <= #CreateODBCDate(Pub_EndDate)#	
	</cfif>
	
		
	AND (NewsExpireDate > #now()# 
	OR NewsExpireDate IS NULL)
	</cfquery>



</cfif>
