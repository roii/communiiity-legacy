<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>My3P New Site</title>
<script type="text/javascript">
  WebFontConfig = {
    google: { families: [ 'Delius:latin' ] }
  };
  (function() {
    var wf = document.createElement('script');
    wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
      '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
    wf.type = 'text/javascript';
    wf.async = 'true';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(wf, s);
  })(); </script>

<link rel="stylesheet" type="text/css" href="184380.css" />
<link href="css/dropdown/themes/vimeo/helper.css" media="screen" rel="stylesheet" type="text/css" />


<!---<link href="css/dropdown/themes/default/helper.css" media="screen" rel="stylesheet" type="text/css" />
<link href="css/dropdown/dropdown.css" media="screen" rel="stylesheet" type="text/css" />
<link href="css/dropdown/themes/default/default.ultimate.css" media="screen" rel="stylesheet" type="text/css" />--->

<!-- Beginning of compulsory code below -->

<link href="css/dropdown/dropdown.css" media="screen" rel="stylesheet" type="text/css" />
<link href="css/dropdown/themes/vimeo/default.advanced.css" media="screen" rel="stylesheet" type="text/css" />

<!--[if lte IE 7]>
<script type="text/javascript" src="js/jquery/jquery.js"></script>
<script type="text/javascript" src="js/jquery/jquery.dropdown.js"></script>
<![endif]-->
<!-- / END -->
</head>
<!--- Query for top Menu ---->
<cfquery name="basenav" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT SectionID, Fuseaction, MenuTitle
FROM Sections
WHERE TopMenu=1

<cfif session.UserIsAuthenticated>

	<cfif session.UserType NEQ 'Administrator'>
		AND (ContactTypeView LIKE '#session.User_ContactTypeID#' OR ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#')
	</cfif>

<cfelse>
	AND PublicView = 1
</cfif>

ORDER BY MainMenuOrder
</cfquery>

<!--- Query for Main menu ---->
<cfquery name="mainmenu" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT SectionID, Fuseaction, MenuTitle, DHTML_POS, DHTML_POS_LOGIN
FROM Sections
WHERE MainMenu=1

<cfif session.UserIsAuthenticated>

	<cfif session.UserType NEQ 'Administrator'>
		AND (ContactTypeView LIKE '#session.User_ContactTypeID#' OR ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#')
	</cfif>

<cfelse>
	AND PublicView = 1
</cfif>

ORDER BY MainMenuOrder
</cfquery>
<cfset thisfuseaction = TRIM(mainmenu.fuseaction)>

<cfquery name="AllDocuments" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT Documents.*, SectionDocuments_Link.*
FROM Documents, SectionDocuments_Link
WHERE 
<!--- SectionDocuments_Link.SectionID=#SectionDetails.sectionid# --->
SectionDocuments_Link.DocumentID=Documents.DocumentID

<cfif session.UserIsAuthenticated>

	<cfif session.UserType NEQ 'Administrator'>
		<!--- AND (Documents.ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#') --->
		AND (Documents.DocExpireDate > #localDateTime# 
		OR Documents.DocExpireDate IS NULL)
		AND Documents.Released=1
	</cfif>

<cfelse>
	<!--- AND Documents.PublicView = 1 --->
	AND (Documents.DocExpireDate > #localDateTime# 
	OR Documents.DocExpireDate IS NULL)
	AND Documents.Released=1
</cfif>

ORDER BY SectionDocuments_Link.DisplayOrder	
</cfquery>
<body>
	<div id="wrapper">
         <div id="header">
           <table width="100%" border="0">
             <tr>
               <td width="10%">&nbsp;</td>              
                <td width="80%" valign="top" class="topMenu">
                    <cfoutput query="basenav">
                        <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(basenav.fuseaction)#" style="color:black;">#menuTitle#</a><cfif basenav.currentrow NEQ basenav.recordcount> &nbsp;|&nbsp;</cfif>
                    </cfoutput>
                </td>
             <!--- <td width="4%" valign="top" class="topMenu">Home </td>
               <td width="4%" valign="top" class="topMenu">Login</td>
               <td width="4%" valign="top" class="topMenu">Register </td>
               <td width="51%" valign="top" class="topMenu">Help?</td>--->
               <td width="10%" class="topMenu">&nbsp;</td>
             </tr>
           </table>           
      </div>
      <div id="logo">
      	<table>
         <tr bgcolor="#FFFFFF">
            <td colspan="6"><img src="images/my3p_header.jpg" /></td>
         </tr>
        </table>
      </div>
      <div id="navigation">
		 
		      <ul id="nav" class="dropdown dropdown-horizontal">

				<li class="dir"><img src="images/spacer_menu.gif" /></li>
				<cfloop query="mainmenu">
                	<cfoutput>
						<li class="dir"><a href="#request.webroot#/index.cfm?fuseaction=#thisfuseaction#">#TRIM(mainmenu.menuTitle)#</a>
                        <cfquery name="getSubmenu" dbtype="query">
                        	SELECT Distinct TITLE FROM ALLDOCUMENTS WHERE SectionID = #mainmenu.sectionID#
                        </cfquery>
                        <cfif getSubmenu.recordcount gt 0>
                        	<ul>
                            	<cfloop query="getSubMenu">
                                    <cfif getSubMenu.currentrow eq 1>
                                    	<li class="first"><a href="./">#getSubMenu.title#</a></li>
                                    <cfelseif getSubMenu.currentrow eq getSubMenu.recordcount>
                                    	<li class="last"><a href="./">#getSubMenu.title#</a></li>
                                    <cfelse>
                                    	<li><a href="./">#getSubMenu.title#</a></li>
                                    </cfif>
                               </cfloop>
                            </ul>
                        </cfif>
                	</cfoutput>
                    </li>
                </cfloop>
                <li class="dir"><img src="images/spacer_menu.gif" /></li>
			</ul>     
		 </div>
		 <div id="content">
		      
			  <br /><br /> <p>This is the main content</p><br /><br /> 
             
		 
		 </div>
		 <div id="footer">
		       
			   <table width="90%" align="center">
               		<tr>
                    	<th width="6%">&nbsp;</th>
                        <th width="15%">About My3P</th>
                        <th width="6%">&nbsp;</th>
                        <th width="15%"> Information </th>
                        <th width="6%">&nbsp;</th>
                        <th width="15%"> Usage </th>
                        <th width="6%">&nbsp;</th>
                        <th width="15%"> Resources </th>
                        <th width="6%">&nbsp;</th>
                    </tr>
                    <tr>
                    	<th width="6%">&nbsp;</th>
						<th width="6%">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                    </tr>
                    <tr>
                    	<td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> About Us</td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> News </td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> IdesFarm </td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> Our Partners </td>
                    </tr>
                    <tr>
                    	<td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> How My3P Started</td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> Anouncements </td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> My Goals </td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> Links </td>
                    </tr>
                    <tr>
                    	<td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> What our users say</td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> Code of Conduct </td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> myPOINTS </td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> Coverage Area Map </td>
                    </tr>
                    <tr>
                    	<td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> What the media says</td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> Site Statistics </td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow"> myContacts </td>
                        <td width="6%">&nbsp;</td>
                        <td width="15%" class="TRow">&nbsp;  </td>
                    </tr>
                     <tr>
                    	<th width="6%">&nbsp;</th>
						<th width="6%" class="TRow">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%" class="TRow">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%" class="TRow">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                        <th width="6%" class="TRow">&nbsp;</th>
                        <th width="6%">&nbsp;</th>
                    </tr>
              </table>
              <table width="90%">
              	<tr class="footerBottom">
                	<td width="6%">&nbsp;</td>
                    <td width="15%"> Home</td>
                    <td width="6%" >Login</td>
                    <td width="15%" > Register  </td>
                    <td width="6%">Help</td>
                    <td width="15%" > myContacts </td>
                    <td width="6%">&nbsp;</td>
                    <td width="15%" >&nbsp;  </td>
                </tr>
              </table>
              			    
	     </div>   
    </div>
</body>
</html>