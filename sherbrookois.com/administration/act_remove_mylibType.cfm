<cfoutput>

<cftransaction action="BEGIN">
  
  <cfquery name="Deletemylib" datasource="#dsn#" username="#request.username#" password="#request.password#">
	delete from mylib WHERE mylibtypeid=#attributes.mylibtypeid#
  </cfquery>
  
  <cfquery name="Deletetype" datasource="#dsn#" username="#request.username#" password="#request.password#">
	delete from mylibtype WHERE mylibtypeid=#attributes.mylibtypeid#
  </cfquery>

</cftransaction>

<script>
alert("This type has been deleted from the database!");
self.location="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=docs&documentid=30";
</script>

</cfoutput>