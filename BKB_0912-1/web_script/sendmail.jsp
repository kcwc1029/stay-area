<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>          
<%@ page import="tools.mail.*" %>
<%!
public String sendmail(String Subject, String smail, String toMail){ 
	String strmsg = "";
	String mailServer = "smtp.kcg.gov.tw";
	String address = "uservice@kcg.gov.tw";
	//String Subject = "工廠登記線上申辦系統訊息通知，系統編號：";
	
	String messageText="";
	messageText=messageText+"<!DOCTYPE html>";
	messageText=messageText+"<html lang=\"zh\">";
	messageText=messageText+"<head>";
	messageText=messageText+"<meta charset=\"utf-8\" />";
	messageText=messageText+"<title>高雄住宅補貼網</title>";
	messageText=messageText+"<link href=\"https://hs.kcg.gov.tw/HSB/web_css/contant.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\" />";
	messageText=messageText+"";
	messageText=messageText+"</head>";
	messageText=messageText+"<body>";
	messageText=messageText+smail;
	messageText=messageText+"<p align=\"center\">　</p>";
	messageText=messageText+"</body>";
	messageText=messageText+"</html>";
	SendMail2_UTF8 sm2 = new SendMail2_UTF8();
	sm2.setSMTP("smtp.kcg.gov.tw");
	sm2.setFrom(address,"高雄市政府都市發展局住宅補貼管理系統");
	sm2.setUserName("uservice");
	sm2.setPassWord("urban5899");
	sm2.setPORT(25);
	sm2.setSSL(false);
	sm2.setTo(toMail);
	//sm2.setBcc("yanyi0917@wholeway-gis.com.tw");  cc副本，先測試是否自己也能收到副本，代表對方成功收到
	sm2.setSubject(Subject);
	sm2.setBody(messageText);
	try{
		sm2.send();
		strmsg="電子郵件寄送成功";  //程式顯示成功，但信不一定成功寄出
	}catch(Exception e){
		System.out.println("電子郵件寄送失敗");
		e.printStackTrace();
		strmsg="電子郵件寄送失敗";
	}
	//out.print(messageText);
	return strmsg;
}
%>

