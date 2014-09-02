<cfoutput> 
 		
<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td>

	<table cellSpacing="0" cellPadding="10" style="border:solid 1px ##b4b4b4;" width="100%">
	
	<tr>
	<td style="color:##000000;"><cfif (session.MissingDetails_display EQ 0) AND (session.AlreadyJoined_display) EQ 0>
		<strong>All your invitations were sent successfully!</strong>
	<cfelse>
		<strong>Some of your invitations were not sent...</strong><br><br>
		
		<cfif session.MissingDetails_display EQ 1>
			#session.MissingDetails#<br><br>
		</cfif>
		
		<cfif session.AlreadyJoined_display EQ 1>
			#session.AlreadyJoined#
		</cfif>		
		
	</cfif></td>
	</tr>
		
	</table>
	
</td>
</tr>

</table>	

</cfoutput>