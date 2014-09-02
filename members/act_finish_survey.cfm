<!--- print receipt --->
<cfparam name="attributes.printR" default="false">

<cfif attributes.printR eq 'true'>
   <cfquery name="kids2surveyQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
		  select * from kids2survey where kidsid = #session.userid# and formid = #attributes.surveyid#
  </cfquery>
  <cfset receiptNo=kids2surveyQ.receiptNo>
<cfelse>  
  <cfset itemid1 = randrange(1,9999)>
  <cfset itemid2 = randrange(1,9999)>
  <cfset receiptNo="#itemid1##itemid2#">
  <cfquery name="updatekids2survey" datasource="#dsn#" username="#request.username#" password="#request.password#">
		  update kids2survey set completed = 1, receiptNo = #receiptNo#
		  where kidsid = #session.userid# and formid = #attributes.surveyid#
  </cfquery>
</cfif>

<cfquery name="surveyDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
   SELECT * FROM forms,surveycom where forms.comid = surveycom.surveycomID and formid = #attributes.surveyid#
</cfquery>
<cfquery name="kidsDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from kids2survey,contacts where kids2survey.kidsid = contacts.contactid 
  and contactid = #session.userid# and kids2survey.formid = #attributes.surveyid#
</cfquery>
		
<cfoutput>
<img src="http://www.mykidsbiz.com/images/logo.gif">
<br>
<hr>
<br>
<h3>Summary Receipt: #surveyDetails.title#</h3>
<p>
<table width="500">
<tr><td>Receipt No: #receiptNo#</td>
<td>#kidsDetails.firstname# #kidsDetails.lastname#</td>
<td>#dateformat(localDateTime,"dd/mm/yyyy")#</td>
</tr>
</table>
</p>
<p>
<table width="400">
<tr>
<td>Number of Surveys Completed:</td>	<td>#kidsDetails.nocompleted#</td>
</tr>
<tr><td>Amount paid for each Survey:</td>	<td>#dollarformat(surveyDetails.price)#</td></tr>
<cfset total = surveyDetails.price * kidsDetails.nocompleted>
<tr>
<td>Total Paid:</td>
<td>#DollarFormat(total)#</td>
</tr>
</table>
</p>
<p>
Thank you for completing the #surveyDetails.title#. <br>
Once we have received the hard copy of your surveys we will deposit #DollarFormat(total)# into your myKidsBiz account
</p>
<br>
<hr><br>
[<a href="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=docs&documentID=35">Ok</a>] 
[<A HREF="javascript:window.print()">Print Receipt</a>]
				
</cfoutput>	