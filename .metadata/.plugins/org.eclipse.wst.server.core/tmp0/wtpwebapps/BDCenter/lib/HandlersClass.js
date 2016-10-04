class Test {
	constructor(){ }
	// fonction interface de test
	giveJSONpassword(){
		return '{ "Charles": { "id":1, "value": "g&co1"}, "Henri":{"id":2,"value":"g&co2"} }';
	}
}

class ImgButton{
	constructor(JSONObj){
		this.reference = JSONObj["Référence"];
		this.titre = JSONObj["Titre"];
		this.auteur = JSONObj["Auteur"];
		this.editeur = JSONObj["Editeur"]["frn_nom"];
		this.contact = JSONObj["Editeur"]["frn_contact"];
		this.contact = JSONObj["Editeur"]["frn_telephone"];
		this.photo = "img/BD/"+JSONObj["Photo"];
		this.neuf = (JSONObj["Etat"] == 5 );
		this.stock = (JSONObj["Stock"] > 0);
		this.command = (JSONObj["Reassort"] > 0);
	}
}

class Bibliotheque{
	constructor(Objs){
		var x;

		this.Editeur = [];				// La liste des éditeurs
		this.buttonList = [];

		for(x in BDAuth) {
			this.Editeur.push( BDAuth[x] );
		}

		for(x in Objs){		// on peuple la bibliothèque !
			Objs[x]["Editeur"] = this.Editeur[ Objs[x]["Editeur"] ];
			this.buttonList.push( new ImgButton( Objs[x] ) );
		}
		var i = 0;
		for(x in this.buttonList){
			var t = this.buttonList[x];
			$("#biblio").append('<div class="col-md-1"><img src="'+t.photo+'" /></div>');
			i++; i%= 12;
		}
	}

	get editeurList(){
		return this.Editeur
	}
}

class Handlers {
	constructor(){
		Handlers.init();

		$(window).resize( function(){
			$("#sz").html( 
				$(window).width() + 'x'+ $(window).height()
			);
		});
/*		$("#t3").click( function() { $("#t3").fadeTo(1600, ($("#t3").css("opacity") == 0) ? 40 : 0, "linear"); });*/

		// gestion du login - recrée le fonctionnement d'un formulaire (touche "enter")
		$("#password").keypress(function(event){
			if(event.which == 13){
				$("#login").trigger("click");
			}
		});

			// vérification du login
		$("#login").click(function() {
			var user = Handlers.isGoodPassword($("#password").val());
			$("#password").val(null);						// efface le dernier mot de passe

			if ($("#password").css("display") == "none") {	// on est déjà connecté => déconnexion
				$(".tglgrp").toggle(800);
				$("#login").addClass("btn-primary");
				$("#login").removeClass("btn-danger");
				$("#login").html("Entrer");
				$("#password").focus();
				$("#login").attr("title","Je suis là pour vous faire entrer !")
				// @button-size: 120px;
				// border-radius: 10px;
				$("#login").animate({
					height: '120px',
					width: '120px', 
					borderRadius: '10px'
				});
			} else if( user != ""){							// on se connecte
				$("#login").animate({
					height: '60px',
					width: '300px', 
					//backgroundColor: 'transparent',
					borderRadius: '30px'
				});

				$(".tglgrp").toggle(800);
				$("#login").addClass("btn-danger");
				$("#login").removeClass("btn-primary");
				$("#login").attr("title","Je suis là pour vous aider à sortir !")
				//$("#login").html("Sortir");

				$("#login").html("Bonjour "+user+" !");
			}
		});

		$("#menu1").click(function(){
			//$('.tgl').toggle(400);
			//$("#workspace1").toggle(600);
		});
	}

		/* initialisation de l'interface */
	static init(){
		$("#sz").html($(window).width() + 'x' + $(window).height());
		$(".tgl").toggle();
		$("#workspace1").toggle();
		$("#password").focus();

		new Bibliotheque( BDCouv );		// crée les boutons
	}


	// récupération du JSON des utilisateurs
	static isGoodPassword(check){
		var retVal = "";
		var test = new Test();

		var JSONuser = $.parseJSON(test.giveJSONpassword());
		for(var t in JSONuser){
			if(JSONuser[t]["value"] == check ){
				retVal = t;
			}
		}
		return retVal;
	}

}