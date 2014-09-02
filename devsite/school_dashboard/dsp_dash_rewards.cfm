<cfoutput>

<!--- GET ALL PRIZES WON BY SCHOOL --->
<cfquery name="AllPrizesWon" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT COUNT(PrizePoolID) AS TotalPrizesWon, SUM(pointsvalue) AS TotalPrizeValue
FROM Prize_Pool
WHERE PrizeDraw=1
AND winner IN (#AllSchoolKids#)
</cfquery>

<!--- GET ALL REWARDS PURCHASED --->
<cfquery name="AllRewardsPurchased" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT COUNT(TransactionID) AS TotalRewardsPurchased, SUM(Transaction_Amount) AS TotalRewardValue
FROM contact_transactions
WHERE Transaction_Type LIKE '%debit%'
AND Transaction_Description LIKE '%PURCHASED REWARD%'
AND ContactID IN (#AllSchoolKids#)
</cfquery>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Prizes and Rewards</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/rewards_sml.jpg" alt="Prizes and Rewards" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Prizes:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllPrizesWon.TotalPrizesWon# (#AllPrizesWon.TotalPrizeValue#pts)</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Rewards:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllRewardsPurchased.TotalRewardsPurchased# (#AllRewardsPurchased.TotalRewardValue#pts)</td>
	</tr>
	
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>