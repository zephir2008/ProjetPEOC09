package com.bdcenter.utils;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.bdcenter.sqlservices.SQLConnector;



public class JSONify implements IJSONify {

	JSONObject objetJson = new JSONObject();
	JSONParser parser = new JSONParser();
	
	SQLConnector sqlcx = new SQLConnector();
	
	
	@Override
	public String parse(String data) {
		// 

		String procsql;
		// Parsing de la string r�cup�r�e:
		objetJson = (JSONObject) parser.parse(data);

		
		//Appel de la fonction qui retourne le nom de la proc�dure � utiliser:
		procsql = EInterfaces.this.getCallBck(objetJson.id);
		
		// Cr�ation de la chaine SQL, avec le nom de la proc�dure et la valeur:
		sqlcx.call_sql(procsql, objet.value);
		
	}

	@Override
	public String stringify(repSql) {
		// TODO Auto-generated method stub
		
		
		return null;
	}

	// constructor
	public void IJSONify(){
		
	} 
}
