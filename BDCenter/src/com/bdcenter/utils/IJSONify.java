package com.bdcenter.utils;

import java.sql.ResultSet;

import org.json.simple.JSONObject;


public interface IJSONify {
	public JSONObject parse(String data);
	public String stringify(ResultSet rs);
}
