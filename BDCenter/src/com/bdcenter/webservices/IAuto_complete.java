package com.bdcenter.webservices;

	// Interface du WebService pour les listes autocompletes
public interface IAuto_complete {

		// nombres de résultat à renvoyer dans le JSON
	static int depth = 5;

		// Paramètre : 'partial' = chaine de caractère à rechercher
		//	dans les champs Auteur, Editeur, Titre et Reference de la base de données
		//
		// Retourne une String JSON contenant le tableau de réponse possible
		//  au format '[{"id": "...", "value": "..."}]'
		// pour des question de performance, seul 'depth' résultats seront renvoyés.
	public String get_autocomplete_from(String partial);

}

// Rien d'autre à faire dans ce package : il est complet !