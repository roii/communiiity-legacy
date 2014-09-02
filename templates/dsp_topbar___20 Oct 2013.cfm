<cfparam name="fusesubaction" default="">
<cfif IsDefined("session.User_FirstName") and session.User_FirstName neq ''>
    <cfset name = session.User_FirstName>
<cfelse>
    <cfset name = ''>
</cfif>  

<cfif IsDefined("URL.fuseaction") and URL.fuseaction neq ''>
    <cfif URL.fuseaction eq "projects">
	<cfelse>
	      <script type="text/javascript" src="../js/jquery.min.js"></script>
	</cfif>
</cfif> 
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
								<a href="#request.webroot#/index.cfm?fuseaction=join" style="color:##FFFFFF; font-family: Verdana,Geneva,sans-serif; font-size: small;">register</a>  
								&nbsp;
									<span style="color:##FFFFFF; font-family: Verdana,Geneva,sans-serif; font-size: small;">
									  or sign-up with <a href="javascript: void(0);" onclick="javascript: window.open('/getRequestToken.cfm','linkeogin','width=800,height=600,scrollbars=1,resizable=1');"> <img src="/images/linkedin-icon-footer.png" style="float: right; height: 20px; margin: 0; padding: 0;" border="0" /></a>
									</span> 
								</cfif> 
							  &nbsp;&nbsp;&nbsp;&nbsp; 
							  <!---<a href="#request.webroot#/index.cfm?fuseaction=help">
												<img src="#request.imageroot#/help_icon.gif" width="22" height="24" alt="HELP" align="absmiddle" border="0">
											</a> 
											<a href="#request.webroot#/index.cfm?fuseaction=help" style="color:##FFFFFF">HELP</a>--->
							  </cfif>  
							   <div style="float: left; margin-left: 25px;">
							       Site language is 
								    <cfif defaultlang eq "fr">  
									      <img src="#request.webroot#/icons/frenchFlag.jpg" alt="French" title="French" align="absmiddle" border="0">
								    <cfelse>
									      <img src="#request.webroot#/icons/usa-flag.gif" alt="English" title="English" align="absmiddle" border="0">
									</cfif>
								   &nbsp;
								   Choose Another &nbsp;
								   <a href="#request.webroot#/change_language.cfm?lang=eng" style="text-decoration: none;">
							          <img src="#request.webroot#/icons/usa-flag.gif" alt="English" title="English" align="absmiddle" border="0"> &nbsp;
								   </a>
								   <a href="#request.webroot#/change_language.cfm?lang=fr" style="text-decoration: none;">
								      <img src="#request.webroot#/icons/frenchFlag.jpg" alt="French" title="French" align="absmiddle" border="0">
								   </a>	  
							   </div>
							  <cfinclude template="dsp_drop_menus.cfm">	   
					  </div>		  
				  </div> 
					</td> 
				  </tr>
				</table>
			  </td>
			</tr>
		  <tr>
			<td width="220" style="font-size: 12px !important;"><!---<img src="#request.imageroot#/transparent_spc.gif" width="220" height="1" border="0"><br>--->
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
					          #getContent.header#
						  </div>	  
					 </div>
			</td>
			</tr>
		  
		</table> 
</div>		 
</cfoutput> 