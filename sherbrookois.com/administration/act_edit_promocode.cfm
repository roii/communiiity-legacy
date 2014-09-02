<cfset expiredate_insert = CreateDate(mid(form.ExpireDate,7,4),mid(form.ExpireDate,4,2),mid(form.ExpireDate,1,2))>
		
		
<cfquery name="EditPromo" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE PromoCodes
SET PromoCode='#form.PromoCode#',
PromoName='#form.PromoName#',
Description='#form.Description#',

<cfif IsNumeric("#form.Points#")>
	Points=#form.Points#,
<cfelse>
	Points=0,
</cfif>

<cfif IsDate("#expiredate_insert#")>
	ExpireDate=#CreateODBCDate(expiredate_insert)#,
<cfelse>
	ExpireDate=NULL,
</cfif>

SponsorID=#form.SponsorID#
WHERE PromoID=#form.PromoID#
 </cfquery>

 

<cfoutput>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	   alert("You have updated the Promo Code!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_promocodes')"></body>
  
</cfoutput>