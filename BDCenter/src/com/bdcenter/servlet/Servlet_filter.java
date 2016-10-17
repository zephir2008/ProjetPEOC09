package com.bdcenter.servlet;

public class Servlet_filter {
	
	//Gestion du POST
	
	private String pwd;
	static String NULL = null;
	boolean state = false;

	
	public String getMessage() {
		String errVal = "Identifiant ou Mot de passe utilisateur incorrect";
		return errVal;
	}

	public String getPwd() {
		return pwd;
	}

	public Servlet_filter(String pwd) throws Exception {
		
	//	String retValpwd = null;
		
		try {	 
			
		if (!(pwd == NULL)){
			
			this.pwd = pwd;
			
		}
		} catch(Exception e) {
			
			e.getMessage();
		
		}
		
		return;
}

	
}
