<cfoutput>

<script language="JavaScript">
<!--
function confirmCodeDelete(aURL) {
    if(confirm('Are you sure you want to delete this Promo Code?')) {
      location.href = aURL;
    }
  }
//-->
</script>

<cfinclude template="qry_promo_codes.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="*" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE PROMO CODES</strong></td>
<td align="right" width="100"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<tr>
<td style="font-size:11px;"><a href="#request.webroot#/administration/dsp_add_promocode.cfm" target="AddPromo" onclick="fdbackwindow=window.open ('','AddPromo','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=550,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A PROMO CODE &raquo;</strong></a></td>
<td></td>
</tr>

</table><br>





<cfif qry_promos.recordcount>

<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="padding-right:10px;font-size:11px;"><b>Expires</b></td>
<td style="padding-right:10px;font-size:11px;"><b>Name</b></td>
<td style="padding-right:10px;font-size:11px;"><b>Code</b></td>
<td style="padding-right:10px;font-size:11px;"><b>Desc.</b></td>
<td align="center" style="font-size:11px;"><b>Points</b></td>
<td> </td>
</tr>

<tr>
<td width="130" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="130" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="130" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="*" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="60" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
</tr>

<tr>
<td colspan="6" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<cfloop query="qry_promos">

<cfset this_PromoID = qry_promos.PromoID>

<tr>
<td valign="top" style="padding-right:10px;font-size:11px;">#DateFormat(qry_promos.ExpireDate)#</td>
<td valign="top" style="padding-right:10px;font-size:11px;">#TRIM(qry_promos.PromoName)#</td>
<td valign="top" style="padding-right:10px;font-size:11px;">#TRIM(qry_promos.PromoCode)#</td>
<td valign="top" style="padding-right:10px;font-size:11px;">#TRIM(qry_promos.Description)#</td>
<td valign="top" align="center" style="font-size:11px;">#INT(qry_promos.Points)#</td>
<td align="right" valign="top" style="font-size:11px;"><a href="#request.webroot#/administration/dsp_edit_promocode.cfm?PromoID=#this_PromoID#" target="EditPromo" onclick="fdbackwindow=window.open ('','EditPromo','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=500,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Promo Code" border="0"></a> <a href="javascript:confirmPromoDelete('#request.webroot#/administration/act_del_promo.cfm?PromoID=#this_PromoID#');"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Promo Code" border="0"></a></td>
</tr>

<tr>
<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="6" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</cfloop>


</table><br><br>
</cfif>


</cfoutput>