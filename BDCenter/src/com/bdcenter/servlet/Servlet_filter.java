package com.bdcenter.servlet;

import com.bdcenter.utils.EInterfaces;
import com.bdcenter.sqlservices.ESQLProcedures;
import com.bdcenter.sqlservices.SQLConnector;

public class Servlet_filter {
		// rechercher dans la base de données pour l'autocomplete
	public String autocomplete(String roots){
		String retVal = "";

		String mon_callback = EInterfaces.AUTOCOM.getCallBck();
		SQLConnector sc = new SQLConnector();
		retVal = sc.sql_autocomplete(mon_callback, roots);

		return retVal;
	}

		// retrouver un/des livre(s) suivant un paramètre  
	public String get_books(String filter, String Value){
		String retVal = "";
		String mon_callback;

		if(Value != null){
			mon_callback = EInterfaces.ALL.getCallbckByKey(filter);
		} else {
			mon_callback = EInterfaces.ALL.getCallBck();
		}
		SQLConnector sc = new SQLConnector();
		retVal = sc.sql_get_books( mon_callback, Value);

		return retVal;
	}

		// Vérifier l'identifiant de connexion
	public String check_password(String pwd) {
		String retVal="";

		String mon_callback = ESQLProcedures.USERBYLOGIN.getCallback();
		SQLConnector sc = new SQLConnector();
		retVal = sc.sql_get_user( mon_callback, pwd );

		return retVal;
	}
}
