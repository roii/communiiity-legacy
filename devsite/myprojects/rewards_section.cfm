<cfoutput>
<h1>
  #rewards#
</h1>
<cfquery name="getRewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TOP 3 * FROM Prize_Pool WHERE related_campaign = #campaignID# and deleted=0 
</cfquery> 
 <table cellpadding="0" cellspacing="0" border="0" width="100%">
	 <tr>
	   <cfif getRewards.recordcount gt 0>  
		 <cfloop query="getRewards">
				 <td>  
					  <div style="width: 100px; padding: 10px">
						 <img width="80" height="60" border="0" src="#request.webroot#/images/prize/#getRewards.image#"> 
						 <br />
						 #UCase(getRewards.name)# 
					  </div> 
				 </td>
		 </cfloop>
	   <cfelse>
		 Will be Shortly... 
	   </cfif>	 
	 </tr>
 </table>
 </cfoutput>