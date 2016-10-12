'use strict';

//***********************************************************
var maBibliotheque = {};

//***********************************************************
const VIERGE = [0,""];
const RUPTURE = [1,"imgrupture"];
const OCCASION = [2,"imgoccasion"];
const COMMANDE = [3,"imgcommand"];
const DISPONIBLE = [4,"imgok"];

//***********************************************************
class Test {
	constructor(){ }

	// fonction interface de test
	giveJSONpassword(){
		return '{ "Charles": { "id":1, "value": "g&co1"}, "Henri":{"id":2,"value":"g&co2"} }';
	}
}
//***********************************************************






//***********************************************************
// Chacune des images de ma bibliothèque affichées
//***********************************************************
class ImgButton{
	//***********************************************************
	// initialisation des valeurs de l'objet
	constructor(JSONObj, editor){
		var bStg = maBibliotheque.BibStorage; 
		bStg.setItem(													// Créer un objet dans le localStorage
			JSONObj["Référence"],
			JSON.stringify({
				reference :	JSONObj["Référence"],
				titre :		JSONObj["Titre"],
				auteur :	JSONObj["Auteur"],
				stock :		JSONObj["Stock"],
				command :	JSONObj["Reassort"],
				photo :		"img/BD/"+JSONObj["Photo"],
				editeur : {
					nom :		editor["frn_nom"],
					contact :	editor["frn_contact"],
					telephone :	editor["frn_telephone"]
				}
			})
		);

		this.ORef = JSON.parse( bStg[ JSONObj["Référence"] ] );			// ORef = "bean" de mon objet
		this.ORef.ref = JSONObj["Référence"];
		//this.ORef.helper = this.myTitle(false);
		this.ORef.helperHTML = this.myTitle();
		this.ORef.helperTitle = this.myTitle(true);

		this.ORef.active = false;										// bouton inactif par défaut
		this.ORef.status = ImgButton.categorie(
			(this.ORef.ref != "0"),
			(JSONObj["Etat"]==5),
			(JSONObj["Stock"]>0),
			(JSONObj["Reassort"]>0)
		);

		this.ORef.displ = $("<img>",{
			id: this.ref,
			src: this.ORef.photo,
			class: 'bibimg'+ this.myShadowClass
		});

		this.ORef.infos = $("<div>", {
			class : "visible-xs-inline visible-sm-inline infos col-md-1 col-xs-2 col-xs-offset-1" + this.myShadowClass,
			id: this.ORef.ref
		}).html(this.ORef.helperHTML);

			// affectation des événements
		$(this.ORef.displ).css("marginBottom","80px");				// marge de mouvement pour l'animation
		$(this.ORef.displ).click([this], ImgButton.onClick);		// click sur une image
		$(this.ORef.displ).mouseover([this], ImgButton.onMouseOver);
		$(this.ORef.displ).mouseout([this], ImgButton.onMouseOut);
		$(this.ORef.infos).click([this], ImgButton.onClick);		// clic sur une informations
	}

	//***********************************************************
	get activate(){													// active le bouton
		this.ORef.active = true;
	}

	//***********************************************************
	get inactivate(){												// désactive le bouton 
		this.ORef.active = false;
	}

	//***********************************************************
	myTitle(isTitle){													// Création du titre (bulles d'aides)
		var retVal = "";
		var crlf = "<br>";
		if(isTitle){
			retVal = this.ORef.ref + '-' + this.ORef.titre
		} else {
			retVal = "<b>Auteur</b>   : " + this.ORef.auteur + crlf
				+ "<b>Editeur</b>  : " + this.ORef.editeur.nom + crlf
				+ "<b>En stock</b> : " + this.ORef.stock + crlf
				+ "<b>Réappro</b>  : " + this.ORef.command;
		}
		return retVal;
	}

	//***********************************************************
	get myShadowClass(){			// classe de l'ombre (= couleur)
		return ((this.ORef.status[1]>"")? " "+this.ORef.status[1] : "");
	}

	//***********************************************************
	static onMouseOver(evt){		// lorsque la sourie entre sur l'image/la div
		var self = evt.data[0].ORef;
		if(self.ref != "0"){
			$(this).animate({
				height: '210px',
				duration: "200",
				marginBottom: "10px"
			}, 200, 'swing').delay(300);
		}
	}
	//***********************************************************
	static onMouseOut(evt){			// lorsque la sourie sort de l'image/la div
		var self = evt.data[0].ORef;
		if(self.ref != "0"){
			$(this).animate({
				height: '140px',
				marginBottom: "80px"
			}, 200, 'swing');
		}
	}
	//***********************************************************
	static onClick(evt){			// lorsqu'on clic sur l'image
		var self = evt.data[0].ORef;
		if(self.active){
console.log("je suis : "+self.titre);
// qque chose a faire ?!
		} else {
			$("#modal").modal('show');
		}
	}
	//***********************************************************
	static categorie(livre, neuf, enStock, enCommande){		// détermine l'état du livre
		var retVal = VIERGE;		// pour la création
		if(livre){
			retVal = COMMANDE;		// en commande
			if(!enCommande){
				retVal = RUPTURE;	// en rupture
				if(enStock){
					retVal = (neuf) ? DISPONIBLE : OCCASION;	// dispo ou occas
				}
			}
		}
		return retVal;
	}
}
//***********************************************************







//***********************************************************
// Le regroupement de toutes les images/boutons de la bibliothèque
//***********************************************************
class Bibliotheque{
	//***********************************************************
	// peuple la bibliothèque à partir de la liste des BD
	constructor(Objs){
		maBibliotheque.BibStorage = Handlers.myStorage;
		var nbImagePerLine = 6;

		this.Editeur = [];
		this.buttonList = [];
		this.divList = [];

		for(var x in BDAuth){					// récupère les éditeurs
			this.Editeur.push(BDAuth[x]);
		}

		var img;
		var f;
		for(var x in Objs){						// peuple la bibliothèque
			img = new ImgButton(
				Objs[x],
				(x > 0) ? this.Editeur[ Objs[x]["Editeur"] ] : {frn_nom: "Création", frn_contact: "n.a.", frn_telephone: "n.a."}
			);
			this.buttonList.push( img );
		}

		var div = "";
		var t;
		var i = 0;
		var mainDiv = $('<div>', {
			id: "biblio"+i,
			class: "row text-center"
		});

		for(var x in this.buttonList){				// créatoin des boutons de l'interface
			t = this.buttonList[x];
			this.divList.push( t );

			div = $('<div>', {
				class: "col-md-2 biblio"
			});
//			div.popover({
			div.tooltip({
				animation: true,
				html: true,
//				container: 'body', // !tooltip
				placement: (x % nbImagePerLine < 2) ? 'right' : 'left',
				title: t.ORef.helperTitle + "<hr>" + t.ORef.helperHTML,
//				content: t.ORef.helperHTML,		//!tooltip
				//delay: { "show": 500, "hide": 100 }
				delay: 300
			});
			div.html( t.ORef.displ ).append( t.ORef.infos );

			mainDiv.append( div );

			i++;
			i %= nbImagePerLine;					// 6 boutton par ligne

			if(i == 0){
				$("#biblio").append( mainDiv );
				var mainDiv = $('<div>', {
					class: "row text-center"
				});
			}
		}
		if(i>0){
			$("#biblio").append( mainDiv );
		}
	}

	//***********************************************************
	stepLogin(){	// a faire suite au login réussi
		this.buttonList.forEach(function(x){
			x.activate;
		});
	}
	//***********************************************************
	stepLogout(){	// a faire suite au logout
		this.buttonList.forEach(function(x){
			x.inactivate;
		});
	}
}
//***********************************************************






//***********************************************************
// Gestion de l'ensemble des événements génériques de la page
//***********************************************************
class Handlers {

	//***********************************************************
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
			$("#modal").modal('show');
			var user = Handlers.isGoodPassword($("#password").val());
			$("#password").val(null);						// efface le dernier mot de passe

			if ($("#password").css("display") == "none") {	// on est déjà connecté => déconnexion
				$(".tglgrp").toggle(800);
				$("#login").addClass("btn-primary");
				$("#login").removeClass("btn-danger");
				$("#login").html("Entrer");
				$("#password").focus();
/*				$("#login").animate({
					height: '80px',
					width: '80px', 
					borderRadius: '10px'
				});*/
				$("#login").tooltip({
					animation: true,
					html: true,
					delay: 300,
					placement: 'bottom',
					title: "Je suis là pour vous faire entrer !"
				});
				$(maBibliotheque).trigger("logout");		// logout bibliothèque
			} else if( user != ""){							// on se connecte
/*				$("#login").animate({
					height: '60px',
					width: '300px', 
					borderRadius: '30px'
				});

				$(".tglgrp").toggle(800);
*/				$("#login").addClass("btn-danger");
				$("#login").removeClass("btn-primary");
				$("#login").tooltip({
					animation: true,
					html: true,
					delay: 300,
					placement: 'bottom',
					title: "Je suis là pour vous aider à sortir !"
				});

				$("#login").html("Bonjour "+user+" !");
				$(maBibliotheque).trigger("login");			// login bibliothèque
			}
		});
		$('[data-toggle="tooltip"]').tooltip();
//		$('[data-toggle="popover"]').popover();
	}

	//***********************************************************
	/* initialisation de l'interface */
	static init(){
		$("#sz").html($(window).width() + 'x' + $(window).height());
		$(".tgl").toggle();
		$("#workspace1").toggle();
		$("#password").focus();
		$("#login").tooltip({
			animation: true,
			html: true,
			delay: 300,
			placement: 'right',
			title: "Je suis là pour vous faire entrer !"
		});

		$('li a').click(function (e) {
			e.preventDefault();
			var selector = "";
			$(this).tab('show');
			var x = "."+RUPTURE[1]+",."+OCCASION[1]+",."+COMMANDE[1]+",."+DISPONIBLE[1];
			switch(this.innerHTML){
				case 'En rupture' :
					selector = '.'+RUPTURE[1];
					break;
				case 'Réassort' :
					selector = '.'+COMMANDE[1];
					break;
				case 'Occasion':
					selector = '.'+OCCASION[1];
					break;
				default:
					selector = x;
			}
			$(x).hide(300);
			$(selector).show(300);

//RUPTURE = [1,"imgrupture"];
// OCCASION = [2,"imgoccasion"];
// COMMANDE = [3,"imgcommand"];
// DISPONIBLE = [4,"imgok"];			$()
//console.log(this.innerHTML);
		});

		maBibliotheque = new Bibliotheque( BDCouv );		// crée les boutons
		$(maBibliotheque).on("login",maBibliotheque.stepLogin);		// déclencheur pour login réussi
		$(maBibliotheque).on("logout",maBibliotheque.stepLogout);	// déclencheur pour logout
	}

	//***********************************************************
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

	//***********************************************************
	// initialise le WebStorage
	static get myStorage(){
		var retVal;
		if (typeof(Storage) !== "undefined") {
			localStorage.clear();
			retVal = localStorage;
			// Code for localStorage/sessionStorage.
		} else {
		    // Sorry! No Web Storage support..
			retVal = sessionStorage;
		}
		return retVal;
	}

	//***********************************************************
	// Gestion des changements de taille de la fenêtre (dynamique)
	// ou des différents affichages des périphériques (PC, tablette, cellphone)
	static viewportHandler(viewport){
	    // Executes only in XS breakpoint
	    if( viewport.is('xs') ) {
	console.log('xs mode');
	        // ...
	    }

	    // Executes in SM, MD and LG breakpoints
	    if( viewport.is('>=sm') ) {
	console.log('SM, MD & LG mode');
	        // ...
	    }

	    // Executes in XS and SM breakpoints
	    if( viewport.is('<md') ) {
	console.log('xs & sm mode');
	        // ...
	    }
	}
}
//***********************************************************
