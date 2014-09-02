<cfoutput> 
<!-- Super Container for entire site -->
<div class="super-container full-width" id="section-tophat">

	<!-- 960 Container -->
	<div class="container">			
		
		<div class="sixteen columns">
			<!--- Add Links to the specific RSS feed or Mailing List sign up page) --->
			<span class="subscribe">Subscribe: <a href="">RSS</a> | <a href="">Email</a></span>
			<cfif len($.siteConfig('tagline'))><span class="tagline">#$.siteConfig('tagline')#</span></cfif>
		</div>
		
	</div>
	
</div>

<!-- Super Container for entire site -->
<div class="super-container full-width" id="section-header">

	<!-- 960 Container -->
	<div class="container">			
		
		<!-- Header -->
		<header>
		<div class="sixteen columns">
			
			<!-- Branding -->
			<div class="six columns alpha">
				<a href="#$.createHREF(filename='')#">
					<h1 id="logo" style="margin-top: 40px; margin-bottom: 30px;">
					<cfswitch expression="#session.themeStyle#">
						<cfcase value="">
							<img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/pacifico-logo/logo.png" alt="logo" />
						</cfcase>
						<cfcase value="clean">
							<img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/pacifico-logo/logo.png" alt="logo" />
						</cfcase>
						<cfcase value="dark">
							<img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/pacifico-logo/logo-footer.png" alt="logo" />
						</cfcase>
					</cfswitch>
					</h1>
				</a>
				<!-- Default Superfish Nav (add/remove "light" class to toggle visual styling) --> 
						<cf_CacheOMatic key="dspPrimaryNav#request.contentBean.getcontentID()#">
							#$.dspPrimaryNav(
								viewDepth="3",
								id="navPrimary",
								displayHome="never",
								closePortals="true",
								showCurrentChildrenOnly="false",
								class="sf-menu light",
								title="#$.content('ssNavDescription')#"
								)#</cf_cacheomatic>
						<!--- Optional named arguments for Primary Nav are: displayHome="Always/Never/Conditional", openPortals/closePortals="contentid,contentid" (i.e. show specific sub-content in dropdown nav) ---> 
						<!-- Responsive Nav - Displays when screen gets small enough -->
						<cf_cacheOMatic key="customTopNav">
						<cfoutput>
						<cfset home=$.getBean("content").loadBy(filename="")>
						<cfset iterator=home.getKidsIterator(aggregation=true)>
						<form id="responsive-nav" action="insert_action" method="post">
						<select class="chzn-select">
						<option value="#home.getURL()#">#HTMLEditFormat(home.getMenutitle())#</option>
						<cfloop condition="iterator.hasNext()">
						<cfset item=iterator.next()>
						<option value="#item.getURL()#">#HTMLEditFormat(item.getMenutitle())#</option>
						</cfloop>
						</select>
						</form>
						</cfoutput>
						</cf_cacheOMatic>
						<!-- /End Responsive Nav -->
			</div>
			<!-- /End Branding -->
			
			<div class="ten columns omega">
				<!---<a href="##" class="header-advert">
					<img src="#$.siteConfig('themeAssetPath')#/demo-images/468.jpg" alt="advert" />
				</a>---> 
			</div>  
			
			<hr class="remove-bottom"/>
		</div>
		
		<!-- Menu -->
		<div class="sixteen columns" id="menu">
			
			<div class="twelve columns alpha navigation">
				
				<cfif $.currentUser().isLoggedIn()>
				    <div class="logout">
					    <a id="logout" class="btn" href="./?doaction=logout">Logout</a> 
					</div>	
				<cfelse>
					<form id="login" name="frmLogin" method="post" action="?nocache=1" onsubmit="return validate(this);" novalidate="novalidate" class="navbar-form pull-right">
					  <div class="login_box">
					           <div class="usernameF">
							         <b>Username:</b>
							        <input type="text" id="txtUsername" class="span2" name="username" required="true" placeholder="Username" message="#htmlEditFormat($.rbKey('user.usernamerequired'))#" />
							   </div>
							   <div class="passwordF">
							         <b>Password:</b>
							        <input type="password" id="txtPassword" class="span2" name="password" required="true" placeholder="Password" message="#htmlEditFormat($.rbKey('user.passwordrequired'))#" />
							   </div>
							   <div class="signInF">
							        <button type="submit" class="btn" value="#htmlEditFormat($.rbKey('user.login'))#">Sign in</button> &nbsp;
									<a id="Register" class="btn" href="index.cfm/register-form/">Register</a> 
							   </div> 
					  </div>  
						<input type="hidden" name="doaction" value="login" />
						<input type="hidden" name="linkServID" value="#HTMLEditFormat($.event('linkServID'))#" />
						<input type="hidden" name="returnURL" value="#HTMLEditFormat($.event('returnURL'))#" /> 
					</form>
				</cfif>
				
					
				
							
			</div>	

			<div class="four columns omega align-right" id="tagline">
				<!-- <p>This is the site tagline</p> -->
				<ul class="social">
					<li><a href="##"><img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/social-icons/google_plus_32.png" alt="google" title="Google+" /></a></li>
					<li><a href="##"><img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/social-icons/facebook_32.png" alt="facebook" title="Facebook"/></a></li>
					<li><a href="##"><img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/social-icons/twitter_32.png" alt="twitter" title="Twitter" /></a></li>
					<li><a href="##"><img src="#$.siteConfig('themeAssetPath')#/assets/images/theme/social-icons/rss_32.png" alt="rss" title="RSS" /></a></li>
				</ul>
			</div>			
			
			<hr class="remove-top"/>
		</div>	
		 
		<!-- /End Menu -->
		
		</header>
		<!-- /End Header -->
	
	</div>
	<!-- End 960 Container -->
	
</div>
<!-- End SuperContainer -->
</cfoutput>