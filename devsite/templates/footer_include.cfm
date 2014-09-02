</div>
    </div> 
<script src="<cfoutput>#request.webroot#</cfoutput>/js/bootstrap.min.js"></script>
<!---<div class="main-footer">
	  <div class="container clearfix">
		  <cfinclude template="dsp_bottombar.cfm">
	  </div> 
</div>--->

<hr />
  
<div class="row">
<div class="col-sm-4">
  <div class="panel panel-default">
	<div class="panel-heading">
	  <h3 class="panel-title">Learn about us</h3>
	</div>
	<div class="panel-body">
	   <a href="https://docs.google.com/document/d/1TjK8iawhPB-mMbHSo7w0iUJFV2tnHiDT7jTbFl0zlhY" target="_blank">our 1 page plan</a>
	</div>
  </div>
  <div class="panel panel-primary">
	<div class="panel-heading">
	  <h3 class="panel-title">join our mailing list</h3>
	</div>
	<div class="panel-body">
	  <form action="http://communiiity.us5.list-manage1.com/subscribe/post?u=2a9009f1263263ad91b730e3c&amp;id=747df58a9b" class="validate" id="mc-embedded-subscribe-form" method="post" name="mc-embedded-subscribe-form" novalidate="" target="_blank">
			<p style="text-align: left;"><input autocomplete="off" class="form-control" id="mce-EMAIL" name="EMAIL" placeholder="your email" required="" tabindex="999" type="email" value="" /> <br />
			    <button type="submit" class="btn btn-lg btn-primary btn-block">Subscribe</button>
			 </p>
			</form>
	</div>
  </div>
</div><!-- /.col-sm-4 -->
<div class="col-sm-4">
  <div class="panel panel-success">
	<div class="panel-heading">
	  <h3 class="panel-title">Connect</h3>
	</div>
	<div class="panel-body">
	  <a href="http://www.linkedin.com/groups?home=&amp;gid=3185331" target="_blank">LinkedIn</a><br />
	  <a href="https://www.facebook.com/communautiii" target="_blank">Facebook</a><br />
	  <a href="https://twitter.com/communiiity" target="_blank">Twitter</a>
	</div>
  </div> 
</div><!-- /.col-sm-4 --> 
</div>
 
        <script src="<cfoutput>#request.webroot#</cfoutput>/js/jquery.grozav.plugins.min.js" type="text/javascript"></script>
        <script src="<cfoutput>#request.webroot#</cfoutput>/js/jquery.grozav.bootslider.min.js" type="text/javascript"></script>
        <script>
            $(document).ready(function() {
                var slider = new bootslider('#bootslider', {
                    animationIn: "fadeInUp",
                    animationOut: "flipOutX",
                    timeout: 5000,
                    autoplay: true,
                    preload: true,
                    pauseOnHover: false,
                    thumbnails: false,
                    pagination: false,
                    mousewheel: false,
                    keyboard: true,
                    touchscreen: true,
                    layout: 'default',
                    canvas: {
                        width: 1440,
                        height: 720
                    }
                });
                slider.init();

                var slider2 = new bootslider('#bootsliderContent', {
                    animationIn: "fadeInLeft",
                    animationOut: "fadeOutRight",
                    timeout: 5000,
                    autoplay: false,
                    preload: false,
                    pauseOnHover: false,
                    thumbnails: false,
                    pagination: false,
                    mousewheel: false,
                    keyboard: true,
                    touchscreen: true,
                    layout: 'content'

                });
                slider2.init();


                $('a[data-animation-test]').click(function() {
                    var anim = $(this).attr('data-animation-test');
                    $(this).removeClass(anim).addClass(anim + ' animated').one('webkitAnimationEnd oAnimationEnd', function() {
                        $(this).removeClass(anim);
                    });
                });
            });
        </script>

<!---<div class="footer">
  <div class="containerF">
	<p class="text-muted">
	    <cfinclude template="dsp_bottombar.cfm">
	</p>
  </div>
</div>--->