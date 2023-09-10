<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.security.*"%>
<%@ page import="org.apache.http.HttpResponse" %>
<%@ page import="org.apache.http.client.HttpClient" %>
<%@ page import="org.apache.http.client.methods.HttpPost" %>
<%@ page import="org.apache.http.entity.mime.HttpMultipartMode" %>
<%@ page import="org.apache.http.entity.mime.MultipartEntity" %>
<%@ page import="org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import="org.apache.http.impl.client.HttpClientBuilder" %>
<%@ page import="org.apache.http.util.EntityUtils" %>
<%@ page import="org.apache.http.entity.mime.content.StringBody" %>
<%@ page import="org.apache.http.entity.mime.content.FileBody" %>
<%@ page import="org.apache.http.NameValuePair" %>
<%@ page import="org.apache.http.message.BasicNameValuePair" %>
<%@ page import="org.apache.http.client.entity.UrlEncodedFormEntity" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>

<%!
public String sendMMS(String Subject,String phonenum,String MMSContent,String MSGSTOPDATE){ 
	String TMA001002 = phonenum; //手機號碼
	String TMA001006 = Subject;	//簡訊主旨
	String TMA001007 = MMSContent;  //簡訊內容
	String TMA001008 = "簡訊發送成功";
	String TMA001009 = "0906268086";
	String TMA001010 = "0906268086";
	String TMA001012 = "0";  //簡訊狀態
	//發送號碼
	String MSGTEXT = "";
	String MSGPW = "@kcg3368333"; //UPASS
	if (!TMA001002.equals("")){
		try{
			MSGTEXT = "<MSISDN>"+TMA001002+"</MSISDN>";
			MSGTEXT = "<Request><Subject>"+TMA001006+"</Subject><Retry>Y</Retry><AutoSplit>Y</AutoSplit><StopDateTime>"+MSGSTOPDATE+"</StopDateTime><Message>"+TMA001007+"</Message><MDNList>"+MSGTEXT+"</MDNList></Request>";
			MSGTEXT = new String(MSGTEXT.getBytes("utf-8"), "iso-8859-1");
			String url = String.format("http://xsms.aptg.com.tw/XSMSAP/api/APIRTFastHttpRequest");
			HttpClient client = HttpClientBuilder.create().build();
			HttpPost post = new HttpPost(url);
			// add header
			String USER_AGENT = "Mozilla/5.0";
			post.setHeader("User-Agent", USER_AGENT);

			List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
			urlParameters.add(new BasicNameValuePair("MDN", TMA001009));
			urlParameters.add(new BasicNameValuePair("UID", TMA001010));
			urlParameters.add(new BasicNameValuePair("UPASS", MSGPW));
			urlParameters.add(new BasicNameValuePair("Content", MSGTEXT));
			//post.setHeader("Authorization", "Basic " + encoding);
			post.setEntity(new UrlEncodedFormEntity(urlParameters));

			HttpResponse resp = client.execute(post);
			String responseJson = EntityUtils.toString(resp.getEntity(), "utf-8");
			System.out.println(responseJson);
			TMA001012 = "1";
			TMA001008 = "簡訊發送成功"; 
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("簡訊發送失敗：" + e);
			TMA001012 = "0";
			TMA001008 = "(簡訊發送失敗："+e+")"; 
		}

	} else {
		TMA001008 = "(本案件資訊中無手機門號，無法發送簡訊)";
		TMA001012 = "0";
	}
	return TMA001008;
}
%>