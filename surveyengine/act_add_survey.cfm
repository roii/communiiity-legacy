<cfset deadline = CREATEDATE(#mid(form.deadline,7,4)#,#mid(form.deadline,4,2)#,#mid(form.deadline,1,2)#)>
<cfset deadline = DateFormat(#deadline#,"mm/dd/yyyy")>

		<cfquery username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="PullItemId" maxrows="1">
				select itemid
				from #tableforms#
				where itemid = #itemid#
		</cfquery>	
		
		<cfif PullItemId.recordcount is 0>

		<cfquery  username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="addform">
			insert into forms (
		   	title,
			vendorid,
			itemid,
<!---			owner,--->
			Datein,
			comID,
			deadline,
			<cfif form.noneeded NEQ ''>NoNeeded,</cfif>
			verified,
			online,
			<cfif form.price NEQ ''>price,</cfif>
			Description
			) 
			values 
			(
			'#form.surveytitle#',
			#vendorid#,
			#itemid#,
<!---			'#session.User_Email#',--->
			#now()#,
			#form.comID#,
			'#deadline#',
			<cfif form.noneeded NEQ ''>#form.noneeded#,</cfif>
			#form.status#,
			#form.online#,
			<cfif form.price NEQ ''>#form.price#,</cfif>
			'#form.description#'
			);
		SELECT Insertedformid = @@IDENTITY;
		</cfquery>
	</cfif>
    <cfquery  username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="newsurvey">
	  select top 1 formid from forms order by formid desc
	</cfquery>
<cfoutput>
<script>
alert("Survey has been added successfully!");
self.location="#request.webroot#/surveyengine/default.cfm?fuseaction=add_term&surveyid=#newsurvey.formid#&at=4&wizard=on";
</script>
</cfoutput>