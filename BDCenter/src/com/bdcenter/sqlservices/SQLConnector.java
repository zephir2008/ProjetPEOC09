package com.bdcenter.sqlservices;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class SQLConnector implements ICommunicationSQL {
	private Connection conn = null;
	private String user;

	public String getUser() {
		return user;
	}

	@Override
	public String call_sql(String reason, String parameters) {
		// TODO Auto-generated method stub
		return null;
	}
	
	private void get_new_connection(){
		try {
		    conn =
		       DriverManager.getConnection("jdbc:mysql://localhost/test?" +
		                                   "user=minty&password=greatsqldb");

		    // Do something with the Connection
		    SQLConnector sc = SQLConnector();
		    sc.call_sql(reason, parameters);
		    chaine = "Call" + reason +"("+parameters+")";
		    resultat = sc.get_new_connection();
		    JSONobject jo = new 

/*		   ... */
		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
	}

}
