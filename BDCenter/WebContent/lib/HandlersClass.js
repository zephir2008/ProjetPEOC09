var maBibliotheque;

class Test {
	constructor(){ }

	// fonction interface de test
	giveJSONpassword(){
		return '{ "Charles": { "id":1, "value": "g&co1"}, "Henri":{"id":2,"value":"g&co2"} }';
	}
}

class ImgButton{
	constructor(JSONObj, editor){
		this.reference = JSONObj["Référence"];
		this.titre = JSONObj["Titre"];
		this.auteur = JSONObj["Auteur"];
		this.editeur = editor["frn_nom"];
		this.contact = editor["frn_contact"];
		this.telephone = editor["frn_telephone"];
		this.photo = "img/BD/"+JSONObj["Photo"];
		this.neuf = JSONObj["Etat"];
		this.stock = JSONObj["Stock"];
		this.command = JSONObj["Reassort"];
		this.displ = $("<img>",{
			id: this.reference,
			src: this.photo,
			class: 'bibimg'+this.myShadow(),
			title: this.myTitle()
		});

		this.inactivate();
			// affectation des événements
		$(this.displ).hover(this.onMouseOver);
		$(this.displ).mouseout(this.onMouseOut);
		$(this.displ).css("marginBottom","80px");		// marge de mouvement pour l'animation
	}

	activate(){
		this.active = true;
console.log(this.reference+' : je suis actif');
	}
	inactivate(){
		this.active = false;
console.log(this.reference+' : je suis inactif');
	}
	myTitle(){
		var retVal = "";
		retVal = this.reference+" - "+this.titre
			+"\nAuteur : "+this.auteur
			+"\nEditeur : "+this.editeur
			+"\nEn stock : " +this.stock
			+"\nRéappro : "+this.command;
		return retVal;
	}

	myShadow(){
		var retVal = "";
		if(this.neuf!=5){
			retVal = "imgoccasion";
		} else {
			if(this.stock==0){
				retVal = (this.command == 0 ) ? "imgrupture" : "imgcommand";
			} else {
				retVal = "imgok";
			}
		}
		return " "+retVal;
	}
	onMouseOver(){
		var t = this;
		$(t).animate({
			height: '210px',
			//duration: "200",
			marginBottom: "10px"
		},400,'swing');
	}
	onMouseOut(){
		var t = this;
		$(t).animate({
			height: '140px',
			//duration: "100",
			marginBottom: "80px"
		},200,'swing').delay(300);
		/*$(t).css("height","140px");*/
	}
	onClick(){
console.log(this.reference+" : actif : "+this.activate);
		if(this.active){
console.log($(this).attr("id"));
		}
	}
}

//class CreateButton extends ImgButton{
//
//}
//class EnRupture extends ImgButtons{
//	
//}


class Bibliotheque{
		// peuple la bibliothèque à partir de la liste des BD
	constructor(Objs){
		this.Editeur = [];
		this.buttonList = [];
		this.divList = [];

		var x;
		for(x in BDAuth) {				// liste les éditeurs
			this.Editeur.push( BDAuth[x] );
		}
		var img;
		for(x in Objs){					// peuple la bibliothèque
			img = new ImgButton( Objs[x], this.Editeur[ Objs[x]["Editeur"] ] );
			this.buttonList.push( img );
		}

		var div = "";
		var t;
		var i = 0;
		var mainDiv = $('<div>', {
			id: "biblio"+i,
			class: "row text-center"
		});

		for(x in this.buttonList){		// créatoin des boutons de l'interface
			t = this.buttonList[x];
			div = $('<div>', {
				class: "col-md-2 biblio"// + ((i==0) ? " col-md-offset-2" : "")
			}).html( t.displ );
			mainDiv.append( div );
			this.divList.push( t );
			i++;
			i %= 6;	// 6 boutton par ligne
			if(i == 0){
				$("#biblio").append( mainDiv );
				var mainDiv = $('<div>', {
					//id: "biblio"+i,
					class: "row text-center"
				});
			}
		}
		if(i>0){
			$("#biblio").append( mainDiv );
		}
	}

	stepLogin(){	// a faire suite au login réussi
		this.buttonList.forEach(function(element){
			this.activate();
			$(this.displ).click(this.onClick);
		});
	}
	stepLogout(){	// a faire suite au logout
		this.buttonList.forEach(function(element){
			element.inactivate();
		});
	}
}

	// Gestion de l'ensemble des événements génériques de la page
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
				$(maBibliotheque).trigger("logout");		// logout bibliothèque
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
				$(maBibliotheque).trigger("login");			// login bibliothèque
			}
		});

//		$("#menu1").click(function(){
//			//$('.tgl').toggle(400);
//			//$("#workspace1").toggle(600);
//		});
	}

		/* initialisation de l'interface */
	static init(){
		$("#sz").html($(window).width() + 'x' + $(window).height());
		$(".tgl").toggle();
		$("#workspace1").toggle();
		$("#password").focus();

		maBibliotheque = new Bibliotheque( BDCouv );		// crée les boutons
		$(maBibliotheque).on("login",maBibliotheque.stepLogin);		// déclencheur pour login réussi
		$(maBibliotheque).on("logout",maBibliotheque.stepLogout);	// déclencheur pour logout
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