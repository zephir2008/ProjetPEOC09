class Test {
	constructor(){ }
	// fonction interface de test
	giveJSON(){
		return '{ "Charles": { "id":1, "value": "g&co1"}, "Henri":{"id":2,"value":"g&co2"} }';
	}
}

class Handlers {
	constructor(){
		Handlers.init();

		$(window).resize( function() { $("#sz").html( $(window).width() + 'x'+ $(window).height()); });
		$("#t3").click( function() { $("#t3").fadeTo(1600, ($("#t3").css("opacity") == 0) ? 40 : 0, "linear"); });

		// gestion du login
		$("#password").keypress(function(event){
			if(event.which == 13){$("#login").trigger("click");}
		});

		$("#login").click(function() {
			var user = Handlers.isGoodPassword($("#password").val());
			$("#password").val(null);						// efface le dernier mot de passe

			if ($("#password").css("display") == "none") {	// on est déjà connecté
				$(".tglgrp").toggle(800);
				$("#login").addClass("btn-primary");
				$("#login").removeClass("btn-danger");
				$("#login").html("Entrer");
				$("#password").focus();
			} else if( user != ""){							// on se connecte
$(".login2").animate({
/*	display: 'block',
	position: 'absolute',*/

	top: '0',
	left: '0'
});
$("#login").animate({
height: '60px',
width: '300px', 
backgroundColor: 'transparent',
borderRadius: '30px'
});

				$(".tglgrp").toggle(800);
				//$("#login").addClass("btn-danger");
				//$("#login").removeClass("btn-primary");
				//$("#login").html("Sortir");

				$("#login").html("Bonjour "+user+" !");
			}
		});

		$("#menu1").click(function(){
			//$('.tgl').toggle(400);
			//$("#workspace1").toggle(600);
		});
	}

	static init(){
		$("#sz").html($(window).width() + 'x' + $(window).height());
		$(".tgl").toggle();
		$("#workspace1").toggle(600);
		$("#password").focus();
	}

	// récupération du JSON des utilisateurs
	static isGoodPassword(check){
		var retVal = "";
		var test = new Test();

		var JSONuser = $.parseJSON(test.giveJSON());
		for(var t in JSONuser){
			if(JSONuser[t]["value"] == check ){
				retVal = t;
			}
		}
		return retVal;
	}

}