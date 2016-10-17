package com.bdcenter.utils;

import java.util.HashMap;
import java.util.Map;


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

	private String Label;
	private String CallBck;
	private String SQLField;
	HashMap<String, String> collproc = new HashMap<String, String>(5);


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
		this.setLabel(label);
		this.setCallBck(callbck);
		this.collproc.put(label, callbck);
	}
}
