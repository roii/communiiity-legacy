
You have to just install this code on your server with following below steps:

1. Extract the zip into IIS/Apache web root where Coldfusion is installed.
2. Change the three variable values as specified below:
                variables.callback = "<Enter the Full URL of your callback file where user will be come back after redirecting from linkedin site.>";  
		variables.apiKey = "<Registered linkedin App API Key>";
		variables.secretKey = "<Registered linkedin App API Secret Key>";	
3. <cfx_http5> CFX C++ custom tag must be configured in Coldfusion Admin.
	