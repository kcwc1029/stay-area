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

//呼叫並擷取資料庫的資料
Table TAB01 =new Table(CONN01); //宣告對應的table


String URA004001 = SQLIJ(request.getParameter("URA004001"));
String URA004002S = SQLIJ(request.getParameter("URA004002S"));
String URA004002E = SQLIJ(request.getParameter("URA004002E"));
if(!URA004001.equals("")){
  SQL01+=" AND URA004001 = '"+URA004001+"'";
}
if(!URA004002S.equals("") && !URA004002E.equals("")){
	String URA004002S1 = SQLIJ(String.valueOf(Integer.parseInt(URA004002S)+19110000));
	String URA004002E1 = SQLIJ(String.valueOf(Integer.parseInt(URA004002E)+19110000));
	SQL01+=" AND URA004002 BETWEEN '"+URA004002S1+"000000' AND '"+URA004002E1+"999999'";
}
if(SQL01.equals("")){
	SQL01 = "SELECT * FROM URA004 WHERE URA004001 = ''";
}else{
	SQL01 = "SELECT * FROM URA004 WHERE URA004001 <> '' " + SQL01 + " ORDER BY URA004002 DESC";
}

//out.print(SQL01);
//out.print(URA004002S1+"/");
//out.print(URA004002E1+"/");
//if(true)return;
RS01 = TAB01.buildMaps(SQL01);
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
<br><br>
<div class="container">	
	<div class="card shadow">
		<div class="card-body pb-0">
			<div class="d-flex justify-content-between">
				<div><h4 class="text-red2 font-weight-bold">使用紀錄查詢</h4></div>
			</div>
			<ol class="breadcrumb">
				<li class="breadcrumb-item">首頁</li>
				<li class="breadcrumb-item">資料維護</li>
				<li class="breadcrumb-item">使用紀錄查詢</li>
				<li class="breadcrumb-item active">使用者紀錄報表</li>
			</ol>	
		</div>
		<div class="container">
		  <div class="R06">
			<table class="table table-striped table-bordered" width="100%" border="0" align="center" cellspacing="1">
			<thead class="thead-light">
			<tr class="RF_C6">
			  <td width="5%" align="center">序號</td>
			  <td width="" height="30" align="center">使用者</td>
			  <td width="" height="30" align="center">登錄日期區間</td>
			  <td width="" height="30" align="center">操作動作</td>
			</tr>
			</thead>
			  <%
			  if(RS01.length!=0){
			  String TT[][]  = new String[RS01.length+1][6];
				TT[0][0]= "序號";
				TT[0][1]= "職稱";
				TT[0][2]= "使用者";
				TT[0][3]= "操作時間";
				TT[0][4]= "操作動作";
				TT[0][5]= "項目流水號";
				String URA001012 = TAB01.getCol("URA001","URA001012","URA001001","'"+USERID+"'");
				for(int A=0;A<RS01.length;A++){
				  TT[A+1][0]= ""+(A+1);
				  TT[A+1][1]= URA001012;
				  TT[A+1][2]= RS01[A].get("URA004001").toString();
				  TT[A+1][3]= RS01[A].get("URA004002").toString();
				  TT[A+1][4]= RS01[A].get("URA004005").toString();
				  TT[A+1][5]= RS01[A].get("URA004004").toString();
			  %>
			<tr class="R_C1">
			  <td align="center"><%=TT[A+1][0]%></td>
			  <td align="center"><%=TT[A+1][2]%></td>
			  <td align="center"><%=TT[A+1][3]%></td>
			  <td align="center"><%=TT[A+1][4]%></td>
			</tr>
			  <%
			  }
			  session.setAttribute("TT1", TT);
			  %>
			  <tr class="R_C1">
			  <td colspan="9" align="center">共計<%=RS01.length%>筆</td>
			  </tr>
		   
			</table>
		 </div>

			<div class="row mt-4">
				<div class="col-sm" align="center">
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:history.back();">回上一頁</button>
					<button type="button" class="btn btn-sm btn-success" onclick="javascript:SF01();">匯出報表</button>
				</div>
			</div>

		<%}else{%>
		<table class="table table-striped table-bordered" width="100%" border="0" cellspacing="4">
		  <tr class="R_C_2">
			<td width="100%" align="center" bgcolor="#FFFFFF">查無資料</td>
		  </tr>
		</table>
		<table width="100%" border="0" cellspacing="4"  bgcolor="#FFFFFF">
		  <tr class="R_C_2">
			<td width="39%" align="right"  bgcolor="#FFFFFF">&nbsp;</td>
			<td width="19%" height="40" align="center"  bgcolor="#FFFFFF"><button type="button" class="btn btn-sm btn-success" onclick="javascript:history.back();">回上一頁</button></td>
			<td width="20%" align="left" bgcolor="#FFFFFF">&nbsp;</td>
			<td width="16%" align="right" bgcolor="#FFFFFF">&nbsp;</td>
		  </tr>
		</table>
		<%}%>
		<input type="hidden" name="T1" id="T1" value="<%=RS01.length+1%>">
		<input type="hidden" name="T2" id="T2" value="6">
		<input type="hidden" name="T3" id="T3" value="TT1">
		<input type="hidden" name="FNAME" id="FNAME" value="使用者紀錄">
		</div>
	</div>
</div>
</form>
<!-- indexF -->
<%@ include file="../web_page/indexF.jsp"%>
<!-- indexJS -->
<%@ include file="../web_page/indexJS.jsp"%>
</body>
</html>
<script type="text/javascript">
function SF01(){
	form1.target = "_new";
	form1.action = "../web_script/outExcel.jsp";
	form1.submit();
}
</script>