		function ActivSpellClass() {
			this.init();	
		}

		ActivSpellClass.prototype = new Object();
		ActivSpellClass.prototype.init = function() {
			this.argsIndex = -1;
			this.fieldRefs = new Array();
			this.ignore = new Array();
			this.change = new Array();
			this.changeto = new Array();
			this.replacements = new Array();
		}
		
		ActivSpell = new ActivSpellClass();
		
		function nextField() {

		}
	
		function spell(formName) {
			
			document.formName = formName;

		    for (i=1; i<aeObjects.length; i++) {
		      	ActivSpell.fieldRefs[i] = "aeObjects[" + i + "].DOM.body.innerHTML";
			  	//ActivSpell.fieldRefs[i].onpropertychange = nextField;
			 }

			
			// Override nextField since registering onpropertychange fires itself.

			nextField = function() {
				ActivSpell.argsIndex++;
				
				if(ActivSpell.argsIndex < ActivSpell.fieldRefs.length) {
				ActivSpellWin = window.open(inc + "window.cfm?jsvar=" + ActivSpell.fieldRefs[ActivSpell.argsIndex], "ActivSpellWin", "height=230,width=450,status=no,toolbar=no,menubar=no,location=no");
				} else {
					spellCheckComplete();
				}
			}
			
			//index ActivSpell.argsIndex
			ActivSpell.argsIndex++;
			
			//send the first field to spellcheck
			ActivSpellWin = window.open(inc + "window.cfm?jsvar=" + ActivSpell.fieldRefs[0], "ActivSpellWin", "height=230,width=450,status=no,toolbar=no,menubar=no,location=no");	

			return false;
		}
		
		function spellCheckComplete() {
			alert("Spell Check Complete!");
			
			ActivSpell.argsIndex = -1;
			ActivSpell.fieldRefs = null;
			nextField = function() {}
			ActivSpellWin.close();
			ae_onSubmit();
			formName = document.formName;
			eval(formName).submit();
		}