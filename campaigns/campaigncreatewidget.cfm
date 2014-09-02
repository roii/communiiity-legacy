<cfif IsDefined("URL.campID") and URL.campID neq ''>
<style> 
.box .group {
    background: none repeat scroll 0 0 #E8E8E8;
    border: 1px solid #D5D6D5;
    margin-bottom: 20px;
    padding-left: 0;
    padding-right: 20px;
    padding-top: 20px;
    width: 640px;
}
.group .code-text {
    background-color: #E8E8E8;
    border: medium none;
    margin: 0 45px 20px 48px;
    width: 550px;
}
textarea {
    overflow: auto;
    vertical-align: top;
}
</style>
	<cfset campaign_id = Replace(#TRIM(URL.campID)#, "-", " ", "ALL")> 
	<div class="fl"> 
		  <section class="blog-widget box rounded shadow clearfix" style="margin-bottom: 20px; padding: 0px 0 20px 20px; background: none repeat scroll 0 0 #FFFFFF; 	overflow: hidden; margin-top: 14px; box-shadow: 1px 1px 2px #888888; border-radius: 6px; width: 727px;">
			<div class="heading">
			  <h2 class="title bold">For a Website/Blog</h2>
			  <p class="subtitle">Copy the code below and paste it into your website or blog.</p>
			</div> 
			<div class="group">
			  <textarea rows="3" onclick="javascript:this.select();" readonly="true" class="code-text">&lt;iframe src="<cfoutput>#request.webroot#</cfoutput>/projects/widget/<cfoutput>#campaign_id#</cfoutput>" width="233px" height="448px" frameborder="0" scrolling="no"&gt;&lt;/iframe&gt;</textarea>
			</div> 
		  </section>  
	</div>

<cfelse>
    <p style="color: red; font-weight: bold;">
	      You are accessing the wrong page.....
	</p>
</cfif>