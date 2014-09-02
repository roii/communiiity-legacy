<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - SMS Number Formats</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="10" topmargin="10" rightmargin="10" bottommargin="10" marginwidth="10" marginheight="10" bgcolor="ffffff">

<table width="100%" border="0">

<tr>
<td align="center" style="color:444444;font-size:11px;">
<hr width="100%" size="1" color="b4b4b4">
<span style="font-size:12px;"><strong>How to format the mobile number you're sending to</strong></span>
<hr width="100%" size="1" color="b4b4b4"><br>


Country Code, Network prefix <u>without</u> the leading "0", Number, <u>no spaces</u>, only numerals.<br><br>

<img src="#request.imageroot#/sms_number_format.gif" width="354" height="84" border="0"><br><br>

AUS: 61401234567 (Country Code = 61, network prefix = 40, number = 1234567)<br>
USA: 12481234567 (Country Code = 1, network prefix = 248, number = 1234567)<br><br>

<strong>i.e.</strong> the number in the NZ &nbsp;<strong>(+64) 021 555 1234</strong>&nbsp; becomes &nbsp;<strong>64215551234</strong><br><br>


<hr width="100%" size="1" color="b4b4b4"><br>
<input type="button" class="whitefield" value="Close Window" onclick="window.close();">

</td>
</tr>

</table>

</body>
</html>

</cfoutput>