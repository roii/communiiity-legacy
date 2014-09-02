<cfquery name="AllKidSurvey" datasource="#dsn#" username="#request.username#" password="#request.password#">

   select count(kidsurvey.kidid) as clientcount,kidsurvey.kidid,contacts.firstname,contacts.lastname,contacts.emailaddress
	  from kidsurvey inner join kidclientlinks on kidclientlinks.clientid = kidsurvey.clientid
	  inner join contacts on contacts.contactid = kidsurvey.kidid
	  where kidclientlinks.clientstageid > 0
          group by kidsurvey.kidid,contacts.firstname,contacts.lastname,contacts.emailaddress


ORDER BY #TRIM(kids_sortby)# #sortorder#
</cfquery>