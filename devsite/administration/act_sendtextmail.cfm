
<cfquery name="IndMember" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select firstname,lastname,emailaddress,loginname,password from contacts where datejoined <= '2005-11-28' 
  and contacttype = 'kid'
</cfquery>	

<cfset failed=0>
<cftry>
<cfmail server="#application.emailserver#" query="IndMember" to="#TRIM(EmailAddress)#" from="theTeam@my3p.com" subject="my3P, the NEW myKidsBiz, is live again....">
Hi #IndMember.firstname#

myKidsBiz is back, and has even more ways for you to make money, win
prizes, and get what you want!

We also have a new name, my3P. The 3P stands for People Planet &
Profits. You can find out heaps more online, use your login details
below to check it out!

You can log in at www.my3P.com 
Here's your account info to log in:
User name: #IndMember.loginname#
Password: #IndMember.password#

----------------------------------------------------

***** So what's new and why's it good for you? *****

*** Make Money ***
Up to $18 per hour doing simple businesses from our Business section. 
http://www.my3p.com/index.cfm?fuseaction=business

*** Win Prizes ***
Just for doing fun stuff on the site. Win MP3 players, movie tickets,
ski lift tickets and more.
http://www.my3p.com/index.cfm?fuseaction=prizes

*** Earn my3P points ***
That you can spend on cool rewards like prepay phone cards. Earning
points is easy. Click below to see all the ways.
http://www.my3p.com/index.cfm?fuseaction=prizes&fusesubaction=docs&docum
entid=50 

*** List and vote on cool ideas ***
In the IDEAfunL where can earn money & points for entering ideas and
voting on ideas from others.
http://www.my3p.com/index.cfm?fuseaction=ideas

*** Make your wildest dreams come true! ***
With our Goals section. You tell us what you want - the goals section
helps you get it, fast! http://www.my3p.com/index.cfm?fuseaction=goals


***** Why has the name changed? *****
We first built and tested myKidsBiz for 9-14 year olds, but we found
that more and more 15-19 year olds were using the site to make money.
Since we have always been about helping PEOPLE and the PLANET while
helping you and the rest of our online community to make PROFITS, the
name my3P was born.

Have fun with the new site and tell your friends!

theTeam@my3p.com 
http://www.my3P.com 

</cfmail>
<cfcatch type="any">
  <cfset failed=failed+1>
</cfcatch>
</cftry>
<cfset succeeded=IndMember.recordcount-failed>
<cfoutput>
#succeeded# emails have been sent
</cfoutput>


