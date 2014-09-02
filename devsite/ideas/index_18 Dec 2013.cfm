<cfoutput>

<cfinclude template="app_locals.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>

<cfset this_metatitle = Replace(this_metatitle,"my3P", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"my3p", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"MY3p", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"MY3P", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"My3p", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"mY3p", 'iii.coop', 'all')>
<title><cfif IsDefined("this_metatitle")>#TRIM(this_metatitle)#<cfelse>#TRIM(AllSettings.SiteName)#</cfif></title>

<cfif IsDefined("this_metadescription")>
	<meta name="Description" content="#TRIM(this_metadescription)#">
</cfif>

<cfif IsDefined("this_metakeywords")>
	<meta name="Keywords" content="#TRIM(this_metakeywords)#">
</cfif>


<cfinclude template="../templates/styles.cfm"> 

<cfif IsDefined("FORM.MainCatID") and FORM.MainCatID neq ''>
	 <cfset MainCatID2 = #FORM.MainCatID#>
<cfelse>
	 <cfset MainCatID2 = ''>	 
</cfif> 

<script language="javascript"> 
   var MainCatIDJS = '#MainCatID2#'; 
  
   function showhide()
   {
         document.getElementById('categoryallselected').checked = true;
		 arrChecks = document.filterform.categoryselected; 
		 
		 if(MainCatIDJS == '')
		  {
		         for (i=0; i<arrChecks.length; i++)
				 { 
					 arrChecks[i].checked = true; 
				 } 
				 document.getElementById('categoryallselected').checked = true;
		         document.getElementById('categoryBoxID').style.display = "none";
				 document.getElementById('catimgID').src = "#request.webroot#/images/toogle-panel-expand.gif";
		  }
		 else if(MainCatIDJS == 'All')
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
		         var res = MainCatIDJS.split(",");
				 var totalCatLenSelected = res.length;
				 var totalcategorieschkboxes = arrChecks.length;
				 
					for (i=0; i<arrChecks.length; i++)
					 {
						  var chekboxVal = arrChecks[i].value;
						  var pos = MainCatIDJS.indexOf(chekboxVal); 
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

<div style="width: 100%; background: none repeat scroll 0 0 ##E8E7E6;">

      <cfinclude template="../templates/header_include.cfm"> 
	  
	  <div class="content" style="background: none repeat scroll 0 0 ##E8E7E6;">
          <cfif browser eq 'Internet Explorer'>
  <div class="container" style="text-align: left;">
<cfelse>
  <div class="container">
</cfif> 
			     <table width="100%" cellpadding="0" cellspacing="0" border="0">
						<!--- MAIN LAYOUT - Leftside column, main column, rightside column --->
						<tr> 
								<!---<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
									<td width="170" valign="top">&nbsp;
										  <cfinclude template="../templates/dsp_internal_Lsidebar.cfm">
									</td>
									<td colspan="2">
								<cfelse>
								    <td colspan="3"> 	
								</cfif>--->
								   <td colspan="3"> 
								<!---<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
									<td width="86%" colspan="2" valign="top" style="padding-left:10px;padding-right:10px;">
								<cfelse>
									<td width="100%" colspan="3" valign="top" style="padding-left:10px;padding-right:10px;">  
								</cfif> --->
											<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
											
											<tr>
											<!---<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>--->
											
											<td width="100%" style="padding-left:10px;padding-right:10px;" colspan="3">
											
													
												<cfif IsDefined("DocumentID") AND DocumentID EQ 75>
													<cfif IsDefined("ideafunl_mode")>
														<cfset ideafunl_mode = ideafunl_mode>
													<cfelse>
														<cfset ideafunl_mode = 'list'>
													</cfif>
													
												<cfelseif IsDefined("DocumentID") AND DocumentID EQ 76>
													<cfset ideafunl_mode = 'Add'>
													
												<cfelseif IsDefined("DocumentID") AND DocumentID EQ 77>
													<cfif IsDefined("ideafunl_mode")>
														<cfset ideafunl_mode = ideafunl_mode>
													<cfelse>
														<cfset ideafunl_mode = 'MyIdeas'>
													</cfif>
													
												<cfelseif IsDefined("DocumentID") AND DocumentID EQ 78>
												
													<cfif IsDefined("ideafunl_mode")>
														<cfset ideafunl_mode = ideafunl_mode>
													<cfelse>
														<cfset ideafunl_mode = 'Actioned'>
													</cfif>
													
												<cfelseif IsDefined("DocumentID") AND DocumentID EQ 80>
													<cfset ideafunl_mode = 'HowItWorks'>
													
												<cfelseif IsDefined("DocumentID") AND DocumentID EQ 99>
													<cfset ideafunl_mode = 'WatchList'>
													
												<cfelse>
													<!--- <cfset fusesubaction = 'docs'>
													<cfset documentID = 75> --->
													<cfset ideafunl_mode = 'list'>
												</cfif>
												
												
												<table border="0" cellpadding="0" cellspacing="0" width="100%">
												
												<!---<cfif IsDefined("DocumentID")>
												
													<tr>
													<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(DocumentDetails.Title))#</strong></td>
													<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=550,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit" border="0"></a>&nbsp;<a href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete" border="0"></a></cfif></td>
													</tr>
												
												<cfelse>
												
													<tr>
													<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(SectionDetails.Title))#</strong></td>
													<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" onClick="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a></cfif></td>
													</tr>
												
												</cfif>--->
												
												    <tr>
														<td colspan="2">
														    <div style="font-size: 21px; font-weight: bold;">#browse# 
															     <span style="color: ##91AE4E;">#allideas#</span>
															</div>
														</td>
													</tr> 
												
												</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
												
												
												<cfif (ideafunl_mode EQ 'list') OR (ideafunl_mode EQ 'voteresults') OR (ideafunl_mode EQ 'details') OR (IsDefined("DocumentID") AND DocumentID EQ 75)>
													
													<cfif ideafunl_mode EQ 'details'> 
														<cfinclude template="dsp_idea_details.cfm">
													<cfelseif ideafunl_mode EQ 'voteresults'> 
														<cfinclude template="dsp_multiidea_details.cfm">
													<cfelseif IsDefined("currentcategory")> 
														<cfinclude template="dsp_ideas_pond.cfm">
													<cfelse>	 
														<cfinclude template="dsp_select_category.cfm">
													</cfif> 
													
													
												<cfelseif (ideafunl_mode EQ 'add') OR (IsDefined("DocumentID") AND DocumentID EQ 76)>
												
													<cfinclude template="dsp_idea_add.cfm">
													
												<cfelseif ideafunl_mode EQ 'details'>
												
													<cfinclude template="dsp_idea_details.cfm">
													
												<cfelseif (ideafunl_mode EQ 'MyIdeas') OR (IsDefined("DocumentID") AND DocumentID EQ 77)>
												
													<cfif MyIdeasMode EQ 'list'>
														<cfinclude template="dsp_myideas.cfm">
													<cfelse>
														<cfinclude template="dsp_myidea_details.cfm">
													</cfif>
													
													
												<cfelseif (ideafunl_mode EQ 'Actioned') OR (IsDefined("DocumentID") AND DocumentID EQ 78)>
													
													<cfif ideafunl_mode EQ 'Actioned'>
														<cfinclude template="dsp_winning_ideas.cfm">
													<cfelse>
														<cfinclude template="dsp_idea_details.cfm">
													</cfif>
													
												<cfelseif (ideafunl_mode EQ 'About') OR (IsDefined("DocumentID") AND DocumentID EQ 80)>
												
													<cfinclude template="dsp_about.cfm">
												
												<cfelseif ideafunl_mode EQ 'WinningDetails'>
												
													<cfinclude template="dsp_idea_details.cfm">
													
												<cfelseif (ideafunl_mode EQ 'Watchlist') OR (IsDefined("DocumentID") AND DocumentID EQ 99)>
												
													<cfinclude template="dsp_watchlist.cfm">
													
													
												<cfelseif ideafunl_mode EQ 'report'>
												
													<cfinclude template="dsp_report_profanity.cfm">
													
												</cfif>
												
												
													<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
														<cfinclude template="../templates/dsp_document_list.cfm">
													</cfif>
												
												
										
											</td>	
											<!---<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>	--->
											</tr>
											
											</table> 
									</td> 
								<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
									<!---<td width="0"></td>--->
								<cfelse>
									<!---<td width="170" valign="top" align="right">
										<cfinclude template="../templates/dsp_internal_Rsidebar.cfm">	
									</td>--->
								</cfif> 
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