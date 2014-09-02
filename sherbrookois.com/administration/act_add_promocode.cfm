<cfset expiredate_insert = form.ExpireDate>

<!--- GENERATE NEW PROMO ID --->	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT PromoID
FROM Promocodes
ORDER BY PromoID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.PromoID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>

		
<cfquery name="addPromo" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO PromoCodes(
PromoID,
PromoCode,
PromoName,
Description,
Points,
ExpireDate,
SponsorID
)
VALUES(
#newID#,
'#form.PromoCode#',
'#form.PromoName#',
'#form.Description#',
<cfif IsNumeric("#form.Points#")>
	#form.Points#,
<cfelse>
	0,
</cfif>

<cfif IsDate("#expiredate_insert#")>
	#CreateODBCDate(expiredate_insert)#,
<cfelse>
	NULL,
</cfif>
#form.sponsorID#
)
 </cfquery>

 

<cfoutput>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	   alert("You have add the new Promo Code!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_promocodes')"></body>
  
</cfoutput>