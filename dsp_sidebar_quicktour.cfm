<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>QUICK TOUR</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td background="#request.imageroot#/sidebar_boxR_bg2.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>

	
	<table width="160" cellpadding="0" cellspacing="0" border="0" align="center">
	
	
	
	<tr>
	<td style="padding-left:5px;font-size:11px;color:black;">The Quick Tour will introduce you to some of the key parts of #TRIM(AllSettings.SiteName)#. Click the image below to lauch the quick tour...<br><br>
	<div align="center"><a href="#request.webroot#/templates/dsp_quicktour_popup.cfm" target="quicktour" onclick="fdbackwindow=window.open ('','quicktour','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')"><img src="#request.imageroot#/quick_tour_icon.gif" width="170" height="106" alt="Launch the Quick Tour" border="0"></a></div></td>
	</tr>
	
	
	</table><br>


</td>
</tr>

</table>


</cfoutput>