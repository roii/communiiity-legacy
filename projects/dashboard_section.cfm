<cfoutput> 
<h1>
	  #dashboard#
</h1>  
<cfif check4DashBoards eq 0> 
<cfelse>
	  <table cellpadding="0" cellspacing="0" border="0" width="100%">
		  <cfif #getCampaigns.dashboard_var_1_label# neq "" and #getCampaigns.dashboard_var_1_value# neq "" and #getCampaigns.dashboard_var_1_percentage# neq "">
				  <tr>
						<td valign="middle">
								#getCampaigns.dashboard_var_1_label#(#getCampaigns.dashboard_var_1_value#)
						</td> 
						<td valign="middle"> 
								<cfset this_percentDone = getCampaigns.dashboard_var_1_percentage>
								 <cfif this_percentDone neq '' and this_percentDone gt 0>  
									 <!---<div style="width: 206px !important; overflow: hidden;"> 
										 <cfinclude template="dsp_percent_bar.cfm"> 
									 </div>---> 
									 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
									 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>
								 </cfif>
						</td>
				  </tr>
		  </cfif>	
		  
		  <cfif #getCampaigns.dashboard_var_2_label# neq "" and #getCampaigns.dashboard_var_2_value# neq "" and #getCampaigns.dashboard_var_2_percentage# neq "">
				  <tr>
						<td valign="middle">
								#getCampaigns.dashboard_var_2_label#(#getCampaigns.dashboard_var_2_value#)
						</td> 
						<td valign="middle"> 
								<cfset this_percentDone = getCampaigns.dashboard_var_2_percentage>
								 <cfif this_percentDone neq '' and this_percentDone gt 0>  
									<!--- <div style="width: 206px !important; overflow: hidden;"> 
										 <cfinclude template="dsp_percent_bar.cfm"> 
									 </div>--->
									 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
									 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>
								 </cfif>
						</td>
				  </tr>
		  </cfif>
		  
		  <cfif #getCampaigns.dashboard_var_3_label# neq "" and #getCampaigns.dashboard_var_3_value# neq "" and #getCampaigns.dashboard_var_3_percentage# neq "">
				  <tr>
						<td valign="middle">
								#getCampaigns.dashboard_var_3_label#(#getCampaigns.dashboard_var_3_value#)
						</td> 
						<td valign="middle"> 
								<cfset this_percentDone = getCampaigns.dashboard_var_3_percentage>
								 <cfif this_percentDone neq '' and this_percentDone gt 0>  
									 <!---<div style="width: 206px !important; overflow: hidden;"> 
										 <cfinclude template="dsp_percent_bar.cfm"> 
									 </div>--->
									 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
									 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>
								 </cfif>
						</td>
				  </tr>
		  </cfif>
		  
		  <cfif #getCampaigns.dashboard_var_4_label# neq "" and #getCampaigns.dashboard_var_4_value# neq "" and #getCampaigns.dashboard_var_4_percentage# neq "">
				  <tr>
						<td valign="middle">
								#getCampaigns.dashboard_var_4_label#(#getCampaigns.dashboard_var_4_value#)
						</td> 
						<td valign="middle"> 
								<cfset this_percentDone = getCampaigns.dashboard_var_4_percentage>
								 <cfif this_percentDone neq '' and this_percentDone gt 0>  
									 <!---<div style="width: 206px !important; overflow: hidden;"> 
										 <cfinclude template="dsp_percent_bar.cfm"> 
									 </div>--->
									 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
									 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>
								 </cfif>
						</td>
				  </tr>
		  </cfif>
		  
		  <cfif #getCampaigns.dashboard_var_5_label# neq "" and #getCampaigns.dashboard_var_5_value# neq "" and #getCampaigns.dashboard_var_5_percentage# neq "">
				  <tr>
						<td valign="middle">
								#getCampaigns.dashboard_var_5_label#(#getCampaigns.dashboard_var_5_value#)
						</td> 
						<td valign="middle"> 
								<cfset this_percentDone = getCampaigns.dashboard_var_5_percentage>
								 <cfif this_percentDone neq '' and this_percentDone gt 0>  
									 <!---<div style="width: 206px !important; overflow: hidden;"> 
										 <cfinclude template="dsp_percent_bar.cfm"> 
									 </div>--->
									 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
									 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>
								 </cfif>
						</td>
				  </tr>
		  </cfif>
		  
		  <cfif #getCampaigns.dashboard_var_6_label# neq "" and #getCampaigns.dashboard_var_6_value# neq "" and #getCampaigns.dashboard_var_6_percentage# neq "">
				  <tr>
						<td valign="middle">
								#getCampaigns.dashboard_var_6_label#(#getCampaigns.dashboard_var_6_value#)
						</td> 
						<td valign="middle"> 
								<cfset this_percentDone = getCampaigns.dashboard_var_6_percentage>
								 <cfif this_percentDone neq '' and this_percentDone gt 0>  
									 <!---<div style="width: 206px !important; overflow: hidden;"> 
										 <cfinclude template="dsp_percent_bar.cfm"> 
									 </div>--->
									 <div style="float: right; margin-right: 15px">#this_percentDone#%</div>
									 <iframe src="#request.webroot#/projects/display_progress.cfm?percentValue=#this_percentDone#" width="217" style="width: 217px; height: 34px;" scrolling="no" frameborder="0"></iframe>
								 </cfif>
						</td>
				  </tr>
		  </cfif>	  
	  </table> 
</cfif>

</cfoutput>