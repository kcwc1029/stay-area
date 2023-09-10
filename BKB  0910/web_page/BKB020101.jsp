<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tools.db.*" %>
<%@ page import="tools.tab.*" %>
<%@ page import="tools.other.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
//取得日期
Database DB01 = new Database("BK");//連資料庫
Connection CONN01 = DB01.getConn();
Table TAB01 = new Table(CONN01);
Map[] RS01 = null;
String SQL01 = "";
Map[] RS02 = null;
String SQL02 = "";
%>

<!DOCTYPE html>
<html lang="zh">
<head>
<!-- indexH -->
<%@ include file="indexH.jsp"%>
</head>
<body class="sb-nav-fixed">
<!-- indexS -->
<%@ include file="indexS.jsp"%>
<form id="form1" name="form1" method="post" action="">
<input name="BKA002001" type="hidden" id="BKA002001" value="" />
<input name="BKA002002" type="hidden" id="BKA002002" value="" />
	<div class="container px-4">
		<h3 class="mt-4">請選擇匯入場次</h3>
		<ol class="breadcrumb mb-4">
			<li class="breadcrumb-item"><a href="../index.jsp"><i class="fas fa-home me-1"></i>Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">選擇匯入場次</li>
		</ol>
		<%
		SQL01 = "SELECT * FROM BKA002 WHERE BKA002001 <> '' AND BKA002004 = '1' ORDER BY BKA002002 DESC";
		RS01 = TAB01.buildMaps(SQL01);
		//out.print(RS01.length);
		//計算總筆數除以3的商數
		int t = RS01.length%3;
		for(int A=0;A<RS01.length-t;A=A+3){
		%>
		<div class="row mt-3" align="center">
			<div class="col-lg-4">
				<a href="javascript:SF02('BKB020100','_self','<%=RS01[A].get("BKA002001").toString()%>','<%=RS01[A].get("BKA002002").toString()%>')" class="btn btn-outline-green large shadow rounded-lg boxcs">
					<h5 class="card-title text-center text-black fw-bold py-5"><%=RS01[A].get("BKA002003").toString()%></h5>
					<p class="card-text">匯入時間：
						<br><%=RS01[A].get("BKA002005").toString().length() >= 12 ? (EYC2(RS01[A].get("BKA002005").toString().substring(0,8))+"&emsp;"+RS01[A].get("BKA002005").toString().substring(8,10)+":"+RS01[A].get("BKA002005").toString().substring(10)):RS01[A].get("BKA002005").toString()%><br>
						~<br><%=RS01[A].get("BKA002006").toString().length() >= 12 ? (EYC2(RS01[A].get("BKA002006").toString().substring(0,8))+"&emsp;"+RS01[A].get("BKA002006").toString().substring(8,10)+":"+RS01[A].get("BKA002006").toString().substring(10)):RS01[A].get("BKA002006").toString()%>
					</p>
				</a>
			</div>
			<div class="col-lg-4">
				<a href="javascript:SF02('BKB020100','_self','<%=RS01[A+1].get("BKA002001").toString()%>','<%=RS01[A+1].get("BKA002002").toString()%>')" class="btn btn-outline-green large shadow rounded-lg boxcs">
					<h5 class="card-title text-center text-black fw-bold py-5"><%=RS01[A+1].get("BKA002003").toString()%></h5>
					<p class="card-text">匯入時間：
						<br><%=RS01[A+1].get("BKA002005").toString().length() >= 12 ? (EYC2(RS01[A+1].get("BKA002005").toString().substring(0,8))+"&emsp;"+RS01[A+1].get("BKA002005").toString().substring(8,10)+":"+RS01[A+1].get("BKA002005").toString().substring(10)):RS01[A+1].get("BKA002005").toString()%><br>
						~<br><%=RS01[A+1].get("BKA002006").toString().length() >= 12 ? (EYC2(RS01[A+1].get("BKA002006").toString().substring(0,8))+"&emsp;"+RS01[A+1].get("BKA002006").toString().substring(8,10)+":"+RS01[A+1].get("BKA002006").toString().substring(10)):RS01[A+1].get("BKA002006").toString()%>
					</p>
				</a>
			</div>
			<div class="col-lg-4">
				<a href="javascript:SF02('BKB020100','_self','<%=RS01[A+2].get("BKA002001").toString()%>','<%=RS01[A+2].get("BKA002002").toString()%>')" class="btn btn-outline-green large shadow rounded-lg boxcs">
					<h5 class="card-title text-center text-black fw-bold py-5"><%=RS01[A+2].get("BKA002003").toString()%></h5>
					<p class="card-text">匯入時間：
						<br><%=RS01[A+2].get("BKA002005").toString().length() >= 12 ? (EYC2(RS01[A+2].get("BKA002005").toString().substring(0,8))+"&emsp;"+RS01[A+2].get("BKA002005").toString().substring(8,10)+":"+RS01[A+2].get("BKA002005").toString().substring(10)):RS01[A+2].get("BKA002005").toString()%><br>
						~<br><%=RS01[A+2].get("BKA002006").toString().length() >= 12 ? (EYC2(RS01[A+2].get("BKA002006").toString().substring(0,8))+"&emsp;"+RS01[A+2].get("BKA002006").toString().substring(8,10)+":"+RS01[A+2].get("BKA002006").toString().substring(10)):RS01[A+2].get("BKA002006").toString()%>
					</p>
				</a>
			</div>
		</div>
		<%
		}
		%>
		<div class="row mt-3" align="center">
			<%
			for(int A=RS01.length-t;A<RS01.length;A++){
			%>
			<div class="col-lg-4">
				<a href="javascript:SF02('BKB020100','_self','<%=RS01[A].get("BKA002001").toString()%>','<%=RS01[A].get("BKA002002").toString()%>')" class="btn btn-outline-green large shadow rounded-lg boxcs">
					<h5 class="card-title text-center text-black fw-bold py-5"><%=RS01[A].get("BKA002003").toString()%></h5>
					<p class="card-text">匯入時間：
						<br><%=RS01[A].get("BKA002005").toString().length() >= 12 ? (EYC2(RS01[A].get("BKA002005").toString().substring(0,8))+"&emsp;"+RS01[A].get("BKA002005").toString().substring(8,10)+":"+RS01[A].get("BKA002005").toString().substring(10)):RS01[A].get("BKA002005").toString()%><br>
						~<br><%=RS01[A].get("BKA002006").toString().length() >= 12 ? (EYC2(RS01[A].get("BKA002006").toString().substring(0,8))+"&emsp;"+RS01[A].get("BKA002006").toString().substring(8,10)+":"+RS01[A].get("BKA002006").toString().substring(10)):RS01[A].get("BKA002006").toString()%>
					</p>
				</a>
			</div>
			<%
			}
			%>
		</div>
	</div>
<!-- indexF -->
<%@ include file="indexF.jsp"%>
</form>
	<!-- indexJS -->
	<%@ include file="indexJS.jsp"%>
	
<script type="text/javascript">
function SF01(A, B){
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}

function SF02(A, B, C, D){
  form1.BKA002001.value = C;
  form1.BKA002002.value = D;
  form1.target = B;
  form1.action = A + ".jsp";
  form1.submit();
}
function PG01(A,B){
	form1.PNO01.value=A;
	form1.target="_self";
	form1.action=B;
	form1.submit();
}
</script>

</body>
</html>
