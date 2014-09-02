<cfquery name="qry_promo_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM promocodes 
WHERE PromoID=#PromoID#
</cfquery>


<cfquery name="AllPartners" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Organisations.*, Countries.Name
FROM Organisations, Countries
WHERE Organisations.OrgCatID=5
AND Organisations.Organisation_Status LIKE '%Active%'
AND Organisations.CountryID=Countries.CountryID
</cfquery>


<cfoutput>

<script language="JavaScript">

<!--
function validate(EditPromo) {

if (EditPromo.PromoCode.value == "") {
	alert("You must enter a Code for this promotion.");
	EditPromo.PromoCode.focus();
	return;
	} 
	
else if (EditPromo.PromoName.value == "") {
	alert("You must enter a Name for this promotion.");
	EditPromo.PromoName.focus();
	return;
	} 
	
else if (EditPromo.Points.value == "") {
	alert("You must enter a Points Value for this promotion.");
	EditPromo.Points.focus();
	return;
	} 
	
else if (EditPromo.ExpireDate.value == "") {
	alert("You must enter an Expiry Date for this promotion.");
	EditPromo.ExpireDate.focus();
	return;
	} 
	
else {
	EditPromo.submit(); //submit form
	}
}
// -->
</script>




<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Edit Promo Code</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Promo Code</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="EditPromo" action="#request.webroot#/administration/act_edit_promocode.cfm" method="post" onsubmit="javascript:validate(EditPromo); return false;">
	
	<input type="hidden" name="PromoID" value="#PromoID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Promotion Code</td>
	<td><input type="text" name="PromoCode" class="whitefield" style="width:300px;" value="#TRIM(qry_promo_details.PromoCode)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Promotion Name</td>
	<td><input type="text" name="PromoName" class="whitefield" style="width:300px;" value="#TRIM(qry_promo_details.PromoName)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110" valign="top">Description</td>
	<td><textarea rows="5" name="Description" class="whitefield" style="width:300px;">#TRIM(qry_promo_details.Description)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Points</td>
	<td><input type="text" name="Points" class="whitefield" style="width:300px;" value="#TRIM(qry_promo_details.Points)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Sponsor</td>
	<td><select name="SponsorID" class="whitefield" style="width:300px;">
	<option value="0">-- No Sponsor --
	<cfloop query="AllPartners">
	<option value="#AllPartners.OrganisationID#"<cfif qry_promo_details.SponsorID EQ AllPartners.OrganisationID> selected</cfif>>#TRIM(AllPartners.Organisation_Name)#
	</cfloop>
	</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Expiry Date</td>
	<td><input type="text" name="ExpireDate" class="whitefield" style="width:300px;" value="#DateFormat(qry_promo_details.ExpireDate, "dd/mm/yy")#"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.EditPromo.ExpireDate);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" value="UPDATE PROMO CODE >>" class="whitefield"> &nbsp; <input type="button" onclick="window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table><br>


	
</td>
</tr>

</table>

</body>
</html>

<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/administration/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">

</cfoutput>