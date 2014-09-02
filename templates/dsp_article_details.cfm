<cfoutput>


<cfif articleDetails.PublicView EQ 0 AND session.UserIsAuthenticated EQ 'no'>

<script>
alert("You must be a member and logged-in to access this part of the website.");
self.location="javascript:history.back();";
</script>
<cfabort>

</cfif>




<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>

<script language="JavaScript">
<!--
function confirmSectionDelete(aURL) {
    if(confirm('Deleting a Section also deletes all linked Documents, Articles and SubArticles.\nAre you sure you want to delete this Section?')) {
      location.href = aURL;
    }
  }
//-->
</script>

<script language="JavaScript">
<!--
function confirmArticleDelete(aURL) {
    if(confirm('Deleting an Article also deletes all linked SubArticles.\nAre you sure you want to delete this Article?')) {
      location.href = aURL;
    }
  }
//-->
</script>

</cfif>

<cfset newdetails=ArticleDetails.details>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(ArticleDetails.ArticleTitle))#</strong></td>
<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_article_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#&articleID=#ArticleDetails.articleID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Article" border="0"></a>&nbsp;<a href="javascript:confirmArticleDelete('#request.webroot#/admin/act_article_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#&articleID=#ArticleDetails.articleID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></cfif></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>




<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<tr>
<td colspan="2">

<cfif TRIM(newdetails) NEQ ''>
<span class="normal">#newdetails#</span>
</cfif>

</td>
</tr>

</table>

</cfoutput>