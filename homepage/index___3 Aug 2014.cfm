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

<div style="width: 100%; background: none repeat scroll 0 0 ##FBF9FC;"> 
	  
<!---	  <!-- Bootstrap core CSS -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
 
<!-- Custom styles for this template -->
    <link href="/css/navbar-fixed-top.css" rel="stylesheet"> --->
	
<cfinclude template="../templates/header_include.cfm">  	
	  
	  <div class="content"> 
	        <cfif browser eq 'Internet Explorer'>
			  <div class="container" style="text-align: left;">
			<cfelse>
			  <div class="container">
			</cfif> 
			    <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
					<tr>
					<!---<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td> --->
					<td width="*" style="padding-left:5px;padding-right:5px;" colspan="3"> 
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
	  
	  <cfinclude template="../templates/footer_include.cfm">
	  
</div>

 
<!---<div align="center">
<cfinclude template="../templates/dsp_partners.cfm">
</div>--->

</body>
</html>

</cfoutput>