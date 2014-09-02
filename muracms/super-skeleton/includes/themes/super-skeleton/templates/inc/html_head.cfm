<!---
		Font Options: Serif, Sans (empty for default)
		Style Options: Dark, Clean (empty for default)
--->
<!--- Uncomment to permanently set these values 
<cfset session.themeFont = '' />
<cfset session.themeStyle = '' />
--->

<cfoutput>
<!doctype html>
<!--[if lt IE 7 ]><html class="ie ie6 #htmleditformat(session.themeStyle)#" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7 #htmleditformat(session.themeStyle)#" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8 #htmleditformat(session.themeStyle)#" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en" class="#htmleditformat(session.themeStyle)#"> <!--<![endif]-->
<head>

	<!-- Basic Page Needs
  	================================================== -->
	<meta charset="utf-8" />
	<meta name="description" content="#HTMLEditFormat($.getMetaDesc())#" />
	<meta name="keywords" content="#HTMLEditFormat($.getMetaKeywords())#" />
	<cfif request.contentBean.getCredits() neq "">
		<meta name="author" content="#HTMLEditFormat($.content('credits'))#" />
	</cfif>
	<meta name="generator" content="Mura CMS #$.globalConfig('version')#" />
	<!--- use this to discourage search engines from indexing your site. (can be useful if developing on a live server for example) Delete if not needed. --->
	<!--- <meta name="robots" content="noindex, nofollow" /> --->	
	<title>#HTMLEditFormat($.content('HTMLTitle'))# - #HTMLEditFormat($.siteConfig('site'))#</title>
	<!--[if lt IE 9]>  
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	
	<!-- Mobile Specific Metas
  	================================================== -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
	
	<!-- CSS
  	================================================== -->
  	<!--- Shared Styles (Mura) --->	
  	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/css/reset.min.css" type="text/css" media="all" />
  	<link rel="stylesheet" href="#$.siteConfig('assetPath')#/css/mura.min.css" type="text/css" media="all" />
  	<!--- Theme-Specific Styles --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/stylesheets/styles.css" />
	
	
	<cfswitch expression="#session.themeFont#">
		<cfcase value="serif">
			<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/stylesheets/typography-serif.css" />
		</cfcase>
		<cfcase value="sans">
			<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/stylesheets/typography-sans.css" />
		</cfcase>
	</cfswitch>
	
	<cfswitch expression="#session.themeStyle#">
		<cfcase value="clean">
			<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/stylesheets/skin-clean.css" />
		</cfcase>
		<cfcase value="dark">
			<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/stylesheets/skin-dark.css" />
		</cfcase>
		<cfcase value="light">
			<!--- Just resetting default style--->
		</cfcase>
	</cfswitch>
		
	<!--- Mura-specific overrides --->
	<link rel="stylesheet" href="#$.siteConfig('themeAssetPath')#/assets/stylesheets/extended.css" />

	<!--- jQuery --->
	<script src="#$.siteConfig('assetPath')#/jquery/jquery.js"></script>
	
	<!-- Favicons
	================================================== -->
	<link rel="shortcut icon" href="#$.siteConfig('themeAssetPath')#/assets/images/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="#$.siteConfig('themeAssetPath')#/assets/images/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="#$.siteConfig('themeAssetPath')#/assets/images/favicon.ico" />
	<link rel="apple-touch-icon" href="#$.siteConfig('themeAssetPath')#/assets/images/apple-touch-icon.png" />
	<link rel="apple-touch-icon" sizes="72x72" href="#$.siteConfig('themeAssetPath')#/assets/images/apple-touch-icon-72x72.png" />
	<link rel="apple-touch-icon" sizes="114x114" href="#$.siteConfig('themeAssetPath')#/assets/images/apple-touch-icon-114x114.png" />
	
	<cfset rs=$.getBean('feedManager').getFeeds($.event('siteID'),'Local',true,true) />
	<cfloop query="rs">
	<link rel="alternate" type="application/rss+xml" title="#HTMLEditFormat($.siteConfig('site'))# - #HTMLEditFormat(rs.name)#" href="#XMLFormat('http://#listFirst(cgi.http_host,":")##$.globalConfig('context')#/tasks/feed/?feedID=#rs.feedID#')#" />
	</cfloop>
</head>
</cfoutput>