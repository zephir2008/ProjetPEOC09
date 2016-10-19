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

		// Construtor, enregistre le pilote JDBC pour l'usage futur 
	public SQLConnector() {
		try {
		    Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
		    e.printStackTrace();
		}
	}

	//**************************************************
	//* Méthodes internes de la classe : les outils
	//**************************************************

	private void show_errors( SQLException ex ){
	    System.out.println("SQLException: " + ex.getMessage());
	    System.out.println("SQLState: " + ex.getSQLState());
	    System.out.println("VendorError: " + ex.getErrorCode());
	}
	
		// Initialise la connexion à la base de données
	private Connection get_new_connection(){
		Connection retVal = null;

		try {
		    retVal = DriverManager.getConnection("jdbc:mysql://192.168.137.102:3306/g_et_co_bdtheque","gore", "gore44");
		} catch (SQLException ex) {				// handle any errors
			this.show_errors(ex);
		}

		return retVal;
	}

		// Ouvre une connexion à la base et execute la requete SQL
	private boolean execute( String chaine ){
		boolean retVal = false;

		try {
			this.conn = this.get_new_connection();
			this.stmt = this.conn.createStatement();
			this.rs = this.stmt.executeQuery( chaine );
			retVal= true;
		} catch (SQLException ex){			// erreur
			this.show_errors(ex);
		}

		return retVal;
	}

		// Fermeture et désallocation de la connexion SQL
	private void close_all(){
	    if (this.rs != null) {
	        try {
	            this.rs.close();
	        } catch (SQLException sqlEx) { /* ignore */ }
	        this.rs = null;
	    }

	    if (this.stmt != null) {
	        try {
	            this.stmt.close();
	        } catch (SQLException sqlEx) { /* ignore */ }
	        this.stmt = null;
	    }
	    
	    if(this.conn != null){
	    	try {
	    		this.conn.close();
	    	} catch (SQLException sqlEx) { /* ignore */ }
	    	this.conn = null;
	    }
	}


	//**************************************************
	//* Méthodes visibles de la classe : les fonctions utilisables
	//**************************************************

		// Récupère les informations pour l'autocomplete
	@SuppressWarnings("unchecked")
	public String sql_autocomplete(String reason, String parameters){
		JSONObject Json = new JSONObject();
		String retVal = "";
		String chaine;
		ArrayList<String> al = new ArrayList<String>();

	    chaine = "Call " + reason + "('" + parameters + "')";
		retVal="{\"id\":\"\",\"value\":\"\",\"categ\":\"\"}";
		try {
			if(execute( chaine )){
				while(this.rs.next()){
					Json.put("id", this.rs.getInt(1));
					Json.put("value", JSONObject.escape(this.rs.getString(2)+ " ("+this.rs.getString(3)+")"));
					al.add(Json.toJSONString());
				};
				retVal = al.toString();
			}
		} catch (SQLException ex){			// erreur
			this.show_errors(ex);
		    retVal="{\"id\":\"erreur\",\"value\":\"erreur\",\"categ\":\"erreur\"}";
		} finally {
			this.close_all();
		}
		return retVal;
	}

		// Récupère l'utilisateur par son identifiant de connexion
	@Override
	public String sql_get_user(String reason, String parameters) {
		String retVal = "";
		String chaine;

		chaine = "Call " + reason + "('" + parameters + "')";
		try {
			if(execute( chaine )){
				this.rs.next();
				retVal = "{ \"utilisateur\": \"" + this.rs.getString( "utl_nom" ) + "\"}";
			}
		} catch (SQLException ex){
			this.show_errors(ex);
			retVal = "{utilisateur call_sql :\"erreur\"}";
		} finally {
			this.close_all();
		}
		return retVal;
	}


	// Récupère l'utilisateur par son identifiant de connexion
	@Override
	@SuppressWarnings("unchecked")
	public String sql_get_books(String reason, String parameters) {
		String retVal = "";
		String chaine;
		JSONObject Json = new JSONObject();
		ArrayList<String> al = new ArrayList<String>();

		if(parameters != null){			// mode 'livre'
			chaine = "Call " + reason + "('" + parameters + "')";
		} else {						// mode bibliotheque
			chaine = "Call " + reason + "()";
		}

		try {
			if(execute( chaine )){
/*
  Ordre et noms des champs remontés de la base :
    1/ "id"
    2/ "Titre"
    3/ "Référence"
    4/ "Auteur"
    5/ "Photo"
    6/ "Stock"
    7/ "Reassort"
    8/ "is_occas"
    9/ "frn_nom"
    10/ "Fournisseur",
    11 /"Etat"
 */
				while(this.rs.next()){
					Json.put("id", this.rs.getInt(1));
					Json.put("Titre", JSONObject.escape(this.rs.getString(2)));
					Json.put("Référence", JSONObject.escape(this.rs.getString(3)));
					Json.put("Auteur", JSONObject.escape(this.rs.getString(4)));
					Json.put("Editeur", this.rs.getInt(10));
					Json.put("Photo", JSONObject.escape(this.rs.getString(5)));
					Json.put("Etat", this.rs.getInt(11));
					Json.put("Stock", this.rs.getInt(6));
					Json.put("Reassort", this.rs.getInt(7));
					al.add(Json.toJSONString());
				};
				retVal = al.toString();
			}
		} catch (SQLException ex){
			this.show_errors(ex);
			retVal = "{call_get_books :\"erreur\"}";
		} finally {
			this.close_all();
		}
		return retVal;
	}
}
