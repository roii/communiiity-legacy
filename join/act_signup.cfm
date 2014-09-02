<!--- CHECK AVAILABILITY OF EMAIL ADDRESS --->
<cfset filename = langFilesStr[1]["#defaultlang#"]> 

<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Contacts
	WHERE EmailAddress = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(form.EmailAddress))#">
	AND ContactStatus <> 'Deleted'
	AND ContactTypeID IN (1,2,4,6,7)
</cfquery> 

<cfif checkuseremail.recordcount>
    <cfhttp method="get" url="#request.webroot#/langCSVs/#filename#" name="csvData"> 
	<cfset langArray = ArrayNew(1)>
	<cfset ctr = 1> 
	<cfset totalRows = csvdata.recordcount>  
		<cfoutput>  
			<cfloop query="csvdata">
				 <cfif trim(csvdata.VARIABLE) eq "emailfoundtext1"><cfset emailfoundtext1 = csvdata.Value></cfif>
				 <cfif trim(csvdata.VARIABLE) eq "emailfoundtext2"><cfset emailfoundtext2 = csvdata.Value></cfif>
				 <cfif trim(csvdata.VARIABLE) eq "emailfoundtext3"><cfset emailfoundtext3 = csvdata.Value></cfif>
				 <cfif trim(csvdata.VARIABLE) eq "emailfoundtext4"><cfset emailfoundtext4 = csvdata.Value></cfif>
			</cfloop>   
			<cfset outputPrint = "#emailfoundtext1#\n#emailfoundtext2#\n#emailfoundtext3# #trim(AllSettings.SiteName)# #emailfoundtext4#">  
			 </cfoutput>
			<script type="text/javascript">
			    function get_html_translation_table (table, quote_style) { 
  var entities = {},
    hash_map = {},
    decimal;
  var constMappingTable = {},
    constMappingQuoteStyle = {};
  var useTable = {},
    useQuoteStyle = {};

  // Translate arguments
  constMappingTable[0] = 'HTML_SPECIALCHARS';
  constMappingTable[1] = 'HTML_ENTITIES';
  constMappingQuoteStyle[0] = 'ENT_NOQUOTES';
  constMappingQuoteStyle[2] = 'ENT_COMPAT';
  constMappingQuoteStyle[3] = 'ENT_QUOTES';

  useTable = !isNaN(table) ? constMappingTable[table] : table ? table.toUpperCase() : 'HTML_SPECIALCHARS';
  useQuoteStyle = !isNaN(quote_style) ? constMappingQuoteStyle[quote_style] : quote_style ? quote_style.toUpperCase() : 'ENT_COMPAT';

  if (useTable !== 'HTML_SPECIALCHARS' && useTable !== 'HTML_ENTITIES') {
    throw new Error("Table: " + useTable + ' not supported');
    // return false;
  }

  entities['38'] = '&amp;';
  if (useTable === 'HTML_ENTITIES') {
    entities['160'] = '&nbsp;';
    entities['161'] = '&iexcl;';
    entities['162'] = '&cent;';
    entities['163'] = '&pound;';
    entities['164'] = '&curren;';
    entities['165'] = '&yen;';
    entities['166'] = '&brvbar;';
    entities['167'] = '&sect;';
    entities['168'] = '&uml;';
    entities['169'] = '&copy;';
    entities['170'] = '&ordf;';
    entities['171'] = '&laquo;';
    entities['172'] = '&not;';
    entities['173'] = '&shy;';
    entities['174'] = '&reg;';
    entities['175'] = '&macr;';
    entities['176'] = '&deg;';
    entities['177'] = '&plusmn;';
    entities['178'] = '&sup2;';
    entities['179'] = '&sup3;';
    entities['180'] = '&acute;';
    entities['181'] = '&micro;';
    entities['182'] = '&para;';
    entities['183'] = '&middot;';
    entities['184'] = '&cedil;';
    entities['185'] = '&sup1;';
    entities['186'] = '&ordm;';
    entities['187'] = '&raquo;';
    entities['188'] = '&frac14;';
    entities['189'] = '&frac12;';
    entities['190'] = '&frac34;';
    entities['191'] = '&iquest;';
    entities['192'] = '&Agrave;';
    entities['193'] = '&Aacute;';
    entities['194'] = '&Acirc;';
    entities['195'] = '&Atilde;';
    entities['196'] = '&Auml;';
    entities['197'] = '&Aring;';
    entities['198'] = '&AElig;';
    entities['199'] = '&Ccedil;';
    entities['200'] = '&Egrave;';
    entities['201'] = '&Eacute;';
    entities['202'] = '&Ecirc;';
    entities['203'] = '&Euml;';
    entities['204'] = '&Igrave;';
    entities['205'] = '&Iacute;';
    entities['206'] = '&Icirc;';
    entities['207'] = '&Iuml;';
    entities['208'] = '&ETH;';
    entities['209'] = '&Ntilde;';
    entities['210'] = '&Ograve;';
    entities['211'] = '&Oacute;';
    entities['212'] = '&Ocirc;';
    entities['213'] = '&Otilde;';
    entities['214'] = '&Ouml;';
    entities['215'] = '&times;';
    entities['216'] = '&Oslash;';
    entities['217'] = '&Ugrave;';
    entities['218'] = '&Uacute;';
    entities['219'] = '&Ucirc;';
    entities['220'] = '&Uuml;';
    entities['221'] = '&Yacute;';
    entities['222'] = '&THORN;';
    entities['223'] = '&szlig;';
    entities['224'] = '&agrave;';
    entities['225'] = '&aacute;';
    entities['226'] = '&acirc;';
    entities['227'] = '&atilde;';
    entities['228'] = '&auml;';
    entities['229'] = '&aring;';
    entities['230'] = '&aelig;';
    entities['231'] = '&ccedil;';
    entities['232'] = '&egrave;';
    entities['233'] = '&eacute;';
    entities['234'] = '&ecirc;';
    entities['235'] = '&euml;';
    entities['236'] = '&igrave;';
    entities['237'] = '&iacute;';
    entities['238'] = '&icirc;';
    entities['239'] = '&iuml;';
    entities['240'] = '&eth;';
    entities['241'] = '&ntilde;';
    entities['242'] = '&ograve;';
    entities['243'] = '&oacute;';
    entities['244'] = '&ocirc;';
    entities['245'] = '&otilde;';
    entities['246'] = '&ouml;';
    entities['247'] = '&divide;';
    entities['248'] = '&oslash;';
    entities['249'] = '&ugrave;';
    entities['250'] = '&uacute;';
    entities['251'] = '&ucirc;';
    entities['252'] = '&uuml;';
    entities['253'] = '&yacute;';
    entities['254'] = '&thorn;';
    entities['255'] = '&yuml;';
  }

  if (useQuoteStyle !== 'ENT_NOQUOTES') {
    entities['34'] = '&quot;';
  }
  if (useQuoteStyle === 'ENT_QUOTES') {
    entities['39'] = '&#39;';
  }
  entities['60'] = '&lt;';
  entities['62'] = '&gt;';


  // ascii decimals to real symbols
  for (decimal in entities) {
    if (entities.hasOwnProperty(decimal)) {
      hash_map[String.fromCharCode(decimal)] = entities[decimal];
    }
  }

  return hash_map;
} 
			    function html_entity_decode (string, quote_style) { 
					  var hash_map = {},
						symbol = '',
						tmp_str = '',
						entity = '';
					  tmp_str = string.toString(); 
					  if (false === (hash_map = this.get_html_translation_table('HTML_ENTITIES', quote_style))) {
						return false;
					  } 
					  delete(hash_map['&']);
					  hash_map['&'] = '&amp;';
					
					  for (symbol in hash_map) {
						entity = hash_map[symbol];
						tmp_str = tmp_str.split(entity).join(symbol);
					  }
					  tmp_str = tmp_str.split('&#039;').join("'");
					
					  return tmp_str;
				} 
			    var outputPrint = "<cfoutput>#outputPrint#</cfoutput>";
			    var safe = html_entity_decode(outputPrint);
				alert(safe);
				history.back();
			</script>  
	<cfabort> 
</cfif>

<!--- <<<<<<< .mine --->
<!--- Removed Mobile Phone requirement from Registration page. DJP 13Sep11 --->
<!--- <cfif TRIM(form.MobilePhone) NEQ ''>
=======
<cfif trim(form.mobilephone) NEQ "">
>>>>>>> .r110
	
	<!--- IF FIRST NUMBER A ZERO STRIP IT OFF --->
	<cfif mid(trim(form.mobilephone), 1, 1) EQ 0>
		<cfset this_mobile = mid(trim(form.mobilephone), 2, len(form.mobilephone))>
	<cfelse>
		<cfset this_mobile = trim(form.mobilephone)>
	</cfif>	
	<!--- CHECK AVAILABILITY OF MOBILE --->
	<cfquery name="CheckUserMobile" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID
		FROM Contacts
		WHERE MobilePhone LIKE '%#trim(this_mobile)#%'
		AND ContactStatus <> 'Deleted'
		AND ContactTypeID IN (1,2,4,6,7)
	</cfquery>	
	<cfif checkusermobile.recordcount>
	
		<cfoutput>
		<script type="text/javascript">
			alert("We already have a member with the mobile phone number you specified.\nPlease use the \"Forgot your Password\" function to retreive your\n login details, or contact #trim(AllSettings.SiteName)# for further help.");
			history.back();
		</script>
		</cfoutput>
		<cfabort>
		
	</cfif>
</cfif> --->

<!--- CREATE VERIFICATION CODE --->
<cfset verificationcode = "">	
<cfset numoptions = "0123456789">	
<cfloop index="loopcount" from="1" to="9">
	<cfset randomnumber = randrange(1,10)>
	<cfset verificationcode = (verificationcode & mid(numoptions,randomnumber,1))>
</cfloop>

<!--- For testing only ---> <!--- <cfset verificationcode = "012345678"> --->

<cftransaction action="BEGIN">

	<!--- GENERATE NEW CONTACT ID --->
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT ContactID
		FROM contacts
		ORDER BY ContactID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastid.contactid + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	<cfparam name="form.AcceptTerms" default="0" />
	
	<!--- INSERT CONTACT INFO --->
	<cfquery name="AddContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO Contacts(
		ContactID,
		ContactTypeID,
		ContactStatus,
		DateJoined,
		EmailAddress,
		MobilePhone,
		CountryID,
		OrganisationID,
		ParentConfirmed,
		RegionID,
		DistrictID,
		SuburbID,
		EmailConfirmed,
		ProfilePermission1,
		ProfilePermission2,
		ProfilePermission3,
		ProfilePermission4,
		ProfilePermission5,
		receiveEmail,
		SchoolID,
		Charity,
		PromoID,
		VerificationCode,
		AcceptTerms
		)
		VALUES(
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#newid#">,
		1,
		'pending', 
		#CreateODBCDateTime(localDateTime)#,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(form.EmailAddress))#">,
		'',
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#verificationcode#">,
		<cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.AcceptTerms#">
		)
	</cfquery>


</cftransaction>


<!--- SEND REGISTRATION ALERT TO MEMBER --->
<cfset contactid = newid>
<cfinclude template="../alerts/act_alert_01_registration.cfm">

<!--- <<<<<<< .mine --->
<!--- Deleted for simplicity
<cfif form.mobilephone NEQ ''>
=======
<cfif trim(form.mobilephone) NEQ "">
>>>>>>> .r110
	
	<!--- LOG MESSAGE --->
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT TxtLogID
		FROM TxtLog
		ORDER BY TxtLogID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastid.txtlogid + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>	
	
	<!--- ADD TAG LINE TO MESSAGE --->
	<cfset tagged_msg = "Go to my3p.com and enter this code to complete your registration.#chr(10)#----#chr(10)#Code: #verificationcode##chr(10)#----#chr(10)#">
		
	<!--- LOG TXT --->
	<cfquery name="LogTxtMessage" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO TxtLog
		(
		TxtLogID, ContactID, TxtDateTime, TxtTo, TxtFrom, TxtMsg
		)
		VALUES
		(
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#newid#">, 
		9999999, 
		#CreateODBCDateTime(localdatetime)#, 
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(form.MobilePhone))#">, 
		'6421319911', 
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(tagged_msg))#">
		)
	</cfquery>
	
	<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false">
		<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
		<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
		<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
		<cfhttpparam type="FORMFIELD" name="text" value="#trim(htmleditformat(tagged_msg))#">
		<cfhttpparam type="FORMFIELD" name="to" value="#trim(htmleditformat(form.MobilePhone))#">
		<cfhttpparam type="FORMFIELD" name="from" value="6421319911">
	</cfhttp>
	
</cfif> --->

<cflocation url="#request.webroot#/index.cfm?fuseaction=join&fusesubaction=step1complete&contactID=#ContactID#">