<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon"> 
<title>#TRIM(session.AllSettings_SiteName)#</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="5" topmargin="0" rightmargin="5" bottommargin="0" marginwidth="5" marginheight="0" bgcolor="##FFFFFF" text="###TRIM(session.AllSettings_TextColour)#">

<div style="width: 100%;">

      <div class="main-header clearfix">
		  <div class="container"> 
		        <cfinclude template="../templates/dsp_topbar.cfm">
		  </div>
	  </div> 
	  
	  <div class="sub-header">
		  <div class="container clearfix">
			    <cfinclude template="../templates/dsp_menubar.cfm">
		  </div>
	  </div> 
	  
	  <div class="content">
          <div class="container">
			    <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
					<tr>
					<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td> 
					<td width="*" style="padding-left:5px;padding-right:5px;" colspan="2"> 
						<cfif (TRIM(sectiondetails.details) NEQ '') AND (sectiondetails.details NEQ '<P>&nbsp;</P>')>
						#TRIM(sectiondetails.details)#<br>
						</cfif> 
						<!---<cfinclude template="dsp_homepage_displaypane.cfm">--->
						<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">  
						<cfinclude template="dsp_community_articles.cfm">
						<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"> 
						<!---<cfinclude template="dsp_stats.cfm">
						<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">---> 
					</td>	
				<!---	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td> --->
					</tr>	
		        </table>
	      </div>
	  </div>	  		   
	  
	  <div class="main-footer">
          <div class="container clearfix">
	          <cfinclude template="../templates/dsp_bottombar.cfm">
		  </div> 
	  </div>
	  
</div>

 
<!---<div align="center">
<cfinclude template="../templates/dsp_partners.cfm">
</div>--->

</body>
</html>

</cfoutput>