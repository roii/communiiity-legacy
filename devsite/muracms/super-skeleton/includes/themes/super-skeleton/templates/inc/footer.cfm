<cfoutput>
<!-- Super Container -->
<div class="super-container full-width" id="section-footer">
	<!-- 960 Container -->
	<div class="container">
		<!-- footer -->
		<footer>
			<div class="sixteen columns" id="header">
				<br />
				
				<!-- 1/4 -->
				<div class="five columns alpha">
					#$.dspObject('component','[Footer] Column 1')#
				</div>
				<!-- /End 1/4 -->
				
				<!-- 2/4 -->
				<div class="five columns">
					#$.dspObject('component', '[Footer] Column 2')#										
				</div>
				<!-- /End 2/4 -->
				
				<!-- 3/4 -->
				<div class="three columns">
					#$.dspObject('component', '[Footer] Column 3')#				
				</div>
				<!-- /End 3/4 -->		
				
				<!-- 4/4 -->
				<div class="three columns omega">
					#$.dspObject('component', '[Footer] Column 4')#
				</div>
				<!-- /End 4/4 -->			
				
				<br />
			</div>
		</footer>
		<!-- /End Footer -->
	</div>
	<!-- /End 960 Container -->
</div>
<!-- /End Super Container -->

<!-- Super Container -->
<div class="super-container full-width" id="section-sub-footer">		
	<!-- 960 Container -->
	<div class="container">
		<div class="sixteen columns">	
			<span class="copyright">&copy; #year(now())# #HTMLEditFormat($.siteConfig('site'))#</span>
			<span class="colophon">Powered by <a href="http://getmura.com">Mura CMS</a>. Theme by Brandon R Jones.</span>
		</div>
	</div>
	<!-- /End 960 Container -->
</div>
<!-- /End Super Container -->		

<!-- JS
================================================== -->
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/tabs.js"></script>	
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/jquery.tipsy.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/jquery.prettyPhoto.js"></script>	
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/jquery.hoverIntent.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/superfish.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/supersubs.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/chosen/chosen.jquery.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/jquery.flexslider-min.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/filterable.pack.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/skeleton-key.js"></script>
<script src="#$.siteConfig('themeAssetPath')#/assets/javascripts/extended.js"></script>
</cfoutput>