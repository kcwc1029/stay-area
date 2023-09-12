<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="idv.mark.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../web_script/WSA010400.jsp"%>
<%@ include file="../web_script/WSA010500.jsp"%>
<%@ include file="../web_script/WSA010700.jsp"%>
<%
String SQL01 = ""; //宣告SQL語法
String[] AS01 = null;
Map[] RS01 = null; //將篩選出來的資料放到陣列中
Map[] RS02 = null; //將篩選出來的資料放到陣列中

//資料庫連線宣告
Database DB01 =new Database("BK"); //宣告資料庫連線(資料寫入用)
Connection CONN01 = DB01.getConn();  //宣告連線(可宣告或不宣告)
String URA004002S = SQLIJ(request.getParameter("URA004002S"));
String URA004002E = SQLIJ(request.getParameter("URA004002E"));
//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table

%>
<!DOCTYPE html>
<html lang="zh">
<head>
<!-- indexH -->
<%@ include file="../web_page/indexH.jsp"%>
</head>

<body>
<!-- indexS -->
<%@ include file="../web_page/indexS.jsp"%>
<form id="form1" name="form1" method="post" action="">
<div class="container">
	<div class="row">	
		<div class="text-dark font-weight-bold col-sm" align="left"><!--%=USERNAME%--> 您好</div>			    
	</div>	
	<div class="card shadow">
		<div class="card-body pb-0">
			<div class="d-flex justify-content-between">
				<div><h4 class="text-red2 font-weight-bold">使用紀錄查詢</h4></div>
			</div>
			<ol class="breadcrumb">
				<li class="breadcrumb-item">首頁</li>
				<li class="breadcrumb-item">資料維護</li>
				<li class="breadcrumb-item active">使用紀錄查詢</li>
			</ol>
		</div>	
		<div class="container mb-3">
			<div class="R_C_1" id="R02">
			<table width="100%" border="0" align="center">
				<tr>
				  <td colspan="4" align="center" class="RF_C6"><strong>使用者紀錄查詢</strong></td>
				</tr>
				<tr>
				  <td width="18%" height="40" align="right">使用者帳號：</td>
				  <td width="36%">
					<input type="text" class="RF_C1" name="URA004001" id="URA004001" value="">
				  </td>
				</tr>
				<tr>
					<td width="18%" height="40" align="right">登錄日期區間：</td>
					<td colspan="3" height="40" align="left">
					<input name="URA004002S" type="text" class="validate[required] datepicker RF_C1" id="URA004002S" value="<%=URA004002S%>" readonly> ~ 
					<input name="URA004002E" type="text" class="validate[required] datepicker RF_C1" id="URA004002E" value="<%=URA004002E%>" readonly>
					</td>
				</tr>
				<tr>
				  <td height="30" colspan="4" align="center"><button type="button" class="btn btn-info" onClick="SF01('THA210600','_self')">查詢</button></td>
				</tr>
			</table>
			</div>
		</div>
	</div>
</div>
</form>
<p>&nbsp;</p>
<!-- indexF -->
<%@ include file="../web_page/indexF.jsp"%>
<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
</body>
</html>
<script type="text/javascript">
function SF01(A, B){
    var url ="THA210601";
	form1.target = B;
	form1.action = url + ".jsp";
	form1.submit();
}
</script>
<%
DB01.close();
%>