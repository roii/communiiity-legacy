<!--- to calculate the percentage, when cflooping, just have topschools.totalregister/topschools.numberstudents * 100 to get the percentage --->

<cfquery name="topschools" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
select top 3 schoolname, count(contacts.contactid) as totalregister, numberstudents from schools,contacts
where contacts.contacttype='kid' 
and contacts.schoolid=schools.schoolid 
and schools.schoolstatus='Active'
group by schoolname,numberstudents
order by totalregister desc
</cfquery>





