package com.bdcenter.servlet;

import com.bdcenter.sqlservices.SQLConnector;

public class Servlet_filter {
	
	String user;

	public String getUser() {
		return user;
	}

	public String check_password(String pwd) {
		
	String retValpwd = "";
	
	//SQLConnector sr = new SQLConnector();
		
		try {	 
		
	//retValpwd = sr.getUser();
		
retValpwd =  "{\"utilisateur\":\"David\"}";
			
		} catch(Exception e) {
			
			retValpwd =  "{\"utilisateur\":\"Erreur\"}";
		
		}
	
		return retValpwd;
}

	
}
