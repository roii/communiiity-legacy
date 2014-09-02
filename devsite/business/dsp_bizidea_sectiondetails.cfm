<cfoutput>

<script language="JavaScript">
<!--
function confirmSectionDelete(aURL) {
    if(confirm('Are you sure you want to delete this Section?')) {
      location.href = aURL;
    }
  }
//-->
</script>


<cfinclude template="qry_bizidea.cfm">

<cfquery name="Sectionstuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT * 
FROM bizidea_sections
WHERE sectionID = #sectionID#
</cfquery>

<table width="100%" cellpadding="2" cellspacing="2" border="0">  

<tr> 
<td><span style="font-size:11px;"><b>#TRIM(Currentbizidea.biz_idea)#</b></span>
<hr width="100%" size="1" color="e2e2e2">
<span style="font-size:14px;"><b>#TRIM(Sectionstuff.title)#</b></span><br><br>
#TRIM(Sectionstuff.details)#</td>
</tr>

</table><br>

</cfoutput>