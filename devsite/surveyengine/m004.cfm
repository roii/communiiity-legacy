<cfquery  name="BuildQuestion" datasource="#datasourceR#">
	SELECT id,questiontype,question,option1,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,vendorid,validation
	FROM #tablequestions#
	WHERE formid = #trim(attributes.formid)# 
	<!---and vendorid = #val(vendorid)#--->
</cfquery>

<cfquery  name="CheckArchive" datasource="#datasourceR#">
	SELECT verified, library
	FROM #tableforms#
	WHERE formid = #val(formid)# 
	and vendorid = #val(vendorid)#
</cfquery>

