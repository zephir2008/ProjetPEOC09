package com.bdcenter.sqlservices;

	// Pour les interfaces de communcation avec les bases de données
	// quelques soient les bases
public interface ICommunicationSQL {
	public String sql_autocomplete( String reason, String parameters);
	public String sql_get_user( String reason, String parameters );
	public String sql_get_books( String reason, String paramters );
}
