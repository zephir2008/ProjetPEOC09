package com.bdcenter.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BDCenterServlet
 */
public class BDCenterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

		// le constructeur (vide)
	public BDCenterServlet() {
        super();
    }

	/**
	 * HTTP / GET
	 * 
	 * Utilisation : les autocompletes (uniquement) !
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String query = request.getParameter("term");
		String retVal = "";

		if( query != null ){
			Servlet_filter sf = new Servlet_filter();			
			retVal = sf.autocomplete(query);
		}

		response.setContentType("text/json; charset=\"UTF-8\"");
		response.getWriter().append( retVal );
	}

	/**
	 * HTTP / POST
	 * 
	 * Utilisation : opération sur le stock (ajout/retrait, bascule, recherche, etc.) 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		String check;
		String retVal = "";

		Servlet_filter sf = new Servlet_filter();			

		check = request.getParameter("password");					// mode 'login' ?
		if( check != null ){
			retVal = sf.check_password( check );
		}

		check = request.getParameter( "voir" );
		if( check != null ){										// mode 'livre' ?
			retVal = sf.get_books( check , request.getParameter("id"));
		}

		check = request.getParameter( "biblio" );
		if( check != null ){										// mode 'bibliothèque' ?
			retVal = sf.get_books( check , null );
		}

		response.setContentType("text/json; charset=\"UTF-8\"");
		response.getWriter().append( retVal );
	}
	
	/**
	 * HTTP / PUT
	 * 
	 * Utilisation : inscription d'un nouveau livre (et/ou d'un nouveau fournisseur)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/json; charset=\"UTF-8\"");
		response.getWriter().append( "{response:'ok'}" );
	}
}