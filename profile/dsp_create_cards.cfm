<cfoutput>

<cfif IsDefined("session.User_ScreenName")>



	<cfparam name="format" default="P">
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>CREATE YOUR BUSINESS CARDS</strong>
	
	<hr wdith="100%" size="1" color="e2e2e2">
	
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		
		<tr>
		<td><a href="#request.webroot#/profile/dsp_print_cards.cfm?format=#format#&mode=Print" style="color:###TRIM(AllSettings.BoxColour)#;" target="printCards" ONCLICK="fdbackwindow=window.open ('','printCards','toolbar=1,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,width=800,height=450,top=10,left=10')"><strong>Open the Print Window</strong></a> to print a sheet of 14 cards. Make sure you set your printer format to PORTRAIT.</td>
		</tr>
		
		</table>
	
		<hr wdith="100%" size="1" color="e2e2e2"><br>
		
		<table cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td colspan="3" bgcolor="e2e2e2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td width="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		<td><cfinclude template="dsp_card_landscape.cfm"></td>
		<td width="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="3" bgcolor="e2e2e2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		</table><br>
		
		<div align="center"><a href="#request.webroot#/profile/dsp_print_cards.cfm?format=#format#&mode=Print" style="color:###TRIM(AllSettings.BoxColour)#;" target="printCards" ONCLICK="fdbackwindow=window.open ('','printCards','toolbar=1,location=0,directories=0,status=0,menubar=1,scrollbars=1,resizable=1,width=800,height=450,top=10,left=10')"><strong>Open the Print Window</strong></a></div>
	
	</td>
	</tr>
	
	</table>

<cfelse>

<script>
alert("Your session has timed-out.\nPlease login again to continue.");
self.location="#request.webroot#/act_logout.cfm";
</script>

</cfif>


</cfoutput>