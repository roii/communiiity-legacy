<cfoutput>

<cftransaction action="BEGIN">

<cfif form.acctno NEQ ''>

	<cfset encrypted = encrypt(form.acctno, "kidskids")>
	
	<cfquery name="BankAcctQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM bankacct 
	WHERE kidsid = #session.userid#
	</cfquery>
	
	<cfif BankAcctQ.recordcount>
	
		<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE bankacct SET
		acctname = '#form.acctname#',
		acctno = '#encrypted#',
		branch = '#form.branch#' 
		where kidsid = #session.userid#
		</cfquery>
	
	<cfelse>
	
		<cfquery name="InsertBankAcct" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO bankacct(
		KidsID,
		acctname,
		acctno,
		branch
		)		
		VALUES(
		#session.UserID#,
		'#form.acctname#',
		'#encrypted#',
		'#form.branch#'
		)
		
		</cfquery>
		
	</cfif>
	
</cfif>

</cftransaction>


<script>
alert("Your account details have been updated");
self.location="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=42";
</script>


</cfoutput>