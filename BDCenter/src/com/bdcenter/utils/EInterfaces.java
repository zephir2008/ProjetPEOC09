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
	EDITOR ("Editeur", "get_editors"),
	ALL("All","autocomplete");

	private String Label;
	private String CallBck;

	//private HashMap<String, String> collproc = new HashMap<String, String>(5);
	private HashMap<String, String> collproc = new HashMap<String, String>();


	public String getLabel() {
		return Label;
	}

	private void setLabel(String label) {
		Label = label;
	}

	public String getCallBck() {
		return CallBck;
	}

	private void setCallBck(String callBck) {
		CallBck = callBck;
	}

	private void setCallbckByKey(String key, String callbck){
		collproc.put(key, callbck);
	}
	
	public String getCallbckByKey(String key){
		String retVal = "";
		collproc.get(key);
		return retVal;
	}

	EInterfaces(String label, String callbck){
		setLabel(label);
		setCallBck(callbck);
		setCallbckByKey(label, callbck);
	}
}
