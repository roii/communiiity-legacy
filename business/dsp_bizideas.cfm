<cfoutput>

<cfinclude template="qry_bizidea.cfm">

<table width="100%" cellpadding="0" cellspacing="1" border="0">

<cfloop query="Allbizideas">

	<cfset this_bizideaID = Allbizideas.bizideaid>

	<!--- GET FIRST SECTION FOR EACH --->
	<cfquery name="bizidea_Sections" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT SectionID
	FROM bizidea_sections
	WHERE bizideaID = #this_bizideaID#
	ORDER BY DisplayOrder
	</cfquery>
	
	<!--- <cfquery name="bizideabizloop" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT business.bizid, bizkidslink.bizkidslinkid
	FROM business, bizkidslink
	WHERE business.bizideaID=#this_bizideaID#
	AND business.Bizid=bizkidslink.bizid
	</cfquery>
	
	<cfset total_income = 0>
	<cfset total_expense = 0>		
	<cfset TotalProfit = 0>
	<cfset TotalMins = 0>
	<cfset HourRate = 0>
	
	<cfloop query="bizideabizloop">
		
		<cfset this_bizkidslinkID = bizideabizloop.bizkidslinkid>
	
		<cfquery name="AllTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT * 
		FROM bizTransaction 
		WHERE bizTransaction.bizkidslinkid=#this_bizkidslinkID#
		AND bizTransaction.ExcludeBenchmark=0
		</cfquery>
		
		<cfloop query="AllTransaction">
		
			<cfif IsNumeric("#AllTransaction.Income1_amount#")>
				<cfset total_income=(total_income+AllTransaction.Income1_amount)>
			</cfif>
			
			<cfif IsNumeric("#AllTransaction.Income2_amount#")>
				<cfset total_income=(total_income+AllTransaction.Income2_amount)>
			</cfif>
			
			<cfif IsNumeric("#AllTransaction.Income3_amount#")>
				<cfset total_income=(total_income+AllTransaction.Income3_amount)>
			</cfif>
			
			<cfif IsNumeric("#AllTransaction.Income4_amount#")>
				<cfset total_income=(total_income+AllTransaction.Income4_amount)>
			</cfif>
			
			<cfif IsNumeric("#AllTransaction.Income5_amount#")>
				<cfset total_income=(total_income+AllTransaction.Income5_amount)>
			</cfif>
			
			
			<cfif IsNumeric("#AllTransaction.expense1_amount#")>
				<cfset total_expense=(total_expense+AllTransaction.expense1_amount)>
			</cfif>
			
			<cfif IsNumeric("#AllTransaction.expense2_amount#")>
				<cfset total_expense=(total_expense+AllTransaction.expense2_amount)>
			</cfif>
			
			<cfif IsNumeric("#AllTransaction.expense3_amount#")>
				<cfset total_expense=(total_expense+AllTransaction.expense3_amount)>
			</cfif>
			
			<cfif IsNumeric("#AllTransaction.expense4_amount#")>
				<cfset total_expense=(total_expense+AllTransaction.expense4_amount)>
			</cfif>
			
			<cfif IsNumeric("#AllTransaction.expense5_amount#")>
				<cfset total_expense=(total_expense+AllTransaction.expense5_amount)>
			</cfif>
			
			
			<cfset TotalProfit = (total_income - total_expense)>
			<cfset TotalMins = (TotalMins + AllTransaction.hours)>
		
		</cfloop>
		
	
	</cfloop>
	
		
	<cfif TotalMins GT 0 AND TotalProfit GT 0>
		<cfset MinuteRate = (TotalProfit / TotalMins)>
		<cfset HourRate = (MinuteRate * 60)>
	</cfif> --->
	
	<!--- GET ALL FEEDBACK --->
	<cfquery name="AllFeedback" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM Feedback
	WHERE Feedback_Type LIKE '%BusinessTemplate%'
	AND LinkID=#this_bizideaID#
	</cfquery>
	
	<cfset totalrating = 0>
	
	<cfif AllFeedback.RecordCount>	
		<cfloop query="AllFeedback">
			<cfset totalrating = (totalrating + AllFeedback.Feedback_Rating)>
		</cfloop>
			
		<cfset feedback_average = (totalrating / AllFeedback.RecordCount)>
		<cfset feedback_average_int = INT(feedback_average)>		
		<cfset average_third = "#feedback_average_int#.3">
		<cfset average_two_third = "#feedback_average_int#.7">		
		<cfif feedback_average LT average_third>
			<cfset wholestars = feedback_average_int>
			<cfset halfstars = 0>
		<cfelseif feedback_average LT average_two_third>
			<cfset wholestars = feedback_average_int>
			<cfset halfstars = 1>
		<cfelse>
			<cfset wholestars = (feedback_average_int + 1)>
			<cfset halfstars = 0>
		</cfif>		
	</cfif>
		
	<cfif isDefined("session.UserID")>	
		<!--- CHECK FOR CURREN USER FEEDBACK --->
		<cfquery name="UserFeedbackCheck" dbtype="query">
		SELECT *
		FROM AllFeedback
		WHERE ContactID=#session.UserID#
		</cfquery>	
	</cfif>
	
	<tr>
	<td valign="top" width="90">
	
		<table width="90" height="70" cellpadding="5" cellspacing="0" style="border:1px solid ##b4b4b4;">
				
		<tr>
		<td align="center" valign="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=BusinessDetails&bizideaID=#this_bizideaID#<cfif bizidea_Sections.recordcount>&BizSectionID=#bizidea_Sections.SectionID#</cfif>&documentID=#documentID#"><cfif FileExists("#request.fileroot#\images\business\#TRIM(Allbizideas.image_lowres)#")><img src="#request.imageroot#/business/#TRIM(Allbizideas.image_lowres)#" border="0" width="80" height="60"><cfelse><img src="#request.imageroot#/prize_placeholder.gif" width="80" height="60" border="0"></cfif></a></td>
		</tr>
		
		</table>
	
	</td>
	<td valign="top" style="padding-left:10px;">
	
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td><cfif session.UserIsAuthenticated EQ 'Yes'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=BusinessDetails&bizideaID=#bizideaID#<cfif bizidea_Sections.recordcount>&BizSectionID=#bizidea_Sections.SectionID#</cfif>&documentID=#documentID#" style="font-size:12px;color:Black;"><cfelse><a href="javascript:alert('Please register and login to view the business templates.');" style="font-size:12px;color:Black;"></cfif><strong>#TRIM(biz_idea)#</strong></a></td>
		<td align="right" style="font-size:12px;color:red;"><cfif session.UserIsAuthenticated EQ 'Yes'><cfif UserFeedbackCheck.recordcount><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=BusinessDetails&BizideaID=#BizideaID#&documentID=#documentID#"><cfloop from="1" to="#wholestars#" index="loopcount"><img src="#request.imageroot#/feedback_redstar.gif" width="12" height="13" alt="Average Rating: #DecimalFormat(feedback_average)#" border="0" align="absmiddle"></cfloop><cfif halfstars EQ 1><img src="#request.imageroot#/feedback_half_redstar.gif" width="12" height="13" alt="Average Rating: #DecimalFormat(feedback_average)#" border="0" align="absmiddle"></cfif></a> <span title="Total Feedback: #AllFeedback.RecordCount#"><sup>(#AllFeedback.RecordCount#)</sup></span><cfelse><a href="#request.webroot#/index.cfm?fuseaction=feedback&fusesubaction=rate&type=BusinessTemplate&BizideaID=#bizideaID#" style="color:red;">Rate this business!</a></cfif></cfif></td>
		</tr>		
		
		<tr>
		<td valign="top" colspan="2">#TRIM(biz_summary)#<br>		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="150" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="4" border="0"></td>
			<td width="100%" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
			</tr>
			
			<cfif session.UserIsAuthenticated EQ 'Yes'>
			
				<!--- IF AUTHORISED CHECK IF USER HAS ALREADY STARTED TIS BUSINESS --->
				<cfquery name="UserBizCheck" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT business.bizid
				FROM bizkidslink, business
				WHERE bizkidslink.kidsid=#session.UserID#
				AND bizkidslink.bizid=business.Bizid
				AND business.bizideaID=#this_bizideaID#
				</cfquery>
				
				<cfif UserBizCheck.RecordCount>
				<cfelse>
				<form name="AddBiz" action="#request.webroot#/business/act_add_biz.cfm" method="post">
				<input type="hidden" name="BizIdeaID" value="#this_bizideaID#">
				<input type="hidden" name="dateCreated" value="#DateFormat(localDateTime, "dd/mm/yyyy")#">
				</cfif>
				
				<tr>
				<td><cfif UserBizCheck.RecordCount><cfelse><input type="image" src="#request.imageroot#/start_business_but.gif" border="0" align="absmiddle"></cfif></td>
				<td align="right" width="100%"><!--- <span style="color:##007500;font-weight:bold;">Avg Profit / hr : </span><span style="color:###TRIM(AllSettings.BoxColour)#;font-weight:bold;">#dollarformat(HourRate)#</span> ---></td>
				</tr>
				<cfif UserBizCheck.RecordCount><cfelse></form></cfif>
				
				
			<cfelse>
				<td><a href="javascript:self.location='#request.webroot#/index.cfm?fuseaction=join';"><img src="#request.imageroot#/start_business_off_but.gif" border="0" style="cursor:hand;" align="absmiddle"></a></td>
				<td align="right" width="100%"><!--- <span style="color:##007500;font-weight:bold;">Avg Profit / hr : </span><span style="color:###TRIM(AllSettings.BoxColour)#;font-weight:bold;">#dollarformat(HourRate)#</span> ---></td>
			</cfif>
			
			</table>			
			
		</td>
		</tr>
		
		</table>		
	
	</td>
	</tr>
	
	
	<tr>
	<td height="2" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="##b4b4b4" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td height="3" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
</cfloop>

</table><br><br>


</cfoutput>