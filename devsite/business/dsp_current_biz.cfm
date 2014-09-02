<cfoutput>

<cfparam name="session.InActiveMode" default="Hide">
<cfif IsDefined("InActiveMode")>
	<cfset session.InActiveMode = InActiveMode>
</cfif>

<cfinclude template="qry_current_biz.cfm">

<table width="100%" cellpadding="0" cellspacing="1" border="0">

<tr>
<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&BizMode=add" style="color:###TRIM(AllSettings.BoxColour)#;text-decoration:none;"><strong>ADD A BUSINESS &raquo;</strong></a></td>
<td align="right"><strong>Inactive Businesses:</strong> &nbsp; <cfif session.InActiveMode EQ 'Hide'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&InActiveMode=Show" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif>Show</a> | <cfif session.InActiveMode EQ 'Show'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&InActiveMode=Hide" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif>Hide</a></td>
</tr>

</table><br>


<table width="100%" cellpadding="0" cellspacing="1" border="0">

<tr bgcolor="###TRIM(AllSettings.DkBoxColour)#" height="25">
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:10px;" colspan="2"><strong>Business</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;" align="center"><strong>Profits<br>to Date</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;" align="center"><strong>Hours<br>invested</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;" align="center"><strong>Avg $ per<br>hour Invested</strong></td>
<td align="center" width="100"> </td>
</tr>

<tr>
<td colspan="6" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
</tr>

<cfif Currentbiz.RecordCount>
	
	<cfloop query="Currentbiz">
	
	<!--- CHECK FOR IMAGE --->
	<cfquery name="ImageStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT image_lowres
	FROM bizidea	
	<cfif Currentbiz.bizideaID NEQ ''>
		WHERE bizideaID=#Currentbiz.bizideaID#
	<cfelse>
		WHERE bizideaID=0
	</cfif>	
	</cfquery>	
	
	<cfquery name="AllTransaction" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT * 
	FROM bizTransaction 
	WHERE bizkidslinkid=#Currentbiz.bizkidslinkid#
	</cfquery>
	
	<cfset total_income = 0>
	<cfset total_expense = 0>
	
	<cfset TotalProfit = 0>
	<cfset TotalMins = 0>
	
	
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
	
	
	<cfset TotalProfit = total_income-total_expense>	
	<cfset TotalMins = TotalMins + AllTransaction.hours>
	
	</cfloop>
	
	
	<cfif TotalMins GT 0>
		<cfset display_hour = INT(TotalMins/60)>
		<cfset display_minutes = TotalMins MOD 60>
	
		<cfset TotalHrs = TotalMins / 60>
	<cfelse>
		<cfset display_hour = 0>
		<cfset display_minutes = 0>
		<cfset TotalHrs = 0>
	</cfif>
	
	<cfif TotalHrs GT 0 AND TotalProfit GT 0>
		<cfset HourRate = TotalProfit / TotalHrs>
	<cfelse>
		<cfset HourRate = 0>
	</cfif>
	
	
	
	<tr>
	<td valign="top" width="90">
	
		<table width="90" height="70" cellpadding="5" cellspacing="0" style="border:1px solid ##b4b4b4;">
			
		<tr>
		<td align="center" valign="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&BizMode=edit&bizkidslinkID=#bizkidslinkID#" title="Edit this business"><cfif IsDefined("ImageStuff") AND ImageStuff.RecordCount AND FileExists("#request.fileroot#\images\business\#TRIM(ImageStuff.image_lowres)#")><img src="#request.imageroot#/business/#TRIM(ImageStuff.image_lowres)#" border="0" width="80" height="60"><cfelse><img src="#request.imageroot#/prize_placeholder.gif" width="80" height="60" border="0"></cfif></a></td>
		</tr>
		
		</table>
	
	</td>
	<td valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&BizMode=edit&bizkidslinkID=#bizkidslinkID#" title="Edit this business" style="padding-left:10px;color:black;"><strong>#TRIM(Currentbiz.bizname)#</strong></a><cfif Currentbiz.BizStatus CONTAINS 'InActive'> (Inactive)</cfif></td>
	<td valign="top" align="right" style="padding-right:10px;">$#decimalformat(TotalProfit)#</td>
	<td valign="top" align="right" style="padding-right:10px;">#display_hour#:#numberFormat(display_minutes, "00")#</td>
	<td valign="top" align="right" style="padding-right:10px;">$#decimalformat(HourRate)#</td>
	<td valign="top" align="center" width="100"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&BizMode=transaction&bizkidslinkID=#bizkidslinkID#" title="Add Transactions to this business"><img src="#request.imageroot#/addjob_button.gif" width="56" height="19" title="Add Transactions to this business" border="0" align="absmiddle"></a> &nbsp; <a href="index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentid=#documentid#&BizMode=EditBiz&bizkidslinkID=#bizkidslinkID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" title="Edit this Business" border="0" align="absmiddle"></a></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	
	</cfloop>

<cfelse>

	<tr>
	<td colspan="6" style="padding-left:10px;">You haven't entered any businesses yet.</td>
	</tr>
	
	<tr>
	<td colspan="6" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>

</cfif>

</table>


</cfoutput>