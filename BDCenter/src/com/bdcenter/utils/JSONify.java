package com.bdcenter.utils;


import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.bdcenter.sqlservices.SQLConnector;



public class JSONify implements IJSONify {

	JSONObject objetJson = new JSONObject();
	JSONParser parser = new JSONParser();
	
	SQLConnector sqlcx = new SQLConnector();
	
	
	@Override
	public JSONObject parse(String data) { 

		String procsql;
		// Parsing de la string récupérée:
		JSONObject objetJson = (JSONObject) parser.parse(data);

		return objetJson;
		

	}

	@Override
	public String stringify(ResultSet rs) {
		
		ResultSetMetaData rsMeta = rs.getMetaData();
		int columnCnt = rsMeta.getColumnCount();		
		List<String> columnNames = new ArrayList<String>();
		List<JSONObject> resList = new ArrayList<JSONObject>();
		
		JSONObject obj = new JSONObject(); 
		
		
		while(rs.next()) { // convert each object to an human readable JSON object           
            for(int i=1;i<=columnCnt;i++) {
                String key = columnNames.get(i - 1);
                String value = rs.getString(i);
                obj.put(key, value);
            }
        }
		
		String jsonSortie = obj.toString();
		
		return jsonSortie;
	}

	// constructor
	public void IJSONify(){
		
	} 
}
