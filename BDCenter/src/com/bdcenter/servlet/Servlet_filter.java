package com.bdcenter.servlet;

import com.bdcenter.sqlservices.ESQLProcedures;
import com.bdcenter.utils.EInterfaces;
import com.bdcenter.sqlservices.SQLConnector;

public class Servlet_filter {

	private String getSqlValues(String callback, String parameters){
		String retVal="";

		try{
			SQLConnector sc = new SQLConnector();
			retVal = sc.sql_autocomplete(callback, parameters);

		} catch(Exception e){
			retVal =  "{\"utilisateur -Servletfilter\":\"Erreur\"}";
		}

		return retVal;
	}

	public String autocomplete(String roots){
		EInterfaces mon_callback = EInterfaces.ALL;
		return this.getSqlValues( mon_callback.getCallBck(), "'"+roots+"'");
	}
	
	
	public String check_password(String pwd) {
		ESQLProcedures mon_callback = ESQLProcedures.USERBYLOGIN;
		return this.getSqlValues( mon_callback.getCallback(), "'"+pwd+"'" );
	}
}
