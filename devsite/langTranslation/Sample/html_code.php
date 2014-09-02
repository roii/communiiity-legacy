<!DOCTYPE html>
<html>
    <head>
        <title>iTranslate4.eu Sample Application</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">                
        <link rel="stylesheet" type="text/css" media="all" href="resources/boxstyle.css" />
        <script type="text/javascript" src="resources/jquery-1.7.1.min.js"></script>
        <script type="text/javascript" src="resources/jquery-ui-1.8.13.custom.min.js"></script>        
        <script type="text/javascript">
            var trgLangCodes = new Array(<?php $trg = null; foreach($languages->trg as $lng): $trg .= "\"{$lng}\", "; endforeach; echo trim($trg, ", "); ?>);
            var srcLangCodes = new Array(<?php $src = null; foreach($languages->src as $lng): $src .= "\"{$lng}\", "; endforeach; echo trim($src, ", "); ?>);
        </script>
        <script type="text/javascript" src="resources/translatebox.js" ></script>
		<script language="javascript">
		    function submitform()
			{
			     document.getElementById('translateForm').submit();
			}
		</script>
    </head>
    <body onLoad="submitform();"> 
	  <?php
	     if( isset($_REQUEST['srcLangId']) and $_REQUEST['srcLangId'] != '' )
		 {
		      $srcLangId = $_REQUEST['srcLangId'];
		 }
	     else
		 {
		      $srcLangId = "en";
		 }
		 
		 if( isset($_REQUEST['trgLangId']) and $_REQUEST['trgLangId'] != '' )
		 {
		      $trgLangId = $_REQUEST['trgLangId'];
		 }
	     else
		 {
		      $trgLangId = "fr";
		 }
		 
		 if( isset($_REQUEST['srcText']) and $_REQUEST['srcText'] != '' )
		 {
		      $srcText = $_REQUEST['srcText'];
		 }
	     else
		 {
		      $srcText = "Hello";
		 }
	  ?>       
        <form action="#" method="post" id="translateForm" class="size234x60"> 
                <input type="hidden" name="srcLangId" id="srcLangId" value="<?php echo $srcLangId; ?>" />
				<input type="hidden" name="trgLangId" id="trgLangId" value="<?php echo $trgLangId; ?>" />
				<input type="hidden" name="srcText" id="textToTranslate" value="<?php echo $srcText; ?>" />                 
                <?php
                if (isset($translationText) && !empty($translationText)):
                    echo '<textarea class="transTrans" style="">'.$translationText.'</textarea></p>';
                endif;
                ?>  
        </form>        
    </body>
</html>