'use strict';

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
		var self;														// pour la gestion des événements
		myStorage.setItem(													// Créer un objet dans le localStorage
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

		this.ORef = JSON.parse( myStorage[ JSONObj["Référence"] ] );			// ORef = "bean" de mon objet
		this.ORef.ref = JSONObj["Référence"];
		//this.ORef.helper = this.myTitle(false);
		this.ORef.helperHTML = this.myTitle();
		this.ORef.helperTitle = this.myTitle(true);

		//this.ORef.active = false;										// bouton inactif par défaut
		//ImgButton.prototype.active = false;								// variable static : bouton inactif par défaut
		this.ORef.status = ImgButton.categorie(
			(this.ORef.ref != "0"),
			(JSONObj["Etat"]==5),
			(JSONObj["Stock"]>0),
			(JSONObj["Reassort"]>0)
		);

		this.ORef.displ = $("<img>",{
			id: this.ref,
			src: this.ORef.photo,
			class: 'hidden-xs bibimg'+ this.myShadowClass
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
	myTitle(isTitle){													// Création du titre (bulles d'aides)
		var retVal = "";
		var crlf = "<br>";
		var ttl = (this.ORef.ref == '0') ? 'Nouvelle' : this.ORef.ref; 
		if(isTitle){
			retVal = '<h3>'+ttl+'</h3>' + crlf + this.ORef.titre
		} else {
			retVal = "<b>Auteur</b>   : " + ((this.ORef.auteur) ? this.ORef.auteur : '--') + crlf
				+ "<b>Editeur</b>  : " + ((this.ORef.editeur.nom) ? this.ORef.editeur.nom : '--') + crlf
				+ "<b>En stock</b> : " + ((this.ORef.stock)?this.ORef.stock:0) + crlf
				+ "<b>Réappro</b>  : " + ((this.ORef.command)?this.ORef.command:0);
		}
		return retVal;
	}

	//***********************************************************
	get myShadowClass(){			// classe de l'ombre (= couleur)
		return ((this.ORef.status[1]>"")? " "+this.ORef.status[1] : "");
	}

	//***********************************************************
	static onMouseOver(evt){		// lorsque la sourie entre sur l'image/la div
		self = evt.data[0].ORef;
		if(self.ref != "0"){
			$(this).stop(true, true).delay(600).animate({
				height: '210px',
				duration: "200",
				marginBottom: "10px",
				delay: 300
			}, 200, 'swing');
		}
		//evt.stopPropagation();
	}
	//***********************************************************
	static onMouseOut(evt){			// lorsque la sourie sort de l'image/la div
		var self = evt.data[0].ORef;
		if(self.ref != "0"){
			$(this).stop(true, true).delay(200).animate({
				height: '140px',
				marginBottom: "80px"
			}, 200, 'swing');
		}
		//evt.stopPropagation();
	}
	//***********************************************************
	static onClick(evt){			// lorsqu'on clic sur l'image
		var self = evt.data[0].ORef;
		var toto = $("<img>",{
			id: self.ref,
			src: self.photo,
			class: 'hidden-xs bibimg'
		});
		if(ImgButton.prototype.active){
			$("#formular").modal('show');
			$("#formular #pict").html(toto);
			$('[data-toggle="tooltip"]').tooltip('hide');
		} else {
			Handlers.doLogin();
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
	constructor( which ){
		var nbImagePerLine = 6;

		this.getBibliothequeDatas(function(){
			var Editeur = [];
			var buttonList = [];
			for(var x in BDAuth){					// récupère les éditeurs
				Editeur.push(BDAuth[x]);
			}

			var img;
			var f;
			var insert;
			var x;
			for(x in BDCouv){						// peuple la bibliothèque
				insert = false;
				switch( which ){
					case "S":
						insert = (BDCouv[x].Stock == 0);
						break;
					case "R":
						insert = (BDCouv[x].Reassort > 0 );
						break;
					case "E":
						insert = (x != 0) && (BDCouv[x].Etat != 5);
						break;
					case "L":
						if(myStorage.SelectedBookCateg == 'Fournisseur') {
							insert = (BDCouv[x].Editeur == myStorage.SelectedBookId );
						} else if (myStorage.SelectedBookCateg == 'Auteur') {
							insert = ( (BDCouv[x].Auteur).indexOf(myStorage.SelectedBookId) >= 0);
						} else {
							insert = ( (1*myStorage.SelectedBookId) == BDCouv[x].id );
						}
						break;
					default:
						insert = true;
				}

				if(insert){
					img = new ImgButton(
						BDCouv[x],
						(BDCouv[x].id > 1) ? Editeur[ BDCouv[x].Editeur ] : {frn_nom: "Création", frn_contact: "n.a.", frn_telephone: "n.a."}
					);
					buttonList.push( img );
				}
			}
			myStorage.removeItem("SelectedBookCateg");
			myStorage.removeItem("SelectedBookId");

			var div = "";
			var t;
			var i = 0;
			var mainDiv = $('<div>', {
				class: "row text-center"
			});

			for(x in buttonList){				// création des boutons de l'interface
				t = buttonList[x];
				div = $('<div>', {
						class: "col-md-2 biblio"
					})
					.html( t.ORef.displ )
					.append( t.ORef.infos )
					.tooltip({
						animation: false,
						html: true,
						placement: (x % nbImagePerLine < 2) ? 'right' : 'left',
						title: t.ORef.helperTitle + "<hr>" + t.ORef.helperHTML,
						delay: { show: 900, hide: 300 }
					});

				mainDiv.append( div );
				i++;
				i %= nbImagePerLine;					// 6 boutton par ligne

				if(i == 0){
					$("#biblio").append( mainDiv );
					mainDiv = $('<div>', {
						class: "row text-center"
					});
				}
			}
			if(i > 0){
				$("#biblio").append( mainDiv );
			}
		});
	}

	//***********************************************************
	getBibliothequeDatas(done){
		$.ajax({
			url: '/BDCenter/Bibliotheque',										// mon Url d'applet JEE
			type: 'POST',														// en méthode GET
			data: { 'biblio' : true },											// le paramètre à vérifier
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',		// j'envois au format ...
			dataType: 'jsonp'													// j'attends un résultat au format ...
		}).complete(function(data){
			var json;
			json = data.responseText;
			if(json != null){
				BDCouv = JSON.parse(json);
				done();
			}
		}).fail(function(data){
			// Raise error div (pb accès au serveur)
		});
	}

	//***********************************************************
	stepLogin(){	// a faire suite au login réussi
		ImgButton.prototype.active = true;
	}
	//***********************************************************
	stepLogout(){	// a faire suite au logout
		ImgButton.prototype.active = false;
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

		var voir = decodeURIComponent($.urlParam('voir'));
		if(voir.toString() == 'null') { voir = 'Tous'; }

		myStorage = Handlers.WebStorage;
		_maBibliotheque = Handlers.initBibliotheque(voir);
		$(_maBibliotheque).on("login",_maBibliotheque.stepLogin);		// déclencheur pour login réussi
		$(_maBibliotheque).on("logout",_maBibliotheque.stepLogout);	// déclencheur pour logout

		if(myStorage.whosLogged){
			Handlers.logMe( myStorage.whosLogged );
		}
	}

	//***********************************************************
	/* initialisation de l'interface */
	static init(){
		$("#sz").html($(window).width() + 'x' + $(window).height());
		// gestion du login - recrée le fonctionnement d'un formulaire (touche "enter")
		$("#password").keypress(function(event){
			if(event.which == 13){
				$("#login").trigger("click");
			}
		});

		$("#login").on('show',function(){
			this.focus();
		});

			// vérification du login (clic sur le bouton login de la fenetre modal
		$("#login").click(function() {						// connexion de l'utilisateur
			Handlers.getUserByPassword($("#password").val());
		});

		$("#logout").click(function(){
			myStorage.clear();
			$(_maBibliotheque).trigger("logout");
			$("#logout").removeClass("show");
			$("#logout").addClass("invisible");
			$("#t3").removeClass("conn");
			$("#t3").addClass("noconn");
		});

		Handlers.autocomplete();
	}

	//***********************************************************
	static initBibliotheque(which){
		var selector;

		switch(which){
			case 'Rupture' :
				selector = "S";
				break;
			case 'Reassort' :
				selector = "R";
				break;
			case 'Occasion':
				selector = "E";
				break;
			case 'Tous':
				selector = "T";
				break;
			default:	// un ouvrage précis (voir='Livre')
				selector = "L";
		}
		$("#selector")						// les boutons de filtres du menu
			.append($('<li>', {
					id: "_T",
					role: "presentation",
					class: "myMenu"+((selector == 'T') ? " active" : "")
				}).append($("<a>",{href: "?voir=Tous"}).html("Tous")))		// on force le rechargement de la bibliothèque (destruction de la précédente)
			.append($('<li>', {
					id: "_S",
					role: "presentation",
					class: "myMenu"+((selector == 'S') ? " active" : "")
				}).append($("<a>",{href: "?voir=Rupture"}).html("En rupture")))
			.append($('<li>', {
					id: "_R",
					role: "presentation",
					class: "myMenu"+((selector == 'R') ? " active" : "")
				}).append($("<a>",{href: "?voir=Reassort"}).html("R&eacute;assort")))
			.append($('<li>', {
					id: "_E",
					role: "presentation",
					class: "myMenu"+((selector == 'E') ? " active" : "")
				}).append($("<a>",{href: "?voir=Occasion"}).html("Occasion"))
		);

		return new Bibliotheque( selector );		// crée les boutons
	}

	//***********************************************************
	// récupération du JSON des utilisateurs
	static logMe( user ){
		$("#password").val(null);						// efface le dernier mot de passe
		$("#modal").modal("hide");
		ImgButton.prototype.active = false;
		if( user != "" ){								// on se connecte
			$("#logout")
				.html("Bonjour "+user+" !")
				.removeClass("invisible")
				.addClass("show");
			$(_maBibliotheque).trigger("login");			// login bibliothèque
			myStorage.whosLogged = user;
			$("#t3").removeClass("noconn");
			$("#t3").addClass("conn");
			ImgButton.prototype.active = true;
		}
	}

	
	//***********************************************************
	// récupération du JSON des utilisateurs
	static getUserByPassword(check){
		$.ajax({
			url: '/BDCenter/Bibliotheque',										// mon Url d'applet JEE
			type: 'POST',														// en méthode GET
			data: { 'password' : check },											// le paramètre à vérifier
			contentType : 'application/x-www-form-urlencoded; charset=UTF-8',		// j'envois au format ...
			dataType: 'json'													// j'attends un résultat au format ...
		}).complete(function(data){
			var json;
			json = data.responseJSON;
			if(json){
				if(json.utilisateur != "erreur"){
					Handlers.logMe( json.utilisateur );
				}
			} else {
				Handlers.logMe("");
			}
		}).fail(function(data){
			// Raise error div (pb accès au serveur)
		});
	}

	//***********************************************************
	static doLogin(){
		$("#modal").modal({
			keyboard: true		// touche 'esc' ferme la modal
		});
		$("#modal").modal('show').delay(500);
		$("#password").delay(800).focus();
	}

	//***********************************************************
	// initialise le WebStorage
	static get WebStorage(){
		var retVal = null;
		if (typeof(Storage) !== "undefined") {
			//localStorage.clear();
			retVal = localStorage;
			// Code for localStorage/sessionStorage.
		} else {
		    // Sorry! No Web Storage support..
			//retVal = sessionStorage;
		}
		return retVal;
	}

	
	//***********************************************************
	//*** Gestion des autocompletes
	static autocomplete(){
		$( "#gsearch" ).autocomplete({
			source: function( request, response ) {
				$.ajax({
					url: '/BDCenter/Bibliotheque',				// mon Url d'applet JEE
					type: 'GET',								// en méthode GET
					data: { term: request.term },				// "term" = paramètre de recherche
					dataType: 'json',							// j'attends un résultat au format ...
					success: function( data ) {					// quand la réponse (= ok) arrive
						// Reste à filtre les valeurs en fonction de l'input parent
//****************************************************
// dédoublonnage
						var temp = {};
						$.each(data, function( item ) {
					    	temp[ data[item].value ] = data[item];	// j'écrase !
						});
//****************************************************
						response( temp );
					}
				});
			},
			minLength: 2,										// 2 caractère minimum pour la recherche
			select: function( event, ui ) {						// on a sélectionné qque chose dans la liste
				var st = ui.item.value;
				var vals;
				if(st.indexOf('(Fournisseur)') > 0){			// Pour les fournisseurs uniquement
					myStorage.SelectedBookCateg = 'Fournisseur';
					myStorage.SelectedBookId = ui.item.id; 
				}
				if(
					(st.indexOf('(Reference)')>0) ||
					(st.indexOf('(Titre)')>0)
				) {
					myStorage.SelectedBookCateg = "id";
					myStorage.SelectedBookId = ui.item.id; 
				}
				if(st.indexOf('(Auteur)')>0){
					myStorage.SelectedBookCateg = 'Auteur';
					myStorage.SelectedBookId = st.substr(0, st.indexOf(' (Auteur)')-1); 
				}

				$(location).attr('href', '?voir=Livre');		// recharge la page pour afficher la selection
			}
		});

/* autocomplete à adapter pour un affichage avec des catégories */
/*		$.widget( "custom.catcomplete", $.ui.autocomplete, {
			_create: function() {
				this._super();
				this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
			},
			_renderMenu: function( ul, items ) {
				var that = this,
				currentCategory = "";
				$.each( items, function( index, item ) {
					var li;
					if ( item.category != currentCategory ) {
						ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
						currentCategory = item.category;
					}
					li = that._renderItemData( ul, item );
					if ( item.category ) {
						li.attr( "aria-label", item.category + " : " + item.label );
					}
				});
			}
		});

		var data = [
			{ label: "anders", category: "" },
			{ label: "andreas", category: "" },
			{ label: "antal", category: "" },
			{ label: "annhhx10", category: "Products" },
			{ label: "annk K12", category: "Products" },
			{ label: "annttop C13", category: "Products" },
			{ label: "Noëm", category: "Products" },
			{ label: "éthàrnet", category: "Products" },
			{ label: "anders andersson", category: "People" },
			{ label: "andreas andersson", category: "People" },
			{ label: "andreas johnson", category: "People" }
		];

		$( "#gsearch" ).catcomplete({
			delay: 0,
			source: data
		});
*/
	}
}
//***********************************************************
