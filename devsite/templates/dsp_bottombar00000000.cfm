<cfoutput>
<cfquery name="bottomnav" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SectionID, Fuseaction, MenuFrenchTitle
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
<cfquery name="getContent" datasource="#dsn#" username="#request.username#" password="#request.password#">
   SELECT * FROM site_section_contents_data WHERE section_id = 1
</cfquery>

</cfoutput>


<div class="col-sm-4">
  <div class="panel panel-default">
	<div class="panel-heading">
	  <h3 class="panel-title">Learn about crowdsourciiing</h3>
	</div>
	<div class="panel-body">
	  <a href="https://docs.google.com/document/d/1TjK8iawhPB-mMbHSo7w0iUJFV2tnHiDT7jTbFl0zlhY" style="color: white;" target="_blank">our 1 page plan</a>
	</div>
  </div>
  <div class="panel panel-primary">
	<div class="panel-heading">
	  <h3 class="panel-title">join our mailing list</h3>
	</div>
	<div class="panel-body">
	    <form action="http://communiiity.us5.list-manage1.com/subscribe/post?u=2a9009f1263263ad91b730e3c&amp;id=747df58a9b" class="validate" id="mc-embedded-subscribe-form" method="post" name="mc-embedded-subscribe-form" novalidate="" target="_blank">
			<p style="text-align: left;"><input autocomplete="off" class="email" id="mce-EMAIL" name="EMAIL" placeholder="your email" required="" style="float: left; margin-right: 6px; margin-top: 1px;" tabindex="999" type="email" value="" /> <input alt="Subscribe" id="mc-embedded-subscribe" name="subscribe" src="/img/arrow_green_tr.png" type="image" value="Subscribe" />&nbsp;</p>
			</form>
	</div>
  </div>
  <div class="panel panel-primary">
	<div class="panel-heading">
	  <h3 class="panel-title">Connect</h3>
	</div>
	<div class="panel-body">
	  <a href="http://www.linkedin.com/groups?home=&amp;gid=3185331" style="color: #ffffff" target="_blank">LinkedIn</a><br />
	  <a href="https://www.facebook.com/communautiii" style="color: #ffffff" target="_blank">Facebook</a><br />
	  <a href="https://twitter.com/communiiity" style="color: #ffffff" target="_blank">Twitter</a>
	</div>
  </div>
</div><!-- /.col-sm-4 --> 







	    <!--- #getContent.footer# --->
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
</table>

<br>

<script type="text/javascript"> (function() { var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true; uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/4NqM1TwVo7QJp8Y5k4mOQ.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s); })(); </script>--->

