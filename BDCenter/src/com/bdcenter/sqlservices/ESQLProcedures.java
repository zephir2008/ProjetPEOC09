package com.bdcenter.sqlservices;



	// Utiliser pour obtenir le nom de la procédure SQL à utiliser
public enum ESQLProcedures {


		//**************************** Partie utile *********************************//
	USERBYLOGIN("get_user_by_login"),		// (parametre : string "login") Renvois l'utilisateur correspondant au login

	LIVREOCCASION("get_livre_occasion"),	// (parametres : <aucun>) les ouvrages d'occasion
	LIVRETOUS("get_livre_tous"),			// (parametres : <aucun>) l'intégralité de la bibliotheque
	LIVRERUPTURE("get_livre_rupture"),		// (parametres : <aucun>) les livres en cours de ruptures de stock (qte = 0)
	LIVRESREASSORT("get_livre_reassort")	// (parametres : <aucun>) les livres en cours de reassortiement (reassort > 0)
	;

	// utilisation : 
	/*
	 * 	p.ex. :		String x = USERBYLOGIN.getCallback();
	 * 				String y = 'call ' + x + '(' + login + ')';
	 * 		resultat = exec( y );
	 * 	 */
	
	//**************************** Partie à ne pas modifier *********************************//
	private String callback;				// le nom de la procédure à appeler1

	public String getCallback(){			// getter pour le callback (usage : 'x = GETUSERBYLOGIN.getCallback();' )
		return this.callback;
	}

	ESQLProcedures(String callback){
		this.callback = callback;
	}
}
