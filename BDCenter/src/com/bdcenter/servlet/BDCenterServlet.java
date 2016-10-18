package com.bdcenter.servlet;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


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


	
	public BDCenterServlet() {
        super();
    }

	/**
	 * Utilisation : autocomplete !
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String query = request.getParameter("term");
		JSONObject Json = new JSONObject();
System.out.println(query);

		Json.put("id", "#rre0048");
		Json.put("value", "test ok");
System.out.println(Json.toString());
		response.getWriter().print(Json); // append( Json );
	}

	/**
	 * @param String
	 * @throws Exception 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * Utilisation : opération sur le stock (ajout/retrait, bascule, etc.) 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response/*, Object String*/) throws ServletException, IOException {	
		if(request.getParameter("password")!= ""){
				//Reception de l'username et password provenants du POST
			response.setContentType("text/json; charset=UTF-8");
			String pwd = request.getParameter("password");	
System.out.println(pwd);
			Servlet_filter servlet_filter = new Servlet_filter();			
			String utilisateur = servlet_filter.check_password(pwd);
System.out.println(utilisateur);
			response.getWriter().append(utilisateur);
		}
	}
}