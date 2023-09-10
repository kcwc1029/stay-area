<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="web_script/WSA010400.jsp"%>
<%@ include file="web_script/WSA010700.jsp"%>
<%
String USERID = SQLIJ((String)session.getAttribute("USERID"));
if(USERID.equals("")){
	response.sendRedirect("web_page/login.jsp");
}else{
	response.sendRedirect("web_page/login_welcome.jsp");
}
%>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=Edge">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>疫苗接種預約管理系統2.0</title>
  <meta http-equiv="Refresh" content="0;URL=web_page/login.jsp"/>
</head>
<script>	
    (function(){
      var chrome_warning_text = "建議使用 Chrome 瀏覽器才能正常執行本網頁",
          userAgent = navigator.userAgent,
          thisHref = location.href,
          isLine = userAgent.indexOf("Line") > -1,
          isFacebook = (userAgent.indexOf("FBAN") > -1) || (userAgent.indexOf("FBAV") > -1),
          isIE = /MSIE \d|Trident.*rv:/.test(userAgent);
	  
      console.log(isLine, isFacebook);
      if(isLine){
        // Line, 直接用外部瀏覽器開啟網頁
        location.href = thisHref.indexOf("?") > 0 ? thisHref + "&openExternalBrowser=1" : thisHref + "?openExternalBrowser=1";
      }else if(isFacebook){
        alert(chrome_warning_text);
      }else if(isIE){
        window.location = 'microsoft-edge:' + window.location;
        setTimeout(function(){
           window.open('', '_self', '').close();           
        }, 0);
      }
    })();
</script>
<body>
</body>
</html>