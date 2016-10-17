package com.bdcenter.servlet;

import com.bdcenter.sqlservices.ESQLProcedures;
import com.bdcenter.sqlservices.SQLConnector;

public class Servlet_filter {

	public String check_password(String pwd) {
		String retVal = "";
		ESQLProcedures mon_callback;
		String chaine;

		try {
System.out.println("a1");
			SQLConnector sc = new SQLConnector();		// connexion à la base
System.out.println("a2");
			mon_callback = ESQLProcedures.USERBYLOGIN;	// ma procédure SQL à appeler
System.out.println("a3");
			chaine = "Call " + mon_callback.getCallback() + "('" + pwd + "')";
System.out.println("a4");

			retVal = sc.call_sql( mon_callback.getCallback(), "'"+pwd+"'" );
		
		} catch(Exception e) {
			retVal =  "{\"utilisateur -Servletfilter\":\"Erreur\"}";
		}
	
		return retVal;
	}

	
}
