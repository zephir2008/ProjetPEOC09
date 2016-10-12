package com.bdcenter.utils;


public class JSONify implements IJSONify {

	JSONObject objJSON = new JSONObject();

	
	@Override
	public String parse(String data) {
		// TODO Auto-generated method stub
		// 
		objJSON = JSON.parse(data);
		
		//Appel de la fonction qui retourne le nom de la procédure à utiliser:
		EInterfaces.trouvenomproc(objJSON.id); 
		
	}

	@Override
	public String stringify() {
		// TODO Auto-generated method stub
		return null;
	}

	// constructor
	public void IJSONify(){
		
	} 
}
