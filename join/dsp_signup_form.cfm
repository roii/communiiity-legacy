<!--- 

	DJP - 05Oct11 - removed fields not required for new streamlined signup process.
	DJP - 25Oct11 - removed all fields except initial email field.
	
 --->



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
			    var validEmailNote = "<cfoutput>#validEmailNote#</cfoutput>";
			    var validEmailNoteD = html_entity_decode(validEmailNote); 
            
	function validate(kidsReg) {
	
	var email = kidsReg.EmailAddress.value;
	var at = email.indexOf("@");		
	var space = email.indexOf(" ");
	var comma = email.indexOf(",");
	var dot = email.indexOf(".");
	var two_dots = email.indexOf("..");
	var length = email.length -1;
	
	if  ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
		alert(validEmailNoteD);
		kidsReg.EmailAddress.focus();
		return;
		}
	else {
		kidsReg.submit(); //submit form
		}
	}
</script>
<cfoutput>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td colspan="2" height="15"><img src="#request.imageroot#/images/transparent_spc.gif" width="1" height="15" border="0"></td>
	</tr>
	<tr>
		<td valign="top"><img src="#request.imageroot#/reg_step1.gif" width="41" height="41" alt="Step 1" border="0"></td>
		<td style="padding-left:5px;" valign="top"><span style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>#registerheadingtext#</strong></span><!---<br>
If you don't already have an email - you can get one FREE from <a href="http://www.gmail.com/" target="_Blank">Gmail</a>, <a href="http://www.yahoo.com/" target="_Blank">Yahoo!</a>, or <a href="http://www.hotmail.com" target="_Blank">Hotmail</a><br>--->
</td>
	</tr>
	<tr>
		<td></td>
		<td style="padding-left:5px;"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0">
			<table border="0" cellpadding="0" cellspacing="1" width="100%">
				<tr>
					<td colspan="2">		
						<table cellspacing="1" cellpadding="0" bgcolor="##b4b4b4" border="0" width="360">
							<tr>
								<td>
									<table cellspacing="0" cellpadding="10" bgcolor="white" border="0" width="100%">
										<tr>
											<td>
												<table width="100%" cellpadding="0" cellspacing="2" border="0">
													<tr>
														<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
														<td></td>
													</tr>
													<form name="kidsReg" action="#request.webroot#/join/act_signup.cfm" method="post">
														<tr>
															<td style="color:###TRIM(AllSettings.DkTextColor)#;">#emailaddress# <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
															<td><input type="text" name="EmailAddress" class="whitefield" style="width:250px;"></td>
														</tr>
														<tr>
															<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
														</tr>
														<tr>
															<td> </td>
															<td><input type="image" src="#request.imageroot#/signup_button.gif" onclick="validate(kidsReg); return false;"></td>
														</tr>
													</form>
												</table>				
											</td>
										</tr>
									</table>		
								</td>
							</tr>
						</table>	
					</td>
				</tr>
			</table>	
		</td>
	</tr>
	<tr>
		<td colspan="2" height="25"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="25" border="0"></td>
	</tr>
	<!--- <tr>
		<td valign="top"><img src="#request.imageroot#/reg_step2.gif" width="41" height="41" alt="Step 2" border="0"></td>
		<td style="padding-left:5px;" valign="top"><span style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Now check your email for your verification link.</strong></span><br>
<span style="color:##ff6d0d;">(make sure the email address you give can be checked right away)</span><br><br>
</td>
	</tr>
	<tr>
		<td colspan="2" height="25"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="25" border="0"></td>
	</tr>
	<tr>
		<td><img src="#request.imageroot#/reg_step3.gif" width="41" height="41" alt="Step 3" border="0"></td>
		<td style="padding-left:5px;"><span style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Finish the registration process and start using the site!</strong></span></td>
	</tr>
	<tr>
		<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
	</tr> --->
</table>  #ortext# <br>
												    <span style="color:##000; font-family: Verdana,Geneva,sans-serif; font-size: small;">
									                    #signinwith# <a href="javascript: void(0);" onclick="javascript: window.open('/getRequestToken.cfm','linkedInogin','width=800,height=600,scrollbars=1,resizable=1');"> 
														<img src="/images/linkedin-icon-footer.png" style="height: 20px; margin: 0; padding: 0;" border="0" /></a>
									                </span> 
</cfoutput>