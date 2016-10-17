package com.bdcenter.utils;

import java.util.Hashtable;

	//********************************************************************
	// la classe de sélection des procédure SQL pour
	// les informations nécessaires à l'autocomplete
public enum EInterfaces {
	// utilisation : 
	/*
	 * 	p.ex. :		String x = TITLES.getLabel();
	 * 				String y = EDITORS.Callback(); 
	 * ou
	 *  			EInterface myVar = new EInterfaces;
	 *  			String x = myVar.getCallback('Titre');
	 *  			String y = myVar.getMyLabel(TITLES);
	 */
	
	
		//**************************** Partie utile *********************************//
	TITLE ("Titre","get_titles"),
	AUTHOR ("Auteur","get_authors"),
	REFERENCE ("Reference","get_references"),
	EDITOR ("Editeur", "get_editors");

	
		//**************************** Partie à ne pas modifier *********************************//
	private String Label;
	private String CallBck;
	private String SQLField;

	private Hashtable<String,String> enumTable;

	public String getMyLabel(String lName){
		String retVal = "";
		retVal = enumTable.get(lName);
		return retVal;
	}
	public String getCallback(String label){
		String retVal = "";
		retVal = enumTable.get(label);
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

	EInterfaces(String label, String callbck){
		this.enumTable.put(label, callbck);			// pour retrouver la commande SQL en fonction du label
		this.enumTable.put(this.toString(), label);	// pour retrouver le label en fonction de l'identifiant Enum (TITLE, AUTOR, etc.)

		this.setLabel(label);
		this.setCallBck(callbck);
	}
}
