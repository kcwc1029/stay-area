<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="WSA010400.jsp"%>
<%@ include file="WSA010700.jsp"%>
<%
//比對星期幾
Calendar cal = Calendar.getInstance();
Date dt = cal.getTime();
cal.setTime(dt);
int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
if(TDATE.equals("1110603"))w=0;  //端午節
String SNUMCOL = "CCA007013";  //記錄平日收案量上限
if(w==0){
	SNUMCOL = "CCA007015";  //記錄週日收案量上限
}else if(w==6){
	SNUMCOL = "CCA007014";  //記錄週六收案量上限
}
out.print(TDATE+"星期"+ w + SNUMCOL +"</br>");
%>
<%
String selkind = SQLIJ(request.getParameter("selkind")); // 代碼類別
String selvalue1 = SQLIJ(request.getParameter("selvalue1")); //第一個選項
String selvalue2 = SQLIJ(request.getParameter("selvalue2")); //第一個選項
String outobj = SQLIJ(request.getParameter("outobj")); // element
String TN = SQLIJ(request.getParameter("TN")); // 借來用
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
String r1="";
String r2="";
Boolean selectpicker = false;
if (selkind.equals("ADR001003")){
	SQL01="SELECT LI_NAME AS T1,LI_NAME AS T2 FROM LI WHERE CITY_ID = '64' AND DIST_NAME = '"+selvalue1+"' ORDER BY LI_NAME";
	selectpicker = true;
	out.print(TN+"</br>");
}
if (selkind.equals("ADR001005")){
	SQL01="SELECT ADR001005+ADR001006+ADR001007+ADR001008 AS T1,ADR001005+ADR001006+ADR001007+ADR001008 AS T2 FROM ADR001 WHERE ADR001002 IN (SELECT DIST_ID FROM DIST WHERE DIST_NAME = '"+selvalue1+"') AND ADR001003 = '"+selvalue2+"' GROUP BY ADR001005+ADR001006+ADR001007+ADR001008 ORDER BY ADR001005+ADR001006+ADR001007+ADR001008";
	selectpicker = true;
}
if (selkind.equals("ADR001009")){
	SQL01="SELECT ADR001009 AS T1,ADR001009 AS T2 FROM ADR001 WHERE ADR001002 IN (SELECT DIST_ID FROM DIST WHERE DIST_NAME = '"+selvalue1+"') AND ADR001003+ADR001005+ADR001006+ADR001007+ADR001008 = '"+selvalue2+"' ORDER BY ADR001009";
	selectpicker = true;
}
if (selkind.equals("CCA007003")){
	SQL01="SELECT CCA007003 AS T1,CCA007003 AS T2 FROM CCA007 WHERE " + SNUMCOL + " <> '0' AND CCA007002 <> '' AND CCA007002 = '"+selvalue1+"' ORDER BY CCA007003";
	selectpicker = true;
}
if (selkind.equals("CCA007001")){
	SQL01="SELECT CCA007001 AS T1,CCA007003 AS T2 FROM CCA007 WHERE CCA007002 = '"+selvalue1+"' ORDER BY CCA007003";
	selectpicker = true;
}
if (selkind.equals("CCA007")){
	SQL01="SELECT CCA007003 AS T1,CCA007003 AS T2 FROM CCA007 WHERE CCA007002 = '"+selvalue1+"' ORDER BY CCA007003";
}
if (selkind.equals("CCA021004")){
	SQL01="SELECT CCA021004 AS T1,CCA021004 AS T2 FROM CCA021 WHERE CCA021001 = N'"+selvalue1+"' ORDER BY CCA021004";
}
if (selkind.equals("LI")){
	SQL01="SELECT LI_NAME AS T1,LI_NAME AS T2 FROM LI WHERE CITY_ID = '64' AND DIST_NAME = '"+selvalue1+"' ORDER BY LI_NAME";
}

if (selkind.equals("TOWN")){
	SQL01="SELECT TOWNNAME T1,TOWNNAME AS T2,TOWNID FROM TOWN WHERE CITYNAME = '"+selvalue1+"' GROUP BY TOWNNAME,TOWNID ORDER BY TOWNID";
}
if (selkind.equals("SECTNAME")){
	String UNIT = TAB01.getCol("TOWN", "UNITID+TOWNID", "CITYNAME", "'"+ selvalue1 + "'", "TOWNNAME", "'"+ selvalue2 +"'");
	SQL01="SELECT KCNT T1,KCNT AS T2 FROM SECTNO WHERE UNIT='"+UNIT+"' AND KRMK <> '註銷' ORDER BY KCNT";
}
RS01 = TAB01.buildMaps(SQL01);

%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8" />
<script language="javascript">
function returnValue()
{
    //alert(parent.<%= outobj %>.value);
    parent.<%= outobj %>.length = 0;
    var o = parent.document.createElement("OPTION");
    o.value = "";
    o.text = "請選擇";
    parent.<%= outobj %>.add(o);
	<%
	for(int A=0; A<RS01.length; A++){
	r1=RS01[A].get("T1").toString();
	r2=RS01[A].get("T2").toString();
	%>
    var o = parent.document.createElement("OPTION");
    o.value = "<%= r1 %>";
    o.text = "<%= r2 %>";
    parent.<%= outobj %>.add(o);
	<%}%>
	parent.<%= outobj %>.disabled = false;
    <%if(selectpicker){%>
	parent.refreshSelectpicker("<%=TN%>");
	<%}%>
	
}

</script>
<title></title>
</head>
<body onLoad="returnValue()">
<%=SQL01%>
</body>
</html>
<%DB01.close();%>