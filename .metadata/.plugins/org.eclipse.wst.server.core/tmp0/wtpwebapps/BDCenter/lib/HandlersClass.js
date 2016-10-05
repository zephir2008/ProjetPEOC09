var maBibliotheque;

const VIERGE = [0,""];
const RUPTURE = [1,"imgrupture"];
const OCCASION = [2,"imgoccasion"];
const COMMANDE = [3,"imgcommand"];
const DISPONIBLE = [4,"imgok"];

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
		this.stock = JSONObj["Stock"];
		this.command = JSONObj["Reassort"];

		this.photo = "img/BD/"+JSONObj["Photo"];

		if(editor != null){
			this.editeur = editor["frn_nom"];
			this.contact = editor["frn_contact"];
			this.telephone = editor["frn_telephone"];
		}

		this.status = ImgButton.categorie((this.reference != "0"), (JSONObj["Etat"]==5), (JSONObj["Stock"]>0), (JSONObj["Reassort"]>0));

		this.displ = $("<img>",{
			id: this.reference,
			src: this.photo,
			class: 'bibimg'+ this.myShadowClass,
			title: this.myTitle()
		});

		this.infos = $("<div>", {
			class : "visible-xs-inline visible-sm-inline infos col-md-1 col-xs-2 col-xs-offset-1" + this.myShadowClass,
			id: this.reference,
			titre: this.myTitle()
		}).html(this.myTitle(true));

			// neutre par défaut
		this.inactivate;

			// affectation des événements
		$(this.displ).hover(this.onMouseOver);
		$(this.displ).mouseout(this.onMouseOut);
		$(this.displ).css("marginBottom","80px");		// marge de mouvement pour l'animation
		$(this.displ).click([this], ImgButton.onClick);		// click sur une image
		$(this.infos).click([this], ImgButton.onClick);		// clic sur une informations
	}

	get activate(){
		this.active = true;
	}
	get inactivate(){
		this.active = false;
	}
	myTitle(html){
		var retVal = "";
		var crlf = (html)?"<br>":"\n";
		retVal = this.reference+" - "+this.titre+crlf
			//+(html)?"<hr>" : ""+crlf
			+"Auteur   : "+this.auteur+crlf
			+"Editeur  : "+this.editeur+crlf
			+"En stock : "+this.stock+crlf
			+"Réappro  : "+this.command;
		return retVal;
	}
	get myShadowClass(){
		return ((this.status[1]>"")? " "+this.status[1] : "");
	}
	onMouseOver(){
		var t = this;
		$(t).animate({
			height: '210px',
			duration: "200",
			marginBottom: "10px"
		}, 200, 'swing');
	}
	onMouseOut(){
		var t = this;
		$(t).animate({
			height: '140px',
			marginBottom: "80px"
		}, 200, 'swing');
	}
	static onClick(evt){
		var self = evt.data[0]; 
		if(self.active){
console.log("je suis : "+self.titre);
// qque chose a faire ?!
		}
	}
	static categorie(livre, neuf, enStock, enCommande){
		var retVal = VIERGE;
		if(livre){
			retVal = COMMANDE;
			if(!enCommande){
				retVal = RUPTURE;
				if(enStock){
					retVal = (neuf) ? DISPONIBLE : OCCASION;
				}
			}
		}
		return retVal;
	}
}

class Bibliotheque{
		// peuple la bibliothèque à partir de la liste des BD
	constructor(Objs){
		this.Editeur = [];
		this.buttonList = [];
		this.divList = [];

		for(var x in BDAuth){				// récupère les éditeurs
			this.Editeur.push(BDAuth[x]);
		}

		var img;
		for(var x in Objs){					// peuple la bibliothèque
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

		for(var x in this.buttonList){		// créatoin des boutons de l'interface
			t = this.buttonList[x];
			div = $('<div>', {
				class: "col-md-2 biblio"
			}).html( t.displ ).append(t.infos);
			
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
		this.buttonList.forEach(function(x){
			x.activate;
		});
	}
	stepLogout(){	// a faire suite au logout
		this.buttonList.forEach(function(x){
			x.inactivate;
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
					borderRadius: '30px'
				});

				$(".tglgrp").toggle(800);
				$("#login").addClass("btn-danger");
				$("#login").removeClass("btn-primary");
				$("#login").attr("title","Je suis là pour vous aider à sortir !")

				$("#login").html("Bonjour "+user+" !");
				$(maBibliotheque).trigger("login");			// login bibliothèque
			}
		});
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