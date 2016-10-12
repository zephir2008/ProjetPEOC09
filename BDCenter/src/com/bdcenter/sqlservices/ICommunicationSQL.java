package com.bdcenter.sqlservices;

/*
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
*/
	// Pour les interfaces de communcation avec les bases de données
	// quelques soient les bases
public interface ICommunicationSQL {
//	private Connection conn = null;

	public String call_sql(String reason, String parameters);
//	private Connection get_new_connection(); 
	
/*
 * 	try {
	    conn =
	       DriverManager.getConnection("jdbc:mysql://localhost/test?" +
	                                   "user=minty&password=greatsqldb");

	    // Do something with the Connection

	   ...
	} catch (SQLException ex) {
	    // handle any errors
	    System.out.println("SQLException: " + ex.getMessage());
	    System.out.println("SQLState: " + ex.getSQLState());
	    System.out.println("VendorError: " + ex.getErrorCode());
	}
*/
}
