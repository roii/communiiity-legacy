<cfinclude template="app_locals.cfm">

<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head> 
<cfif IsDefined("this_metatitle")>
	<cfset this_metatitle = Replace(this_metatitle,"3P.com", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"3p.com", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"my3P.com", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"MY3P.com", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"mY3P.com", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"My3P.com", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"mY3p.com", 'iii.coop', 'all')> 
	<cfset this_metatitle = Replace(this_metatitle,"3P", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"my3P", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"3p", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"my3p", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"MY3p", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"MY3P", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"My3p", 'iii.coop', 'all')>
	<cfset this_metatitle = Replace(this_metatitle,"mY3p", 'iii.coop', 'all')>
</cfif>	
<title><cfif IsDefined("this_metatitle") and this_metatitle neq ''>#TRIM(this_metatitle)#<cfelse>#TRIM(AllSettings.SiteName)# - Campaign Page</cfif></title>
 

<cfif IsDefined("this_metadescription")>
	<meta name="Description" content="#TRIM(this_metadescription)#">
</cfif>

<cfif IsDefined("this_metakeywords")>
	<meta name="Keywords" content="#TRIM(this_metakeywords)#">
</cfif>

<!---Start of new code added to add jqgrid JS and CSS   Added by Veena --->
<!---<cfif attributes.fusesubaction EQ 'docs'>--->
    <!---<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>---> 
	<script type="text/javascript" src="<cfoutput>#request.webroot#</cfoutput>/js/jquery.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js"></script>
	<script src="<cfoutput>#request.webroot#</cfoutput>/includes/js/grid.locale-en.js"></script>
	<script src="<cfoutput>#request.webroot#</cfoutput>/includes/js/jquery.jqGrid.min.js"></script>
	<link rel="stylesheet" href="<cfoutput>#request.webroot#</cfoutput>/includes/css/jquery-ui.css" type="text/css" />
	<link rel="stylesheet" href="<cfoutput>#request.webroot#</cfoutput>/includes/css/ui.jqgrid.css" type="text/css" />
<!---</cfif>--->
<!---Start of new code added to add jqgrid JS and CSS  Added by Veena --->

<cfinclude template="../templates/styles.cfm">

<cfif IsDefined("FORM.selStatus") and FORM.selStatus neq ''>
     <cfset selStatus = #FORM.selStatus#>
<cfelse>
     <cfset selStatus = ''>	 
</cfif>

<cfif IsDefined("FORM.selCategory") and FORM.selCategory neq ''>
     <cfset selCategory = #FORM.selCategory#>
<cfelse>
     <cfset selCategory = ''>	 
</cfif>

<cfif IsDefined("FORM.selPriority") and FORM.selPriority neq ''>
     <cfset selPriority = #FORM.selPriority#>
<cfelse>
     <cfset selPriority = ''>	 
</cfif> 
 

<script language="javascript">
   var selStatusJS   = '#selStatus#';
   var selCategoryJS = '#selCategory#';
   var selPriorityJS = '#selPriority#';
  
   function showhide()
   {
         document.getElementById('categoryallselected').checked = true;
		 arrChecks = document.filterform.categoryselected; 
		 
		 if(selCategoryJS == '')
		  {
		         for (i=0; i<arrChecks.length; i++)
				 { 
					 arrChecks[i].checked = true; 
				 } 
				 document.getElementById('categoryallselected').checked = true;
		         document.getElementById('categoryBoxID').style.display = "none";
				 document.getElementById('catimgID').src = "#request.webroot#/images/toogle-panel-expand.gif";
		  }
		 else if(selCategoryJS == 'showallcats')
		  {
			     for (i=0; i<arrChecks.length; i++)
				 { 
					 arrChecks[i].checked = true; 
				 } 
				 document.getElementById('categoryallselected').checked = true;
		         document.getElementById('categoryBoxID').style.display = "";
				 document.getElementById('catimgID').src = "#request.webroot#/images/toogle-panel-collapse.gif";
		  }
		 else
		  {
		         var res = selCategoryJS.split(",");
				 var totalCatLenSelected = res.length;
				 var totalcategorieschkboxes = arrChecks.length;
				 
					for (i=0; i<arrChecks.length; i++)
					 {
						  var chekboxVal = arrChecks[i].value;
						  var pos = selCategoryJS.indexOf(chekboxVal); 
						   if(pos >= 0)
						   {
							   arrChecks[i].checked = true;
						   } 
						   else
						   {
						       arrChecks[i].checked = false;
						   }
					 } 
					 
					if(totalCatLenSelected == totalcategorieschkboxes)
					{
					     document.getElementById('categoryallselected').checked = true;
					}
					else
					{
					     document.getElementById('categoryallselected').checked = false;
					}  
				  document.getElementById('categoryBoxID').style.display = "";
				  document.getElementById('catimgID').src = "#request.webroot#/images/toogle-panel-collapse.gif";
		 	}
			 
			 
			 
			 
		 document.getElementById('statuallselected').checked = true;	 
		  arrChecks = document.filterform.statuselected;
			
		  if(selStatusJS == '')
		  {
		         for (i=0; i<arrChecks.length; i++)
				 {
					  arrChecks[i].checked = true;
				 } 
				 document.getElementById('statuallselected').checked = true;
		         document.getElementById('statusBoxID').style.display = "none";
				 document.getElementById('statimgID').src = "#request.webroot#/images/toogle-panel-expand.gif";
		  }
		 else if(selStatusJS == 'showallstatus')
		  {
			     for (i=0; i<arrChecks.length; i++)
				 { 
					 arrChecks[i].checked = true; 
				 } 
				 document.getElementById('statuallselected').checked = true;
		         document.getElementById('statusBoxID').style.display = "";
				 document.getElementById('statimgID').src = "#request.webroot#/images/toogle-panel-collapse.gif";
		  }
		 else
		  {
		         var res = selStatusJS.split(",");
				 var totalStatusLenSelected = res.length;
				 var totalstatuschkboxes = arrChecks.length;
				 
					for (i=0; i<arrChecks.length; i++)
					 {
						  var chekboxVal = arrChecks[i].value;
						  var pos = selStatusJS.indexOf(chekboxVal); 
						   if(pos >= 0)
						   {
							   arrChecks[i].checked = true;
						   } 
						   else
						   {
						       arrChecks[i].checked = false;
						   }
					 } 
				  
				    if(totalStatusLenSelected == totalstatuschkboxes)
					{
					     document.getElementById('statuallselected').checked = true;
					}
					else
					{
					     document.getElementById('statuallselected').checked = false;
					} 	 
					  	 
				  document.getElementById('statusBoxID').style.display = "";
				  document.getElementById('statimgID').src = "#request.webroot#/images/toogle-panel-collapse.gif";
		 	}	 
		 	 
			
			
			 
			 
		 document.getElementById('priorityallselected').checked = true;
		  arrChecks = document.filterform.priorityselected;
		  
		   if(selPriorityJS == '')
		  {
		         for (i=0; i<arrChecks.length; i++)
				 {
					  arrChecks[i].checked = true;
				 } 
				 document.getElementById('priorityallselected').checked = true;
		         document.getElementById('priorityBoxID').style.display = "none";
				 document.getElementById('priorityimgID').src = "#request.webroot#/images/toogle-panel-expand.gif";
		  }
		 else if(selPriorityJS == 'showallpriorities')
		  {
			     for (i=0; i<arrChecks.length; i++)
				 { 
					 arrChecks[i].checked = true; 
				 } 
				 document.getElementById('priorityallselected').checked = true;
		         document.getElementById('priorityBoxID').style.display = "";
				 document.getElementById('priorityimgID').src = "#request.webroot#/images/toogle-panel-collapse.gif";
		  }
		 else
		  {
		         var res = selPriorityJS.split(",");
				 var totalPriorityLenSelected = res.length;
				 var totalPrioritychkboxes = arrChecks.length;
				 
					for (i=0; i<arrChecks.length; i++)
					 {
						  var chekboxVal = arrChecks[i].value;
						  var pos = selPriorityJS.indexOf(chekboxVal); 
						   if(pos >= 0)
						   {
							   arrChecks[i].checked = true;
						   } 
						   else
						   {
						       arrChecks[i].checked = false;
						   }
					 } 
				
				  if(totalPriorityLenSelected == totalPrioritychkboxes)
					{
					     document.getElementById('priorityallselected').checked = true;
					}
					else
					{
					     document.getElementById('priorityallselected').checked = false;
					}	 
					 
				  document.getElementById('priorityBoxID').style.display = "";
				  document.getElementById('priorityimgID').src = "#request.webroot#/images/toogle-panel-collapse.gif";
		 	} 	 
   }
   
   function showhideBoxesAgain(boxID, imgID)
   {
         var boxIDcheck = document.getElementById(boxID).style.display;
		   if(boxIDcheck == "none")
		   {
		         document.getElementById(boxID).style.display = "";
				 document.getElementById(imgID).src = "#request.webroot#/images/toogle-panel-collapse.gif";
		   }
		   else
		   {
		         document.getElementById(boxID).style.display = "none";
				 document.getElementById(imgID).src = "#request.webroot#/images/toogle-panel-expand.gif"; 
		   }
   }
</script>

</head>
<!--- --->
<body leftmargin="5" topmargin="0" rightmargin="5" bottommargin="0" marginwidth="5" marginheight="0" bgcolor="##FFFFFF" text="###AllSettings.TextColour#" stats=1 onLoad="showhide();">

<!--BEGINNING OF DEEPMETRIX STATSCRIPT-->
<script language="javascript">
var DMdomain = "";
var DMpage = window.location;
var DMVersion = 86;
var DMsendTo = "//collector.deepmetrix.com/dm.gif?";
var DMsession;
function dmerr(){return true;}window.onerror=dmerr;
var u3k8u6y1j3 = new Date();
if (navigator.userAgent.indexOf('Mac') >= 0 && u3k8u6y1j3.getTimezoneOffset() >= 720){
u3k8u6y1j3.setTime (u3k8u6y1j3.getTime() - 1440*60*1000);}
var u3k8u6y1 = location.protocol+DMsendTo+"v="+DMVersion+"&vst=1";
var u3k8u6 = document.cookie.toString();if(u3k8u6.indexOf("_dmid") == -1)
{DMsession = parseInt( Math.random()*1000000 ) + "_" + u3k8u6y1j3.getTime();
var u3k8 = "";if(DMdomain != ""){u3k8 = "domain="+ DMdomain +";";}
document.cookie = "_dmid=" + DMsession + ";expires=Mon, 31-Dec-2008 00:00:00 GMT;"+u3k8+"path=/;";}
u3k8u6 = document.cookie.toString();if(u3k8u6.indexOf('_dmid') == -1){DMsession = "";}
else{if(u3k8u6.indexOf(';') == -1){u3k8u6 = u3k8u6.replace(/_dm/g, ';_dm');}var u3 = u3k8u6.indexOf("_dmid=") + 6;
var g5b1z7i5z6 = u3k8u6.indexOf(";",u3);if (g5b1z7i5z6 == -1){g5b1z7i5z6 = u3k8u6.length;}
DMsession = unescape(u3k8u6.substring(u3,g5b1z7i5z6));}
u3k8u6y1 += "&id="+DMsession+"&url="+escape(DMpage) + "&ref="+escape(document.referrer)+"&lng=" + 
((!document.all || navigator.userAgent.match('Opera')) ? navigator.language : navigator.userLanguage) + 
"&tz=" + (Math.round(new Date('dec 1, 2002').getTimezoneOffset()/60)*-1);
if(screen){u3k8u6y1 += "&scr=" + escape( screen.width + "x" + screen.height + " " + screen.colorDepth + "bpp" );}
u3k8u6y1 += "&rnd=" + new Date().getTime();if(document.layers){
document.write("<la"+"yer name=\"DMStats\" visibility=hide><img src=\""+u3k8u6y1+"\" height=1 width=1></la"+"yer>");
}else{document.write("<di"+
"v id=\"DMStats\" STYLE=\"position:absolute;visibility:hidden;\"><img src=\""+u3k8u6y1+
"\" height=1 width=1></di"+"v>");}
</script>
<!--END OF DEEPMETRIX STATSCRIPT-->



<div style="width: 100%; background: none repeat scroll 0 0 ##FBF9FC;">

      <cfinclude template="../templates/header_include.cfm"> 
	  
	  <div class="content">
          <cfif browser eq 'Internet Explorer'>
  <div class="container" style="text-align: left;">
<cfelse>
  <div class="container">
</cfif> 
		      <table width="100%" cellpadding="0" cellspacing="0" border="0">
			       <!--- MAIN LAYOUT - Leftside column, main column, rightside column ---> 
					<tr> 
						<!---<td width="170" valign="top">
							<cfinclude template="../templates/dsp_internal_Lsidebar.cfm">
						</td>---> 
						<td width="*" valign="top" style="padding-left:10px;padding-right:10px;" colspan="3"> 
						
						<cfif (TRIM(sectiondetails.details) NEQ '') AND (sectiondetails.details NEQ '<P>&nbsp;</P>')>
						    <div style="margin-left: 30px;"> 
							   #TRIM(sectiondetails.details)#<br>
						    </div>
						</cfif> 
						
						    <table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="459" height="8" border="0"></td>
	</tr>
	
	<tr>
		<!---<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>--->
		
		<td width="100%" style="padding-left:10px;padding-right:10px;" colspan="3">
			<cfif IsDefined("URL.campID") and #URL.campID# neq ''> <cfelse>
				  <div style="font-size: 21px; font-weight: bold;">#browse# <span style="color: ##91AE4E;">#allcamp#</span></div>  
			</cfif>
			
				<cfif attributes.fusesubaction EQ 'index'>
				
					
						<!---<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>--->
							
							<!---<cfinclude template="../templates/dsp_section_details.cfm">
							<cfinclude template="../templates/dsp_document_list.cfm">
							<cfinclude template="../templates/qry_related_downloads.cfm">
							<cfinclude template="../templates/dsp_related_downloads.cfm">--->
							
							<cfset DocumentID = 5> 
							<cfset attributes.DocumentID = 5>
							<cfset url.documentID = 5>
							<cfinclude template="../templates/qry_document_details.cfm">	 
					
							<!--- CHECK IF DOCUMENT ID IN GROUPS TABLE --->
							<cfquery name="GroupResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
							SELECT GroupID, GroupName
							FROM ProjectGroups
							WHERE DocumentID=#DocumentID#
							</cfquery> 
							
							<cfif GroupResults.RecordCount>
								
								<cfset groupID = GroupResults.GroupID>
								
								<cfinclude template="../templates/dsp_document_details.cfm">
								<!--- <br><cfdump var="#projectmode#">:<br> --->
								<cfif projectmode EQ 'list'>
								
									<cfinclude template="qry_group_categories.cfm">
									<cfinclude template="dsp_campaigns_list.cfm">
								
								<cfelse>
									<!--- <cfdump label="bleh" var="blehVar"> --->
									<cfinclude template="qry_project_details.cfm">
									<cfinclude template="dsp_project_details.cfm">
								
									<cfif attributes.CampaignsID EQ "3" AND session.UserIsAuthenticated EQ 'yes'>
										<cfinclude template="dsp_survey_form.cfm">
									</cfif>
									
								
								</cfif>
							
							
							
							<cfelse>
							
								<cfinclude template="../templates/dsp_document_details.cfm">
							
								<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
									<cfinclude template="../templates/dsp_article_list.cfm">
								</cfif>
							
								<cfinclude template="../templates/qry_related_downloads.cfm">
								<cfinclude template="../templates/dsp_related_downloads.cfm">
						
							</cfif>
							
						<!---<cfelse> 
							<cflocation url="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=86">
						
						</cfif>--->
						
					
					
				
				<cfelseif attributes.fusesubaction EQ 'docs'>
				
					<cfinclude template="../templates/qry_document_details.cfm">	
					
					<!--- CHECK IF DOCUMENT ID IN GROUPS TABLE --->
					<cfquery name="GroupResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT GroupID, GroupName
					FROM ProjectGroups
					WHERE DocumentID=#DocumentID#
					</cfquery> 
					
					<cfif GroupResults.RecordCount>
						
						<cfset groupID = GroupResults.GroupID>
						
						<cfinclude template="../templates/dsp_document_details.cfm">
						<!--- <br><cfdump var="#projectmode#">:<br> --->
						<cfif projectmode EQ 'list'>
						
							<cfinclude template="qry_group_categories.cfm">
							<cfinclude template="dsp_campaigns_list.cfm">
						
						<cfelse>
							<!--- <cfdump label="bleh" var="blehVar"> --->
							<cfinclude template="qry_project_details.cfm">
							<cfinclude template="dsp_project_details.cfm">
						
							<cfif attributes.CampaignsID EQ "3" AND session.UserIsAuthenticated EQ 'yes'>
								<cfinclude template="dsp_survey_form.cfm">
							</cfif>
							
						
						</cfif>
					
					
					
					<cfelse>
					
						<cfinclude template="../templates/dsp_document_details.cfm">
					
						<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
							<cfinclude template="../templates/dsp_article_list.cfm">
						</cfif>
					
						<cfinclude template="../templates/qry_related_downloads.cfm">
						<cfinclude template="../templates/dsp_related_downloads.cfm">
				
					</cfif>
				
				
				
				<cfelseif attributes.fusesubaction EQ 'article'>
				
					<cfinclude template="../templates/qry_document_details.cfm">
					<cfinclude template="../templates/qry_article_details.cfm">
					
					
					
					<cfif TRIM(ArticleDetails.PluginModule) EQ 'news'>
						<cfinclude template="../default_news/index.cfm">	
						
						
					<cfelseif TRIM(ArticleDetails.PluginModule) EQ 'events'>
					
						<cfinclude template="../default_events/index.cfm">
						
						
							
					<cfelseif TRIM(ArticleDetails.PluginModule) EQ 'links'>	
						
						<cfinclude template="../default_links/qry_link_cats.cfm">
						<cfinclude template="../default_links/dsp_links.cfm">
						
						
					<cfelseif TRIM(ArticleDetails.PluginModule) EQ 'bulletin'>	
						
						<cfinclude template="../templates/dsp_document_details.cfm">
						<cfinclude template="../newsletter/qry_bulletin_list.cfm">
						<cfinclude template="../newsletter/dsp_bulletin_list.cfm">
						
						
					<cfelse>	
					
					
						<cfinclude template="../templates/dsp_article_details.cfm">
					
						<cfinclude template="../templates/qry_related_downloads.cfm">
						<cfinclude template="../templates/dsp_related_downloads.cfm">
						
					
					</cfif>
				
				
				
				<cfelseif attributes.fusesubaction EQ 'subarticle'>
				
					
					<cfinclude template="../templates/qry_document_details.cfm">
					<cfinclude template="../templates/qry_article_details.cfm">
					<cfinclude template="../templates/qry_subarticle_details.cfm">
					<cfinclude template="../templates/dsp_subarticle_details.cfm">
					
					<cfinclude template="../templates/qry_linked_level4articles.cfm">
					<cfinclude template="../templates/dsp_level4article_list.cfm">
						
						
					<cfinclude template="../templates/qry_related_downloads.cfm">
					<cfinclude template="../templates/dsp_related_downloads.cfm">
				
				
				
				<cfelseif attributes.fusesubaction EQ 'level4'>
				
					
					<cfinclude template="../templates/qry_document_details.cfm">
					<cfinclude template="../templates/qry_article_details.cfm">
					<cfinclude template="../templates/qry_subarticle_details.cfm">
					<cfinclude template="../templates/qry_level4_details.cfm">
					<cfinclude template="../templates/dsp_level4_details.cfm">
					
					<cfinclude template="../templates/qry_related_downloads.cfm">
					<cfinclude template="../templates/dsp_related_downloads.cfm">
				
				
				<cfelseif attributes.fusesubaction EQ 'insertcomment'> 
					<cfinclude template="act_insert_comment.cfm"> 
					
				<cfelseif attributes.fusesubaction EQ 'campaigndetails'> 
					<cfinclude template="campaigndetails.cfm">
						 
				</cfif>
		</td>	
		<!---<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>--->	
	</tr>
	
	</table>	      
						</td> 
						<!---<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
							<td width="0"></td>
						<cfelse>
							<td width="170" valign="top" align="right">
								<cfinclude template="../templates/dsp_internal_Rsidebar.cfm">	
							</td>
						</cfif>--->
					</tr>  
			  </table>		
	      </div>
	  </div>	  		   
	  
	  <cfinclude template="../templates/footer_include.cfm">
	  
</div>   

<cfinclude template="../templates/dsp_partners.cfm">

</body>
</html>
</cfoutput>