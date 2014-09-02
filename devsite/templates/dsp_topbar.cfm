<cfparam name="fusesubaction" default="">
<cfif IsDefined("session.User_FirstName") and session.User_FirstName neq ''>
    <cfset name = session.User_FirstName>
<cfelse>
    <cfset name = ''>
</cfif>  
<cfinclude template="set_language.cfm">	
<cfif IsDefined("URL.fuseaction") and URL.fuseaction neq ''>
    <cfif URL.fuseaction eq "projects" or URL.fuseaction eq "tasks">
	<cfelse>
	      <!---<script type="text/javascript" src="/js/jquery.min.js"></script>--->
		  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	</cfif>
<cfelse>
   <!--- <script type="text/javascript" src="/js/jquery.min.js"></script>	--->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</cfif>

<cffunction name="getTranslated" output="true" returntype="any">
    <cfargument name="qStr" type="string" default="" required="yes">
    <cfargument name="langpair" type="string" default="" required="yes">
	
	<cfhttp method="Post" url="http://api.mymemory.translated.net/get">  
		<cfhttpparam type="URL" value="#arguments.qStr#" name="q">
		<cfhttpparam type="url" value="#arguments.langpair#" name="langpair"> 
	</cfhttp>
	
	<cfset theData = #cfhttp.filecontent#>  
	<cfset cfData = DeserializeJSON(theData)> 

   <cfreturn #cfData.responseData.translatedText#>
</cffunction>

<script language="javascript" type="text/javascript">
	function intOnlyfn(i)
	{
		if(i.value.length>0)
		{
		     i.value = i.value.replace(/[^\d]+/g, '');
		}
	}
 
    function goToCampaign(url) {
	      window.parent.location.reload = url;  
	} 
</script>
								 
<script type="text/javascript" src="/devsite/js/myJS.js"></script>  
<cfoutput>
<link rel="stylesheet" type="text/css" href="#request.webroot#/css/myCS.css">


<cfinclude template="qry_sub_menu.cfm">

  <!-- Fixed navbar -->
					<div class="navbar navbar-default navbar-fixed-top" role="navigation">
					  <div class="containerNav">
						<div class="navbar-header">
						  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						  </button> 
						  <a class="navbar-brand" href="#request.webroot#/" style="text-decoration: none; color: black;"><!---Crowdsourciiing--->
						      <img src="#request.webroot#/images/CS-LOGO-green-black-360x70.png" border="0" height="35" />
						  </a>
						</div>
						<div class="navbar-collapse collapse">  
						  <ul class="nav navbar-nav navbar-right">  
							<cfif session.UserIsAuthenticated EQ 'Yes'> 
								      <cfinclude template="dsp_drop_menus.cfm">	  
							<cfelse>
							     <cfif fusesubaction NEQ 'step2'> 
							   <li>
							           <a href="#request.webroot#/index.cfm?fuseaction=projects" style="color:black; font-family: Verdana,Geneva,sans-serif; font-size: small; text-decoration: none; width: 100%">Projects</a> 
							  </li>
							  <li>
							           <a href="#request.webroot#/index.cfm?fuseaction=tasks" style="color:black; font-family: Verdana,Geneva,sans-serif; font-size: small; text-decoration: none; width: 100%">Tasks</a> 
							  </li>
							  <li>
								 
									  <cfloop query="basenav">
											<cfif session.UserIsAuthenticated EQ 'Yes'>
													<cfif #TRIM(basenav.fuseaction)# neq "login">
														  <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(basenav.fuseaction)#" style="color:black;font-family:Verdana, Geneva, sans-serif;font-size:small">
															  <cfif IsDefined("Session.defaultlang") and Session.defaultlang neq ''>
																   <cfif Session.defaultlang eq 'fr'>
																		 #MenuFrenchTitle#
																   <cfelse>
																		 #MenuEnglishTitle# 
																   </cfif>
															  <cfelse>
																   #MenuFrenchTitle#
															  </cfif> 
														  </a> 
													</cfif>
											<cfelse>
												   <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(basenav.fuseaction)#" style="color:black;font-family:Verdana, Geneva, sans-serif;font-size:small; text-decoration: none; width: 100%">
														  <cfif IsDefined("Session.defaultlang") and Session.defaultlang neq ''>
																   <cfif Session.defaultlang eq 'fr'>
																		 #MenuFrenchTitle#
																   <cfelse>
																		 #MenuEnglishTitle# 
																   </cfif>
															  <cfelse>
																   #MenuFrenchTitle#
															  </cfif>     
												   </a> 
												   <cfif basenav.currentrow NEQ basenav.recordcount> &nbsp;|&nbsp;</cfif> 
											</cfif> 
									  </cfloop>
							  </li>
							 </cfif>
								<li>
									 <a href="#request.webroot#/index.cfm?fuseaction=join" style="color:black; font-family: Verdana,Geneva,sans-serif; font-size: small; text-decoration: none; width: 100%">#register#</a>  
								</li>  
							</cfif>	 
						  </ul>
						</div><!--/.nav-collapse -->
					  </div>
					</div>
					
					
	<CFIF FindNoCase('MSIE','#CGI.HTTP_USER_AGENT#') GREATER THAN 0 AND FindNoCase('Opera','#CGI.HTTP_USER_AGENT#') LESS THAN 1>
						      <CFSET browser = 'Internet Explorer'>
						<cfelse>
						      <CFSET browser = 'Others'>  
						</CFIF>
					
				   	
 		 
</cfoutput> 