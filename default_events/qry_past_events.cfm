<cfquery name="EventDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM Events
WHERE EventCatID=#EventsReturn.EventCatID#
AND EndDate <= #Now()#
ORDER BY Startdate
</cfquery>