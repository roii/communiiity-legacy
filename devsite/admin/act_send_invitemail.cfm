<cfquery name="emaillist" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from contacts,kidclientlinks
  where contacts.contactid = kidclientlinks.clientid and contactType='shopper' and
  emailaddress <> '' and contactstatus = 'pending' and contactid not in(select clientid from kidsurvey)
</cfquery>

<cfabort>
<cfoutput query="emaillist">
  #firstname# #lastname# #loginname# #password# #kidid# #emailaddress#<br>
</cfoutput>


<cfloop query="emaillist">

<cfquery name="kidsdetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from contacts where contactid = #emaillist.kidid#
</cfquery>

<cfmail server="#application.emailserver#" to="#TRIM(emaillist.EmailAddress)#" from="#kidsdetails.emailaddress#" subject="Invitation from #kidsdetails.firstname# #kidsdetails.lastname# to make a difference!" type="HTML">
<html>
<head>
<title>Mykidsbiz.com</title>
<style>
body,td 
{
   FONT-SIZE: 11px;
   COLOR: Black;
   FONT-FAMILY: Verdana;
   LINE-HEIGHT: 150%;
}

</style>

</head>

<body>

<TABLE width="750px" border=0 cellpaddinig="10"><TBODY>
<tr><td><A href="www.mykidsbiz.com" target="_blank">
<IMG alt=MyKidzBiz.com align="left" src="http://www.mykidsbiz.com/images/logo.gif" border=0 target="_blank" width="243" height="67"></A>
</td></tr>
<TR><TD>
<font face="Verdana">
<p>Hi #TRIM(emaillist.FirstName)#</P>  
<p><font color=red>It's me again! Sorry to be sending this to you again, but as the last email was my very first try, a couple things weren't quite right. 
I have fixed them all now so please click below to become a special client of mine, thanks for your patience!</font></p>

<b>Here's how you can help me achieve my goals and help the planet too!</b>&nbsp;<br>
I have started my very own business that is good for the planet, provides you with great environmentally friendly products,
plus helps me achieve my money and educational goals. I know you might think I'm   
a bit young to be running a business. Well you are right, but I like to think big!&nbsp;  

<p>To become a special client of mine, all you have to do is:
<ol>
<li><a href="http://www.mykidsbiz.com/index.cfm?fuseaction=grownups&fusesubaction=invite_thanks&emailaddress=#TRIM(emaillist.EmailAddress)#&contactid=#emaillist.contactid#">click this link</a></li>
<li>Enter a few details</li>
<li>And you're done!</li>
</ol>

<p>If you don't want to help me out - that's ok too - you just won't get any more info from me.</p>
 
<p>As my way of saying thanks, when you make your first purchase I will include a gift valued at over $5! So verify and buy from me today and I will get this cool gift to you real fast. </p>

<p>I look forward to doing business with you and giving you great service so that one day soon - you will be a RAVING FAN of myKidsBiz!</p>


<p>Seeya!</p>

#kidsdetails.firstname# #kidsdetails.lastname#<br>
Eco-Entrepreneur in training!&nbsp;<br>

                      <p>  
<b>
PS:  Buy with confidence! All the eco-goods we kids offer are high-quality, great value for money, and come with myKidsBiz 100% Money-Back Guarantee.</p></b>
                        <HR width="100%" color=##e2e2e2 SIZE=1>
                      </TD></TR></TBODY></TABLE>
</body>

</html>


</cfmail>
</cfloop>