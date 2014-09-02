<cfparam name="attributes.email" default="">
<cfparam name="attributes.actcode" default="">
<cfparam name="attributes.fname" default="">
<cfmail to="@gmail.com" from="info@my3p.com" subject="test email" server="#application.emailserver#">

Welcome to YeRite.com, to complete your registration, please click on the link below:

http://www.yerite.com/members/?action=login&eac=test

Regards

</cfmail>

