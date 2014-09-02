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

      <header class="main-header clearfix">
		  <div class="container"> 
		        <cfinclude template="../templates/dsp_topbar.cfm">
		  </div>
	  </header> 
	  
	  <div class="sub-header">
		  <div class="container clearfix">
			    <cfinclude template="../templates/dsp_menubar.cfm">
		  </div>
	  </div> 
	  
	  <div style="width: 1000px;">
	       dddsds
	  </div>
	  
	  <div style="width: 1000px;">
	       <cfinclude template="../templates/dsp_bottombar.cfm">
	  </div>
	  
</div>

 
<!---<div align="center">
<cfinclude template="../templates/dsp_partners.cfm">
</div>--->

</body>
</html>

</cfoutput>