<!-- Bootstrap core CSS -->
<link href="<cfoutput>#request.webroot#</cfoutput>/css/bootstrap.min-updated.css" rel="stylesheet">

<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="<cfoutput>#request.webroot#</cfoutput>/js/ie-emulation-modes-warning.js"></script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="<cfoutput>#request.webroot#</cfoutput>/js/ie10-viewport-bug-workaround.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
 
<!---<div class="main-header clearfix">---> 
	    <cfinclude template="dsp_topbar.cfm"> 
<!---</div> --->

<!---<div class="sub-header"> 
		<cfinclude template="dsp_menubar.cfm"> 
</div>--->  


<cfif IsDefined("URL.fuseaction") and URL.fuseaction neq ''>

       <cfif URL.fuseaction eq 'homepage'>
	          <!-- Required Bootslider Styles -->
					<link href="<cfoutput>#request.webroot#</cfoutput>/css/animate.css" rel="stylesheet" type="text/css" />
					<link href="<cfoutput>#request.webroot#</cfoutput>/css/bootslider.css" rel="stylesheet" type="text/css" />
			
					<!-- Page Level Styles -->
					<style> 
			
						/*
						SET DESIRED HEIGHT, for fixedheight
						
						.bs-slide{
							height:550px;
						}
						@media screen and (max-width:767px){
							.bs-slide{
								height:300px;
							}
						}
						*/
			
			
			
						.heading{
							margin: 10px 0 0 0;
							color: #fff;
							font-size:56px;
							font-weight: bold;
							text-shadow: -3px 3px 8px rgba(0,0,0,0.75);
						}
						@media screen and (max-width: 1279px){
							.heading{
								font-size:48px;
							}
						}
						@media screen and (max-width: 979px){
							.heading{
								font-size:36px;
							}
						}
						@media screen and (max-width: 767px){
							.heading{
								font-size:28px;
							}
						}
						@media screen and (max-width: 479px){
							.heading{
								font-size:22px;
							}
						}
			
						.subheading{
							margin-top: 0;
							color: #fff;
							font-size:48px;
							font-weight: 300;
							text-shadow: -3px 3px 8px rgba(0,0,0,0.75);
						}
						@media screen and (max-width: 1279px){
							.subheading{
								font-size:36px;
							}
						}
						@media screen and (max-width: 979px){
							.subheading{
								font-size:30px;
							}
						}
						@media screen and (max-width: 767px){
							.subheading{
								font-size:24px;
							}
						}
						@media screen and (max-width: 479px){
							.subheading{
								font-size:20px;
							}
						}
			
			
			
						#parallax1{
							background-image: url(/devsite/img/parallax-slide-1.jpg); 
						}
						#parallax2{
							background-image: url(/devsite/img/parallax-slide-2.jpg);
						}
			
					</style>
					
					<cfquery name="getSliderImages" datasource="#dsn#" username="#request.username#" password="#request.password#">
						 SELECT * FROM homepage_slider_images;
					</cfquery>
				
				<div class="bootslider" id="bootslider">
						<!-- Bootslider Loader -->
						<div class="bs-loader">
							<img src="<cfoutput>#request.webroot#</cfoutput>/img/loader.gif" width="31" height="31" alt="Loading.." id="loader"/>
						</div>
						<!-- /Bootslider Loader --> 
						
						<div class="bs-container"> 
							   <cfset start = 1>
										<cfoutput query="getSliderImages">	
											<!-- Bootslider Slide --> 
												<cfif start eq 1> 
													 <div class="bs-slide active" data-animate-in="bounceInUp" data-animate-out="hinge">
												<cfelse>	 
													 <div class="bs-slide" data-animate-in="bounceInUp" data-animate-out="hinge">
												</cfif>	 
															<div class="bs-foreground">
																<div class="container">
																	<div class="row" data-animate-in="fadeInLeftBig" data-delay="1000" data-animate-out="fadeOutDown">
																		<div class="col-md-12">
																			<!---<h1 class="heading">BOOTSLIDER</h1>--->
																			<p class="subheading text-white">#image_text#</p>
																			<p>
																				<a class="btn btn-primary" href="#image_url#" style="color: white; text-decoration: none;">BUY NOW
																				</a>
																			</p>
																		</div>
																	</div>
																</div> 
															</div>
															<div class="bs-background"> 
																<img src="#request.webroot#/images/homePageSliderImages/#image_name#" alt="" /> 
															</div>
													</div>
											<!-- /Bootslider Slide --> 
											  <cfset start = start + 1>
										</cfoutput>  
						</div>  
			
						<!-- Bootslider Progress -->
						<div class="bs-progress progress">
							<div class="progress-bar progress-primary"></div>
						</div>
						<!-- /Bootslider Progress -->
			
						<!-- Bootslider Thumbnails -->
						<div class="bs-thumbnails text-center text-turquoise">
							<ul class=""></ul>
						</div>
						<!-- /Bootslider Thumbnails -->
			
						<!-- Bootslider Pagination -->
						<div class="bs-pagination text-center text-turquoise">
							<ul class="pagination"></ul>
						</div>
						<!-- /Bootslider Pagination -->
			
						<!-- Bootslider Controls -->
						<div class="bs-controls text-center">
							<div class="btn-group">
								<a href="javascript:void(0);" class="btn btn-primary bs-prev" style="color: white; text-decoration: none;">&lt;</a>
								<a href="javascript:void(0);" class="btn btn-primary bs-next" style="color: white; text-decoration: none;">&gt;</a>
							</div>
						</div>
						<!-- /Bootslider Controls --> 
				</div>
	   </cfif>

<cfelse>

  <!-- Required Bootslider Styles -->
        <link href="<cfoutput>#request.webroot#</cfoutput>/css/animate.css" rel="stylesheet" type="text/css" />
        <link href="<cfoutput>#request.webroot#</cfoutput>/css/bootslider.css" rel="stylesheet" type="text/css" />

        <!-- Page Level Styles -->
        <style> 

            /*
            SET DESIRED HEIGHT, for fixedheight
            
            .bs-slide{
                height:550px;
            }
            @media screen and (max-width:767px){
                .bs-slide{
                    height:300px;
                }
            }
            */



            .heading{
                margin: 10px 0 0 0;
                color: #fff;
                font-size:56px;
                font-weight: bold;
                text-shadow: -3px 3px 8px rgba(0,0,0,0.75);
            }
            @media screen and (max-width: 1279px){
                .heading{
                    font-size:48px;
                }
            }
            @media screen and (max-width: 979px){
                .heading{
                    font-size:36px;
                }
            }
            @media screen and (max-width: 767px){
                .heading{
                    font-size:28px;
                }
            }
            @media screen and (max-width: 479px){
                .heading{
                    font-size:22px;
                }
            }

            .subheading{
                margin-top: 0;
                color: #fff;
                font-size:48px;
                font-weight: 300;
                text-shadow: -3px 3px 8px rgba(0,0,0,0.75);
            }
            @media screen and (max-width: 1279px){
                .subheading{
                    font-size:36px;
                }
            }
            @media screen and (max-width: 979px){
                .subheading{
                    font-size:30px;
                }
            }
            @media screen and (max-width: 767px){
                .subheading{
                    font-size:24px;
                }
            }
            @media screen and (max-width: 479px){
                .subheading{
                    font-size:20px;
                }
            }



            #parallax1{
                background-image: url(/devsite/img/parallax-slide-1.jpg); 
            }
            #parallax2{
                background-image: url(/devsite/img/parallax-slide-2.jpg);
            }

        </style>
		
		<cfquery name="getSliderImages" datasource="#dsn#" username="#request.username#" password="#request.password#">
			 SELECT * FROM homepage_slider_images;
		</cfquery>
	
	<div class="bootslider" id="bootslider">
            <!-- Bootslider Loader -->
            <div class="bs-loader">
                <img src="<cfoutput>#request.webroot#</cfoutput>/img/loader.gif" width="31" height="31" alt="Loading.." id="loader"/>
            </div>
            <!-- /Bootslider Loader --> 
			
			<div class="bs-container"> 
			       <cfset start = 1>
                            <cfoutput query="getSliderImages">	
                                <!-- Bootslider Slide --> 
								    <cfif start eq 1> 
										 <div class="bs-slide active" data-animate-in="bounceInUp" data-animate-out="hinge">
									<cfelse>	 
									     <div class="bs-slide" data-animate-in="bounceInUp" data-animate-out="hinge">
									</cfif>	 
												<div class="bs-foreground">
												    <div class="container">
														<div class="row" data-animate-in="fadeInLeftBig" data-delay="1000" data-animate-out="fadeOutDown">
															<div class="col-md-12">
																<!---<h1 class="heading">BOOTSLIDER</h1>--->
																<p class="subheading text-white">#image_text#</p>
																<p>
																	<a class="btn btn-primary" href="#image_url#" style="color: white; text-decoration: none;">BUY NOW
																	</a>
																</p>
															</div>
														</div>
													</div> 
												</div>
												<div class="bs-background"> 
													<img src="#request.webroot#/images/homePageSliderImages/#image_name#" alt="" /> 
												</div>
               					        </div>
								<!-- /Bootslider Slide --> 
								  <cfset start = start + 1>
				            </cfoutput>  
            </div>  

            <!-- Bootslider Progress -->
            <div class="bs-progress progress">
                <div class="progress-bar progress-primary"></div>
            </div>
            <!-- /Bootslider Progress -->

            <!-- Bootslider Thumbnails -->
            <div class="bs-thumbnails text-center text-turquoise">
                <ul class=""></ul>
            </div>
            <!-- /Bootslider Thumbnails -->

            <!-- Bootslider Pagination -->
            <div class="bs-pagination text-center text-turquoise">
                <ul class="pagination"></ul>
            </div>
            <!-- /Bootslider Pagination -->

            <!-- Bootslider Controls -->
            <div class="bs-controls text-center">
                <div class="btn-group">
                    <a href="javascript:void(0);" class="btn btn-primary bs-prev" style="color: white; text-decoration: none;">&lt;</a>
                    <a href="javascript:void(0);" class="btn btn-primary bs-next" style="color: white; text-decoration: none;">&gt;</a>
                </div>
            </div>
            <!-- /Bootslider Controls --> 
    </div>
	
</cfif>
	

<div class="container theme-showcase">
	<!-- Main jumbotron for a primary marketing message or call to action -->
	 

      
	
	 <!--- <div class="jumbotron">
		<h1><a href="http://www.crowdsourciiing.com/<cfoutput>#request.webroot#</cfoutput>/" id="headingFormat">crowd sourciiing Beta</a></h1>
		<p>the future site for our LinkedIn.<br />
		   <a href="http://www.linkedin.com/groups?mostRecent=&amp;gid=3185331" id="headingFormat" style="font-size:18px;"><span style="color:##A9A9A9;">crowdsourcing &amp; crowdfunding community</span></a>
		</p> 
	  </div>--->
 	  
<!--- <div class="page-header">
	<h1><cfoutput>#app.pageTitle#</cfoutput></h1>
 </div>--->

<div class="jumbotron">	  