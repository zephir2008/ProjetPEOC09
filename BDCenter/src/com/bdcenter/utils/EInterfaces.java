package com.bdcenter.utils;

		// les informations nécessaires pour l'autocomplete
public enum EInterfaces {
	// utilisation : 
	/*
	 * 	p.ex. :		x = TITLES.getLabel();
	 * ou
	 *  			EInterface myVar = new EInterfaces;
	 *  			x = myVar.getCallback('Titre');
	 */
	
	
		//**************************** Partie utile *********************************//
	TITLES ("Titre","get_titles","gco_livres.liv_titre"),
	AUTHORS ("Auteur","get_authors","gco_livres.liv_auteur"),
	REFERENCE ("Reference","get_references","gco_livres.liv_references"),
	EDITORS ("Editeur", "get_editors","gco_fournisseurs.frn_nom");

	
		//**************************** Partie à ne pas modifier *********************************//
	private String Label;
	private String CallBck;
	private String SQLField;

	private Object enumCollection;

	public String getCallback(String label){
		String retVal = "";

		return retVal;
	}
	public String getLabel() {
		return this.Label;
	}

	public void setLabel(String label) {
		this.Label = label;
	}

	public String getCallBck() {
		return this.CallBck;
	}

	public void setCallBck(String callBck) {
		this.CallBck = callBck;
	}

	public String getSQLField() {
		return this.SQLField;
	}

	public void setSQLField(String sQLField) {
		this.SQLField = sQLField;
	}

	EInterfaces(String label, String callbck, String sqlField){
		this.setLabel(label);
		this.setCallBck(callbck);
		this.setSQLField(sqlField);
		//this.enumCollection("");
	}
}
