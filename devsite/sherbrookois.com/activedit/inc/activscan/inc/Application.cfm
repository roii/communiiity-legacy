<CFAPPLICATION name="cf_activescan_inc">

<CFLOCK SCOPE="Application" TIMEOUT="30" TYPE="Exclusive">
    <CFIF NOT IsDefined("application.errMessage")>
        <CFSET application.errMessage = "">
    </CFIF>
</CFLOCK>