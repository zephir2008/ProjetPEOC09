package com.bdcenter.utils;

import java.util.HashMap;
import java.util.Map;


public enum EInterfaces {
<<<<<<< HEAD
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
=======
	TITLES ("Titre","get_titles","gco_livres.liv_titre"),
	AUTHORS ("Auteur","get_authors","gco_livres.liv_auteur"),
	REFERENCE ("Reference","get_references","gco_livres.liv_references"),
	EDITORS ("Editeur", "get_editors","gco_fournisseurs.frn_nom");
>>>>>>> origin/Version-1.0

	private String Label;
	private String CallBck;
	private String SQLField;
	
	
	////
	private String item;
	private String procedure;
	
	private EInterfaces(String item, String procedure) {
	    this.item = item;
	    this.procedure = procedure;
	}

	HashMap<String, String> collproc = new HashMap<String, String>(5);
	
	public String trouvenomproc(String item) {
		
		
		String nomproc = "";
		
		for (EInterfaces enumit : EInterfaces.values()) {
			collproc.put(enumit.item,enumit.procedure);			
		}
		
		
		for (Map.Entry mapentry: collproc.entrySet()) {
			
		           if (item == mapentry.getKey())
		           {
		                nomproc = (mapentry.getValue().toString());
		           }
		        	   	           
		        }
		
		return nomproc;
		
	}
	
	/////
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
	}
}
