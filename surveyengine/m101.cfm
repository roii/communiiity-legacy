
<!--- Check if new survey title is not blank --->
<cfif len(title)>
	
		<!--- Run Transaction --->
		<cftransaction>
		
			<cfquery username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="PullItemId" maxrows="1">
				select itemid
				from #tableforms#
				where itemid = #itemid#
			</cfquery>	
		
			<cfif PullItemId.recordcount is 0>
			
				<!--- Insert new survey title in the database
				<cfinsert username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" tablename="#tableforms#" formfields="title,vendorid,itemid"> --->
               <cfquery  username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="addform">
				insert into forms (title,vendorid,itemid,owner) values ('#title#',#vendorid#,#itemid#,'#session.User_Email#')
			   </cfquery>

				<!--- Select newly created ID --->
				<cfquery username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="PullId">
					select max(formid) as fid
					from #tableforms#
					where itemid = #itemid#
				</cfquery>
		
			</cfif>			
			
		</cftransaction>
		
</cfif>
