package com.bdcenter.sqlservices;

	// Pour les interfaces de communcation avec les bases de donn�es
	// quelques soient les bases
public interface ICommunicationSQL {
	public void call_sql(String reason, String parameters);

}
