<cfquery name="prizepoolQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from prize_pool where prize_pool.status = 1 and getdate() > prize_pool.start_date
</cfquery>


