<cfoutput>
<cfquery name="bottomnav" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SectionID, Fuseaction, MenuTitle
FROM Sections
WHERE BottomMenu=1

<cfif session.UserIsAuthenticated>

	<cfif session.UserType NEQ 'Administrator'>
		AND (ContactTypeView LIKE '#session.User_ContactTypeID#' OR ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#')
	</cfif>

<cfelse>
	AND PublicView = 1
</cfif>
ORDER BY MainMenuOrder
</cfquery>
<style>
	.links {		
		color:##FFFFFF;
		font-family:Verdana, Geneva, sans-serif;
		font-size:small
		}

</style>

<div style="color:##FFFFFF;font-weight:bold;background:##EEEEEE; text-align: center; padding-left: 22%;">
<cfquery name="getContent" datasource="#dsn#" username="#request.username#" password="#request.password#">
   SELECT * FROM site_section_contents_data WHERE section_id = 1
</cfquery>
  #getContent.footer#
</div>  

<!---<table width="100%" align="center" style="color:##FFFFFF;font-weight:bold;background:##AEAEAE;">
    <tr>
        <th width="6%">&nbsp;</th>
        <th width="15%" align="left">About My3P</th>
        <th width="6%">&nbsp;</th>
        <th width="15%" align="left"> Information </th>
        <th width="6%">&nbsp;</th>
        <th width="15%" align="left"> Usage </th>
        <th width="6%">&nbsp;</th>
        <th width="15%" align="left"> Resources </th>
        <th width="6%">&nbsp;</th>
    </tr>
    <tr>
        <th width="6%">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%">&nbsp;</th>
    </tr>
    <tr>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"> About Us</td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentid=123" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">News</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=80" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">Ideas & Voting</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentid=102" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">Our Partners</a></td>
    </tr>
    <tr>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=about" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">How My3P Started</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentid=100" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">Anouncements</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentid=39" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">My Goals</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentid=106" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">Links</a></td>
    </tr>
    <tr>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentid=109" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">What our users say</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentid=121" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">Code of Conduct</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=84" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">myPOINTS</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"> Coverage Area Map </td>
    </tr>
    <tr>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentid=117" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">What the media says</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentid=116" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">Site Statistics</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow"><a href="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=54" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small;text-decoration: none">myContacts</a></td>
        <td width="6%">&nbsp;</td>
        <td width="15%" class="TRow">&nbsp;  </td>
    </tr>
     <tr>
        <th width="6%">&nbsp;</th>
        <th width="6%" class="TRow">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%" class="TRow">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%" class="TRow">&nbsp;</th>
        <th width="6%">&nbsp;</th>
        <th width="6%" class="TRow">&nbsp;</th>
        <th width="6%">&nbsp;</th>
    </tr>
</table>
<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="##999999">
    <tr>
        <td><div style="border:dotted 1px ##b4b4b4;"></div></td>
    </tr>
    <tr>
        <td align="center" valign="middle" style="padding-top:6px;padding-bottom:6px;">
            <img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0" align="absmiddle">
            
                <cfloop query="bottomnav">
                    <a href="#request.webroot#/index.cfm?fuseaction=#TRIM(bottomnav.fuseaction)#" style="color:##FFFFFF;font-family:Verdana, Geneva, sans-serif;font-size:small">#TRIM(bottomnav.MenuTitle)#</a>
                        <cfif bottomnav.currentrow NEQ bottomnav.recordcount> &nbsp;|&nbsp;</cfif>
                 </cfloop>
        </td>
    </tr>
</table>--->

<br>
</cfoutput>
<!---<script type="text/javascript"> (function() { var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true; uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/4NqM1TwVo7QJp8Y5k4mOQ.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s); })(); </script>--->

