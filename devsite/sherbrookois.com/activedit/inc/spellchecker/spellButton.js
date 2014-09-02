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
	
		function spell(num) {

		      	ActivSpell.fieldRefs[0] = "aeObjects[" + num + "].DOM.body.innerHTML";


			
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
		}