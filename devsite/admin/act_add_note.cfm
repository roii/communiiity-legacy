<cfparam name="form.kidsnote" default="">

<cfif form.kidsnote EQ ''>
  <cflocation url="#request.webroot#/admin/dsp_kid_edit.cfm?contactid=#form.contactid#">
</cfif>

		<!--- INSERT Note --->
		
		<cfquery name="AddNote" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO kidsnote(
		dateadded,
		Note,
		kidsid,
		admin
		)
		
		VALUES(
		#localDateTime#, 
		'#trim(form.kidsnote)#',
		'#form.contactid#',
		'#session.user_email#'
		)
		</cfquery>
		
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location.reload(true);
	    self.close();
	}
	
	// -->
	</script>
		

<body onload="showParentAndClose('#request.webroot#/admin/dsp_kid_edit.cfm?contactid=#form.contactid#')">
</body>