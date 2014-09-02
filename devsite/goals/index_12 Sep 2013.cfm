<cfinclude template="app_locals.cfm">


<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfset this_metatitle = Replace(this_metatitle,"3P.com", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"3p.com", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"my3P.com", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"MY3P.com", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"mY3P.com", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"My3P.com", 'iii.coop', 'all')>
<cfset this_metatitle = Replace(this_metatitle,"mY3p.com", 'iii.coop', 'all')> 
<title><cfif IsDefined("this_metatitle")>#TRIM(this_metatitle)#<cfelse>#TRIM(AllSettings.SiteName)#</cfif></title>

<cfif IsDefined("this_metadescription")>
	<meta name="Description" content="#TRIM(this_metadescription)#">
</cfif>

<cfif IsDefined("this_metakeywords")>
	<meta name="Keywords" content="#TRIM(this_metakeywords)#">
</cfif>


<cfinclude template="../templates/styles.cfm">

</head>

<body leftmargin="5" topmargin="0" rightmargin="5" bottommargin="0" marginwidth="5" marginheight="0" bgcolor="##FFFFFF" text="###AllSettings.TextColour#" stats=1>

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



<div style="width: 100%;">

      <cfinclude template="../templates/header_include.cfm"> 
	  
	  <div class="content">
          <div class="container">
		      <table width="100%" cellpadding="0" cellspacing="0" border="0">
			       <!--- MAIN LAYOUT - Leftside column, main column, rightside column ---> 
					<tr> 
						<td width="170" valign="top">
							<cfinclude template="../templates/dsp_internal_Lsidebar.cfm">
						</td> 
						<td width="*" valign="top" style="padding-left:10px;padding-right:10px;" colspan="2"> 
							 <table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="459" height="8" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	
	<td width="100%" style="padding-left:10px;padding-right:10px;">

<cfif attributes.fusesubaction EQ 'index'>
	
	<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType NEQ 'Administrator'>
		
		<cflocation url="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentID=38">
	
	<cfelse>
	
		<cfinclude template="../templates/dsp_section_details.cfm">
	
	</cfif>
	
	<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
		<cfinclude template="../templates/dsp_document_list.cfm">
	</cfif>
	
	
	<cfinclude template="../templates/qry_related_downloads.cfm">
	<cfinclude template="../templates/dsp_related_downloads.cfm">
	

<cfelseif attributes.fusesubaction EQ 'docs'>
	
	
	<cfif TRIM(DocumentDetails.PluginModule) EQ 'news'>
		<cfinclude template="../default_news/index.cfm">	
		
		
	<cfelseif TRIM(DocumentDetails.PluginModule) EQ 'events'>
	
		<cfinclude template="../default_events/index.cfm">
		
		
	<cfelseif TRIM(DocumentDetails.PluginModule) EQ 'links'>	
		
		<cfinclude template="../default_links/qry_link_cats.cfm">
		<cfinclude template="../default_links/dsp_links.cfm">
		
		
	<cfelseif TRIM(DocumentDetails.PluginModule) EQ 'bulletin'>	
		
		<cfinclude template="../templates/dsp_document_details.cfm">
		<cfinclude template="../newsletter/qry_bulletin_list.cfm">
		<cfinclude template="../newsletter/dsp_bulletin_list.cfm">
		
		
	<cfelse>
	
	
		<cfinclude template="../templates/dsp_document_details.cfm">
		
		<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
			<cfinclude template="../templates/dsp_article_list.cfm">
		</cfif>
		
		
		<cfif DocumentID EQ 38>	
			<cfinclude template="../templates/qry_current_goals.cfm">
			
			<cfif CurrentPrivateGoals.recordcount>
				<cfinclude template="dsp_current_goals.cfm">
			<cfelse>
				<cflocation url="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentID=43&NoGoals=1">
			</cfif>
			
		<cfelseif DocumentID EQ 40>	
			<cfinclude template="../templates/qry_current_goals.cfm">
			<cfinclude template="dsp_completed_goals.cfm">
		<cfelseif DocumentID EQ 43>	
			<cfinclude template="../templates/qry_all_goals.cfm">
			<cfinclude template="dsp_add_goal.cfm">
		</cfif>
		
		<cfinclude template="../templates/qry_related_downloads.cfm">
		<cfinclude template="../templates/dsp_related_downloads.cfm">
		
	</cfif>



<cfelseif attributes.fusesubaction EQ 'article'>
	
	
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
		<cfif #articleID# EQ 2>
			<cfinclude template="../templates/qry_all_goals.cfm">
			<cfinclude template="dsp_add_goal.cfm">
		</cfif>
		<cfif #articleID# EQ "3">
		    <cfinclude template="../templates/qry_all_goals.cfm">
		    <cfinclude template="dsp_edit_goal.cfm">
		</cfif>
	
	</cfif>



<cfelseif attributes.fusesubaction EQ 'subarticle'>

	
	<cfinclude template="../templates/dsp_subarticle_details.cfm">
	<cfinclude template="../templates/dsp_level4article_list.cfm">
		
		
	<cfinclude template="../templates/qry_related_downloads.cfm">
	<cfinclude template="../templates/dsp_related_downloads.cfm">



<cfelseif attributes.fusesubaction EQ 'level4'>

	
	<cfinclude template="../templates/dsp_level4_details.cfm">
	
	<cfinclude template="../templates/qry_related_downloads.cfm">
	<cfinclude template="../templates/dsp_related_downloads.cfm">




</cfif>

</td>	
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>	
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