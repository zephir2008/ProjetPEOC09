package com.bdcenter.sqlservices;


import java.util.ArrayList;
import org.json.simple.JSONObject;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class SQLConnector implements ICommunicationSQL {
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;

	public SQLConnector() {
		//super();
		try {
		    Class.forName("com.mysql.jdbc.Driver");
		} 
		catch (ClassNotFoundException e) {
		    e.printStackTrace();
		}
	}

	public String sql_autocomplete(String reason, String parameters){
		JSONObject Json = new JSONObject();
		String retVal = "";
		String chaine;
		ArrayList<String> al = new ArrayList<String>();

	    chaine = "Call " + reason + "(" + parameters + ")";
		retVal="{\"id\":\"\",\"value\":\"\",\"categ\":\"\"}";

		try {
			this.conn = this.get_new_connection();
			this.stmt = this.conn.createStatement();
			this.rs = this.stmt.executeQuery( chaine );

			while(this.rs.next()){
				Json.put("id", this.rs.getInt(1));
				Json.put("value", JSONObject.escape(this.rs.getString(2)+ " ("+this.rs.getString(3)+")"));

				al.add(Json.toJSONString());
			};
			retVal = al.toString();
		} catch (SQLException ex){			// erreur
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		    retVal="{\"id\":\"erreur\",\"value\":\"erreur\",\"categ\":\"erreur\"}";
		} finally {
		    if (this.rs != null) {
		        try {
		            this.rs.close();
		        } catch (SQLException sqlEx) { } // ignore
		        this.rs = null;
		    }

		    if (this.stmt != null) {
		        try {
		            this.stmt.close();
		        } catch (SQLException sqlEx) { } // ignore
		        this.stmt = null;
		    }
		    
		    if(this.conn != null){
		    	try {
		    		this.conn.close();
		    	} catch (SQLException sqlEx) { } // ignore
		    	this.conn = null;
		    }
		}
		return retVal;
	}


	
	
	@Override
	public String call_sql(String reason, String parameters) {
		String retVal = "";
		String chaine;

	    chaine = "Call " + reason + "(" + parameters + ")";

		try {
			this.conn = this.get_new_connection();
			this.stmt = this.conn.createStatement();
			this.rs = this.stmt.executeQuery( chaine );


			this.rs.next();
			retVal = "{ \"utilisateur\": \""+this.rs.getString("utl_nom")+"\"}";

		} catch (SQLException ex){
			// erreur
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
			retVal = "{utilisateur call_sql :\"erreur\"}";
		} finally {
		    // it is a good idea to release resources in a finally{} block
		    // in reverse-order of their creation if they are no-longer needed

		    if (this.rs != null) {
		        try {
		            this.rs.close();
		        } catch (SQLException sqlEx) { } // ignore
		        this.rs = null;
		    }

		    if (this.stmt != null) {
		        try {
		            this.stmt.close();
		        } catch (SQLException sqlEx) { } // ignore
		        this.stmt = null;
		    }
		    
		    if(this.conn != null){
		    	try {
		    		this.conn.close();
		    	} catch (SQLException sqlEx) { } // ignore
		    	this.conn = null;
		    }
		}
		return retVal;
	}
	
	private Connection get_new_connection(){
		Connection retVal = null;
		try {
			//jdbc:mysql://192.168.137.102:3306/
			//jdbc:mysql://localhost:3306/
		    retVal = DriverManager.getConnection("jdbc:mysql://192.168.137.102:3306/g_et_co_bdtheque","gore", "gore44");
		} catch (SQLException ex) {
		    // handle any errors
		    System.out.println("SQLException: " + ex.getMessage());
		    System.out.println("SQLState: " + ex.getSQLState());
		    System.out.println("VendorError: " + ex.getErrorCode());
		}
		return retVal;
	}

}
