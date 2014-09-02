<cfparam name="data" default="#URL.cid#">

<cfset strDecodedString = URLDecode(data)>

<cfset dataTest = ListToArray(#strDecodedString#)>

<cfoutput>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>Linked In Profile ID:</td>
    <td>#dataTest[1]#</td>
  </tr>
  <tr>
    <td>First Name</td>
    <td>#dataTest[2]#</td>
  </tr>
  <tr>
    <td>Last Name</td>
    <td>#dataTest[3]#</td>
  </tr>
  <tr>
    <td>Headline</td>
    <td>#dataTest[4]#</td>
  </tr>
  <tr>
    <td>Public Profile URL</td>
    <td>
	    <a href="#dataTest[5]#">#dataTest[5]#</a>
	</td>
  </tr>
</table>

</cfoutput>
 <br /><br />
<a href="index.cfm">Back to Home Page</a>
 