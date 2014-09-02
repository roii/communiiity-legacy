<!--- 

	DJP - 05Oct11 - removed fields not required for new streamlined signup process.
	DJP - 25Oct11 - removed all fields except initial email field.
	
 --->

<cfoutput>

<script type="text/javascript">
	function validate(kidsReg) {
	
	var email = kidsReg.EmailAddress.value;
	var at = email.indexOf("@");		
	var space = email.indexOf(" ");
	var comma = email.indexOf(",");
	var dot = email.indexOf(".");
	var two_dots = email.indexOf("..");
	var length = email.length -1;
	
	if  ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
		alert("Please enter a valid Email Address.");
		kidsReg.EmailAddress.focus();
		return;
		}
	else {
		kidsReg.submit(); //submit form
		}
	}
</script>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td colspan="2" height="15"><img src="#request.imageroot#/images/transparent_spc.gif" width="1" height="15" border="0"></td>
	</tr>
	<tr>
		<td valign="top"><img src="#request.imageroot#/reg_step1.gif" width="41" height="41" alt="Step 1" border="0"></td>
		<td style="padding-left:5px;" valign="top"><span style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Enter your email address in the form. Then click SIGN-UP NOW!</strong></span><br>
If you don't already have an email - you can get one FREE from <a href="http://www.gmail.com/" target="_Blank">Gmail</a>, <a href="http://www.yahoo.com/" target="_Blank">Yahoo!</a>, or <a href="http://www.hotmail.com" target="_Blank">Hotmail</a><br>
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
															<td style="color:###TRIM(AllSettings.DkTextColor)#;">Email Address <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
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
</table>  or <br>
												    <span style="color:##000; font-family: Verdana,Geneva,sans-serif; font-size: small;">
									                    sign in with <a href="javascript: void(0);" onclick="javascript: window.open('/getRequestToken.cfm','linkedInogin','width=800,height=600,scrollbars=1,resizable=1');"> 
														<img src="/images/linkedin-icon-footer.png" style="height: 20px; margin: 0; padding: 0;" border="0" /></a>
									                </span> 
</cfoutput>