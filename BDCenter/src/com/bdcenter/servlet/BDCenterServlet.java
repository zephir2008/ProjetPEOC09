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
	String ppwd;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BDCenterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * Utilisation : autocomplete !
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		//Reception de l'username et password provenants du POST

		response.setContentType("texte/plaine;charset=UTF-8");
        
		//PrintWriter out = response.getWriter();
		String pwd = request.getParameter("password");	
		
		Servlet_filter servlet_filter = new Servlet_filter();			
		String JSONpwd = servlet_filter.check_password(pwd);
		
			response.getWriter().append(JSONpwd);

	}
	

	/**
	 * @param String 
	 * @throws Exception 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * Utilisation : opération sur le stock (ajout/retrait, bascule, etc.) 
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response, Object String) throws Exception {

	
				response.getWriter().append("Served at: ").append(request.getContextPath());
			} 
}
						
	
