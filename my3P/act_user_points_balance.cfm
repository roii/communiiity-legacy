<cfif IsDefined("session.UserID") AND IsNumeric("#session.UserID#")>
	<cfset thisMember = session.UserID>	
<cfelseif IsDefined("newmemberID") AND IsNumeric("#session.UserID#")>
	<cfset thisMember = newmemberID>
</cfif>
	
<cfif IsDefined("thisMember")>

	<cfquery name="PointsIn" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT SUM(Transaction_Amount) AS TotalPointsIn
	FROM contact_transactions
	WHERE ContactID = #thisMember#
	AND Transaction_Type LIKE '%credit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#PointsIn.TotalPointsIn#")>
		<cfset TotalUserPointsIn = INT(PointsIn.TotalPointsIn)>
	<cfelse>
		<cfset TotalUserPointsIn = 0>
	</cfif>
	
	<cfquery name="PointsOut" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT SUM(Transaction_Amount) AS TotalPointsOut
	FROM contact_transactions
	WHERE ContactID = #thisMember#
	AND Transaction_Type LIKE '%debit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#PointsOut.TotalPointsOut#")>
		<cfset TotalUserPointsOut = INT(PointsOut.TotalPointsOut)>
	<cfelse>
		<cfset TotalUserPointsOut = 0>
	</cfif>
	
	<cfset user_points = INT(TotalUserPointsIn - TotalUserPointsOut)>

<cfelse>

	<cfset user_points = 0>

</cfif>