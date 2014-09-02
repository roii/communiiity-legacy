<cfoutput><cfquery name="AllTrans" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT TransactionID, Related_Identifier, Related_Description
FROM contact_transactions
WHERE Related_Description LIKE '%CompleteGoal%'
AND Transaction_Type LIKE '%credit%'
AND Transaction_Account LIKE '%Points%'
ORDER BY Related_Identifier DESC
</cfquery>

<cfset IdentifierList=''>
<cfset this_row=0>
<cfloop query="AllTrans">
<cfset this_transID = AllTrans.TransactionID>
<cfset this_Identifier = AllTrans.Related_Identifier>
<cfset this_Desc = AllTrans.Related_Description>

<cfif ListFind(IdentifierList, this_Identifier, ",")>

<cfset this_row=this_row+1>

	<cfquery name="DeleteTrans" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	DELETE 
	FROM contact_transactions
	WHERE TransactionID=#this_transID#
	</cfquery>
	
	[#this_Row#] DELETE: #this_transID# - #this_Identifier# - #this_Desc#<br>

<cfelse>

	<cfset IdentifierList = ListAppend(IdentifierList, #this_Identifier#, ",")>
	

</cfif>


</cfloop></cfoutput>