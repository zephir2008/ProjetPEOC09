package com.bdcenter.utils;

import com.bdcenter.sqlservices.SQLConnector;


public class JSONify implements IJSONify {

	JSONObject objJSON = new JSONObject();
	SQLConnector sqlcx = new SQLConnector();

	
	@Override
	public String parse(String data) {
		// TODO Auto-generated method stub
		// 
		String procsql;
		objJSON = JSON.parse(data);
		
		//Appel de la fonction qui retourne le nom de la proc�dure � utiliser:
		
		procsql = EInterfaces.this.trouvenomproc(objJSON.id); 
		// Cr�ation de la chaine SQL, avec le nom de la proc�dure et la valeur:
		sqlcx.call_sql(procsql, objJSON.value);
		
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
