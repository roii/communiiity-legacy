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
  
<cfinclude template="../templates/header_include.cfm">    
			
				<cfif (TRIM(sectiondetails.details) NEQ '') AND (sectiondetails.details NEQ '<P>&nbsp;</P>')>
				#TRIM(sectiondetails.details)#<br>
				</cfif>  
			  
<cfinclude template="../templates/footer_include.cfm"> 
 
<!---<div align="center">
<cfinclude template="../templates/dsp_partners.cfm">
</div>--->

</body>
</html>
</cfoutput>