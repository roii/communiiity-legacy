<html>
<head>
<title>Activescan Demo</title>
</head>
<body leftmargin="0" topmargin="0">
<cflock scope="application" timeout="100">
  <cf_activescan 
  	imagename="current"
  	inc="#application.inc#"
  	imagepath="#application.imagepath#"
  	onSave="redirect"
  	onSaveAction="overwrite.cfm?wrote=%file%"
  	license="#application.license#"
  >
</cflock>
</body>

</html>