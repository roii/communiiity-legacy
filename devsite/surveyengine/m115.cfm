<cfparam name="urls" default="test">
<cfquery  datasource="#datasourceW#" name="Update">
	update #tableforms#
	set url = '#left(urls,255)#',
	header = '#left(header,2000)#',
	footer = '#left(footer,2000)#',
	report = #report#
	where formid = #val(formid)#
	and vendorid = #val(vendorid)#
</cfquery>

