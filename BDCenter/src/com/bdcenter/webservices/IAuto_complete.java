package com.bdcenter.webservices;

	// Interface du WebService pour les listes autocompletes
public interface IAuto_complete {

		// nombres de r�sultat � renvoyer dans le JSON
	static int depth = 5;

		// Param�tre : 'partial' = chaine de caract�re � rechercher
		//	dans les champs Auteur, Editeur, Titre et Reference de la base de donn�es
		//
		// Retourne une String JSON contenant le tableau de r�ponse possible
		//  au format '[{"id": "...", "value": "..."}]'
		// pour des question de performance, seul 'depth' r�sultats seront renvoy�s.
	public String get_autocomplete_from(String partial);

}

// Rien d'autre � faire dans ce package : il est complet !