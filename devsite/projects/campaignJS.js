 	<!--
	function confirmCategoryDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmProjectDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Project?')) {
	      location.href = aURL;
	    }
	  }
	//--> 
	
	function followunfollow(followstatus, userid, userip, campaignID, webroot)
	{
		  alert(webroot);
	     // Launch AJAX request.
		 $.ajax({
			// The link we are accessing.
			url: webroot+"/projects/follow_campaign.cfm", 
			// The type of request.
			type: "get", 
			data: { followstatus: followstatus, userid: userid, userip: userip, campaignID: campaignID },
			// The type of data that is getting returned.
			dataType: "html", 
			error: function(){
				/*ShowStatus( "AJAX - error()" ); 
				// Load the content in to the page.
				jContent.html( "<p>Page Not Found!!</p>" );*/
			}, 
			beforeSend: function(){
				/*ShowStatus( "AJAX - beforeSend()" );*/
			}, 
			complete: function(){
				/*ShowStatus( "AJAX - complete()" );*/
			}, 
			success: function( strData ){
				//ShowStatus( "AJAX - success()" ); 
				// Load the content in to the page.
				if(strData.trim() == 'follow')
				{
				       alert('You have been added in this Project follow list.');
					    //$('#flluntextID').html('UnFollow'); 
				}
				else
				{
				       alert('You have been removed from this Project follow list.');
					    //$('#flluntextID').html('Follow');
				}
				window.location = webroot+'/projects/'+campaignID;
			}
		 });
	} 