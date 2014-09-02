<!--- SET THE REVIEW DATE --->
<cfset InsertDate='#Date_startday#' & ' ' & '#Date_startmonth#' & ' ' & '#Date_startyear#'>


<!--- UPDATE INFO --->
<cfquery name="updateEvent" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE WhatsNew
SET ShortDescription='#TRIM(form.shortdescription)#',
DateExpires=#createODBCDate(InsertDate)#
WHERE WNID=#form.WNID#
</cfquery>



<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=whatsnew')"></body>
	

		
	
	
	</cfoutput>