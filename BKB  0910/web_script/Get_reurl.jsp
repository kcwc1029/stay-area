<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.apache.http.client.HttpClient" %>
<%@ page import="org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import="org.apache.http.client.methods.HttpPost" %>
<%@ page import="org.apache.http.client.methods.HttpGet" %>
<%@ page import="org.apache.http.HttpResponse" %>
<%@ page import="org.apache.http.util.EntityUtils" %>
<%@ page import="org.apache.http.entity.StringEntity" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.http.impl.client.HttpClientBuilder" %>
<%@ page import="org.apache.http.entity.StringEntity" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ page import="java.math.BigInteger" %>
<%!
public String Get_surl(String A){
	//得到token
	String target = A; 
	String token = "4070ff49d794e03310563b663c974755ecd0b735959904df8a38b58d65165567c4f5d6"; 
	String API_DATA_URL = "https://api.reurl.cc/shorten";
	String errorMsg = "查無資料";
	String short_url = "";
	try{
	  //JSONObject resultJson = new JSONObject(responseString);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("url", target);
		jsonObject.put("utm_source", "GA_AD");
		
		HttpPost httpPost = new HttpPost(API_DATA_URL);
		httpPost.addHeader("reurl-api-key", token);
		StringEntity entity = new StringEntity(jsonObject.toString(), "UTF-8");
		entity.setContentEncoding("UTF-8");
		entity.setContentType("application/json");
		httpPost.setEntity(entity);
		
		DefaultHttpClient defaultHttpClient = new DefaultHttpClient();
		HttpResponse httpResponse = defaultHttpClient.execute(httpPost);
		String responseString = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
		
		//out.print(responseString+"<br>");
		
		try{
		  JSONObject resultJson = new JSONObject(responseString);
		  //System.out.print(resultJson.toString()+"<br>");
		  short_url = resultJson.get("short_url").toString();  //得到token		  
		}catch(Exception e){
		  short_url = "ERROR 2." + e.toString();
		}
	}catch(Exception e){
	  short_url = "ERROR 1." + e.toString();
	}
	return short_url;
}
%>
