package com.bdcenter.utils;

import java.util.HashMap;
//import java.util.Map;


public enum EInterfaces {
	// utilisation : 
	/*
	 * 	p.ex. :		String x = EInterface.getCallbck('Titre');
	 *  			String y = EInterface.getMyLabel(TITLES);
	 */
	
	
		//**************************** Partie utile *********************************//
	TITLE ("Titre","get_titles"),
	AUTHOR ("Auteur","get_authors"),
	REFERENCE ("Reference","get_references"),
	EDITOR ("Editeur", "get_editors");

	private static String Label;
	private static String CallBck;
	private static String SQLField;
	//private HashMap<String, String> collproc = new HashMap<String, String>(5);
	private HashMap<String, String> collproc = new HashMap<String, String>();


	public static String getLabel() {
		return Label;
	}

	private static void setLabel(String label) {
		Label = label;
	}

	public static String getCallBck() {
		return CallBck;
	}

	private static void setCallBck(String callBck) {
		CallBck = callBck;
	}

	public String getCallbckByKey(String key){
		String retVal = "";
		this.collproc.get(key);
		return retVal;
	}

	EInterfaces(String label, String callbck){
		setLabel(label);
		setCallBck(callbck);
		this.collproc.put(label, callbck);
	}
}
