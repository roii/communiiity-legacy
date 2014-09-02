<cfquery name="getUserDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
    SELECT * FROM Contacts
	 WHERE ContactID = #SESSION.userid#  
</cfquery>