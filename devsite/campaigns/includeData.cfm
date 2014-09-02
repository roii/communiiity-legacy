<cfif IsDefined("SESSION.userid") and SESSION.userid neq ''>
      <cfset userid = SESSION.userid>
<cfelse>
      <cfset userid = 0>
</cfif>
<cfset userip = CGI.REMOTE_ADDR>
<style>
    /* Example Styles for Demo */
    .etabs { margin: 0; padding: 0; }
    .tab { display: inline-block; zoom:1; *display:inline; background: #eee; border: solid 1px #999; border-bottom: none; -moz-border-radius: 4px 4px 0 0; -webkit-border-radius: 4px 4px 0 0; }
    .tab a { font-size: 14px; line-height: 2em; display: block; padding: 0 10px; outline: none; text-decoration:none; color: grey; }
    .tab a:hover { text-decoration: none; color: #008621; font-weight: bold; }
    .tab.active { background: #fff; padding-top: 6px; position: relative; top: 1px; border-color: #666; color: #008621; text-decoration:none;}
    .tab a.active { font-weight: bold; text-decoration:none; color: #008621; }
    .tab-container .panel-container { background: #fff; border: solid #666 1px; /*padding: 10px;*/ -moz-border-radius: 0 4px 4px 4px; -webkit-border-radius: 0 4px 4px 4px;
	width: 965px; }
    .panel-container { margin-bottom: 10px; }
</style>
<script type="text/javascript">
    $(document).ready( function() {
      $('#tab-container').easytabs();
    });
</script> 

<cfquery name="getCampaigns" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT * FROM campaigns WHERE CampaignsID = #campaign_id# 
		</cfquery>   
		<cfset check4DashBoards = 0> 
		<cfif #getCampaigns.dashboard_var_1_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_1_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_1_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_2_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_2_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_2_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_3_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_3_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_3_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_4_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_4_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_4_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_5_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_5_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_5_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_6_label# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_6_value# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>
		<cfif #getCampaigns.dashboard_var_6_percentage# neq ''>
             <cfset check4DashBoards = check4DashBoards + 1>
		</cfif>  
	 <cfset campaignID = #getCampaigns.CampaignsID#>	 
	 <cfset categoryID = #getCampaigns.PROJECTCATEGORYID#> 
	    <cfquery name="getCategoryName" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Title FROM ProjectCategories WHERE ProjectCategoryID = '#categoryID#' 
		</cfquery> 
		
      <cfquery name="getcontributorIdeasData" datasource="#dsn#" username="#request.username#" password="#request.password#">
		 SELECT DISTINCT sugg.contactID as contactID, scat.Name as ideaTopic FROM SugCategory as scat INNER JOIN Suggestion as sugg ON scat.CategoryID = sugg.CategoryID INNER JOIN Contacts as ct ON ct.ContactID = sugg.contactID
		 WHERE scat.related_campaign = #campaignID#
	  </cfquery> 
	  
	  <cfquery name="getcontributorProjectsData" datasource="#dsn#" username="#request.username#" password="#request.password#">
		 SELECT DISTINCT projcom.contactID as contactID, proj.Title as Project FROM Projects as proj INNER JOIN ProjectComments as projcom ON proj.ProjectID = projcom.ProjectID INNER JOIN Contacts as ct ON ct.ContactID = projcom.contactid
		 WHERE proj.related_campaign = #campaignID#
	  </cfquery> 