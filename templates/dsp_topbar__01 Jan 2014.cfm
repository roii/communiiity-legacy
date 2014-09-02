<cfparam name="fusesubaction" default="">
<cfif IsDefined("session.User_FirstName") and session.User_FirstName neq ''>
    <cfset name = session.User_FirstName>
<cfelse>
    <cfset name = ''>
</cfif>  

<cfif IsDefined("URL.fuseaction") and URL.fuseaction neq ''>
    <cfif URL.fuseaction eq "projects" or URL.fuseaction eq "tasks">
	<cfelse>
	      <script type="text/javascript" src="../js/jquery.min.js"></script>
	</cfif>
<cfelse>
    <script type="text/javascript" src="../js/jquery.min.js"></script>	
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
								 
<script type="text/javascript" src="../js/myJS.js"></script>  
<link rel="stylesheet" type="text/css" href="../css/myCS.css">
<cfoutput>
<cfinclude template="set_language.cfm">	
<cfinclude template="qry_sub_menu.cfm">
<div class="topRowColor">  
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		  <tr bgcolor="##999999">
			<td colspan="2" >
			  <table width="100%">
				<tr>
				  <td colspan="2"> 
				  <div class="topRowSet">
				      <div class="container" style="padding-left: 29px;"> 
								<cfif fusesubaction NEQ 'step2'> 
								 
							  <cfloop query="basenav">
									<cfif session.UserIsAuthenticated EQ 'Yes'>
											<cfif #TRIM(basenav.fuseaction)# neq "login">
												  <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(basenav.fuseaction)#" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small">
													 #menuTitle#
												  </a> 
											</cfif>
									<cfelse>
										   <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(basenav.fuseaction)#" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small">
											#menuTitle#
										   </a> 
										   <cfif basenav.currentrow NEQ basenav.recordcount> &nbsp;|&nbsp;</cfif> 
									</cfif> 
							  </cfloop>
							  </cfif> 
								<cfif fusesubaction NEQ 'step2'>
							  <cfif session.UserIsAuthenticated EQ 'Yes'>
									<!---&nbsp;|&nbsp; <a href="#request.webroot#/act_logout.cfm" style="color:##FFFFFF; font-family: Verdana,Geneva,sans-serif; font-size: small;">log-out</a>--->
								<cfelse>
								<!---<a href="#request.webroot#/index.cfm?fuseaction=login" style="color:Black;">LOGIN</a> ---> 
								&nbsp;|&nbsp;
								<a href="#request.webroot#/index.cfm?fuseaction=join" style="color:##FFFFFF; font-family: Verdana,Geneva,sans-serif; font-size: small;">#register#</a>  
								&nbsp;
									<span style="color:##FFFFFF; font-family: Verdana,Geneva,sans-serif; font-size: small;">
									  #ortext# #signinwith# <a href="javascript: void(0);" onclick="javascript: window.open('/getRequestToken.cfm','linkeogin','width=800,height=600,scrollbars=1,resizable=1');"> <img src="/images/linkedin-icon-footer.png" style="float: right; height: 20px; margin: 0; padding: 0;" border="0" /></a>
									</span> 
								</cfif> 
							  &nbsp;&nbsp;&nbsp;&nbsp; 
							  <!---<a href="#request.webroot#/index.cfm?fuseaction=help">
												<img src="#request.imageroot#/help_icon.gif" width="22" height="24" alt="HELP" align="absmiddle" border="0">
											</a> 
											<a href="#request.webroot#/index.cfm?fuseaction=help" style="color:##FFFFFF">HELP</a>--->
							  </cfif>  
							  <!---<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>--->
								   <div style="float: left; margin-left: 25px;">
									  <!--- Site language is 
										<cfif defaultlang eq "fr">  
											  <span style="text-decoration: underline; font-weight: bold;">français</span>
										<cfelse>
											  <span style="text-decoration: underline; font-weight: bold;">English</span>
										</cfif>
									   &nbsp;
									   Choose Another &nbsp;--->
									   <cfif IsArray(langArr) and not ArrayIsEmpty(langArr)>
									       <cfset arrayLen = ArrayLen(langArr)>
										   <cfif IsDefined("Session.defaultlang") and Session.defaultlang neq ''>
											   <cfloop from="1" to="#arrayLen#" index="i"> 
											         <cfif Session.defaultlang neq #langArr[i]['lang']#>
														   <a href="#request.webroot#/change_language.cfm?lang=#langArr[i]['lang']#" style="text-decoration: none; color: white;">
																<span style="text-decoration: none;">#langArr[i]['title']# &nbsp;</span>									  
														   </a>
													 </cfif> 	      
											   </cfloop>
											<cfelse>
											   <cfloop from="1" to="#arrayLen#" index="i"> 
											           <cfif #langArr[i]['lang']# neq 'fr'>
														   <a href="#request.webroot#/change_language.cfm?lang=#langArr[i]['lang']#" style="text-decoration: none; color: white;">
																<span style="text-decoration: none;">#langArr[i]['title']# &nbsp;</span>									  
														   </a>   
													   </cfif>
											   </cfloop>    	
											</cfif>      
									   </cfif> 
									   <!---<a href="#request.webroot#/change_language.cfm?lang=eng" style="text-decoration: none; color: white;">
									        <cfif defaultlang eq "eng"> 
										         <span style="text-decoration: underline;">English &nbsp;</span>
											<cfelse>
											     <span style="text-decoration: none;">English &nbsp;</span>	 
											</cfif>										  
									   </a>
									   <a href="#request.webroot#/change_language.cfm?lang=fr" style="text-decoration: none; color: white;">
									        <cfif defaultlang eq "fr"> 
										         <span style="text-decoration: underline;">français</span>
											<cfelse>
											     <span style="text-decoration: none;">français</span>	 
											</cfif>  
									   </a>	--->  
								   </div>
							  <!---</cfif>--->	   
							  <cfinclude template="dsp_drop_menus.cfm">	   
					  </div>		  
				  </div> 
					</td> 
				  </tr>
				</table>
			  </td>
			</tr>
		  <tr>
			<td width="220" style="font-size: 12px !important;"><!--- headertitle1 <img src="#request.imageroot#/transparent_spc.gif" width="220" height="1" border="0"><br>--->
					 <cfquery name="getContent" datasource="#dsn#" username="#request.username#" password="#request.password#">
					   SELECT * FROM site_section_contents_data WHERE section_id = 1
					 </cfquery>
					 <div class="rowSet2">
					    <CFIF FindNoCase('MSIE','#CGI.HTTP_USER_AGENT#') GREATER THAN 0 AND FindNoCase('Opera','#CGI.HTTP_USER_AGENT#') LESS THAN 1>
						      <CFSET browser = 'Internet Explorer'>
						<cfelse>
						      <CFSET browser = 'Others'>  
						</CFIF>
						<cfif browser eq 'Internet Explorer'>
						  <div class="container" style="padding-left: 140px; text-align: left;">
						<cfelse>
						  <div class="container" style="padding-left: 29px;">
						</cfif> 
					          <cfset displayHeaderTitle = Replace(#getContent.header#, "{headertitle1}", #headertitle1#, "ALL")>
							  #displayHeaderTitle#
						  </div>	  
					 </div>
			</td>
			</tr>
		  
		</table> 
</div>		 
</cfoutput> 