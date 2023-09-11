<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%
String PK01 = SQLIJ(request.getParameter("PK01"));
String PK02 = SQLIJ(request.getParameter("PK02"));
String ST01 = "";
%>
<!doctype html>
<html>
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="FM01" name="FM01" method="post" action="">

	<input name="PK01" type="hidden" id="PK01" value="<%=PK01%>">
	<input name="PK02" type="hidden" id="PK02" value="<%=PK02%>">
	<div id="R02">
	<%
	if (!PK01.equals("")){
	ST01 = PK02 + "?PK01=" +PK01;
	} else {
	ST01 = PK02;
	}
	%>
	  <iframe src="<%=ST01%>" onload="javascript:{dyniframesize('IFM02');parent.dyniframesize('IFM01');}" name="IFM02" id="IFM02" width="100%" height="400" scrolling="No" frameborder="0" marginwidth="0" marginheight="0"></iframe>
	</div>

</form>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
<!-- indexJS -->
<%@ include file="indexJS.jsp"%>
</body>
</html>
