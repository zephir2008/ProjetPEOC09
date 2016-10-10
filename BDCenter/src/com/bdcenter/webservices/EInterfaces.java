package com.bdcenter.webservices;

public enum EInterfaces {
	TITLES ("Titre","get_titles","gco_livres.liv_titre"),
	AUTHORS ("Auteur","get_authors","gco_livres.liv_auteur"),
	REFERENCE ("Reference","get_references","gco_livres.liv_references"),
	EDITORS ("Editeur", "get_editors","gco_fournisseurs.frn_nom");

	private String Label;
	private String CallBck;
	private String SQLField;

	public String getLabel() {
		return this.Label;
	}

	public void setLabel(String label) {
		this.Label = label;
	}

	public String getCallBck() {
		return this.CallBck;
	}

	public void setCallBck(String callBck) {
		this.CallBck = callBck;
	}

	public String getSQLField() {
		return this.SQLField;
	}

	public void setSQLField(String sQLField) {
		this.SQLField = sQLField;
	}

	EInterfaces(String label, String callbck, String sqlField){
		this.setLabel(label);
		this.setCallBck(callbck);
		this.setSQLField(sqlField);
	}
}
